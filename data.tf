data "aws_region" "this" {}

data "aws_vpc" "tag_filter" {
  count = var.vpc_filter_map == null ? 0 : 1

  dynamic "filter" {
    for_each = var.vpc_filter_map
    content {
      name   = "tag:${filter.key}"
      values = [filter.value]
    }
  }
}

data "aws_subnet_ids" "public_tag_filter" {
  count = var.vpc_filter_map == null ? 0 : 1

  vpc_id = data.aws_vpc.tag_filter.*.id[0]

  filter {
    name = "tag:Name"
    values = [
    "*public*"]
  }
}

data "aws_subnet_ids" "private_tag_filter" {
  count = var.vpc_filter_map == null ? 0 : 1

  vpc_id = data.aws_vpc.tag_filter.*.id[0]

  filter {
    name = "tag:Name"
    values = [
    "*private*"]
  }
}

data "aws_subnet" "public_tag_filter" {
  count = var.vpc_filter_map == null ? 0 : length(data.aws_subnet_ids.public_tag_filter.*.ids[0])
  id    = tolist(data.aws_subnet_ids.public_tag_filter.*.ids[0])[count.index]
}

data "aws_subnet" "private_tag_filter" {
  count = var.vpc_filter_map == null ? 0 : length(data.aws_subnet_ids.private_tag_filter.*.ids[0])
  id    = tolist(data.aws_subnet_ids.private_tag_filter.*.ids[0])[count.index]
}

data "aws_security_group" "map_filter" {
  count = var.security_group_filter_map == null ? 0 : 1

  vpc_id = local.vpc_id

  dynamic "filter" {
    for_each = merge(module.label.tags, { Name : var.security_group_name })
    content {
      name   = "tag:${filter.key}"
      values = [filter.value]
    }
  }
}

data "aws_security_group" "name_filter" {
  count = local.security_group_name == "" ? 0 : 1

  vpc_id = local.vpc_id

  filter {
    name   = "tag:Name"
    values = [local.security_group_name]
  }
}

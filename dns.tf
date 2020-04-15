
variable "domain_name" {
  description = "The domain to attach records in"
  type        = string
  default     = ""
}

variable "hostname" {
  description = "The hostname - hostname.example.com"
  type        = string
  default     = ""
}

data "aws_route53_zone" "this" {
  count = var.domain_name == "" ? 0 : 1
  name  = "${var.domain_name}."
}

resource "aws_route53_record" "this" {
  count = var.domain_name == "" ? 0 : 1

  zone_id = join("", data.aws_route53_zone.this.*.id)

  name = var.hostname == "" ? var.domain_name : "${var.hostname}.${var.domain_name}"
  type = "A"
  ttl  = "300"

  records = [join("", aws_instance.this.*.public_ip)]
}

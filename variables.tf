variable "create" {
  description = "Boolean to make module or not"
  type        = bool
  default     = true
}


########
# Label
########
variable "environment" {
  description = "The environment"
  type        = string
  default     = ""
}

variable "namespace" {
  description = "The namespace to deploy into"
  type        = string
  default     = ""
}

variable "stage" {
  description = "The stage of the deployment"
  type        = string
  default     = ""
}

variable "network_name" {
  description = "The network name, ie kusama / mainnet"
  type        = string
  default     = ""
}

variable "owner" {
  description = "Owner of the infrastructure"
  type        = string
  default     = ""
}

#########
# Network
#########
variable "subnet_id" {
  description = "The id of the subnet."
  type        = string
  default     = ""
}

variable "security_group_id" {
  description = "The id of the security group to run in"
  type        = string
}

#####
# ec2
#####
variable "node_name" {
  description = "Name of the node"
  type        = string
  default     = ""
}

variable "monitoring" {
  description = "Boolean for cloudwatch"
  type        = bool
  default     = false
}

variable "create_eip" {
  description = "Boolean to create elastic IP"
  type        = bool
  default     = false
}

//variable "ebs_volume_size" {
//  description = "EBS volume size"
//  type        = string
//  default     = 0
//}

variable "root_volume_size" {
  description = "Root volume size"
  type        = string
  default     = 0
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

//variable "volume_path" {
//  description = "Volume path"
//  type        = string
//  default     = "/dev/xvdf"
//}

variable "public_key" {
  description = "The public ssh key. key_name takes precidence"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "The name of the preexisting key to be used instead of the local public_key_path"
  type        = string
  default     = ""
}
data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "^base-ami-*"
  owners           = ["648194886491"]

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

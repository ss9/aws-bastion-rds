// Security Group
resource "aws_security_group" "bastion" {
    name = "${var.stack}-bastion"
    description = "Allow SSH inbound traffic"
    vpc_id = "${aws_vpc.main.id}"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.access_ip}/32"]
    }
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "${var.stack}-aws_security_group"
    }
}

data "aws_ssm_parameter" "amzn2_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

// EC2
resource "aws_instance" "bastion" {
    ami = data.aws_ssm_parameter.amzn2_ami.value
    instance_type = "t2.micro"
    key_name = "${var.ssh_key_name}"
    vpc_security_group_ids = [
        "${aws_security_group.bastion.id}"
    ]
    subnet_id = aws_subnet.public[0].id
    associate_public_ip_address = "true"

    user_data = <<EOF
    #!/bin/bash
    yum update -y

    ## MySQL Setup
    sudo yum install mysql -y

    ## Git
    sudo yum install git -y

    EOF

    tags = {
        Name = "${var.stack}-aws_instance-bastion"
    }
}
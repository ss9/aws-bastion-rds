resource "aws_security_group" "rds-sg" {
    name        = "${var.stack}-rds-sg"
    description = "RDS service security group for ${var.stack}"
    vpc_id      = "${aws_vpc.main.id}"
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "${var.stack}-sg of mysql"
    }
}
resource "aws_db_subnet_group" "rds-subnet-group" {
    name        = var.db_name
    description = "rds subnet group for ${var.db_name}"
    subnet_ids = aws_subnet.private.*.id
}

resource "aws_db_instance" "db" {
allocated_storage      = 10
storage_type           = "gp2"
engine                 = var.engine
engine_version         = var.engine_version
instance_class         = var.db_instance
identifier             = var.db_name
username               = var.db_username
password               = var.db_password
skip_final_snapshot    = true
vpc_security_group_ids = [aws_security_group.rds-sg.id]
db_subnet_group_name   = aws_db_subnet_group.rds-subnet-group.name
}


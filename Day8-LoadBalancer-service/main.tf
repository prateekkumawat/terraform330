# create a vpc 
resource "aws_vpc" "use1" {
   cidr_block = var.vpc_cidr_block
   tags = {
    Name = "${var.orgnization}-${var.enviornment}-vpc"
   }
}

# crate a public subnet in az1 
resource "aws_subnet" "useusubnet1" {
  cidr_block = var.subnet_cidr[0]
  availability_zone = var.az[0]
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.use1.id
  tags = { 
    Name = "${var.orgnization}-${var.enviornment}-publicsubnet-az1"
  }
}

resource "aws_subnet" "useusubnet3" {
  cidr_block = var.subnet_cidr[2]
  availability_zone = var.az[1]
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.use1.id
  tags = { 
    Name = "${var.orgnization}-${var.enviornment}-publicsubnet-az2"
  }
}

# crate a private subnet in az2 
resource "aws_subnet" "useusubnet2" {
  cidr_block = var.subnet_cidr[1]
  availability_zone = var.az[1]
  map_public_ip_on_launch = false
  vpc_id = aws_vpc.use1.id
  tags = { 
    Name = "${var.orgnization}-${var.enviornment}-privatesubnet-az2"
  }
}


resource "aws_subnet" "useusubnet4" {
  cidr_block = var.subnet_cidr[3]
  availability_zone = var.az[0]
  map_public_ip_on_launch = false
  vpc_id = aws_vpc.use1.id
  tags = { 
    Name = "${var.orgnization}-${var.enviornment}-privatesubnet-az1"
  }
}
# create a igw for vpc use1
resource "aws_internet_gateway" "use1igw" {
  vpc_id = aws_vpc.use1.id
  tags = { 
    Name = "${var.orgnization}-${var.enviornment}-igw"
  }
}

# create a nat gateway for use1 vpc
resource "aws_eip" "use1vpcnateip" {
  domain = "vpc"
  tags = {
    Name = "${var.orgnization}-${var.enviornment}-nat-eip"
  }
 # depends_on = [aws_nat_gateway.use1vpcnat1]
}

resource "aws_nat_gateway" "use1vpcnat1" {
  subnet_id = aws_subnet.useusubnet1.id
  allocation_id = aws_eip.use1vpcnateip.id 
  tags = {
    Name = "${var.orgnization}-${var.enviornment}-nat-gw"
  }
}

# create a route table custom public 
resource "aws_route_table" "use1routetable" {
 vpc_id = aws_vpc.use1.id 

 route {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.use1igw.id
 }
 tags = { 
    Name = "${var.orgnization}-${var.enviornment}-public-rt"
  }
}

resource "aws_route_table" "use1routetableprivate" {
 vpc_id = aws_vpc.use1.id 

 route {
  cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.use1vpcnat1.id
 }
 tags = { 
    Name = "${var.orgnization}-${var.enviornment}-private-rt"
  }
}

 # Assosiate route table with public subnet
resource "aws_route_table_association" "use1publicrt" {
  subnet_id      = aws_subnet.useusubnet1.id
  route_table_id = aws_route_table.use1routetable.id
}
resource "aws_route_table_association" "use1publicrt2" {
  subnet_id      = aws_subnet.useusubnet3.id
  route_table_id = aws_route_table.use1routetable.id
}
resource "aws_route_table_association" "use1privatert1" {
  subnet_id      = aws_subnet.useusubnet2.id
  route_table_id = aws_route_table.use1routetableprivate.id
}
resource "aws_route_table_association" "use1privatert2" {
  subnet_id      = aws_subnet.useusubnet4.id
  route_table_id = aws_route_table.use1routetableprivate.id
}

#************ Security Group For Aws Resources ********
resource "aws_security_group" "use1pubins1" {
  vpc_id = aws_vpc.use1.id
  description = "public instnace sg"
  name       = "public_instance_sg_1"
  tags = { 
    Name = "${var.orgnization}-${var.enviornment}-public-instance1-sg"
  }

  ingress  {
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
  }
   
 ingress  {
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  egress  {
    to_port           = 0
    protocol          = "-1"
    from_port         = 0
    cidr_blocks       = ["0.0.0.0/0"]
  }

  lifecycle {
    ignore_changes = [ ingress, egress ]
  }
}


resource "aws_security_group" "use1lbsg1" {
  vpc_id = aws_vpc.use1.id 
  description = "lb security sg "
  name       = "lb_sg_1"
  tags = { 
    Name = "${var.orgnization}-${var.enviornment}-lb-sg"
  }

  ingress  {
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  egress  {
    to_port           = 0
    protocol          = "-1"
    from_port         = 0
    cidr_blocks       = ["0.0.0.0/0"]
  }
}

#######*****DB Instance connect purpose EC2 Instnace******#####

resource "tls_private_key" "use1ins1" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "use1ins1key1" {
 key_name = "instnace1_public_key1"
 public_key = tls_private_key.use1ins1.public_key_openssh
} 

# key download in your local system
resource "local_file" "use1ins1key1" {
   filename = "instance1_public_key1.pem"
   content = tls_private_key.use1ins1.private_key_pem
}

resource "aws_instance" "use1ins1pub" {
    ami = var.aws_ami_image
    instance_type = var.aws_instnace_type
    subnet_id = aws_subnet.useusubnet2.id
    security_groups = [aws_security_group.use1pubins1.id]
    key_name = aws_key_pair.use1ins1key1.key_name
    tags = {
       Name = "${var.orgnization}-${var.enviornment}-webserver-1"
    }
}

resource "aws_instance" "use1ins2pub" {
    ami = var.aws_ami_image
    instance_type = var.aws_instnace_type
    subnet_id = aws_subnet.useusubnet4.id
    security_groups = [aws_security_group.use1pubins1.id]
    key_name = aws_key_pair.use1ins1key1.key_name
    tags = {
       Name = "${var.orgnization}-${var.enviornment}-webserver-2"
    }
}

####****************** Setup ALB and Target Group Resource ****************##

resource "aws_lb_target_group" "use1lbtg" {
  name     = "highsky-prod-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.use1.id
}


resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.use1lbsg1.id]
  subnets            = [aws_subnet.useusubnet1.id, aws_subnet.useusubnet2.id]
}

resource "aws_lb_listener" "use1lb1listenerrule" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.use1lbtg.arn
  }
}

resource "aws_lb_target_group_attachment" "use1lbinsattachment1" {
  target_group_arn = aws_lb_target_group.use1lbtg.arn
  target_id        = aws_instance.use1ins1pub.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "use1lbinsattachment2" {
  target_group_arn = aws_lb_target_group.use1lbtg.arn
  target_id        = aws_instance.use1ins2pub.id
  port             = 80
}

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
 # Assosiate route table with public subnet
resource "aws_route_table_association" "use1publicrt" {
  subnet_id      = aws_subnet.useusubnet1.id
  route_table_id = aws_route_table.use1routetable.id
}
resource "aws_route_table_association" "use1publicrt2" {
  subnet_id      = aws_subnet.useusubnet3.id
  route_table_id = aws_route_table.use1routetable.id
}

##########################################################################
##  In this section we write a code for Instance security group         ##
##  eg. public_instnace1 and private_instnace_1 security group          ##
##########################################################################

resource "aws_security_group" "use1pubins1" {
  vpc_id = aws_vpc.use1.id 
  description = "public instnace sg "
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
}


resource "aws_security_group" "use1privins1" {
  vpc_id = aws_vpc.use1.id 
  description = "private instnace sg "
  name       = "private_instance_sg_1"

   tags = { 
    Name = "${var.orgnization}-${var.enviornment}-private-instance1-sg"
  }

  ingress  {
    from_port         = 22
    to_port           = 22
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

#************************************************************
# Add key pair of instance in code

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


resource "tls_private_key" "use1ins2" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "use1ins2key2" {
 key_name = "instnace1_private_key1"
 public_key = tls_private_key.use1ins2.public_key_openssh
} 

# key download in your local system
resource "local_file" "use1ins2key2" {
   filename = "instance1_private_key1.pem"
   content = tls_private_key.use1ins2.private_key_pem
}

#*************** Add Instances in terraform code ***********

resource "aws_instance" "use1ins1pub" {
    ami = var.aws_ami_image
    instance_type = var.aws_instnace_type
    subnet_id = aws_subnet.useusubnet1.id
    security_groups = [aws_security_group.use1pubins1.id]
    key_name = aws_key_pair.use1ins1key1.key_name
    tags = {
       Name = "${var.orgnization}-${var.enviornment}-public-ins1"
    }
}

resource "aws_instance" "use1ins1private" {
    ami = var.aws_ami_image
    instance_type = var.aws_instnace_type
    subnet_id = aws_subnet.useusubnet2.id
    security_groups = [aws_security_group.use1privins1.id]
    key_name = aws_key_pair.use1ins2key2.key_name
    tags = {
       Name = "${var.orgnization}-${var.enviornment}-private-ins1"
    }
}
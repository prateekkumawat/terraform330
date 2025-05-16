# create a vpc 
resource "aws_vpc" "use1" {
   cidr_block = var.vpc_cidr_block
   tags = {
    Name = "${var.orgnization}-${var.enviornment}"
   }
}

resource "aws_subnet" "usesubnet1" {
  vpc_id = aws_vpc.use1.id
  cidr_block = var.subnet_cidr[0]
  availability_zone = var.az[0]
  tags = {
    Name = "${var.orgnization}-${var.enviornment}-public-subnet-az1"
  }  
}

resource "aws_subnet" "usesubnet2" {
  vpc_id = aws_vpc.use1.id
  cidr_block = var.subnet_cidr[1]
  availability_zone = var.az[1]
  tags = {
    Name = "${var.orgnization}-${var.enviornment}-public-subnet-az2"
  }  
}



# Configure Resoure EC2 Instance 
resource "aws_instance" "instance1" {
  ami               = var.aws_ami_image                   # "ami-0af9569868786b23a"
  instance_type     = var.aws_instnace_type
  key_name          =  "mount.pem" 
  security_groups   =  ["launch-wizard-13"]
  tags =  { 
    Name  =  "Launch-by-terraform"
  }
}

resource "aws_instance" "instance2" {
  ami               = var.aws_ami_image
  instance_type     = var.aws_instnace_type
  key_name          =  "mount.pem" 
  security_groups   =  ["launch-wizard-13"]
  tags =  { 
    Name  =  "Launch-by-terraform-again"
  }
}


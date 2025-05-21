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
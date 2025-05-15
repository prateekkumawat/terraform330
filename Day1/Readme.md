# Introduction and Intital state 
Terraform used as a IAC tools. 
in terraform everyfile have extenstion like .tf 
terraform based on provider -----> AWS AZURE GCP ORCALE 
in our case provider is aws ---- becuase we want to create infra on AWS CLOUD. 

terraform follow key value method if your value is string then its pass in "". 
eg: region = "ap-south-1" 
    name = "prateek" 

if the value is number or any variable or any function than its pass without Quotation. 
eg: region = var.aws_region 
    count = 3 
    id = aws.vpc.main.id 

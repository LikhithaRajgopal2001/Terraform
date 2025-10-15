module "dev-infra-app" {
    source = "./infra-app"
    env = "dev"
    bucket_name = "infra-app-bucket-practice"
    instance_count = 1
    instance_type = "t3.micro"
    ec2_ami_id = "ami-00e73adb2e2c80366"
    hash_key = "StudentID"
}

module "prd-infra-app" {
    source = "./infra-app"
    env = "prd"
    bucket_name = "infra-app-bucket-practice"
    instance_count = 2
    instance_type = "t3.micro"
    ec2_ami_id = "ami-00e73adb2e2c80366"
    hash_key = "StudentID"
}

module "stg-infra-app" {
    source = "./infra-app"
    env = "stg"
    bucket_name = "infra-app-bucket-practice"
    instance_count = 1
    instance_type = "t3.micro"
    ec2_ami_id = "ami-00e73adb2e2c80366"
    hash_key = "StudentID"
}
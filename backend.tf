terraform {
  backend "s3" {
    bucket = "seshubucketnaga"
     key    = "env/dev/terraform.tfstate"  # Path in the bucket (acts like folder)
    region = "ap-south-1"  
  }
}
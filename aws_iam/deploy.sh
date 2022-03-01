eu-central-1
BUCKET=tfstate-sandbox
terraform init -backend-config=bucket=$BUCKET -backend-config=key=rba-terraform-iam-api/terraform.tfstate -backend-config=region=$AWS_DEFAULT_REGION
terraform plan

                                                                        

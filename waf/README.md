# waf

To test the DAI WAF module

terraform init
terraform apply --> state will be in s3://tf-state-911453050078/rbapst-tamedia/terrafrom/waf/terraform.tfstate
terraform destroy
aws s3 rm s3://tf-state-911453050078/rbapst-tamedia/terrafrom/waf/terraform.tfstate



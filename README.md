# New-Azure-Terraform-GA-Sonarcloud-integration
New-Azure-Terraform-GA-Sonarcloud-integration
this repo is to test the Sonarcloud SAST integrate with githuub action CI/CD pipeline.
if sonarcloud qualitygate checcks fail then terraform apply gets failed.
flow:
terraform plan>>sonarcloud scan>> sonarcloud qualitygate checck>> if pass(Green) then terraform apply>> if fail(red) then terraform apply fail
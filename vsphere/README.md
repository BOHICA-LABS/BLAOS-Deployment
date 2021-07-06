# Getting Started

## Create answers.tfvars
Rename the answers.tfvars.tpl to answers.tfvars and populate the varables. a description of each variable can be found inside the variables.tf file

### Variables Tables

## Initialize terrafrom
```powershell
terraform.exe init
```

## View the build plan
```powershell
terraform.exe plan -var-file="answers.tfvars"
```

## Standup the Platform
```powershell
terraform.exe apply -var-file="answers.tfvars"
```

## Tear Down the Platform
```powershell
terraform.exe destroy -var-file="answers.tfvars"
```
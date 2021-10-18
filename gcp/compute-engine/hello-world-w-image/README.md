```bash
terraform init
terraform apply -auto-approve

open $(terraform output -raw url)
```

You'll need a `terraform.tfvars` like
```
project_id         = "<project-id>"
subnetwork         = "default"
subnetwork_project = "<project-id>"
zone               = "us-east1-b"
```
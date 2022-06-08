
# Simple OpenSource Kafka Setup in AWS 

## Terraform Cloud 

1. Create a workspace 
2. Change the execution to `local`

```bash
terraform login
# Get the token from the UI and complete it
terraform init
terraform plan
terraform apply --auto-approve

# For terraform console 
terraform console
```
### Networking 

Refer `networking/main.tf`

1. Create an Internet Gateway `kafka_internet_gateway` to talk to the outside world in the `vpc`
2. Create a route table `kafka_public_rt` in the `vpc`
3. Configure `default_route` route to `kafka_public_rt` route table in the `vpc`
4. Associate every `subnet` to the route table `kafka_public_rt` 


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

### EC2 

Refer https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/managing-users.html

For a RHEL AMI, the user name is ec2-user or root.

In any terminal

```bash
# Generate key pair (public and private) 
# this path varies on local terminal that is used
# to run tf
# and save it to /home/ec2-user/.ssh/kafkassh (no passphrase) "kafkassh" is the key name
ssh-keygen -t rsa
# Will generate pub and private keys


```
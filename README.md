# AWS-DOCKER SWARM

## Requirements


- AWScli 
- ansible
- Terraform 0.12.28 or greater
- Docker and docker compose

By default we use "dev" environment. You can change the environment in the variables.tf file


## Run app



### Steps

1) You need to provide your aws credentials in tfvars file and set up the aws login correctly in order to execute aws commands. 

2) Clone the repo and go to infra/scripts and execute install_all.sh script
```
bash install_all.sh

```


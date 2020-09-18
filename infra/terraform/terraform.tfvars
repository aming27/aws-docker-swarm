# AWS Settings
aws_access_key = "your_aws_key"
aws_secret_key = "your_secret"
aws_region     = "eu-west-1"
# Set up a key pair in AWS and add the name here to allow SSH access to the instances
key_name="Yourkey"
# Set the IP ranges from which to allow SSH access to the instances
ssh_access=["0.0.0.0/0"]


zone_id="Z********"


domain="app.mydomain.tld"

# Set the instance type to use
instance_type="t2.nano"

# Set the root EBS volume size for the swarm instances
volume_size=12



# Set database password
database_password = "mysecret"
# Set the number of instances to run as managers
swarm_manager_count=3

# # Set the number of instances to run as workers
# swarm_worker_count=1

install_infra(){
    
    pushd ../terraform
    terraform init
    terraform workspace new $workspace
    terraform workspace select $workspace
    terraform apply -var-file="terraform.tfvars" -var="environment=${environment}"\
		
		
    ASGName=$(terraform output autoscaling-group-name)
    FQDNS_RDS=$(terraform output hostname)
    popd
    
    #Configure AWS
    aws configure --profile ~/.aws/credentials
    
    #Get manager ip  instance
    for i in `aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name ASGName | grep -i instanceid  | awk '{ print $2}' | cut -d',' -f1| sed -e 's/"//g'`
    do
    	manager=aws ec2 describe-instances --filters Tags=manager --instance-ids $i | grep -i PrivateIpAddress | awk '{ print $2 }' | head -1 | cut -d"," -f1
    done;
    
    #Get workers ips
    for i in `aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name ASGName | grep -i instanceid  | awk '{ print $2}' | cut -d',' -f1| sed -e 's/"//g'`
    do
           workers=aws  ec2 describe-instances --filters Tags=workers --instance-ids $i | grep -i PrivateIpAddress | awk '{ print $2 }' | head -1 | cut -d"," -f1
    done;
    

    pushd ../ansible
    echo \[masters]\ > inventory.yml
    echo $manager	>> inventory.yml
    echo \[workers]\ >> inventory.yml 
    echo $workers   >> inventory.ymk
}

install_swarm(){

	pushd ../ansible
	ansible-playbook  pb-master.yml 
    ansible-playbook  pb-worker.yml 
	popd
}

deploy_app(){

    repo="https://github.com/scm-spain/devops-test-helloworld-app.git"
    base_dir="devops-test-helloworld-app"
    uri_repo_aws="my_uri_repo"
    image=$uri_repo_aws"/"$base_dir
    stack="adev-app"
    tag="latest"
    svc="adev-svc"
    pushd ../../deploy
    
    if [ "$environment" = "dev" ]; then
        docker_replicas="1"
        echo "dev"
        pushd dev
        
        #Clone repo and build image for app

        git clone $repo
        docker build --build-arg base_dir=${base_dir} -t $base_dir .
        docker tag $base_dir $image:$tag
        aws ecr get-login --no-include-email --region=eu-west-1 && docker push $image
        
        popd

        #Create env file
        echo \[$environment]\ > inventory.${environment}.yml
        echo $workers   >> inventory.${environment}.yml

        echo \[dev:vars]\ >> inventory.${environment}.yml
        echo \REPO_NAME=$repo\   >> inventory.${environment}.yml
        echo \IMAGE=$image\   >> inventory.${environment}.yml
        echo \STACK_NAME=$stack\   >> inventory.${environment}.yml
        echo \DOCKER_REPPLICAS=$docker_replicas\   >> inventory.${environment}.yml
        echo \URI_REPO_AWS=$uri_repo_aws\   >> inventory.${environment}.yml
        echo \ENVIRONMENT=$environment\   >> inventory.${environment}.yml
        echo \IMAGE_TAG=$tag\   >> inventory.${environment}.yml
        echo \SVC=$svc\   >> inventory.${environment}.yml
        echo \FQDNS_RDS=$FQDNS_RDS\   >> inventory.${environment}.yml
        

        #Deploy app
        ansible-playbook -i inventory.${environment}.yml   deploy.yml
    fi

    if [ "$environment" = "prod" ]; then
        docker_replicas="3"
        echo "prod"
        pushd prod

        #Clone repo and build image for app
        git clone $repo
        docker build --build-arg base_dir=${base_dir} -t $base_dir .
        docker tag $base_dir $image:$tag
        aws ecr get-login --no-include-email --region=eu-west-1 && docker push $image


        popd

        #Create env file
        echo \[$environment]\ > inventory.${environment}.yml
        echo $workers   >> inventory.${environment}.yml


        echo \[dev:vars]\ >> inventory.${environment}.yml
        echo \REPO_NAME=$repo\   >> inventory.${environment}.yml
        echo \IMAGE=$image\   >> inventory.${environment}.yml
        echo \STACK_NAME=$stack\   >> inventory.${environment}.yml
        echo \DOCKER_REPPLICAS=$docker_replicas\   >> inventory.${environment}.yml
        echo \URI_REPO_AWS=$uri_repo_aws\   >> inventory.${environment}.yml
        echo \ENVIRONMENT=$environment\   >> inventory.${environment}.yml
        echo \IMAGE_TAG=$tag\   >> inventory.${environment}.yml
        echo \SVC=$svc\   >> inventory.${environment}.yml
        echo \FQDNS_RDS=$FQDNS_RDS\   >> inventory.${environment}.yml

        #Deploy app
        ansible-playbook -i inventory.${environment}.yml   deploy.yml

    fi
 	
}

deploy_elk(){
    pushd ../../logging

    stack_elk="adev-elk"
    base_dir="elk"
    
    echo $workers   > inventory.yml
    echo \[workers]\  >> inventory.yml
    echo \STACK_NAME=$stack_elk\   >> inventory.yml
    echo \BASE_DIR=$base_dir\   >> inventory.yml


    ansible-playbook -i inventory.yml   deploy.yml



}

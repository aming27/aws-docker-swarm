FROM centos:centos7


ARG TERRAFORM_VERSION=0.12.7


# update and install essential packages
RUN yum update -y \
    && yum install epel-release -y \
    && yum install wget bash-completion make sshpass vim git tmux telnet nc zip unzip -y \
    && yum install python2-pip python36 python36-pip -y

#install docker 
RUN yum install -y yum-utils device-mapper-persistent-data lvm2  \
    && yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo -y \
    && yum install docker -y 

#install docker-compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
   && chmod +x /usr/local/bin/docker-compose


# install ansible
RUN yum install ansible -y \
    && pip install pywinrm

# install ansible tower cli tool
RUN pip install ansible-tower-cli


# install terraform
RUN curl -sSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o ./terraform.zip \
    && unzip ./terraform.zip -d /usr/local/bin/ \
    && rm -f ./terraform.zip

# install awscli tool
RUN pip install awscli



WORKDIR /root
ENTRYPOINT [ "/bin/bash", "-c" ]
USER root

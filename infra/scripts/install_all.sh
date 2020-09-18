#!/bin/bash
. environments.sh

. installers.sh

# execute

create_image
install_infra
install_swarm
deploy_app
deploy_elk

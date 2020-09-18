#!/bin/bash
. environments.sh

. installers.sh

# execute

install_infra
install_swarm
deploy_app
deploy_elk

#!/bin/bash

PS3='Choose your environment: '
options=("prod" "dev" "quit")
select opt in "${options[@]}"
do
    case $opt in
        "prod")
            
            export application='my-app'
            export environment='prod'
            export workspace="$application-$environment"
            break
            ;;            
        "dev")   
                    
            export application='my-app'
            export environment='dev'
            export workspace="$application-$environment"
            echo "you choose $workspace"
            break
            ;;        
        "quit")
            exit
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

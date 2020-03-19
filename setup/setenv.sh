#!/bin/bash

## Update below section for your environment.
## Org is the name of the organization in which you have an account. 
## Login to enterprise.apigee.com and check account settings.
## Credentials are the username and password that you use to login 
## to enterprise.apigee.com
## Trial and cloud accounts have environments called 'test' and 'prod'. 
## If you have a trial or cloud account, you do not need to
## modify the URL.
## You can obtain a free account at https://accounts.apigee.com/accounts/sign_up
## On-premise deployments may have other environments.
## --------------------------------------
## Cloud users: Leave the default values for $url and $api_domain.
## On-prem customers: 
## - Change the $url to your Apigee management server.
## - Change $api_domain to the base domain for your own Apigee API calls.
##   $api_domain gets used in conjunction with $org and $env to construct
##   the base URL to your APIs: https://$org-$env.$api_domain/<api_resource>

# Setup Creds
read -p 'Username: ' APIGEE_USERNAME
read -sp 'Password: ' APIGEE_PASSWORD
printf "\n" 
read -p 'Apigee Organisation Name: ' APIGEE_ORGANIZATION
read -p 'Apigee Environment Name: ' APIGEE_ENV

export org=$APIGEE_ORGANIZATION
export username=$APIGEE_USERNAME
export env=$APIGEE_ENV
export url="https://api.enterprise.apigee.com"
export api_domain="apigee.net"

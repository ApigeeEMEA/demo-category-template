#!/bin/bash

source ./setenv.sh

echo This script deploys all sample API proxies under ./apigee-apiproxies to your organization on the Apigee API Platform.

echo Using $APIGEE_USERNAME in $APIGEE_ORGANIZATION.

#echo "Enter your password for the Apigee Enterprise organization $org, followed by [ENTER]:"
#read -s password

echo Verifying credentials...

response=`curl -s -o /dev/null -I -w "%{http_code}" $url/v1/organizations/$APIGEE_ORGANIZATION -u $APIGEE_USERNAME:$APIGEE_PASSWORD`

if [ $response -eq 401 ]
then
  echo "Authentication failed!"
  echo "Please re-run the script using the right username/password."
  exit
elif [ $response -eq 403 ]
then
  echo Organization $APIGEE_ORGANIZATION is invalid!
  echo Please re-run the script using the right org.
  exit
else
  echo "Verfied! Proceeding with deployment."
fi;

echo Deploying all samples to $APIGEE_ENV using $APIGEE_USERNAME and $APIGEE_ORGANIZATION

cd ../apigee-apiproxies/

for proxydir in *; do
    if [ -d "${proxydir}" ]; then
        #../tools/deploy.py -n $proxydir -u $username:$password -o $org -e $env -p / -d $proxydir -h $url
        apigeetool deployproxy -o $APIGEE_ORGANIZATION -u $APIGEE_USERNAME -p $APIGEE_PASSWORD -e $APIGEE_ENV -n $proxydir -d $proxydir
    fi
done

: <<'END'
cd ../apigee-config/

for shs in *.sh; do
  source "$shs" -H 
done
END

cd ../setup/

echo "Deployment complete. Sample API proxies are deployed to the $APIGEE_ENV environment in the organization $APIGEE_ORGANIZATION"

echo "Login to enterprise.apigee.com to view and interact with the sample API proxies"
#!/bin/bash
AWS_SSH_PRIVATE_KEY_FILE="/home/mohamed/Desktop/aws/created_key.pem"
#echo $AWS_SSH_PRIVATE_KEY_FILE

set -e

if [ -z ${AWS_SSH_PRIVATE_KEY_FILE} ]
then
    echo "ERROR: You must set AWS_SSH_PRIVATE_KEY_FILE in the environment."
    exit 1
fi

i=0
for publicDnsName in $(cat nodes-public)
do
    i=$((i+1))
    echo Starting on node ${i}: ${publicDnsName}...
    #ssh -o StrictHostKeyChecking=no -i ${AWS_SSH_PRIVATE_KEY_FILE} ec2-user@${publicDnsName} ./start-h2o-bg.sh
    ssh -o StrictHostKeyChecking=no -i ${AWS_SSH_PRIVATE_KEY_FILE} ec2-user@${publicDnsName} "nohup java -jar h2o.jar -flatfile flatfile.txt 1> h2o.out 2> h2o.err &"
    #java -jar h2o.jar -flatfile flatfile.txt"
    
    
done

echo Success.

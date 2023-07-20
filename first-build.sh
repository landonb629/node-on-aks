#!/bin/bash 
for repo in frontend service1 service2 
do 
    aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 500731508494.dkr.ecr.us-east-2.amazonaws.com
    cd $repo 
    docker build --platform linux/arm64 -t 500731508494.dkr.ecr.us-east-2.amazonaws.com/$repo:1.0 .
    docker push 500731508494.dkr.ecr.us-east-2.amazonaws.com/$repo:1.0
    cd .. 
done
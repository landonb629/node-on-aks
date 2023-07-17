#!/bin/bash
REPOSITORY_NAME=$1 
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 500731508494.dkr.ecr.us-east-2.amazonaws.com/$REPOSITORY_NAME

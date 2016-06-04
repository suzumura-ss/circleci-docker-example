#!/bin/bash
ENV_NAME=circleciDockerExample

aws elasticbeanstalk describe-environment-health \
  --environment-name ${ENV_NAME} \
  --attribute-names All

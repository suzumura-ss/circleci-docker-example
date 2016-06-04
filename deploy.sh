#!/bin/bash

configure_aws_cli(){
	aws --version
	aws configure set default.region ap-northeast-1
	aws configure set default.output json
}


VERSION=${1-$(date +"%Y%m%dT%H%M%S")}

APP_NAME=circleci-docker-example
ENV_NAME=circleciDockerExample
ZIP_FILE="${APP_NAME}-${VERSION}.zip"
EB_BUCKET=pflabo-elasticbeanstalk-deploy
set -e

# Create application.zip
export APPLICATION_VERSION=${VERSION}
bundle exec rake eb:package[${ZIP_FILE}]

configure_aws_cli

# Create new ElasticBeanstalk version
aws s3 cp pkg/${ZIP_FILE} s3://${EB_BUCKET}/${ZIP_FILE}
aws elasticbeanstalk create-application-version \
  --application-name ${APP_NAME} \
  --version-label ${VERSION} \
  --source-bundle S3Bucket=${EB_BUCKET},S3Key=${ZIP_FILE}

# Update ElasticBeanstalk environment to new version
aws elasticbeanstalk update-environment \
  --environment-name ${ENV_NAME} \
  --version-label ${VERSION}

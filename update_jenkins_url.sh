#!/usr/bin/env bash
set -exo pipefail
# TODO this could be terraform plugin,
#      also adding API key for jenkins user would be helpful in form of terraform plugin or will have to be done when image is build

# Update url with sed
sed "s,System.getenv('_JENKINS_URL'),'${1}'," ./post-deployment/jenkins-url.groovy > ./post-deployment/update-jenkins-url.groovy
# Execute groovy script to update Jenkins URL
curl --user "${JENKINS_USERNAME}:${JENKINS_TOKEN}" \
     --data-urlencode script="$(< ./post-deployment/update-jenkins-url.groovy)" \
     "http://${JENKINS_URL}/scriptText"

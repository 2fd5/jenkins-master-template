# Jenkins-master-template

## Build

```bash
docker build . --tag jenkins-master-template:0.0.1
```

## Tag

```bash
docker tag jenkins-master-template:0.0.1 organization.azurecr.io/as-jenkins-master-template:0.0.1
```

## Push

```bash
docker login organization.azurecr.io
docker push organization.azurecr.io/as-jenkins-master-template:0.0.1
```

## Start

with docker compose it is just

```bash
docker-compose up -d && docker-compose logs -f
```

## Access Jenkins

http://localhost:$HOST_HTTP_PORT defaults to http://localhost:28080

## Default settings

Default settings for docker-compose are located in `.env` file.

## Set JENKINS_URL post deployment

Base on discussion in [JENKINS-28466](https://issues.jenkins.io/browse/JENKINS-28466?page=com.atlassian.jira.plugin.system.issuetabpanels%3Acomment-tabpanel&showAll=true)

> Requirements: _JENKINS_URL have to be set on jenkins master. Potentially groovy script could just pass desired value instead of relaying on environment variable state.

```bash
curl --user 'username:api_key' --data-urlencode script="$(< ./post-deployment-groovy/jenkins-url.groovy)" http://localhost:28080/scriptText
```

Also `update_jenkins_url.sh "new-hostname.com:8080"` can be used.

## To get plugins list

```bash
JENKINS_HOST=username:password@myhost.com:port
curl -sSL "http://$JENKINS_HOST/pluginManager/api/xml?depth=1&xpath=/*/*/shortName|/*/*/version&wrapper=plugins" | perl -pe 's/.*?<shortName>([\w-]+).*?<version>([^<]+)()(<\/\w+>)+/\1 \2\n/g'|sed 's/ /:/'
```

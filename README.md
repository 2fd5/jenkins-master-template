# Jenkins-master-template

## Start

with docker compose it is just

```bash
docker-compose up -d && docker-compose logs -f
```

## Access Jenkins

http://localhost:$HOST_HTTP_PORT defaults to http://localhost:28080

## Default settings

Default settings for docker-compose are located in `.env` file.

## To get plugins list

```bash
JENKINS_HOST=username:password@myhost.com:port
curl -sSL "http://$JENKINS_HOST/pluginManager/api/xml?depth=1&xpath=/*/*/shortName|/*/*/version&wrapper=plugins" | perl -pe 's/.*?<shortName>([\w-]+).*?<version>([^<]+)()(<\/\w+>)+/\1 \2\n/g'|sed 's/ /:/'
```

## TODO

- Add optional pack where hosts docker can be used via bind mounting docker sock file.
- Allow plugins.txt file be provided in easy way.

## Set JENKINS_URL post deployment

Base on discussion in [JENKINS-28466](https://issues.jenkins.io/browse/JENKINS-28466?page=com.atlassian.jira.plugin.system.issuetabpanels%3Acomment-tabpanel&showAll=true)

> Requirements: _JENKINS_URL have to be set on jenkins master. Potentially groovy script could just pass desired value instead of relaying on environment variable state.

```bash
curl --user 'username:api_key' --data-urlencode script="$(< ./post-deployment-groovy/jenkins-url.groovy)" http://localhost:28080/scriptText
```

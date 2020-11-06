# Jenkins-template

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

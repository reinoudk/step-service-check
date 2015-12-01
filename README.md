# step-service-check
Check if a service is online by polling the specified tcp endpoint.

[![wercker status](https://app.wercker.com/status/bd3b2ebfd29919c5674fafb01775f233/m/master "wercker status")](https://app.wercker.com/project/bykey/bd3b2ebfd29919c5674fafb01775f233)

## Usage
Add the following to your wercker.yml:

```yaml
build:
  steps:
    - reinoud/service-check@0.2.1:
        service: service-name
        port: "1337"  # numbers must be in quotes or they get evaluated to 'false'
        timeout: "10" # in seconds (optional)
        interval: "1" # in seconds (optional)
```

The service and port parameters are used to determine the environment variable which is used to get the service port
 `${SERVICE}_PORT_${PORT}_TCP_ADDR:${SERVICE}_PORT_${PORT}_TCP_PORT`. 


## TODO

- check multiple services in parallel
- flexible protocol selection

## Changelog
[Changelog](CHANGELOG.md)
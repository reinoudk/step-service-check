# step-service-check

## Usage
Add the following to your wercker.yml:

```yaml
build:
  steps:
    - reinoud/service-check@0.1.0:
        service: service-name
        port: 1337
        timeout: 10 # in seconds (optional)
        interval: 1 # in seconds (optional)
```

The service and port parameters are used to determine the environment variable which is used to get the service port
 `DOCKER_${SERVICE}_PORT_${PORT}_TCP_ADDR:${PORT}`. 

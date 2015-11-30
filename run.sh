#!/usr/bin/env bash

echo "PORT $WERCKER_SERVICE_CHECK_PORT"

SERVICE=${WERCKER_SERVICE_CHECK_SERVICE}
PORT=${WERCKER_SERVICE_CHECK_PORT}
TIMEOUT=${WERCKER_SERVICE_CHECK_TIMEOUT}
INTERVAL=${WERCKER_SERVICE_CHECK_INTERVAL}

STEPS=$((TIMEOUT / INTERVAL))

echo -e "\e[1mChecking if service $SERVICE is reachable on port $PORT using timeout and interval $TIMEOUT and $INTERVAL .\e[21m"

i=0; SERVICE_ONLINE=0;
while ((i < STEPS)) && ((200!=SERVICE_ONLINE))
do
  printf "."
  SERVICE_ONLINE=$(curl -s -o /dev/null -w "%{http_code}" -H "Accept: application/json" "DOCKER_${SERVICE}_PORT_${PORT}_TCP_ADDR:${PORT}")
  sleep "${INTERVAL}"
done

if ((200!=SERVICE_ONLINE))
then
  echo -e "\e[31mCould not connect to service $SERVICE \e[39m" >&2
  exit 1
else
  echo -e "\n\e[32m Service $SERVICE online! \e[39m"
fi
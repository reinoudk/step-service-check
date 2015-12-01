#!/usr/bin/env bash

if [ -z ${WERCKER_SERVICE_CHECK_SERVICE} ]; then
  fail "Please provide the service name in your wercker.yml"
fi

if [ -z ${WERCKER_SERVICE_CHECK_PORT} ]; then
  fail "Please provide the service port in your wercker.yml"
fi

if [ -z ${WERCKER_SERVICE_CHECK_TIMEOUT} ]; then
  WERCKER_SERVICE_CHECK_TIMEOUT="10"
fi

if [ -z ${WERCKER_SERVICE_CHECK_INTERVAL} ]; then
  WERCKER_SERVICE_CHECK_INTERVAL="1"
fi

ADDR="${WERCKER_SERVICE_CHECK_SERVICE^^}_PORT_${WERCKER_SERVICE_CHECK_PORT}_TCP_ADDR"
PORT="${WERCKER_SERVICE_CHECK_SERVICE^^}_PORT_${WERCKER_SERVICE_CHECK_PORT}_TCP_PORT"
STEPS=$((WERCKER_SERVICE_CHECK_TIMEOUT / WERCKER_SERVICE_CHECK_INTERVAL))

echo -e "\e[1mChecking if service ${WERCKER_SERVICE_CHECK_SERVICE} is reachable at ${!ADDR}:${!PORT}.\e[21m"

i=0; SERVICE_ONLINE=0;
while ((i < STEPS)) && ((200 != SERVICE_ONLINE))
do
  ((i++))
  printf "."
  SERVICE_ONLINE=$(curl -s -o /dev/null -w "%{http_code}" -H "Accept: application/json" "${!ADDR}:${!PORT}")
  sleep "${WERCKER_SERVICE_CHECK_INTERVAL}"
done

if ((200!=SERVICE_ONLINE))
then
  echo -e "\n\e[31mCould not connect to service ${WERCKER_SERVICE_CHECK_SERVICE} \e[39m" >&2
  exit 1
else
  echo -e "\n\e[32m Service ${WERCKER_SERVICE_CHECK_SERVICE} online! \e[39m"
fi
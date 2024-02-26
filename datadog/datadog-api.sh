#!/bin/bash
export DD_HOST=https://api.datadoghq.eu/
# Get users
curl -X GET $DD_HOST/api/v1/users \
     -H "Accept: application/json" \
     -H "DD-API-KEY: ${DD_API_KEY}" \
     -H "DD-APPLICATION-KEY: ${DD_APP_KEY}" -o users.json

# Get API keys
curl -X GET $DD_HOST/api/v2/api_keys \
     -H "Accept: application/json" \
     -H "DD-API-KEY: ${DD_API_KEY}" \
     -H "DD-APPLICATION-KEY: ${DD_APP_KEY}" -o api_keys.json

# Get APP keys
curl -X GET $DD_HOST/api/v2/application_keys \
     -H "Accept: application/json" \
     -H "DD-API-KEY: ${DD_API_KEY}" \
     -H "DD-APPLICATION-KEY: ${DD_APP_KEY}" -o application_keys.json

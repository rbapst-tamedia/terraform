#!/bin/bash
#export LW_ACCOUNT="my-account"
#export LW_API_KEY="my-api-key"
#export LW_API_SECRET="my-api-secret"
export LACEWORK_HOST=txgroup.lacework.net

# Get an API_TOKEN
export LW_API_TOKEN=$(curl -X POST https://$LACEWORK_HOST/api/v2/access/tokens \
     -H "X-LW-UAKS: $LW_API_SECRET" \
     -H "Content-Type: application/json" \
     -d '{"keyId": "'$LW_API_KEY'", "expiryTime": 3600}' -o - -s | jq -rc '.token')

# List all policies
curl -X GET https://$LACEWORK_HOST/api/v2/Policies \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer $LW_API_TOKEN" -o lacework_policies.json

# List all vulnerabiliy policies
curl -X GET https://$LACEWORK_HOST/api/v2/VulnerabilityPolicies \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer $LW_API_TOKEN" -o lacework_vulnerability_policies.json

# List all policies exception
curl -v -X GET https://$LACEWORK_HOST/api/v2/Exceptions'?'policyId=lacework-global-72 \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer $LW_API_TOKEN"

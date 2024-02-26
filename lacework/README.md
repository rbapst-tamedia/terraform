# Lacework in terraform

```bash
export LW_ACCOUNT="my-account"
export LW_API_KEY="my-api-key"
export LW_API_SECRET="my-api-secret"
```

## Implementation

In the lacework console create in "TX GROUP"
- An (API Keys)[https://app.datadoghq.eu/organization-settings/api-keys] (`rba_test_org_api_key_not_used`)
- An (Application Key)[https://app.datadoghq.eu/organization-settings/application-keys] (`rba_test_org_app_keys`)

They are saved as the `RBA_Datadog api_keys` secure node in my LastPass account

The API key is used to deploy the datadog agent on the K8s nodes

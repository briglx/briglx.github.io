---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Infrastructure as Code Patterns"
date: "2023-12-08"
tags:
  - "blogging"
---

I've been using a few different patterns for Infrastructure as Code (IaC) and wanted to document them.

## Domains

I think about a automating deployments for infrastructure as code in domains. This helps me decide where to define parameters.

| Domain | Description |
| ------ | ----------- |
| Human Computer Interaction (HCI) | The UI that a person uses to change parameters for a deployment. |
| Automation Plane | Tool used to take the UI parameters and execute a deployment. |
| Deployment | Tool use to deploy resources to an environment. |
| Target | The environment that the resources are deployed to. |

The deploymnent domain usually has an orchestration configuration which uses resuable components to deploy resources. For example it could be a orchestration arm template that calls child templates.

## Tools

| Tool | HCI | Automation Plane | Orchestration | Modules | Target |
| ---- | --- | ---------------- | ------------- | ------- | ------ |
| GitHub UI | X |  |  |  |  |
| GitHub Actions |  | X |  |  |  |
| Azure DevOps |  | X |  |  |  |
| Bamboo |  | X |  |  |  |
| shell script | | X | X | X |  |
| shell script `./iac/orchestration.sh` |  |  | X |  |  |
| shell script `./script/common.sh` |  |  |  | X |  |
| Azure CLI |  |  |  |  | X |
| Arm Templates | |  | X | X |  |
| Terraform |  |  | X | X |  |
| bicept |  |  | X | X |  |

## Example - GitHub Actions with Azure CLI

I use this as my starting point but I'm starting to look more at bicept.

Get Parameters from user in GitHub Actions step.
{% raw  %}
```bash
# Get params
target_env=${{github.event.inputs.environment}}
rg_region=${{github.event.inputs.location}}

echo create provision_connectivity in $location
./script/devops.sh provision_connectivity --location "$location"
```
{% endraw  %}

The `devops.sh` is a single place to pass all the control through. It just forwards on the a file like `./iac/<specific>_orchestration.sh` script

Update Parameters Step. The `<specific>_orchestration.sh` updates the default parameters with values from the user.
{% raw  %}
```bash
# default values
rg_name="rg_${name}_${location}"
kv_name="kv-common-$randomIdentifier"
log_name="log-common-$randomIdentifier"

# Parse arguments
echo "Parsing arguments"
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --parameters)
        shift
        # Assume it's key-value pairs passed directly
        while [ -n "$1" ] && [ "${1:0:1}" != "-" ]; do
            key="${1%%=*}"
            value="${1#*=}"
            local "$key=$value"
            shift
        done
        ;;
    *)
        echo "Unknown option: $1"
        exit 1
        ;;
  esac
done

# Create resources
# az ...

```
{% endraw  %}

## Example - GitHub Actions with Arm Templates

Here is an example of what is in my GitHub Actions workflow for one of the steps using powershell to update the arm template parameter file with values from the user.

Update Parameters Step
{% raw  %}
```powershell
# Point to the right orchestration templates and parameter files
$templateFilePath = "./pipelines/artifacts/deploy.json"
$parameterFilePath = "./pipelines/artifacts/parameters.json"
$parameterUpdatedFilePath = "./pipelines/parameters.updated.json"

# Read the parameter file and sanitize it
$paramsRaw = Get-Content $parameterFilePath -Raw
$paramsSanitized = $paramsRaw -replace '(?m)(?<=^([^"]|"[^"]*")*)//.*' -replace '(?ms)/\*.*?\*/'
$json = ConvertFrom-Json $paramsSanitized -AsHashTable

# Replace with Pipeline parameters
$json.parameters.componentStorageAccountId.value = "${{secrets.COMPONENT_STORAGE_ACCOUNT_ID}}"
$json.parameters.componentsStorageContainerName.value = "${{env.componentsStorageContainerName}}"
$json.parameters.location.value = "${{ env.location }}"
$json.parameters.resourcegroupname.value = "${{ github.event.inputs.resourceGroupName }}"
$json.parameters.soCWvdPrincipalIds.value = "${{ env.soc_service_principal_ids }}"

# Save the updated parameter file
New-Item -Path $parameterUpdatedFilePath -Force
ConvertTo-Json $json -depth 10 | Out-File $parameterUpdatedFilePath

# Save Param file so next step can pick up
echo "Parameters updated path:" $parameterUpdatedFilePath
echo ::set-output name=parameterUpdatedFilePath::$parameterUpdatedFilePath
```

Validate Deployment
```powershell
Write-Verbose 'Validate deployment' -Verbose

$ValidationErrors = $null
$deployment_name = "${{github.event.inputs.resourceGroupName}}-${{github.run_id}}-${{github.run_id}}-validate"
$templateFilePath = "${{ env.orchestrationPath }}/${{ env.rgFolder }}/deploy.json"
$parameterUpdatedFilePath = "${{ env.orchestrationPath }}/${{ env.rgFolder }}/Parameters/parameters.updated.json"

# Validate deployment
az deployment sub validate --name $deployment_name --location "${{ env.location }}" --template-file $templateFilePath --parameters $parameterUpdatedFilePath

if ($ValidationErrors) {
  Write-Error "Template is not valid."
}
``` 
{% endraw  %}

Deployment Step

{% raw  %}
```powershell
 Write-Verbose 'Handling subscription level deployment' -Verbose

$ValidationErrors = $null

$deployment_name = "${{github.event.inputs.resourceGroupName}}-${{github.run_id}}-${{github.run_id}}-validate"
$templateFilePath = "${{ env.orchestrationPath }}/${{ env.rgFolder }}/deploy.json"
$parameterUpdatedFilePath = "${{ env.orchestrationPath }}/${{ env.rgFolder }}/Parameters/parameters.updated.json"

# Create deployment
az deployment sub create --name $deployment_name --location "${{ env.location }}" --template-file $templateFilePath --parameters $parameterUpdatedFilePath

if ($ValidationErrors) {
  Write-Error "Template is not valid."
}
```
{% endraw  %}

## Example - Bash Script and bicept

I'm starting to look more at bicept. Here is an example of what is in my GitHub Actions workflow for one of the steps using powershell to update the arm template parameter file with values from the user.

Get Parameters from user

{% raw  %}
```bash
# Get params
target_env=${{github.event.inputs.environment}}
rg_region=${{github.event.inputs.location}}

echo create provision_connectivity in $location
./script/devops.sh provision_connectivity --location "$location"
```

Update Parameters Step
```bash
local env_file="${PROJ_ROOT_PATH}/.env"
local deployment_name="${app_name}.Provisioning-${run_date}"

# Pass additional parameters to overide the defaults defined in the parameters file
additional_parameters=("applicationName=$app_name")
if [ -n "$ENV_NAME" ]
then
    additional_parameters+=("environmentName=$ENV_NAME")
fi

if [ -n "$AZURE_LOCATION" ]
then
    additional_parameters+=("location=$AZURE_LOCATION")
fi

echo "Deploying ${deployment_name} in $location with ${additional_parameters[*]}"
az deployment sub create \
    --name "${deployment_name}" \
    --location "$location" \
    --template-file "${PROJ_ROOT_PATH}/infra/main.bicep" \
    --parameters "${PROJ_ROOT_PATH}/infra/main.parameters.json" \
    --parameters "${additional_parameters[@]}"

# Get the output variables from the deployment
output_variables=$(az deployment sub show -n "${deployment_name}" --query 'properties.outputs' --output json)
echo "Save deployment $deployment_name output variables to ${env_file}"
{
    echo ""
    echo "# Deployment output variables"
    echo "# Generated on ${ISO_DATE_UTC}"
    echo "$output_variables" | jq -r 'to_entries[] | "\(.key | ascii_upcase )=\(.value.value)"' 
}>> "$env_file"
```
{% endraw  %}

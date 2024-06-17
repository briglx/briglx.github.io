---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Organize GitHub Parameters for Infrastructure as Code"
date: "2024-02-14"
tags:
  - "Cloud"
  - "GitHub"
  - "IaC"
---

Here are more details on how I organize parameters and variables as a follow-up to my previous post on [Infrastructure as Code Patterns](/2023/12/08/infrastructure-as-code-patterns/).

Remember:
* `Domains` help me decide where to define variables and when to pass parameters.
* `Tools` are the processes that use variables and parameters.
* `Variables` are values that can change between deployments.
* `Parameters` are variables used to pass information between domains.

| Domain | Description | 
| ------ | ----------- | 
| Human Computer Interaction (HCI) or Trigger | UI a person uses to change parameters for a deployment. <br> <note>Note: The human could be replaced by an Automation that triggers the interaction</note> |
| Automation Plane | Tool used to take the UI or Trigger parameters and execute a deployment.  |
| Deployment | Tool use to deploy resources to an environment. |
| Target | Environment where resources are deployed. |

Domains have additional areas to consider:
* Framework
  * Command Plane: Variables available to the framework and commands. For example:
    * GitHub Actions: `github.run_id`, `runner.os`
    * bicep:  [`managementGroup()`](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-functions-scope#management-group-example)
  * Runner Plane: Variables available to the host machine or environment executing the commands. For example:
    * GitHub Actions. `GITHUB_RUN_ID` available as an OS environment variables.
* Reusabilty
  * Orchestration: Uses resuable modules.
    * GitHub Action [caller workflow](https://docs.github.com/en/actions/using-workflows/reusing-workflows)
    * Azure ARM Parent template
    * Bicep Parent file.
  * Modules: Generic resuable components. 
    * GitHub Action [reusable workflow](https://docs.github.com/en/actions/using-workflows/reusing-workflows)
    * Azure ARM [linked template](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/linked-templates?tabs=azure-powershell)
    * [bicep module](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/modules)

## Domain Paramter Sequence
![Domain Parameter Sequence]({{ site.url }}{{ site.baseurl }}/assets/images/20240214-cd-iac-parameters-overview.png)

1. **HCI/Trigger** - The user or automation triggers the automation orchestration which calls the first child modules which calls the deployment tool.
2. **Deployment** - The orchestration calls two child modules which call the resource api to create the target resources.
3. **Deployment** - The automation orchestration calls the second module which calls a deployment with only one child module.

## GitHub Variables and Parameters

In the GitHub world there are several places to set variables and parameters.

| Type | Description | Access | Setting  | Example |
| ---- | ----------- | ------- | ------- | ------- |
| [Environment variables](https://docs.github.com/en/actions/learn-github-actions/variables) | Global variable for a single workflow | Command Plane: <ul><li>[`env`](https://docs.github.com/en/actions/learn-github-actions/contexts#env-context) context</li></ul><br>Runner Plane:<ul><li>os environment variable</li></ul> | Command Plane:<ul><li>workflow `env`</li><li>`jobs.<job_id>.env`</li><li>`jobs.<job_id>.steps[*].env`</li></ul><br>Runner Plane:<ul><li>`echo "my_var=example" >> "$GITHUB_ENV"`</li></ul>  | <ul><li> `PYTHON_VERSION`, `CMAKE_OPTIONS`, `CUDA_PATH` </li><li>...</li></ul> |
| [Default environment variables](https://docs.github.com/en/actions/learn-github-actions/variables#default-environment-variables) | Variables available to every step in a workflow. | <ul><li>environment variable</li><li>[context](https://docs.github.com/en/actions/learn-github-actions/contexts) property</li></ul> | Value set by GitHub | <ul><li>`GITHUB_RUN_ID`, `RUNNER_OS`</li><li>`github.run_id`, `runner.os`</li></ul> |
| [Configuration Variables](https://docs.github.com/en/actions/learn-github-actions/variables#defining-configuration-variables-for-multiple-workflows) | Global variables for use across multiple workflows. | `vars` context. | <ul><li>[organization](https://docs.github.com/en/actions/learn-github-actions/variables#creating-configuration-variables-for-an-organization)</li><li>[repository](https://docs.github.com/en/actions/learn-github-actions/variables#creating-configuration-variables-for-a-repository)</li><li>[environment](https://docs.github.com/en/actions/learn-github-actions/variables#creating-configuration-variables-for-an-environment)</li></ul> | <ul><li>`DOCKERHUB_REPO`, `APPLE_DEVELOPER_ID`, `DEFAULT_REGION`, `ORG_TENANT_ID`</li></ul> |
| Workflow inputs  | Parameters passed by a user or trigger. | <ul><li>[`github.event.inputs`](https://docs.github.com/en/actions/learn-github-actions/contexts#inputs-context)</li><li>[`on.workflow_call.inputs`](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#onworkflow_callinputs)</li><li>[`on.workflow_dispatch.inputs`](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#onworkflow_dispatchinputs)</li></ul> | UI or event call |


## Mapping GitHub Variables and Parameters to Domains

| Type | Domain |  Usage | GitHub | Example |
| ---- | ------------- | ------------- | ----- | ------- |
| Org Global | Automation | Variables used between repos and workflows. | [Configuration Variables](https://docs.github.com/en/actions/learn-github-actions/variables#defining-configuration-variables-for-multiple-workflows) | `DOCKERHUB_REPO`, `APPLE_DEVELOPER_ID`, `DEFAULT_REGION`, `ORG_TENANT_ID` |
| Input parameters | HCI - Automation |  Pass paramter between domains  |  Workflow inputs | `env`, `skip_coverage`, `release_type`, `profile` |



## Other Stuff
| Type  | Capability | Domain | Usage | Example |
| ----- | --------- | ------ | ----- | ------- |
| [Environments](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment) | Group Custom Variables and Secrets | HCI/Trigger | Configure environments  | `dev`, `test`, `prod`, `stable`, `canary`, `release` |
| | Input variables | HCI/Trigger | Parameters passed to an action, resuable workflow, or manually triggered workflow. Parameters that change for each deployment. | `env`, `skip_coverage`, `release_type`, `profile` |
| Org - Custom [Variables](https://docs.github.com/en/actions/learn-github-actions/variables) | Global variable | Automation Plane | Org wide variable used between repos and workflows. | `DOCKERHUB_REPO`, `APPLE_DEVELOPER_ID`, `DEFAULT_REGION`, `ORG_TENANT_ID` |
| Org - [Secrets](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions#creating-secrets-for-an-organization) |  Global Secure variable | Automation Plane | Org wide secure variable used between repos and workflows.  | `CODE_SCANNING_TOKEN`, `CERTIFICATE_BASE64` |
| Repo - Custom [Variables](https://docs.github.com/en/actions/learn-github-actions/variables) | Global variable | Automation Plane | Repo wide variable used between workflows. | `VERSION`, `CHANGELOG_BRANCH`, `BASE_FOLDER_PATH`, `IAC_PATH` |
| Repo - [Secrets](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions#creating-secrets-for-a-repository) |  Global Secure variable | Automation Plane | Repo wide secure variable used between workflows.  | `CODECOV_TOKEN`, `REGISTRY_PASSWORD`, `DOCKERHUB_TOKEN`, `REPO_DISPATCH_TOKEN` |
| Workflow - Custom [Variables](https://docs.github.com/en/actions/learn-github-actions/variables) | Global variable | Automation Plane | Variable used between workflow jobs. | `PYTHON_VERSION`, `CMAKE_OPTIONS`, `CUDA_PATH` |
| Workflow - [Secrets](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions) | Global secure variable | Automation Plane | Secure variable used between workflow jobs. |  |
| Job - Custom [Variables](https://docs.github.com/en/actions/learn-github-actions/variables) | Global variable | Automation Plane | Variable used between job steps. | `PYTHON_VERSION`, `CMAKE_OPTIONS`, `CUDA_PATH` |
| Job - [Secrets](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions) | Global secure variable | Automation Plane | Secure variable used between job steps. |  |
| Step - Custom [Variables](https://docs.github.com/en/actions/learn-github-actions/variables) | Variable | Automation Plane | Variable used for a single step. | `CLIENT_SECRET`, `PYPI_API_TOKEN`, `AWS_ACCESS_KEY_ID`, `API_TOKEN`  |
| Step - [Secrets](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions) | Secure variable | Automation Plane | Secure variable used for a single step. | `GITHUB_TOKEN`, `OAUTH_TOKEN`, `OPENAI_API_KEY`, `CLIENT_ID` |

## IaC Parameter Types

ARM Templates

| Type  | Capability | Domain | Usage | Example |
| ----- | --------- | ------ | ----- | ------- |
| Parameter | Input variables  | HCI | Variable used to pass information | `location`, `environment`, `region`, `sku` |
| Parameter File | Group Custom Variables | HCI | Deployment environment | `dev`, `test`, `prod`, `stable`, `canary`, `release` |
| Secure | Secure variable | HCI | Secret or sensitive information | `client_id`, `client_secret` |
| Configuration Variables | Group Custom Variables | Deployment | Configure environments | `dev`, `test`, `prod`, `stable`, `canary`, `release` |
| Variable | Global Variable | Deployment | Variable used between resources or deployment steps | `resource_group_name`, `location`, `storage_account_name`, `container_name` |
| Outputs | Return value | Deployment | Return value from a deployment | `resource_id`, `resource_name`, `endpoint` |

Bicept

| Type  | Capability | Domain | Usage | Example |
| ----- | --------- | ------ | ----- | ------- |
| Parameter | Input variables | Deployment | Variable used to pass information | `location`, `environment`, `region`, `sku` |
| Variable | Global Variable | Deployment | Variable used between resources or deployment steps | `resource_group_name`, `location`, `storage_account_name`, `container_name` |
| [Configuration set](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/patterns-configuration-set) | Group Custom Variables | Deployment | Configure environments | `dev`, `test`, `prod`, `stable`, `canary`, `release` |
| Outputs | Return value | Deployment | Return value from a deployment | `resource_id`, `resource_name`, `endpoint` |


## General Best Practices

* Always use parameters for user names, passwords, secrets, and other sensitive information.
* Don't store secrets in the code or parameter files. Use a secret store.
* Use variables for values that you need to use more than once in a workflow or IaC template.
* Use variables for values that must be unique
* Use variables for complex expressions.
* Remove unused parameters and variables.
* Set variable values in the right domain.
* Use parameters to pass information between domains.
* Avoid outputing sensitive data.
* 


## Example Configuration

This example uses the following parameters.

```
ENV_CONTEXT_VAR
ORGANIZATION_VAR
REPOSITORY_VAR 
JOB_NAME
USE_VARIABLES
RUNNER
ENVIRONMENT_STAGE
OVERRIDE_VAR
HELLO_WORLD_STEP
HELLO_WORLD_ENABLED
GREET_NAME
```

```yaml
on:
  workflow_dispatch:
env:
  # Setting an environment variable with the value of a configuration variable
  env_var: ${{ vars.ENV_CONTEXT_VAR }}

jobs:
  display-variables:
    name: ${{ vars.JOB_NAME }}
    # You can use configuration variables with the `vars` context for dynamic jobs
    if: ${{ vars.USE_VARIABLES == 'true' }}
    runs-on: ${{ vars.RUNNER }}
    environment: ${{ vars.ENVIRONMENT_STAGE }}
    steps:
    - name: Use variables
      run: |
        echo "repository variable : $REPOSITORY_VAR"
        echo "organization variable : $ORGANIZATION_VAR"
        echo "overridden variable : $OVERRIDE_VAR"
        echo "variable from shell environment : $env_var"
      env:
        REPOSITORY_VAR: ${{ vars.REPOSITORY_VAR }}
        ORGANIZATION_VAR: ${{ vars.ORGANIZATION_VAR }}
        OVERRIDE_VAR: ${{ vars.OVERRIDE_VAR }}
        
    - name: ${{ vars.HELLO_WORLD_STEP }}
      if: ${{ vars.HELLO_WORLD_ENABLED == 'true' }}
      uses: actions/hello-world-javascript-action@main
      with:
        who-to-greet: ${{ vars.GREET_NAME }}
```



[GitHub Environments](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment) are a way to group parameters.  This is useful for defining parameters for different environments.  For example, you might have a `dev`, `test`, and `prod` environment.  Each environment would have different parameters.

## References
* Example Workflows https://github.com/supertokens/next.js/tree/canary/.github/workflows
* Example CI Workflow https://github.com/ITJamie/salt/blob/master/.github/workflows/ci.yml
* Example choose environment based on eventy type, branch name https://github.com/Fuzzkatt/pytorch/blob/ec18ef62f44e68e154b939ed4f860a2bda69716d/.github/workflows/_binary-upload.yml#L77
* https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment
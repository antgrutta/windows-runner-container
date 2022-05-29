$CONFIG_CMD = "C:\actions-runner\config.cmd"
$CONFIG_OPTIONS = "--unattended --replace --token $env:RUNNER_TOKEN"

if (-not [Environment]::GetEnvironmentVariable('GITHUB_URL')){
  $GITHUB_URL = "https://github.com/"
}else{
  $GITHUB_URL = [Environment]::GetEnvironmentVariable('GITHUB_URL')
}

if ([Environment]::GetEnvironmentVariable('RUNNER_ORG') -and [Environment]::GetEnvironmentVariable('RUNNER_REPO') -and [Environment]::GetEnvironmentVariable('RUNNER_ENTERPRISE')){
  $CONFIG_OPTIONS += " --url ${GITHUB_URL}${env:RUNNER_ORG}/$env:RUNNER_REPO"
} elseif ([Environment]::GetEnvironmentVariable('RUNNER_ORG')) {
  $CONFIG_OPTIONS += " --url ${GITHUB_URL}${env:RUNNER_ORG}"
} elseif ([Environment]::GetEnvironmentVariable('RUNNER_REPO')) {
  $CONFIG_OPTIONS += " --url ${GITHUB_URL}${env:RUNNER_REPO}"
} elseif ([Environment]::GetEnvironmentVariable('RUNNER_ENTERPRISE')) {
  $CONFIG_OPTIONS += " --url ${GITHUB_URL}enterprises/$env:RUNNER_ENTERPRISE"
}

if ([Environment]::GetEnvironmentVariable('RUNNER_NAME')){
  $CONFIG_OPTIONS += " --name $env:RUNNER_NAME"
} else {
  $CONFIG_OPTIONS += " --name windows-container-runner"
}

if (-not [Environment]::GetEnvironmentVariable('RUNNER_GROUP')){
  $CONFIG_OPTIONS += " --runnergroup Default"
} else {
  $CONFIG_OPTIONS += " --runnergroup $env:RUNNER_GROUP"
}

if ([Environment]::GetEnvironmentVariable('RUNNER_EPHEMERAL')){
  $CONFIG_OPTIONS += " --ephemeral"
}

if ([Environment]::GetEnvironmentVariable('RUNNER_LABELS')){
  $CONFIG_OPTIONS += " --labels '$env:RUNNER_LABELS'"
}

Invoke-Expression "$CONFIG_CMD $CONFIG_OPTIONS"

.\actions-runner\run.cmd;

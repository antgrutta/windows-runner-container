FROM mcr.microsoft.com/windows/servercore:ltsc2019

LABEL org.opencontainers.image.authors Anthony Grutta
LABEL org.opencontainers.image.title Windows Runner Container
LABEL org.opencontainers.image.description This image is a base image for the GitHub Self-Hosted runner for the Windows platform.
LABEL org.opencontainers.image.source https://github.com/antgrutta/windows-runner-container
LABEL org.opencontainers.image.documentation https://github.com/antgrutta/windows-runner-container/README.md

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';$ProgressPreference='silentlyContinue';"]

ARG RUNNER_VERSION=VERSION

# Install GitHub Runner
RUN Invoke-WebRequest -Uri https://github.com/actions/runner/releases/download/v$env:RUNNER_VERSION/actions-runner-win-x64-$env:RUNNER_VERSION.zip -OutFile runner.zip
RUN Expand-Archive -Path $pwd/runner.zip -DestinationPath C:/actions-runner

ADD entrypoint.ps1 entrypoint.ps1

CMD [ "pwsh", "entrypoint.ps1"]

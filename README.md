# GitHub Self-Hosted Runner Windows Container

This project aims to create a self-hosted runner for GitHub Actions using Windows containers that is compatible with the [actions-runner-controller](https://github.com/actions-runner-controller/actions-runner-controller).

## Getting Started

I used [Azure Kubernetes Service](https://docs.microsoft.com/en-us/azure/aks/) for developing this solution. While I am sure all this can be done with other flavors of Kubernetes, this documentation will be AKS focused.

### Prerequisites

- A Kubernetes cluster with a Windows node pool using `conatinerd`, [AKS and containerd](https://docs.microsoft.com/en-us/azure-stack/aks-hci/use-containerd-on-windows-aks).
- A working install of the [actions-runner-controller](https://github.com/actions-runner-controller/actions-runner-controller).
- A container repository for Kubernetes to retrieve the image from ([GitHub Packages](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry), [Azure Container Registry](https://docs.microsoft.com/en-us/azure/container-registry/), [Docker Hub](https://hub.docker.com/)).

### Building Locally

Ensure you have [Docker Desktop installed](https://docs.microsoft.com/en-us/virtualization/windowscontainers/quick-start/set-up-environment?tabs=Windows-10-and-11) on your Windows machine.

Using the included `Dockerfile`, include the `RUNNER_VERSION` in the `docker build` command.

```
docker build -t winrunner --build-arg RUNNER_VERSION=<VERSION NUMBER> .
```

## Using the Image with the Runner Controller

An example `RunnerDeployment` using the image, given this is a Windows-based container you may need to add whatever tolerations and or labels you are using to select your Kubernetes Windows node pool:

```
apiVersion: actions.summerwind.dev/v1alpha1
kind: RunnerDeployment
metadata:
  name: example-org-win-runner
spec:
  replicas: 2
  template:
    spec:
      image: ghcr.io/antgrutta/winrunner:latest
      dockerdWithinRunnerContainer: true
      organization: antgrutta
```

### Adding to the container

The file `Dockerfile-example` is included in the repository to demonstrate how one might add some common tooling to the container to make it more useful.

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are greatly appreciated.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement". Don't forget to give the project a star! Thanks again!

- Fork the Project
- Create your Feature Branch (git checkout -b feature/AmazingFeature)
- Commit your Changes (git commit -m 'Add some AmazingFeature')
- Push to the Branch (git push origin feature/AmazingFeature)
- Open a Pull Request

## Acknowledgements

This project was inspired by the excellent work of others, this list contains links to the original projects/articles used in creating this project.

- [actions-runner-controller](https://github.com/actions-runner-controller/actions-runner-controller)
- [docker-github-self-hosted-runner](https://github.com/rajyraman/docker-github-self-hosted-runner)
- [Dockerized self-hosted runner on Windows](https://github.com/shivammathur/setup-php/wiki/Dockerized-self-hosted-runner-on-Windows)
- [GitHub Self-Hosted Runner inside a container](https://dreamingincrm.com/2020/12/02/github-self-hosted-runner-inside-a-container/)

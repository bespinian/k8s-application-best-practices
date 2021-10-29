# Use unprivileged containers

The default user in a container is `root`. Hence, if an attacker manages to escape a container, they may obtain superuser privileges on the Kubernetes node on which this container happens to be running at the time. In order to prevent this, Kubernetes has means of enforcing containers to run as certain non-privileged users. Furthermore, some Kubernetes distributions even make this the default. This means that an applications container images must be capable of running under a non-root user. Hence, they should

1. define their own user at `Dockerfile`-level and
2. not expose their application on privileged ports, i.e. ports below `1023`

## Examples

Two deployments which enforce that their containers run as non-root users. One deployment uses an [NGINX container image which uses a non-root user](https://github.com/nginxinc/docker-nginx-unprivileged/blob/main/Dockerfile-alpine.template), the other deployment uses an [NGINX image which runs with the root user](https://hub.docker.com/_/nginx?tab=description).

Deploy the example using the following command:

```shell
kubectl apply -f examples/
```

Note that the Pod with the unprivileged container starts properly, but the Pod with the privileged container fails to start because it does not receive the necessary privileges by Kubernetes.

Clean up using the following command:

```shell
kubectl delete -f examples/

```

# Read-only filesystem

By default a container's filesystem is writable when the container is running in Kubernetes. This means that an application may store ephemeral data in the container's filesystem or make changes to config files for example. However, it also means that an attacker who manages to break out of an application into the container could make changes to configuration files or even install new tools in the container. Hence, all containers should be configured with the option `readOnlyRootFilesystem: true` in their `securityContext` section. Furthermore, specific writable directories which are required by applications (say to store data) must be mounted into the container as writable volumes.

## Examples

Two deployments of NGINX which run their containers with a read-only filesystem. One deployment mounts `/tmp` as a writable in-memory volume the other one does not.

Deploy the example using the following command:

```shell
kubectl apply -f examples/
```

Note that the Pod without `/tmp` mounted as a writable volume fails to start because NGINX needs to write to `/tmp`. The deployment which mounts `/tmp` as a writable volume starts correctly.

Clean up using the following command:

```shell
kubectl delete -f examples/
```

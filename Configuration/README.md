# Configure components via environment variables and use ConfigMaps for configuration parameters

In Kubernetes any configuration of an application component which varies between environments must be passed in to the relevant containers from outside. This can happen either

1. by directly passing values as environment variables (such values can be provided explicitely or fetched from ConfigMaps or Secrets) or
1. by using file-based [ConfigMaps](https://kubernetes.io/docs/concepts/configuration/configmap) to mount config files in the relevant locations of a containers file system

## Rule of thumb
It should never be necessary to open an shell in a container in order to set some configuration options before an application component is started.

## Examples

Two NGINX deployments. One obtains its config via a ConfigMap mounted as a volume. The other one obtains parts of its config via environment variables. In the latter case, one environment variable is set explicitely, another one is read from a ConfigMap.

Use the following command to apply the deployments

```
kubectl apply -f examples/
```

Check the pods and remember their IPs

```
kubectl get pods -o wide
```

Make requests the nginx instances and check the outputs

```
kubectl run curl --image=curlimages/curl --rm -it -- curl <Pod 1 IP>

kubectl run curl --image=curlimages/curl --rm -it -- curl <Pod 2 IP>
```

Use the following command to delete the deployments

```
kubectl delete -f examples/
```

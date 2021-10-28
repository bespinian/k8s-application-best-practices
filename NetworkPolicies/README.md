# Restricting network connectivity

In Kubernetes network connectivity is open by default. This means that, by default, any pod can reach any port on any other pod in the same Kubernetes cluster. This is often useful in a development setting but when deploying productive applications, network connectivity needs to be restricted to the necessary communication by using [NetworkPolicies](https://kubernetes.io/docs/concepts/services-networking/network-policies).

## What NetworkPolicies can do

Network policies are firewall rules which act at the Container Network Interface level on layer 3 and 4. With NetworkPolicies you can deny and allow traffic between Pods based on the source and destination namespaces, based on source and destination labels assigned to Pods, based on ports and port ranges and based on source and destination IP addresses and IP address ranges.

## What NetworkPolicies cannot do

NetworkPolicies have no insight into traffic at layer 7, i.e. the application layer. They cannot act on such things user or service identity, credentials or certificates. These concerns are typically addressed by adding a service mesh like [Istio](https://istio.io) on top. NetworkPolicies also have no knowledge of the Service or Ingress rules through which Pods might be accessed and they will allow or deny traffic regardless of the presence of such additional resources.

## Examples

The example consists of the following resources:

- A deployment `target` listening on port `1234` with a service which exposes the deployment on port `2345`
- A network policy which denies all ingress traffic in the current namespace
- Another network policy which allows ingress traffic on the `target` deployment for pods which have the label `allowed`
- A deployment `allowed` labeled with `allowed`
- A deployment `denied` not labeled with `allowed`

Deploy the resources with the following command:

```shell
kubectl apply -f examples/
```

Tail the logs of the `target`-deployment's pod:

```shell
kubectl logs $(kubectl get pods --selector=app=target -o jsonpath='{.items[0].metadata.name}') -f
```

Send some traffic from the pod of the `allowed` deployment to the `target` service:

```shell
kubectl exec $(kubectl get pods --selector=app=allowed -o jsonpath='{.items[0].metadata.name}') -- /bin/sh -c "echo 'hello there target!' | nc -v target 2345"
```

Note that the traffic is received and the log line `hello there target!` is logged by the `target` deployment's pod.

Now try sending some traffic from the pod of the `denied` deployment to the `target` service:

```shell
kubectl exec $(kubectl get pods --selector=app=denied -o jsonpath='{.items[0].metadata.name}') -- /bin/sh -c "echo 'hello there target!' | nc -v target 2345"
```

Note that the connection cannot be opened and there is no new log line in the log of the `target` deployment's pod.

Clean up using the following command:

```shell
kubectl delete -f examples/
```

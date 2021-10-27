# Run with Service Accounts

In Kubernetes every namespace has a `default` [ServiceAccount](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/) with which Pods in that namespace are executed. In order to enable more fine grained identity and role based access control and in order to be prepared for a zero-trust setup using service mesh technologies like [Istio](https://istio.io/), all applications should be configured to run under specific service accounts.

## Examples

A deployment running under a specific service account. Use the following command to deploy the example:

```shell
kubectl apply -f examples/
```

Inspect the `serviceAccountName` attribute of the pod which was scheduled:

```shell
kubectl get pod $(kubectl get pods --selector=app=example -o jsonpath='{.items[0].metadata.name}') -o jsonpath='{.spec.serviceAccountName}'
```

Clean up with the following command:

```shell
kubectl delete -f example/
```

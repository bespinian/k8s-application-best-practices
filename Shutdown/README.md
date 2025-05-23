# Graceful Shutdown

Pods of a Deployment (or StatefulSet) can be terminated during normal operation in Kubernetes. When a pod is terminated, Kubernetes executes a [well-defined sequence of steps](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-termination). Most notably, Kubernetes calls a `preStop`-hook in each container of the Pod and subsequently sends `SIGTERM` to the process with PID 1 in each container. Applications should ensure that they can deal with being terminated at any time by implementing custom `preStop`-hooks and reacting to `SIGTERM` with application specific shutdown logic. A sudden termination should never result in an inconsistent application state. If the shutdown procedure of an application takes exceptionally long, the application should specify its own `terminationGracePeriodSeconds` to ensure that its Pods receive enough time to terminate cleanly.

## When do you need to worry about graceful shutdown?

Here are some examples:

- When your application needs to guarantee that it always writes certain log lines when one of its replicas is terminated.
- When your application needs to perform some database operation (commit, rollback) on termination of one of its replicas.
- When your application's replicas need to write some persistent data when terminating.
- When your application's replicas need to make an announcement to their peers (e.g. in a database cluster implemented as a StatefulSet) when being terminated.

## Examples

A Deployment which can reacts to `SIGTERM` and implements a `preStop`-hook. Create it using the following command:

```shell
kubectl apply -f examples/
```

Tail the logs of the associated pod using the following command

```shell
kubectl logs $(kubectl get pods --selector=app=graceful-shutdown -o jsonpath='{.items[0].metadata.name}') -f
```

Open a new shell and delete the deployment using the following command, observing the log lines concerning `SIGTERM` and the `preStop`-hook:

```shell
kubectl delete -f examples/
```

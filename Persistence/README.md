# Persistence

![Diagram of Kubernetes resources with volumes and persistent volume claims focused](img/persistence.png "Persistence")

[Volumes](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir) can be used in Kubernetes to share storage between containers in a Pod. However, by default Volumes (of type `emptyDir`) are not persistent, meaning that they are destroyed whenever the Pod is destroyed (which can happen during normal operation). This means that any data which needs to be persistent and independent of Pod-lifespan needs to be stored in a [Persistent Volume](https://kubernetes.io/docs/concepts/storage/persistent-volumes) which needs to be provisioned using a [Persistent Volume Claim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#reserving-a-persistentvolume).

## What are non-persistent volumes used for?

Non-persistent, Pod-local volumes can be used for sharing and exchanging data between two containers in a Pod, depending on the specific requirements of containers. They can also be used for completely reproducible data such as temporary files or caches used by specific applications. They must never be used for data which needs to survive Pod, Deployment or StatefulSet rescheduling.

## What are persistent volumes used for?

Persistent volumes are used for data which needs to survive Pod rescheduling or even cluster restarts. Storage used by database systems typically falls into this category, but also filesystem storage which is used by legacy applications.

## Examples

A deployment writing lines to a file in a persistent volume. Use the following command to create the persistent volume claim and the deployment:

```shell
kubectl apply -f examples/
```

Check the file in the persistent volume via the running pod:

```shell
kubectl exec $(kubectl get pods --selector=app=data-producer -o jsonpath='{.items[0].metadata.name}') -- cat /data/data-file.txt
```

You will see a line `Some persistent data from ...` containing the name of the currently running pod.

Delete the deployment and re-create it with the following two commands:

```shell
kubectl delete deployment data-producer
kubectl apply -f examples/data-producer.yml
```

If you check the persistent volume again using the same command as above, you will see the old line from the last deployment and a new one from the current deployment.

Clean up using the following command:

```shell
kubectl delete -f examples/
```

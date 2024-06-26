# Declare resource requests and limits for your components

Kubernetes has no knowledge of the resource needs of the containers which make up your application components. Thus, if these are not specified, Kubernetes will schedule your components on any node that happens to have space for the container image's size. In this scenario, if one of your components eventually uses a lot of CPU or memory, it can end up impairing the operation of other components on the same node. On the other hand, it could also happen, that the node does not have enough of a certain resource to meet the demands of your component and consequently your component crashes.

In order to mitigate this problem, [resource requests and limits](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) should always be used. Resource requests tell Kubernetes how much of certain resources (e.g. CPU or memory) the component needs as a minimum. Resource limits tell Kubernetes how much of certain resources the component will need as a maximum. Kubernetes will use the resource request and resource limit declaration of a component in order to make an informed decision on where to schedule the component, minimizing the risk of downtime due to resource shortage while maximizing cluster utilization. Furthermore, [Kubernetes Quality of Service classes](https://kubernetes.io/docs/concepts/workloads/pods/pod-qos/) are determined by how precisely applications declare their resource requests and limits. The highest Quality of Service (class `Guaranteed`) is assigned to applications which declare both requests and limits for memory and cpu and the requests and limits are equal.

Another reason why resource request and limit declarations should be used is, that the cluster operator may choose to impose namespace-level resource quotas on compute resources (i.e. memory and CPU) on particular clusters. This is done to enable different application teams to share a cluster without one team hogging all cluster resources. In this case, components which do not make resource request and limit declarations will produce an error when scheduled.

## Example

An NGINX deployment with one replica with CPU request and limit set to 250 milli-CPUs, memory request and limit set to 128 megabytes.

```shell
kubectl apply -f examples/nginx-deployment.yml
```

Check the Pods with

```shell
kubectl get pods
```

Check that each pod has the requests and limits set as specified, and that each pod receives QoS class `Guaranteed`.

```shell
kubectl describe pod nginx-deployment-<id>
```

Use the following command to delete the deployment:

```shell
kubectl delete -f examples/nginx-deployment.yml
```

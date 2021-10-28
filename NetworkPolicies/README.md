# Restricting network connectivity

In Kubernetes network connectivity is open by default. This means that, by default, any pod can reach any port on any other pod in the same Kubernetes cluster. This is often useful in a development setting but when deploying productive applications, network connectivity needs to be restricted to the necessary communication by using [NetworkPolicies](https://kubernetes.io/docs/concepts/services-networking/network-policies).

## What NetworkPolicies can do

Network policies are firewall rules which act at the Container Network Interface level on layer 3 and 4. With NetworkPolicies you can deny and allow traffic between Pods based on the source and destination namespaces, based on source and destination labels assigned to Pods, based on ports and port ranges and based on source and destination IP addresses and IP address ranges.

## What NetworkPolicies cannot do

NetworkPolicies have no insight into traffic at layer 7, i.e. the application layer. They cannot act on such things user or service identity, credentials or certificates. These concerns are typically addressed by adding a service mesh like [Istio](https://istio.io) on top. NetworkPolicies also have no knowledge of the Service or Ingress rules through which Pods might be accessed and they will allow or deny traffic regardless of the presence of such additional resources.

## Examples

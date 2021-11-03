# Manage variants with the right tools

![Examples of things that may vary between variants of a deployment](./img/variants.png "Variants")

There are two main tools for managing variants and variations in your Kubernetes-based applications, [Kustomize](https://kustomize.io/) and [Helm](https://helm.sh/).

## Kustomize

![Illustration of the way Kustomize works](./img/kustomize.png "Kustomize")

Kustomize uses the approach of overlays to manage variants. It starts from a base of fully functional YAML files which describe an arbitrary set of Kubernetes resources. The resources described in this base usually reflect the productive deployment. For every variant Kustomize lets you define overlays and furthermore use some syntactic sugar for some things which vary frequently. An overlay can be viewed as a transformation from valid YAML to valid YAML.

### When to use Kustomize

- When you have a small number of variants, for example dev, test and prod environments of the same app
- When your variants vary in a few well-defined parameters, the values of which are all known in advance
- When there are no parameters which can take a potentially infinite number of different values (e.g. a domain name which is not known in advance)

### When not to use Kustomize

- When you have a potentially infinite number of variants, which you do not know in advance.
- When there are many different parameters which can vary to produce variants.
- When there are parameters which take a potentially infinite number of values.

In this case you should use Helm instead.

### Example Kustomize setup

An application which has a productive and a development environment. The productive environment is in a namespace called `awesome-app`, the development environment in `awesome-app-dev`. The productive environment is running version `1.0.0` of the application with 3 replicas and has additional liveness and readiness probes. The development environment is running version `2.0.0` of the application with one replica and is using a development instance of the database hosted on Kubernetes.

Create the namespaces with the following commands:

```shell
kubectl create ns awesome-app
kubectl create ns awesome-app-dev
```

Apply the `dev` environment with the following command. As you can see Kustomize is included in `kubectl` via the `-k` option:

```shell
kubectl apply -k examples/kustomize/env/dev
```

Apply the `prd` environment with the following command:

```shell
kubectl apply -k examples/kustomize/env/prd
```

Inspect the deployment by looking at the Pods that were created:

```shell
kubectl get pods -n awesome-app
kubectl get pods -n awesome-app-dev
```

Clean up using the following commands:

```shell
kubectl delete -k examples/kustomize/env/dev
kubectl delete -k examples/kustomize/env/prd
kubectl delete ns awesome-app
kubectl delete ns awesome-app-dev
```

## Helm

![Illustration of the way Helm works](./img/helm.png "Helm")

Helm uses the approach of templates to manage variants. It starts from a set of template files comprised of YAML with Go-template expressions. For every variant you define an additional YAML file with the values which fill the customization points in the templates. The templates themselves are not valid Kubernetes YAML because they contain variables and template expressions.

### When to use Helm

- When you are building an application which will be distributed to customers who will deploy it in an unknown number of variants
- When you need to publish applications for others to consume. Helm uses so-called Helm repos for this purpose

### When not to use Helm

- When you have a small number of variants, for example dev, test and prod environments of the same app
- When your variants vary in a few well-defined parameters, the values of which are all known in advance
- When you have no need to distribute application variants to potentially unknown users.

In this case you should use Kustomize instead.

### Helm example

The analogous example to the Kustomize case. Create the namespaces using the following commands:

```shell
kubectl create ns awesome-helm
kubectl create ns awesome-helm-dev
```

Deploy the `dev` environment using the following command:

```shell
helm install dev examples/helm -f examples/helm/values-dev.yaml --namespace awesome-helm-dev
```

Deploy the `prd` environment using the following command:

```shell
helm install prd examples/helm -f examples/helm/values.yaml --namespace awesome-helm
```

Inspect the deployment by looking at the Pods that were created:

```shell
kubectl get pods -n awesome-helm
kubectl get pods -n awesome-helm-dev
```

List the Helm deployments:

```shell
helm list -A
```

Clean up using the following commands:

```shell
helm uninstall prd --namespace awesome-helm
helm uninstall dev --namespace awesome-helm-dev
kubectl delete ns awesome-helm
kubectl delete ns awesome-helm-dev
```

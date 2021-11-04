# Use Secrets for Sensitive Parameters

If you application requires sensitive configuration parameters like credentials, keys or certificates, you should provide these to the application using [Secrets](https://kubernetes.io/docs/concepts/configuration/secret). Unlike ConfigMaps, secrets are never shown to the user in clear text and they are not intended to be stored as YAML-files in source control. Instead they are either populated manually on the command line or via an integration to a secrets repository like Hashicorp Vault or [Cyberark](https://docs.cyberark.com/Product-Doc/OnlineHelp/AAM-DAP/Latest/en/Content/Integrations/k8s-ocp/cjr-secrets-provider-lp.htm).

## Example

A deployment using a Secret to receive a sensitive parameter.

Create a dummy secret on the command line:

```shell
kubectl create secret generic example-secret --from-literal=password="verysecret"
```

Create a deployment which uses this secret:

```shell
kubectl apply -f examples/
```

Check that the secret is injected correctly:

```shell
kubectl exec $(kubectl get pods --selector=app=secret-example -o jsonpath='{.items[0].metadata.name}') -it -- env
```

Clean up using the following command:

```shell
kubectl delete -f examples/
kubectl delete secret example secret
```

# Use Secrets with care

If you application requires sensitive configuration parameters like credentials, keys or certificates, the Kubernetes-native way to provide these to the application is using [Secrets](https://kubernetes.io/docs/concepts/configuration/secret). Unlike ConfigMaps, secrets are never shown to the user in clear text and they are not intended to be stored as YAML-files in source control. Instead they are either populated manually on the command line. While Secrets provide some level of protection against unintentional compromises, they are not very secure. Indeed, parameters store in Secrets can be inspected in clear text by anyone with read-access to them. Also, Kubernetes offers no native way to rotate secrets on a regular basis, or to control access to secrets in a fine-grained way (beyond namespaces). If a higher level of protection is required, a secrets management solution like [HashiCorp Vault](https://developer.hashicorp.com/vault/docs/platform/k8s) should be used.

## Example

A deployment using a Secret to receive a sensitive parameter.

Create a dummy secret on the command line:

```shell
kubectl create secret generic example-secret --from-literal=password="verysecret"
```

Inspect the secret in clear text

```shell
kubectl get secret example-secret -o template --template={{.data.password}} | base64 -d
```

Clean up using the following command:

```shell
kubectl delete secret example-secret
```

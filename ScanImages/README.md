# Scan your images

Before deploying you should scan all container images which make up your application with a tool like `trivy`. Scanning tools make use of the fact that images are made up of layers, each of which is identified by a unique hash. These hashes can be used to build up global databases of known vulnerabilities, misconfigurations and secret breaches for each image layer.

Scanning your images allows you to detect security issues which sneak into your image via base images and application dependencies.

## Example

Run trivy on the latest version of the unprivileged NGINX image used in other examples:

```shell
trivy image nginxinc/nginx-unprivileged
```

We see that this version contains a number of vulnerabilities.

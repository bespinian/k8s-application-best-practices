# Be declarative

Kubernetes is designed to work with a declaratively described resources which represent the desired state of an application. This desired state can be applied in a deterministic and idempotent way to a Kubernetes cluster and can be versioned as code. A consequence of this is that declaratively described resources can by design not contain variables or take parameters. Consequently, the following Dos and Don'ts apply:

## Do ...

- use technologies like Kustomize or Helm to manage different variants of your application as described in [another chapter of this guide](../Variants/README.md)
- use fixed version number tags when referencing container images

## Don't ...

- use floating version tags like `latest` when referencing container images (these will make your deployment non-deterministic, allowing a new image version to creep in implicitely)

- script your deployments using procedural scripts and imperative `kubectl` commands (or you will end up trying to solve problems Kubernetes would solve for you)

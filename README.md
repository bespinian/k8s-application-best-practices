# caas-best-practices

Best practices for deploying workload to Kubernetes. This repo is in English in order to accommodate multiple audiences (Swisscom, customer, customer's suppliers).

## Topics

- [What is a Pod?](Pods/README.md)

- [Stateless workload: Deployments](Deployments/README.md)

- [Stateful workload: StatefulSets](StatefulSets/README.md)

- [Exposing your components: Services](Services/README.md)

- Unprivileged containers

- Distroless containers

- Be declarative (includes image tagging)

- Log to stdout / stderr

- Expose your metrics on an endpoint

- Configure via environment variables

- Liveness and readiness probes

- Fast startup, graceful shutdown

- Use ConfigMaps for config

- Use Secrets for sensitive parameters

- Run with ServiceAccounts

- Resource requests and limits

- Persistence

- Restricting network connectivity

- Managing variants: Helm

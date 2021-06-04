# caas-best-practices

Best practices for deploying workload to Kubernetes. This repo is in English in order to accommodate multiple audiences (Swisscom, customer, customer's suppliers).

## Topics

- [What is a Pod?](Pods/README.md)

- [Stateless workload: Deployments](Deployments/README.md)

- [Stateful workload: StatefulSets](StatefulSets/README.md)

- [Exposing your components: Services](Services/README.md)

- Liveness and readiness probes

- Log to stdout / stderr

- Restricting network connectivity

- Configure via environment variables

- Use ConfigMaps for config

- Use Secrets for sensitive parameters

- Resource requests and limits

- Unprivileged containers

- Distroless containers

- Be declarative (includes image tagging)

- Expose your metrics on an endpoint

- Fast startup, graceful shutdown

- Run with ServiceAccounts

- Persistence

- Managing variants: Helm

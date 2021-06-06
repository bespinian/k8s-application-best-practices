# caas-best-practices

Best practices for deploying workload to Kubernetes. This repo is in English in order to accommodate multiple audiences (Swisscom, customer, customer's suppliers).

## Topics

- [What is a Pod?](Pods/README.md)

- [Stateless workload: Deployments](Deployments/README.md)

- [Stateful workload: StatefulSets](StatefulSets/README.md)

- [Exposing your components: Services](Services/README.md)

- [Liveness and readiness probes](LivenessReadinessProbes/README.md)

- [Log to stdout / stderr](Logging/README.md)

- Expose your metrics on an endpoint

- Restricting network connectivity

- Configure via environment variables

- Use ConfigMaps for config

- Use Secrets for sensitive parameters

- Resource requests and limits

- Unprivileged containers

- Distroless containers

- Be declarative (includes image tagging)

- Fast startup, graceful shutdown

- Run with ServiceAccounts

- Persistence

- Managing variants: Helm

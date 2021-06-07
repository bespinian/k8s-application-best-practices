# caas-best-practices

Best practices for deploying workload to Kubernetes. This repo is in English in order to accommodate multiple audiences (Swisscom, customer, customer's suppliers).

## Topics

### Application architecture

- [What is a Pod?](Pods/README.md)

- [Stateless workload: Deployments](Deployments/README.md)

- [Stateful workload: StatefulSets](StatefulSets/README.md)

- [Exposing your components: Services](Services/README.md)

- [Liveness and readiness probes](LivenessReadinessProbes/README.md)

- [Log to stdout / stderr](Logging/README.md)

- [Expose your metrics on an endpoint](Metrics/README.md)

- [Configure via environment variables / use ConfigMaps for config](Configuration/README.md)

- Resource requests and limits

- Persistence

- Fast startup, graceful shutdown

### Security

- Use Secrets for sensitive parameters

- Restricting network connectivity

- Unprivileged containers

- Run with ServiceAccounts

- Distroless containers

### Deployment

- Be declarative (includes image tagging)

- Managing variants: Helm

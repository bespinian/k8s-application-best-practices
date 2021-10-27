# caas-best-practices

Best practices for deploying workload to Kubernetes. This repo is in English in order to accommodate multiple audiences (Swisscom, customer, customer's suppliers).

## Best practices

### Application architecture

- [What a Pod is and what a Pod is not](Pods/README.md)

- [Use Deployments for stateless components](Deployments/README.md)

- [Use StatefulSets for stateful components](StatefulSets/README.md)

- [Use Services to expose and access your components](Services/README.md)

- [Use liveness and readiness probes on you components](LivenessReadinessProbes/README.md)

- [Make your components log to stdout / stderr](Logging/README.md)

- [Expose your component's metrics on an endpoint](Metrics/README.md)

- [Configure components via environment variables and use ConfigMaps for configuration parameters](Configuration/README.md)

- [Resource requests and limits](RequestsLimits/README.md)

- [Persistence](Persistence/README.md)

- [Graceful shutdown](Shutdown/README.md)

### Security

- [Run with ServiceAccounts](ServiceAccounts/README.md)

- Restricting network connectivity

- Unprivileged containers

- Distroless containers

### Deployment

- Be declarative (includes image tagging)

- Managing variants: Helm

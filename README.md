# caas-best-practices

Best practices for deploying workload to Kubernetes. This repo is in English in order to accommodate multiple audiences (Swisscom, customer, customer's suppliers).

## Best practices

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

- What is a Pod?

- Stateless workload: Deployments

- Stateful workload: StatefulSets

- Persistence

- Exposing your components

- Restricting network connectivity

- Managing variants: Helm

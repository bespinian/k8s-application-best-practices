# Kubernetes Application Best Practices

Best practices for applications on Kubernetes

`git clone` this repo and work your way through the individual READMEs in the following order:

## App Components

- [What a Pod is and what a Pod is not](Pods/README.md)

- [Use Deployments for stateless components](Deployments/README.md)

- [Resource requests and limits](RequestsLimits/README.md)

- [Use Services to expose and access your components](Services/README.md)

## App Troubleshooting

- [Streamline your troubleshooting efforts](Troubleshooting/README.md)

## App Patterns

- [Use StatefulSets for stateful components](StatefulSets/README.md)

- [Configure components via environment variables and use ConfigMaps for configuration parameters](Configuration/README.md)

- [Persistence](Persistence/README.md)

## App Design

- [Make your components log to stdout / stderr](Logging/README.md)

- [Graceful shutdown](Shutdown/README.md)

## App Monitoring

- [Use liveness and readiness probes on your components](LivenessReadinessProbes/README.md)

- [Expose your component's metrics on an endpoint](Metrics/README.md)

## App Security

- [Run with ServiceAccounts](ServiceAccounts/README.md)

- [Restricting network connectivity](NetworkPolicies/README.md)

- [Unprivileged containers](UnprivilegedContainers/README.md)

- [Read-only filesystem](ReadOnlyFilesystem/README.md)

- [Minimal containers](MinimalContainers/README.md)

- [Scan your images](ScanImages/README.md)

- [Use Secrets with care](/Secrets/README.md)

## App Deployment

- [Be declarative](DeclarativeResources/README.md)

- [Managing variants](Variants/README.md)

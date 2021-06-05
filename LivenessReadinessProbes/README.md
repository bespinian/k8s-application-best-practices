# Liveness, readiness and startup probes

Application components should declare a liveness probe in order to enable Kubernetes to determine whether a particular replica of the component is healthy and functioning as expected. They should also declare a readiness probe in order to enable Kubernetes to determine whether a particular replica is ready for receiving traffic or whether it is too busy. Both liveness and readiness probes can be based on http endpoints, tcp ports or shell scripts which are executed in the respective containers. If a Pod of a Deployment or StatefulSet fails its liveness probe, Kubernetes will terminate it and schedule a new Pod with the same specification. If a Pod of a Deployment fails its readiness probe, Kubernetes will temporarily refrain from sending traffic to that particular Pod and instead send it to other replicas. Startup probes work analogously to readiness probes, but they are only checked during Pod startup. Kubernetes uses the startup probe to determine when it should consider a Pod as started.

## Why do we need liveness probes?

Without a liveness probe, the only way for Kubernetes to check the health of a Pod is to check whether its containers are all running. However, this can still be the case even if the application within the container has crashed. In this case Kubernetes will falsely keep the Pod alive and clients will start noticing the crash.

## Why do we need readiness probes?

Without readiness probes, Kubernetes will send traffic to Pods which are still starting up or to Pods which are busy with a heavy operation. Both will lead to clients noticing timeouts.

## When do we need startup probes?

In case we are dealing with a legacy application which takes an unusually long time to become ready when starting up, we can define a dedicated startup probe. This allows us to be less strict during Pod startup and more strict for measuring readiness when a Pod is running.

## What should liveness, readiness and startup probes check?

Liveness probes should ideally run a quick but semantically complete checks of the health of a Pod. They should check things like "is the database connection working?" or "do I have a connection to the component I depend on?". Readiness probes should check the responsiveness of an average request to the Pod. Startup probes should do the same but with different `failureThreshold` and `periodSeconds` values.

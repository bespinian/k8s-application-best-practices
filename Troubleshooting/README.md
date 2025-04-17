# Streamline your troubleshooting

In this lab, you'll learn how to troubleshoot common issues in Kubernetes applications in a streamlined manner by:​

1. Identifying the problem
1. Gathering relevant information
1. Analyzing logs and events
1. Diagnosing the root cause
1. Applying fixes and verifying the solution​

> There's also a [Talk at Cloud Native Zurich](https://www.youtube.com/watch?v=sk6j7_VFhSc) about this topic. Feel free to check it out in your own time.

## Scenario 1: Pod CrashLoopBackOff

### 📝 Step 1: Deploy a Faulty Application

Apply the following manifest to deploy an application that will crash:​

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: crashpod
spec:
  containers:
    - name: crashcontainer
      image: busybox
      command: ["sh", "-c", "exit 1"]
```

Save this as crashpod.yaml and apply it:​

```bash
kubectl apply -f crashpod.yaml
```

### 🔍 Step 2: Identify the Issue

Check the pod status:​

```bash
kubectl get pods
```

### 📄 Step 3: Gather Logs

Retrieve the logs to understand why the container is crashing:​

```bash
kubectl logs crashpod
```

Since the container exits immediately, you might need to check previous logs:​

```bash
kubectl logs crashpod --previous
```

### 🛠️ Step 4: Diagnose and Fix

The container is exiting with status code 1. Modify the command to keep the container running:​

```yaml
command: ["sh", "-c", "while true; do echo Hello; sleep 10; done"]
```

Update the pod:​

```bash
kubectl delete pod crashpod
kubectl apply -f crashpod.yaml
```

Verify the pod is running:​

```bash
kubectl get pods
```

## 🔍 Scenario 2: ImagePullBackOff

### 📝 Step 1: Deploy with Incorrect Image

Apply a manifest with a non-existent image:​

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: badimagepod
spec:
  containers:
    - name: badimage
      image: nonexistentrepo/nonexistimage:latest
```

Save this as badimagepod.yaml and apply it:​

```bash
kubectl apply -f badimagepod.yaml
```

### 🔍 Step 2: Identify the Issue

Check the pod status:​

```bash
kubectl get pods
```

The pod should be in an `ImagePullBackOff` state.​

### 📄 Step 3: Describe the Pod

Get detailed information about the pod:​

```bash
kubectl describe pod badimagepod
```

Look for events indicating image pull errors.​

#### 🛠️ Step 4: Fix the Image Reference

Update the image to a valid one, such as nginx:latest. Modify the manifest accordingly and reapply:​

```bash
kubectl delete pod badimagepod
kubectl apply -f badimagepod.yaml
```

Verify the pod is running:​

```bash
kubectl get pods
```

## 🔍 Scenario 3: Pending Pod Due to Resource Constraints

### 📝 Step 1: Deploy a Pod with High Resource Requests

Apply the following manifest:​

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: highresourcepod
spec:
  containers:
    - name: highresource
      image: nginx
      resources:
        requests:
          memory: "10Gi"
          cpu: "4"
```

Save this as highresourcepod.yaml and apply it:​

```bash
kubectl apply -f highresourcepod.yaml
```

### 🔍 Step 2: Identify the Issue

Check the pod status:​

```bash
kubectl get pods
```

The pod should be in a Pending state.​

### 📄 Step 3: Describe the Pod

Get detailed information:​

```bash
kubectl describe pod highresourcepod
```

Look for messages indicating insufficient resources.​

### 🛠️ Step 4: Adjust Resource Requests

Reduce the resource requests to fit within the cluster's capacity:​

```yaml
resources:
  requests:
    memory: "256Mi"
    cpu: "0.5"
```

Update the manifest and reapply:​

```bash
kubectl delete pod highresourcepod
kubectl apply
```

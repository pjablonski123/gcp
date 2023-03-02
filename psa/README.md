kubectl label --dry-run=server --overwrite ns default pod-security.kubernetes.io/enforce=restricted
kubectl label --overwrite ns default pod-security.kubernetes.io/enforce=restricted
kubectl get ns --show-labels
https://kubernetes.io/docs/concepts/security/pod-security-standards/

https://console.cloud.google.com/logs/query
resource.type="k8s_cluster"
protoPayload.response.reason="Forbidden"
protoPayload.resourceName="core/v1/namespaces/restricted-ns/pods/nginx"

** privileged-pod.yaml

```
kind: Pod
apiVersion: v1
metadata:
  name: privileged-pod
spec:
  containers:
    - name: privileged-pod
      image: nginx
      securityContext:
        privileged: true
```

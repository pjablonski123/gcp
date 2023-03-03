## Migration to Pod Security Admission

Enhancement to the lab "Securing Google Kubernetes Engine with Cloud IAM and Pod Security Policies, Task 2".

_The Pod Security Standards define three different policies to broadly cover the security spectrum. These policies are cumulative and range from highly-permissive to highly-restrictive. This guide outlines the requirements of each policy.
_


https://kubernetes.io/docs/concepts/security/pod-security-standards/

| Profile | Description |
| ------------- | ------------- |
| Privileged  | Unrestricted policy, providing the widest possible level of permissions. This policy allows for known privilege escalations.|
| Baseline  | Minimally restrictive policy which prevents known privilege escalations. Allows the default (minimally specified) Pod configuration.|
| Restricted | Heavily restricted policy, following current Pod hardening best practices.|

```
kubectl label --dry-run=server --overwrite ns default pod-security.kubernetes.io/enforce=restricted
kubectl label --overwrite ns default pod-security.kubernetes.io/enforce=restricted
kubectl get ns --show-labels
```



privileged-pod.yaml
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

Log observation

https://console.cloud.google.com/logs/query
```
resource.type="k8s_cluster"
protoPayload.response.reason="Forbidden"
protoPayload.resourceName="core/v1/namespaces/restricted-ns/pods/nginx"
```

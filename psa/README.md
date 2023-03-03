## Migration to Pod Security Admission

Enhancement to the lab "Securing Google Kubernetes Engine with Cloud IAM and Pod Security Policies, Task 2".

PodSecurityPolicy (PSP) was deprecated in Kubernetes v1.21, and removed from Kubernetes in v1.25.

Instead of PSP use a different solution. For this purpose you can migrate to Pod Security Admission (PSA) and still enforce restrictions on Pods but with a simpler yet effective solution.

To configure PSA you choose a policy and an action.

1. Security policy

*The Pod Security Standards define three different policies to broadly cover the security spectrum. These policies are cumulative and range from highly-permissive to highly-restrictive. This guide outlines the requirements of each policy.*
source: https://kubernetes.io/docs/concepts/security/pod-security-standards/

| Profile | Description |
| ------------- | ------------- |
| Privileged  | Unrestricted policy, providing the widest possible level of permissions. This policy allows for known privilege escalations.|
| Baseline  | Minimally restrictive policy which prevents known privilege escalations. Allows the default (minimally specified) Pod configuration.|
| Restricted | Heavily restricted policy, following current Pod hardening best practices.|

2. Action/mode

| Mode	| Description | 
| ------------- | ------------- |
| enforce	| Policy violations will cause the pod to be rejected.| 
| audit	| Policy violations will trigger the addition of an audit annotation to the event recorded in the audit log, but are otherwise allowed.| 
| warn	| Policy violations will trigger a user-facing warning, but are otherwise allowed.| 

3. Verify a potential impact of the new PSA policy and apply the label to a selected namespace. In the following example the policy is **restricted** with the mode set to **enforce** in the **default** namespace.
```
kubectl label --dry-run=server --overwrite ns default pod-security.kubernetes.io/enforce=restricted
kubectl label --overwrite ns default pod-security.kubernetes.io/enforce=restricted
kubectl get ns --show-labels
```

4. Deploy the privileged pod.

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

Log observation:
- in a terminal
```
$ kubectl apply -f privileged-pod.yaml
Error from server (Forbidden): error when creating "privileged-pod.yaml": pods "privileged-pod" is forbidden: violates PodSecurity "restricted:latest": host namespaces (hostNetwork=true, hostPID=true), hostPort (container "privileged-pod" uses hostPort 80), privileged (container "privileged-pod" must not set securityContext.privileged=true), allowPrivilegeEscalation != false (container "privileged-pod" must set securityContext.allowPrivilegeEscalation=false), unrestricted capabilities (container "privileged-pod" must set securityContext.capabilities.drop=["ALL"]), runAsNonRoot != true (pod or container "privileged-pod" must set securityContext.runAsNonRoot=true), seccompProfile (pod or container "privileged-pod" must set securityContext.seccompProfile.type to "RuntimeDefault" or "Localhost")
```
- in the GUI: https://console.cloud.google.com/logs/query use specific keywords in a query
```
resource.type="k8s_cluster"
protoPayload.response.reason="Forbidden"
protoPayload.resourceName="core/v1/namespaces/default/pods/nginx"
```

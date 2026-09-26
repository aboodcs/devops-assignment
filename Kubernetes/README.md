1. What is Kubernetes?

A) Kubernetes manages and runs containers across multiple servers and helps keep applications available if one server goes down.

2. Explain the purpose of master and worker nodes, and how to identify whether a node is master or worker.

A) The master node manages the Kubernetes cluster and the worker nodes run the containers.

3. Sample deployment

A) I used this command to create the YAML file:

```bash
kubectl create deployment deploy --image=nginx --replicas=2 --dry-run=client -o yaml > deployment.yaml
```

Then I applied it using this command:

```bash
kubectl apply -f deployment.yaml
```

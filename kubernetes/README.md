-- The Simple Definition:
Kubernetes is an open-source system for automating the deployment, scaling, and management of containerized applicationsacross a group of machines called a cluster.

-- Master and Worker Nodes:

-- Master Node "Control Plane": This's the brain of a cluster, it decides what runs where and watch the cluster. 
-- Worker Node : This where the application runs, it have an agent called [kubelet] which start the pods and reports thier health.

-- How to identify whether a node is master or worker ?
-- You can check Nodes role with this command (kubectl get nodes), this will list all nodes in the cluster along with thier assigned roles, for master node it will get (control-plane, master) in the role column, while the worker node get nothing (none). 


















kubectl create clusterrolebinding serviceaccount-cluster-admin --clusterrole=cluster-admin --group=system:serviceaccount

#apiVersion: rbac.authorization.k8s.io/v1
#kind: ClusterRole
#metadata:
#  name: cluster-admin
#subjects:
#  - kind: Group
#    name: system:serviceaccount


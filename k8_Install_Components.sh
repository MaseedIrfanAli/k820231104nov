
sudo apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
# we should maintain same versions for kubelet kubeadm and kubectl
sudo apt-get update
sudo apt-get install -y kubelet=1.28.0-1.1 kubeadm=1.28.0-1.1 kubectl=1.28.0-1.1
sudo apt-mark hold kubelet kubeadm kubectl7. Create the actual cluster
kubeadm init --pod-network-cidr=192.168.0.0/16

# Note - Notedown the Command to join cluster

# 8. Install the Calico network plugin for pod network 
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

# 9. Untaint the master so that it will be available for scheduling workloads
kubectl taint nodes --all node-role.kubernetes.io/master-

# 10. Get Cluster Nodes
kubectl get nodes
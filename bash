curl -sfL https://get.k3s.io | sh - 
# Check for Ready node, takes ~30 seconds 
sudo k3s kubectl get node 

sudo k3s server &
# Kubeconfig is written to /etc/rancher/k3s/k3s.yaml
sudo k3s kubectl get node

# On a different node run the below command. 
# NODE_TOKEN comes from /var/lib/rancher/k3s/server/node-token on your server
sudo k3s agent --server https://localhost.me:6443 --token ${AIzaSyAvrxOyAVzPVcnzxuD0mjKVDyS2bNWfC10}

gpg --verify guix-system-vm-image-1.4.0.x86_64-linux.qcow2.sig guix-system-vm-image-1.4.0.x86_64-linux.qcow2
# Assuming the file is named guix-system-vm-image-1.4.0.x86_64-linux.qcow2.sig.cpp
# This will strip everything except the signature lines
grep -E "-----BEGIN PGP SIGNATURE-----|-----END PGP SIGNATURE-----|^[A-Za-z0-9+/=]+$" guix-system-vm-image-1.4.0.x86_64-linux.qcow2.sig.cpp > guix-system-vm-image-1.4.0.x86_64-linux.qcow2.sig

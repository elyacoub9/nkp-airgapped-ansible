
deploy nkp airgapped with a private and secure registry (harbor) using ansible.

main tasks:
  - create bootstrap VM 
  - generate ssl certs
  - deploy and configure docker
  - deploy and configure harbor
  - deploy nkp

1. update the system 
   ```bash
   dnf update -y 
   ```

2. update the system 
   ```bash
   dnf install ansible-core -y 
   ```

3. install ansible collections:
   ```bash
   ansible-galaxy collection install community.general # --> community.general:10.5.0 was installed successfully
   ansible-galaxy collection install ansible.posix # --> ansible.posix:2.0.0 was installed successfully
   ansible-galaxy collection install nutanix.ncp # --> nutanix.ncp:2.1.1 was installed successfully
   ```

4. clone this repository:
   ```bash
   git clone https://github.com/elyacoub9/nkp-airgapped-ansible.git
   cd nkp-airgapped-ansible
   ```

5. edit the variables file with your env details:

   a. fill the params in this file vars/all.yaml:
   ```bash
   vim vars/all.yaml  #yum install vim -y 
   ```
   b. customize your management cluster resources (optional):
   ```bash
   vim vars/custom_resources.yaml  
   ```
  if you don’t make any changes to the file, the cluster will use the default (recommended) config.

6. update hosts.ini and generate ssh keys:
   ```bash
   HARBOR_IP=$(grep 'HARBOR_IP:' vars/all.yaml | awk '{print $2}' | tr -d '"')
   echo -e "[bootstrap]\n$HARBOR_IP" > inventory/hosts.ini
   ```
   ```bash
   ssh-keygen -o -f /root/.ssh/id_rsa -N "" -q
   ```

7. play
   - add -v for more detailed output
   ```bash
   ansible-playbook site.yaml 
   ```

**the default login for the bootstrap vm is root:root, which you should change.**

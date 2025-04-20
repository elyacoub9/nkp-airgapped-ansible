
this repository contains ansible playbooks for deploying nkp in an airgapped env with a private and secure registry - harbor.

main tasks:
  - create bootstrap VM 
  - generate ssl certs
  - deploy and configure docker
  - deploy and configure harbor
  - deploy nkp

1. update the system and install ansible
   ```bash
   dnf update -y & dnf install ansible -y
   ```

2. install ansible collections:
   ```bash
   ansible-galaxy collection install nutanix.ncp
   ansible-galaxy collection install community.general
   ```

3. clone this repository:
   ```bash
   git clone https://github.com/elyacoub9/nkp-airgapped-ansible.git
   cd nkp-airgapped-ansible
   ```

4. edit the variables file with your env details:
   ```bash
   vim vars/all.yaml
   ```

5. update hosts.ini and generate ssh keys:
   ```bash
   HARBOR_IP=$(grep 'HARBOR_IP:' vars/all.yaml | awk '{print $2}' | tr -d '"')
   echo -e "[bootstrap]\n$HARBOR_IP" > inventory/hosts.ini
   ```
   ```bash
   ssh-keygen -o -f /root/.ssh/id_rsa -N "" -q
   ```

6. play
   - add -v for more verbose output
   ```bash
   ansible-playbook site.yaml 
   ```


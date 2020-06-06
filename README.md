# hey-my-ws

This is repository of my own configs. Config deploy use ansible.

## Some information

Directory tree:

config                        - all config files
files                         - other files (ex: font file)
include_tasks                 - extra tasks for utilities
group_vars/fedora_30/main.yml - has `dans_tools` vars which has description of
                                all installed tools
host_vars/<host>/main.yml     - special utilities for hosts

## How to use

```bash
git clone https://github.com/HeyLazySunnyKid/hey-my-ws

#!! Add <your host> name to my_ws.ini and my_ws.yml

ansible-galaxy install -f -r requirements.yml

#!! Remove utilities that you don't want to install from 
#!! group_vars/fedora_30/main.yml file 

# Install utilities:
ANSIBLE_DISPLAY_SKIPPED_HOSTS=no ansible-playbook -i my_ws.ini my_ws.yml -K  --limit <your host> --ask-vault-pass
```

#!/bin/bash
#This script check if packer is update
#return:
#  latest - if version if packer on local machine is latest
#  url - if packer not update or not installed, return url of packer zip

set -e

function latest_version(){
  curl 'https://releases.hashicorp.com/packer/' 2>/dev/null |\
      grep 'packer_' |\
      sed -E 's/.*packer_([0-9]+\.[0-9]+\.[0-9]+).*/\1/' |\
      sed '/-/!{s/$/_/}' |\
      sort -V |\
      sed 's/_$//' |\
      tail -1
}

function current_version(){
    if [ $(command -v packer.io) ]; then 
        echo "$(packer.io --version)"
    else
        echo "false"
    fi
}

function update_packer(){
    if [ ! -f "packer_${LAST}_linux_amd64.zip" ]; then
        curl -O "https://releases.hashicorp.com/packer/${LAST}/packer_${LAST}_linux_amd64.zip" 2>/dev/null
    fi
    unzip -d "packer_${LAST}" "packer_${LAST}_linux_amd64.zip"
    install -o root -g root -m755 "packer_${LAST}/packer" "/usr/local/bin/packer.io"
    find . -maxdepth 1 -name 'packer_*' -exec rm -rf {} +
}

CURRENT=$(current_version)
LAST=$(latest_version)

if [[ "$CURRENT" != "$LAST" ]]; then
    update_packer
    echo -n "updated"
else
    echo -n "latest"
fi

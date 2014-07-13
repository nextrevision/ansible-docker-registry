ansible-docker-registry
=======================

Ansible role for installing docker registry

## Using with Docker

    docker pull busybox
    docker tag busybox 192.168.59.4:5000/busybox
    docker push 192.168.59.4:5000/busybox

## Testing
    cd tests && rake vagrant

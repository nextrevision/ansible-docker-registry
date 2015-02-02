ansible-docker-registry
=======================

[![Build Status](https://travis-ci.org/nextrevision/ansible-docker-registry.png?branch=master)](https://travis-ci.org/nextrevision/ansible-docker-registry)

Ansible role for installing docker registry

## Variables

### Default

* ```domain```: Specify a domain name (default: ```localhost```)
* ```log_level```: Log level for the server (default: ```info```)
* ```secret_key```: Secret key used by the registry (default: ```cd8fbaa639122edad0617212ff0a6666```)
* ```storage_type```: Accepts either ```file``` or ```s3``` (default: ```file```)
* ```storage_path```: File path to store registry uploads (default: ```/mnt/registry```)
* ```manage_nginx```: Install nginx and manage docker-registry vhost (default: ```true```)
* ```manage_redis```: Install and manage redis server (default: ```true```)

### SSL Settings
* ```registry_port```: Custom port to have nginx listen on (default: ```80```)
* ```registry_ssl```: Enable SSL on nginx (default: ```false```)
* ```registry_ssl_cert```: Specify a SSL certificate to use (default: ```/etc/ssl/certs/docker_registry.crt```)
* ```registry_ssl_key```: Specify a SSL key to use (default: ```/etc/ssl/private/docker_registry.key```)
* ```create_ssl_cert```: Create a self-signed certificate if ```registry_ssl_cert``` is not present on the system (default: ```true```)

### S3 Storage

* ```s3_region```: optional, will default to US Standard
* ```s3_bucket```: also provides the value for boto_bucket
* ```s3_storage_path```
* ```s3_access_key```
* ```s3_secret_key```

## Note on SSL

If using a self-signed certificate, or no SSL certificate for recent docker versions, you must start the docker daemon with ```--insecure-registry```.

For boot2docker, see https://github.com/boot2docker/boot2docker#insecure-registry.

## Using with Docker

    docker pull busybox
    docker tag busybox 192.168.59.4:5000/busybox
    docker push 192.168.59.4:5000/busybox

## Testing

### Install Dependencies
    bundle install

### Precise w/ Defaults
    rake precise:default

### Precise w/ SSL Self-Signed Cert
    rake precise:ssl

### Trusty w/ Defaults
    rake trusty:default

### Trusty w/ SSL Self-Signed Cert
    rake trusty:ssl

## TODO

* Add basic auth support (requires SSL)
* Extend config options

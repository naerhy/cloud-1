# Cloud-1

Introduction to automation with Ansible.

## Description

The goal of this project is to deploy the same infrastructure of services as in [Inception](https://github.com/naerhy/inception), but on the cloud. Each service (WordPress, Nginx, phpMyAdmin and MariaDB) has to be executed in a separate container using Docker and Docker Compose.  
In order to automate the deployment of this Docker infrastructure, we have to use **Ansible**, an open-source automation tool. It simplifies complex tasks like managing servers, networks, and cloud infrastructure by using yaml files to describe automation jobs, called "playbooks".

We decided to use one of my virtual private server as host for the project, but any available server can be targeted thanks to Ansible inventories.

As a bonus (which didn't award more points during evaluation though...), we made the deployed website accessible from HTTPS only, and bought a domain name then made it point to our server.

## Usage

A Dockerfile can be used in order to try the project without installing any dependencies on your system.

```bash
# build the image
docker build . -t cloud1

# start the container
docker run --rm -it cloud1 /bin/bash
```

Once inside the container, call any defined Makefile commands.

```
make setup

make install

make start

make remove
```

### Secrets

The `secrets.yaml` file holds all the sensitive data about the deployment: the host, user, password and domain name. It is protected by a password which has to be entered before any Ansible commands.

You can generate a new file, or edit the existing one, with a new password in case you have to update these values.

```
# create a new file
ansible-vault create ansible/secrets.yaml

# edit the file
ansible-vault edit ansible/secrets.yaml
```

### Environment variables

Define the following variables in a `.env` file located in the `ansible/playbooks/files` directory. The displayed values only serve as an example.

```
MYSQL_ROOT_PASSWORD=root_password
MYSQL_USER=user
MYSQL_DATABASE=cloud-db
MYSQL_PASSWORD=password

MARIADB_CONTAINER_NAME=mariadb-container
MARIADB_PORT=3306

PHPMYADMIN_CONTAINER_NAME=phpmyadmin-container
PHPMYADMIN_PORT=3337
PMA_HOST=mariadb-container
PMA_USER=user
PMA_PASSWORD=password
PMA_ARBITRARY=1

WP_PORT=3338
WP_CONTAINER_NAME=wp-container
WP_DB_NAME=cloud-db
WP_DB_USER=user
WP_DB_PASSWORD=password
WP_DB_HOST=mariadb-container:3306

NGINX_CONTAINER_NAME=nginx-container
NGINX_PORT=443
```

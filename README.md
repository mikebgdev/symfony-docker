# Symfony Docker

A [Docker](https://www.docker.com/)-based installer and runtime for the [Symfony](https://symfony.com) web framework

Configured to have multiple symfony projects

## Containers

- PHP 8.2-fpm-alpine
- NGINX 1.25-alpine

## Configure environment

Create the .env file from the .env.dist

- PROJECTS_JSON: A json array where we will indicate the name and host of our projects
    - name: the name of the project, if it does not exist in our 'projects' folder, it will be created automatically
    - host: the name of the host to access by the browser and to create your ssl certificates

Example:
```
'{
  "projects": [
    {
      "name": "app",
      "host": "app.localhost"
    },
    {
      "name": "app2",
      "host": "app2.localhost"
    }
  ]
}'
```
- SYMFONY_VERSION: indicates the version of symfony 6 or higher, for example 6.3.*
- SERVER_OWNER: to create the self signed ssl certificate
- HTTP_PORT: your port for http access (80 by default)
- HTTPS_PORT: your port for https access (443 by default)

## Start Docker

* Run `docker-compose up -d --build` to build images for first time or if you change the Dockerfiles
* Run `docker-compose up` to start containters in debug mode, use `-d` if you want run it in the background
* Run `docker-compose restart` to restart containters
* Run `docker-compose stop` to stop containers


### Note: configurare hosts files

When you run docker, if you can't open your host in your browser (for example app.localhost), do the following:

Open your hosts file and add the names of the hosts you added in PROJECTS_JSON

## Credits

Created by [mikebgdev](https://github.com/mikebgdev)

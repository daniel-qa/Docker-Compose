#!/bin/bash

# crate and start
docker-compose up -d

# stop and remove
docker-compose down 

# restart
docker-compose restart

# start
docker-compose start

# stop
docker-compose stop

# logs
docker-compose logs

# ps
docker-compose ps

# images
docker-compose images

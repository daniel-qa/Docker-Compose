## This is Not Work Solution !
> command: bash -c "yum install nano"   ( X )

## After Contain Starting, Use docker-compose exec install Software 
> docker-compose exec httpd /bin/bash -c "apt-get update && apt-get -y install nano"

## Use Docker File RUN command, Install Software

* For Ubuntu:

> RUN apt-get update && apt-get -y install nano vim && apt-get autoremove


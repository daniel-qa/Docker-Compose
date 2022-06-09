```
networks:
  mynet:
    driver: bridge
    ipam:
      driver: default
      config:
        - subnet: 192.168.55.0/24
          gateway: 192.168.55.1

services:
  web:
    image: 'mycompany/webserver:latest'
    hostname: www
    domainname: mycompany.com
    stdin_open: true # docker run -i
    tty: true        # docker run -t
    networks:
      mynet:
        ipv4_address: 192.168.55.10
    ports:
      - '80:80'
      - '443:443'
    volumes:
      - '../honeyfund:/var/www/html'
```

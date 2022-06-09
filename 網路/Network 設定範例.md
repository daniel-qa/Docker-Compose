* Subnet
<img src="https://github.com/daniel-qa/Docker-Compose/blob/main/%E7%B6%B2%E8%B7%AF/getway.png?raw=true" >

```
16 是指8 bit, 為 2個byte 數，是指前面固定不變的部分
如果是 24 則為下面的形式(3個byte 固定)

 - subnet: 192.168.55.0/24
   gateway: 192.168.55.1

gateway 通常為 subnet 前面，然後由 1 開始的位置

```

* 範例 1
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
* 範例2
```
networks:
  Mynetwork:
      driver: bridge
      ipam:
          driver: default
          config:
              - subnet: "192.168.0.0/24"
                gateway: "192.168.0.1"
```


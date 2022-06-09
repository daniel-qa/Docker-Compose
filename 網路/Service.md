

## docker-compose 可以直接用 service 名稱作為 ip 位置


## 最後一個網路設定(總設定)，記得名稱最後要加上冒號  :

```
# Define networks
networks:
  my-network:  
```  


## 固定 IP
```
version: '2'
services:
   nginx:
      image: nginx:1.13.12
      container_name: nginx
      restart: always
      networks:
         extnetwork:
            ipv4_address: 172.19.0.2
 
networks:
   extnetwork:
      ipam:
         config:
         - subnet: 172.19.0.0/16
           gateway: 172.19.0.1
```
> **extnetwork:** 是自定義的網路名稱


* gateway 的格式，應該是   xx.xx.0.1 的格式，前面與容器 IP 相同
* subnet，則是 xx.xx.0.0/16 的格式，前面與容器 IP 相同

# 查詢 Gateway
```
netstat -r
```
# 查詢 Network
```
docker network ls
```



## docker-compose 可以直接用 service 名稱作為 ip 位置


## 最後一個網路設定(總設定)，記得名稱最後要加上冒號  :

```
# Define networks
networks:
  my-network:  
```  


## 固定 IP
```
# Define networks
networks:
  njty-network: 
    ipam: 
      driver: default
      config: 
        - subnet: "172.20.0.0/24"
```

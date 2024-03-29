
https://ithelp.ithome.com.tw/articles/10206725

# Docker Network mode

## Bridge mode
這是 Docker Compose 預設的網路模式，所有有 service 預設 network_mode: 都是 bridge (見 network_mode)。**當我們 docker-compose up 時，會建立一個名為 <dir_name>_default 的 network 出來，所有 bridge mode 的 container 會自己配網路卡並接上那個預設的 network**。

<img src="https://github.com/daniel-qa/Docker-Compose/blob/main/%E7%B6%B2%E8%B7%AF/docker_network.png?raw=true" >

172.28.0.0/16 是指一網路的網段從 172.28.0.1 ~ 172.28.255.255，子網路的主機可以互相通訊。 16 是指 16 bits 的子網路遮罩 255.255.0.0。

你可以用 **docker network ls** 列出所有 network


```
172.28.0.0/16 是指一網路的網段從 172.28.0.1 ~ 172.28.255.255，
子網路的主機可以互相通訊。 16 是指 16 bits 的子網路遮罩 255.255.0.0。
```

### Container 間如何通訊： Container <-> Container

Container 間的通訊有幾個方法：

* 1 .用 service/container name：直接寫 serivce name/container。

就如同前面寫的
```
backend:
        …略
        environment:
            PORT: 3001
            NODE_ENV: "development"
            MONGODB_URL: "mongodb://database:27017"
```
backend 可以訪問 database。

* 2 用 IP: 我們也可以直接指定 IP。

指令 **docker network inspect ithelp-30dayfullstack-day30_default 可以查詢「接上此 network 的 container 資訊」**

**ithelp-30dayfullstack-day30_default 有三個容器及它們配置的 IP。另外還有 gateway 和 subnet。**


### 外界(NET-0)如何存取 container： 外界(NET-0) -> Container

若外界 192.168.0.5 要訪問我們的主機 192.168.0.2:80 的 ithelp.front 服務，我們要設定 --publish/-p。
就是我們在 **Docker file 中的 ports: 或 docker run -p 設定 publish。同時， Network Address Translation(NAT) 也會自動設定內外部 network 的轉換。**


<img src="https://github.com/daniel-qa/Docker-Compose/blob/main/%E7%B6%B2%E8%B7%AF/docker-network2.png?raw=true" >

從外界來看，邏輯上就像：

<img src="https://github.com/daniel-qa/Docker-Compose/blob/main/%E7%B6%B2%E8%B7%AF/docker-network3.png?raw=true">

外界不會發現內部的網路。



## Host mode

這是最簡單的模式，直接想成 container 執行在 HOST 的 process，它監聽什麼 port ， HOST 什麼 port 就會被使用，連 --publish/-p 都不用了。

這模式的通訊比較簡單，不像 bridge mode 複雜。127.0.0.1 就是指 HOST，所以每個容器可以用 127.0.0.1:<port> 通訊，與其它的 HOST 服務也是一樣；外界就是用 192.168.0.2。
```
version: '2'
services:
    database:
        image: mongo:4.1
        container_name: mongo4
        network_mode: "host"
        volumes:
            - "./data/mongo/data:/data/db"
    frontend:
        image: ithelp/frontend:1.0.0
        container_name: ithelp.frontend
        network_mode: "host"
        volumes:
            - "./data/nginx/log:/var/log/nginx"
    backend:
        image: ithelp/backend:1.0.0
        container_name: ithelp.backend
        network_mode: "host"
        command: >
            /bin/bash -c "
            sleep 15;
            npm run start;"
        environment:
            PORT: 3001
            NODE_ENV: "development"
            MONGODB_URL: "mongodb://127.0.0.1:27017"
```
        
<img src="https://github.com/daniel-qa/Docker-Compose/blob/main/%E7%B6%B2%E8%B7%AF/docker-network4.png?raw=true">        

        
# Docker Network mode 小總結
        
我們介紹了 Bridge mode、Host mode，它們有各自的特色：
```
*　bridge mode:

高彈性的網路設定
不同容器間的 port 號可以一樣，因為容器有自己的 IP
可以降低 HOST port 相衝的可能
用起來設定複雜
容器、 HOST 、外界不容易通訊

* Host mode：

容易與 HOST port 、容器 port 的相衝、
用起來設定簡單
容器、 HOST 、外界容易通訊        
   
```
        
***
## Docker-compose 使用外部網路


* 使用 pre-existing network

如果希望容器加入預先定義好的 network，就可以使用 external option。

如果 external 設為 true，就會指定已在 Compose 之外先建立的那個 network，所以 docker-compose up 不會嘗試建立此 network。

如果此 network 不存在，會因為找不到參考的目標 network 而發生錯誤。錯誤如下：

```
$ docker-compose up
ERROR: Network my_network declared as external, but could be found. Please create the network manually using `docker network create my_network` and try again.
```
如果找不到此 network，可以執行 **docker network create [network_name]** 來建立 network。

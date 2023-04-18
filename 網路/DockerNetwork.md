
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
backend 可以訪問 database。
```
* 2 用 IP: 我們也可以直接指定 IP。
* 
指令 **docker network inspect ithelp-30dayfullstack-day30_default 可以查詢「接上此 network 的 container 資訊」**

ithelp-30dayfullstack-day30_default 有三個容器及它們配置的 IP。另外還有 gateway 和 subnet。

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

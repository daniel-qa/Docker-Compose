
https://ithelp.ithome.com.tw/articles/10206725

<img src="https://github.com/daniel-qa/Docker-Compose/blob/main/%E7%B6%B2%E8%B7%AF/docker_network.png?raw=true" >

172.28.0.0/16 是指一網路的網段從 172.28.0.1 ~ 172.28.255.255，子網路的主機可以互相通訊。 16 是指 16 bits 的子網路遮罩 255.255.0.0。

你可以用 docker network ls 列出所有 network


```
172.28.0.0/16 是指一網路的網段從 172.28.0.1 ~ 172.28.255.255，
子網路的主機可以互相通訊。 16 是指 16 bits 的子網路遮罩 255.255.0.0。
```



## Docker-compose 使用外部網路


* 使用 pre-existing network

如果希望容器加入預先定義好的 network，就可以使用 external option。

如果 external 設為 true，就會指定已在 Compose 之外先建立的那個 network，所以 docker-compose up 不會嘗試建立此 network。

如果此 network 不存在，會因為找不到參考的目標 network 而發生錯誤。錯誤如下：

```
$ docker-compose up
ERROR: Network my_network declared as external, but could be found. Please create the network manually using `docker network create my_network` and try again.
```
如果找不到此 network，可以執行 docker network create [network_name] 來建立 network。

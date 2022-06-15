https://docs.docker.com/engine/reference/commandline/network/

```
docker network inspect	    // Display detailed information on one or more networks
docker network ls	          // List networks
docker network prune	      // Remove all unused networks
docker network rm	          //Remove one or more networks
```

* 網路模式
```
在執行 docker run 指令時，有一個參數是 --net，它可以設定在執行 Docker Container 是要使用哪一種的網路模式，
目前所知道的網路模式有 none、container、host、bridge、overlay… 等等的模式，
它們是透過使用 Linux 的 libnetwork 所建立出來的網路模式，
以下分別說明這些網路模式：

none： 在執行 container 時，網路功能是關閉的，所以無法與此 container 連線

container： 使用相同的 Network Namespace，所以 container1 的 IP 是 172.17.0.2 那 container2 的 IP 也會是 172.17.0.2

host： container 的網路設定和實體主機使用相同的網路設定，所以 container 裡面也就可以修改實體機器的網路設定，因此使用此模式需要考慮網路安全性上的問題

bridge： Docker 預設就是使用此網路模式，這種網路模式就像是 NAT 的網路模式，例如實體主機的 IP 是 192.168.1.10 它會對應到 Container 裡面的 172.17.0.2，在啟動 Docker 的 service 時會有一個 docker0 的網路卡就是在做此網路的橋接。

overlay： container 之間可以在不同的實體機器上做連線，例如 Host1 有一個 container1，然後 Host2 有一個 container2，container1 就可以使用 overlay 的網路模式和 container2 做網路的連線。

```

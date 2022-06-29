# Dockerfile

## Basic Syntax

```
FROM : 建立 image 的 基底image 名稱，可指定版號
ENV : 設定 container 環境變數
WORKDIR : 決定啟動後所在目錄，若目錄不存在則創建一個
RUN : Container 準備階段時指定執行命令，例如 apt-get install -y vim
EXPOSE : 對外暴露出可使用的 ports，建立的容器如果沒有特別將 ports 暴露出來的話，是無法使用特定 port 的
COPY : 建立 container 時想從本機一併複製過去的檔案或目錄
ADD : 除了與 COPY 同樣可以複製本機目錄外，ADD 可以接收來自 URL 的 zip 並解壓縮
CMD : Container 啟動階段時指定執行命令，僅能執行一次次

```

## Build

```
利用 docker build command 將 Dockerfile 實體化成 image。

-t : 標記 image tag(名稱)
--no-cache : 避免被 cache 住，而造成沒有 build 到修改過的 Dockerfile

```

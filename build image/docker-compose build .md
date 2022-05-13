```
build:
  context: ./dir
#   Dockerfile在當前路徑的dir資料夾裡

```
# 範例 1

```
ersion: "3.7"

# Define services/containers
services:
    myos:
      #image: ubuntu:16.04
      stdin_open: true
      tty: true
      build:
        context: ./image

      networks:
        - ubuntu-network

networks:
    ubuntu-network:

```

# 範例 2

```
### PHP-FPM ##############################################
php-fpm:
      build:
        context: ./php-fpm
        args:
        ....
```

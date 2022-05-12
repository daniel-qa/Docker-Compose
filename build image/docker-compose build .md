```
build:
  context: ./dir
#   Dockerfile在當前路徑的dir資料夾裡

```

# 範例

```
### PHP-FPM ##############################################
php-fpm:
      build:
        context: ./php-fpm
        args:
        ....
```

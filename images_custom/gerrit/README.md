## 启动 gerrit 服务

> docker-compose up -d

## 注意事项

问题1： 重启会报错？
  由于我们指定了本地数据路径，可以先删除之前的容器，然后再启动即可。
```sh
$ docker rm -f gerrit_gerrit_1
$ docker-compose up -d
```

问题2: 数据路径的权限要求：
> chmod 777 -R /data/gerrit


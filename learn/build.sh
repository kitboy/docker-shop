# 1. 创建machine
$ docker-machine.exe create -d virtualbox --engine-registry-mirror https://docker.mirrors.ustc.edu.cn master
$ docker-machine.exe ssh master 
    $ docker swarm init --advertise-addr 192.168.99.100
    $ docker swarm join-token worker
        docker swarm join \
        --token SWMTKN-1-3qdgerwwydwez2dcna8n875gmh6trrc8ctn6l6av38undk401t-8mtwtgp6yoeofysnbutomfbjt \
        192.168.99.100:2377
    $ docker login
        kitboy
        doyouwant108
    $ docker pull nginx
    $ docker run hello-world

$ docker-machine.exe create -d virtualbox --engine-registry-mirror https://docker.mirrors.ustc.edu.cn slave1
$ docker-machine.exe ssh slave1 
    $ docker login
$ docker-machine.exe create -d virtualbox --engine-registry-mirror https://docker.mirrors.ustc.edu.cn slave2
$ docker-machine.exe ssh slave2
    $ docker login

$ docker-machine.exe ls
NAME      ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER        ERRORS
default   -        virtualbox   Running   tcp://192.168.99.102:2376           v17.05.0-ce
master    -        virtualbox   Running   tcp://192.168.99.100:2376           v17.05.0-ce
slave1    -        virtualbox   Running   tcp://192.168.99.103:2376           v17.05.0-ce
slave2    -        virtualbox   Running   tcp://192.168.99.104:2376           v17.05.0-ce


# 2. 组建swarm
$ docker-machine.exe ssh master 
    $ docker swarm init --advertise-addr 192.168.99.100
    $ docker swarm join-token worker
        docker swarm join \
        --token SWMTKN-1-3qdgerwwydwez2dcna8n875gmh6trrc8ctn6l6av38undk401t-8mtwtgp6yoeofysnbutomfbjt \
        192.168.99.100:2377
$ docker-machine.exe ssh slave1 
    $ docker swarm join \
        --token SWMTKN-1-3qdgerwwydwez2dcna8n875gmh6trrc8ctn6l6av38undk401t-8mtwtgp6yoeofysnbutomfbjt \
        192.168.99.100:2377
$ docker-machine.exe ssh slave2 
    $ docker swarm join \
        --token SWMTKN-1-3qdgerwwydwez2dcna8n875gmh6trrc8ctn6l6av38undk401t-8mtwtgp6yoeofysnbutomfbjt \
        192.168.99.100:2377

$ docker-machine.exe ssh master 
    $ docker node ls
        ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS
        b3y12wu9ewuisjjw0l817k9gl     slave1              Ready               Active
        knr8xgrclhq27bx4qsulo94kx     slave2              Ready               Active
        so0ljnokm89q6a4h5c1yky8r2 *   master              Ready               Active              Leader

# 3.创建docker image
$ cat Dockerfile
    # Use an official Python runtime as a base image
    FROM python:2.7-slim
    # Set the working directory to /app
    WORKDIR /app
    # Copy the current directory contents into the container at /app
    ADD . /app
    # Install any needed packages specified in requirements.txt
    RUN pip install -r requirements.txt
    # Make port 80 available to the world outside this container
    EXPOSE 80
    # Define environment variable
    ENV NAME World
    # Run app.py when the container launches
    CMD ["python", "app.py"]

$ cat requirements.txt
    Flask
    Redis

$ cat app.py
    from flask import Flask
    from redis import Redis, RedisError
    import os
    import socket

    # Connect to Redis
    redis = Redis(host="redis", db=0, socket_connect_timeout=2, socket_timeout=2)

    app = Flask(__name__)

    @app.route("/")
    def hello():
        try:
            visits = redis.incr("counter")
        except RedisError:
            visits = "<i>cannot connect to Redis, counter disabled</i>"

        html = "<h3>Hello {name}!</h3>" \
            "<b>Hostname:</b> {hostname}<br/>" \
            "<b>Visits:</b> {visits}"
        return html.format(name=os.getenv("NAME", "world"), hostname=socket.gethostname(), visits=visits)

    if __name__ == "__main__":
            app.run(host='0.0.0.0', port=80)
$ docker-machine scp app.py master:~
$ docker-machine scp requirements.txt master:~
$ docker-machine scp Dockerfile master:~
$ docker-machine ssh master
    $ docker build . -t mydock-image
    $ docker images
        REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
        mydock-image        latest              b1069da06234        8 seconds ago       194MB
        python              2.7-slim            4ba53c70eb04        40 hours ago        182MB
        hello-world         latest              48b5124b2768        4 months ago        1.84kB
    $ docker run -d -p 4000:80 mydock-image    # run image as container in background, visit result by http://192.168.99.100:4000
    $ docker container ls
        CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                NAMES
        f4e4b86e0dbb        mydock-image        "python app.py"     22 seconds ago      Up 21 seconds       0.0.0.0:80->80/tcp   brave_thompson
    $ docker stop f4e4b86e0db
    $ docker tag mydock-image kitboy/test:v1.0
    $ docker tag mydock-image kitboy/testdock:v1.0
    $ docker images
        REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
        kitboy/testdock     v1.0                b1069da06234        12 minutes ago      194MB
        mydock-image        latest              b1069da06234        12 minutes ago      194MB
        kitboy/test         v1.0                b1069da06234        12 minutes ago      194MB
        python              2.7-slim            4ba53c70eb04        40 hours ago        182MB
        hello-world         latest              48b5124b2768        4 months ago        1.84kB
    $ docker push kitboy/testdock:v1.0
$ docker-machine ssh slave1
    $ docker pull kitboy/testdock:v1.0
$ docker-machine ssh slave2
    $ docker run -p 80:80 kitboy/testdock:v1.0


# 4.编排Service
$ docker-machine ssh master
    $ cat docker-compose.yml
        version: "3"
        services:
        web:
            # replace username/repo:tag with your name and image details
            image: kitboy/testdock:v1.0
            deploy:
            replicas: 5
            resources:
                limits:
                cpus: "0.1"
                memory: 50M
            restart_policy:
                condition: on-failure
            ports:
            - "80:80"
            networks:
            - webnet
        networks:
        webnet:
    $ docker stack deploy -c ./docker-compose.yml testdock-service
    $ docker stack ls
        NAME              SERVICES
        testdock-service  1
    $ docker stack services testdock-service
        ID                  NAME                   MODE                REPLICAS            IMAGE                  PORTS
        qhn601b0ll4e        testdock-service_web   replicated          5/5                 kitboy/testdock:v1.0   *:80->80/tcp
    $ docker stack ps testdock-service
        ID                  NAME                     IMAGE                  NODE                DESIRED STATE       CURRENT STATE           ERROR               PORTS
        r0acnycbn5tz        testdock-service_web.1   kitboy/testdock:v1.0   master              Running             Running 3 minutes ago
        1skt9no2d995        testdock-service_web.2   kitboy/testdock:v1.0   slave1              Running             Running 3 minutes ago
        7jnlpua0coz4        testdock-service_web.3   kitboy/testdock:v1.0   slave2              Running             Running 2 minutes ago
        uph4opsuyk5f        testdock-service_web.4   kitboy/testdock:v1.0   slave1              Running             Running 3 minutes ago
        q8koqpzt9ajd        testdock-service_web.5   kitboy/testdock:v1.0   slave2              Running             Running 2 minutes ago

    $ docker stack deploy -c ./docker-compose.yml testdock-service #update

# 5.编排服务栈Stack
$ docker-machine ssh master
    $ mkdir ./data
    $ cat docker-compose.yml
        version: "3"
        services:
        web:
            # replace username/repo:tag with your name and image details
            image: kitboy/testdock:v1.0
            deploy:
            replicas: 5
            restart_policy:
                condition: on-failure
            resources:
                limits:
                cpus: "0.1"
                memory: 50M
            ports:
            - "80:80"
            networks:
            - webnet
        visualizer:
            image: dockersamples/visualizer:stable
            ports:
            - "8080:8080"
            volumes:
            - "/var/run/docker.sock:/var/run/docker.sock"
            deploy:
            placement:
                constraints: [node.role == manager]
            networks:
            - webnet
        redis:
            image: redis
            ports:
            - "6379:6379"
            volumes:
            - ./data:/data
            deploy:
            placement:
                constraints: [node.role == manager]
            networks:
            - webnet
        networks:
        webnet:
    $ docker stack deploy -c ./docker-compose.yml testdock-service

在host环境中，如果想执行docker命令等
    1.要么通过docker-machine ssh <machine-name> 进入machine环境
    2.要么通过eval $(docker-machine env <machine-name>) 将machine参数写入环境变量



# 6.安装lamp服务栈

# 6.1 在VirtualBox上创建共享文件夹，使得host能与machine之间共享文件夹
#  将host上的D:/docker目录共享到default machine的docker
$ docker-machine restart default
$ docker-machine ssh default mount        # 查看所有mount
$ docker-machine ssh default ls /docker   # D:/docker被挂载为/docker
$ eval $(docker-machine env default)      # 使得在git bash中可以执行docker命令（写入环境变量，使得docker命令穿透到machine中执行）

# 6.2 准备共享volumn
$ cd D:/docker      # D:/docker -> /d/docker
$ mkdir mysql-data
$ mkdir mysql-conf
$ mkdir html
$ mkdir nginx-conf
$ cat nginx-conf/default.conf
$ cat nginx-conf/h5api.conf

# 6.3 运行mysql容器
$ winpty docker run -itd --rm --name mysql \
    -v //docker/mysql-data:/var/lib/mysql \
    -v //docker/mysql-conf:/etc/mysql/conf.d \
    -e MYSQL_ROOT_PASSWORD=huiyee \
    mysql                                       
    # --rm容器结束后自动删除container
    # -i 交互 -t 生成pty　-d 背景模式运行
    # winpty是为了在git bash中模拟Windows的pty从而能够与容器的bash交互
    # //docker/xxx 在/docker/xxx前加上/前缀，是为了避免git bash的路径自动转换（在git bash中/是git安装目录） 
$ docker ps             # 查看运行容器
$ docker port mysql     # 若要在外部能够访问容器的expose端口，需要加上-p 3306发布（publish）指定端口，或者使用-P选项自动publish所有expose端口
$ docker network inspect bridge     # 容器默认加入bridge网络，并有自己的ip地址（bridge网络只能通过publish端口来访问，host网络自动暴露所有端口，none网络没有网卡）
$ docker logs mysql     # 查看容器日志
$ docker attach mysql   # 将当前pty连接到容器的pty上，使用Ctrl-p Ctrl-q重新将container detach入后台
$ winpty docker exec -it mysql bash    # 在mysql容器上执行命令bash
$ winpty docker run --rm -it --link mysql:mysql mysql \ 
    sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -phuiyee'
    # 通过--link container:alias来使得当前容器能够网络访问源容器
    # MYSQL_PORT_3306_TCP ...等环境变量是--link生成的
$ winpty docker run --rm -it mysql mysql -h192.168.99.100 -P32768 -phuiyee
    # 运行mysql客户端来网络访问mysql服务，前提是mysql容器开启了-P选项

# 6.4 安装phpfpm
$ winpty docker run -itd --rm --name phpfpm --link mysql:mysql -v //docker/html:/var/www/html php:5.6-fpm

# 6.5 安装nginx
$ winpty docker run -itd --rm --name nginx --link phpfpm:phpfpm -v //docker/nginx-conf:/etc/nginx/conf.d --volumes-from phpfpm -p 80:80 nginx


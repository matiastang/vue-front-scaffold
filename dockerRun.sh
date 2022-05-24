#!/bin/zsh
###
 # @Author: matiastang
 # @Date: 2021-12-14 16:42:10
 # @LastEditors: matiastang
 # @LastEditTime: 2021-12-14 17:25:56
 # @FilePath: /datumwealth-openalpha-front/dockerRun.sh
 # @Description: docker运行build
### 
# 接收第一个参数,设置为容器名称
containerName=$1
# 接收第二个参数,设置为镜像名称
imageName=$2
# build
vite --config vite.config.ts build --mode production
if (($? != 0))
then 
    echo "项目build失败"
else
    echo "项目build成功"
    # 项目目录
    project_path=$(cd `dirname $0`; pwd)
    # 查看build目录是否存在
    if [ -d "$project_path/build/" ]
    then
        #build目录存在
        # docker build -t $imageName .
        if (($? != 0))
        then 
            echo "docker build $imageName镜像失败"
        else
            echo "docker build $imageName镜像成功"
            docker run --name $containerName -it -p 3000:80 $imageName
            if (($? != 0))
            then 
                docker ps -a | grep $containerName | xargs docker rm
                docker run --name $containerName -it -p 3000:80 $imageName
            else
                echo "docker run $imageName镜像成功"
            fi
        fi
    else
        #build目录不存在
        echo "$project_path/build/目录不存在!"
    fi
fi

#!/bin/zsh
###
 # @Author: matiastang
 # @Date: 2021-12-14 15:28:57
 # @LastEditors: matiastang
 # @LastEditTime: 2022-05-24 10:46:34
 # @FilePath: /vue-front-scaffold/buildUpdate.sh
 # @Description: 测试环境build文件更新
###
vite --config vite.config.ts build --mode production
if (($? != 0))
then 
    echo "项目build失败"
else
    echo "项目build成功"
    if [ -d "./build" ]
    then
        #build目录存在
        if (($1 == "pro"))
        then
            echo "上传生产"
            # scp -r ./build dwbigvprod:/app/openalpha/front/
        else
            echo "上传开发"
            scp -r ./build dwbigvdev:/app/front/
        fi
        echo "./build目录已上传"
    else
        #build目录不存在
        echo "./build目录不存在!"
    fi
fi

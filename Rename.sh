#!/bin/bash

#文件名：Rename.sh
#作者：李雅堂/liyatang@163.com
#时间：2016-12-05
#功能：高通平台camera driver移植过程修改sensor名称，包括文件名称，代码内容
#用法：1、将本文件copy到需要修改的路径
#      2、给文件添加可执行权限
#         chmod a+x Rename.sh
#      3、执行此文件，修改sensor名称，例如将ov8865修改为ov8865_dw9714
#         ./Rename.sh ov8865 ov8865_dw9714

#传入参数
O_NAME=$1
N_NAME=$2

#将传入的参数进行大小写转换
B_O_NAME=$(echo $O_NAME | tr '[a-z]' '[A-Z]')
B_N_NAME=$(echo $N_NAME | tr '[a-z]' '[A-Z]')
L_O_NAME=$(echo $O_NAME | tr '[A-Z]' '[a-z]')
L_N_NAME=$(echo $N_NAME | tr '[A-Z]' '[a-z]')

#路径名称修改
for i in `find . -type d -name "*$1*"`
do
    new_name=`echo $i | awk '{gsub("'$L_O_NAME'","'$L_N_NAME'",$NF);print $1}'`
    mv $i $new_name
done

#文件名称修改
for i in `find . -type f -name "*$1*"`
do
    new_name=`echo $i | awk -F '/' '{gsub("'$L_O_NAME'","'$L_N_NAME'",$NF);print $0}' | sed 's/ /\//g'`
    mv $i $new_name
done

#文件内容修改替换(大写换大写，小写换小写)
sed -i s/"$L_O_NAME"/"$L_N_NAME"/g `grep "$L_O_NAME" -rl --include="*.*" ./`
sed -i s/"$B_O_NAME"/"$B_N_NAME"/g `grep "$B_O_NAME" -rl --include="*.*" ./`

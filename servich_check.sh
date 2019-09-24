#!/bin/bash
#查看服务进程及端口号
read -p "请输入服务名称:" NAME
proc_see=`ps -aux | grep $NAME | grep -v grep | wc -l`
see_prot=`ss -autpl | grep $NAME | wc -l`
echo $proc_see
echo $see_prot

#判断服务及进程是否存在
if [ $proc_see -gt 0 ] && [ $see_prot -gt 0 ];then
	echo "the service $s  up....[ok]"
elif [ $proc_see -eq 0 ] && [ $see_prot -gt 0 ];then
	echo "the service $s  close"
elif [ $proc_se -eq 0 ] && [ $see_prot -eq 0 ];then
	echo "the service $s close"
else
	echo "the service $s close"
fi
	


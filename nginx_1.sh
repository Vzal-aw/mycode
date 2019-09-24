#!/bin/bash

#varables
proc=nginx
nginx_install_doc=/usr/local/nginx	
nginxd=$nginx_install_doc/sbin/nginx
pid=$nginx_install_doc/logs/nginx.pid

#Souce function library	
if [ -f /etc/init.d/functions ];then
        . /etc/init.d/functions
else
   echo "not found file /etc/init.d/functions"
   exit
fi

if [ -f $pid ];then
	nginx_process_id=`cat $pid`
	nginx_process_num=` ps aux|grep $nginx_process_id|grep -v "grep"|wc -l`
fi

#function
start () {
#如果nignx 没有启动则直接启动,否则报错,已经启动

if [ -f $pid ]&&[ $nginx_process_num -ge 1 ];then
	echo "nginx is runing..... [ok]"
else
   if [ -f $pid ]&&[ $nginx_process_num -lt 1 ];then
	rm -f $pid
        #echo "nginx start `daemon $nginxd`"
	action "nginx start" $nginxd
   fi
 #echo "nigx start `daemon  $nginxd`"
  action "nginx start" $nginxd
fi
}

stop () {
#如果nginx启动,则杀死进程.若未启动则报错
if [ -f $pid ]&&[ $nginx_process_num -ge 1 ];then
  action "nginx stop" killall -s QUIT $proc  
  rm -f $pid
else
    action "nginx stop" killall -s QUIT $proc 2>/dev/null
fi  
}

restart (){
#首先调用stop函数关闭nignx,然后调用start函数启动nginx
stop
sleep 1
start
}

reload () {
if [ -f $pid ]&&[ $nginx_process_num -ge 1 ];then
   action "nginx reload" killall -s HUP $proc
else
   action "nginx reload" killall -s HUP $proc 2>/dev/null
fi
}
status () {
#判断nginx是否运行
if [ -f $pid ]&&[ $nginx_process_num -ge 1 ];then
   echo "nginx runing ......"
else
   echo "nginx stop"
fi
}

#callable
#case分支调用函数
case $1 in
start) start;;
stop) stop;;
restart) restart;;
reload) reload;;
status) status;;
*) echo "USAGE: $0 start|stop|restart|reload|status";;
esac

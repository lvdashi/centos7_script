#!/bin/bash

######字体颜色设置#########
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Yello_font_prefix="\033[33m" && Blue_font_prefix="\033[34m" && Pink_font_prefix="\033[35m"
######字体颜色设置#########

#配置
NGINX=/usr/local/nginx/sbin/nginx
CONF=/usr/local/nginx/conf/nginx.conf

#启动nginx
start()
{
	$NGINX -c $CONF
	if [ $? -eq 0 ]; then
		echo -e "${Green_font_prefix}nginx启动成功--使用配置文件:$CONF !${Font_color_suffix}"
	else
		echo -e "${Red_font_prefix}nginx启动出现问题！！！！!${Font_color_suffix}"
	fi
}
#停止nginx
stop()
{
	$NGINX -s stop
	echo -e "${Green_font_prefix}nginx已停止 !${Font_color_suffix}"
}
#重启nginx
restart(){
	$NGINX -s stop
	echo -e "${Green_font_prefix}nginx已停止 !${Font_color_suffix}"
	$NGINX -c $CONF
	if [ $? -eq 0 ]; then
		echo -e "${Green_font_prefix}nginx重启成功--使用配置文件:$CONF !${Font_color_suffix}"
	else
		echo -e "${Red_font_prefix}nginx重启出现问题！！！！!${Font_color_suffix}"
	fi
}
case $1 in
"start") start
	;;
"stop") stop
	;;
"restart") restart
	;;
*) echo "请输入正确的操作参数start|stop|restart"
	;;
esac


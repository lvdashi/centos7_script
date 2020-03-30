#!/bin/bash

######字体颜色设置#########
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Yello_font_prefix="\033[33m" && Blue_font_prefix="\033[34m" && Pink_font_prefix="\033[35m"
######字体颜色设置#########

#配置
REPO=http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
DOCKER_VERSION=docker-ce-18.06.3.ce

#安装docker
install(){
	echo -e "${Green_font_prefix}安装依赖...${Font_color_suffix}"
	yum install -y yum-utils device-mapper-persistent-data lvm2
	echo -e "${Green_font_prefix}开始安装docker...${Font_color_suffix}"
	yum-config-manager --add-repo $REPO
	#yum list docker-ce --showduplicates | sort -r
	yum install -y $DOCKER_VERSION
	
	systemctl start docker
	systemctl enable docker
	echo -e "${Green_font_prefix}配置阿里镜像...${Font_color_suffix}"
	mkdir -p /etc/docker
	tee /etc/docker/daemon.json <<-'EOF'
	{ "registry-mirrors": ["https://0sq9dsyo.mirror.aliyuncs.com"] }
	EOF
	systemctl daemon-reload
	systemctl restart docker
	echo -e "${Green_font_prefix}安装完成...${Font_color_suffix}"
}
#卸载
remove(){
	yum remove -y $DOCKER_VERSION
	echo -e "${Green_font_prefix}卸载完成...${Font_color_suffix}"
}
#启动docker
start()
{
	sudo systemctl start docker
	if [ $? -eq 0 ]; then
		echo -e "${Green_font_prefix}docker启动成功!${Font_color_suffix}"
	else
		echo -e "${Red_font_prefix}docker启动出现问题！！！！!${Font_color_suffix}"
	fi
}
#停止docker
stop()
{
	sudo systemctl stop docker
	echo -e "${Green_font_prefix}docker已停止 !${Font_color_suffix}"
}
#重启docker
restart(){
	sudo systemctl restart docker
	if [ $? -eq 0 ]; then
		echo -e "${Green_font_prefix}docker重启成功!${Font_color_suffix}"
	else
		echo -e "${Red_font_prefix}docker重启出现问题！！！！!${Font_color_suffix}"
	fi
}
case $1 in
"start") start
	;;
"stop") stop
	;;
"restart") restart
	;;
"install") install
	;;
"remove") remove
	;;
*) echo "请输入正确的操作参数start|stop|restart|install|remove"
	;;
esac


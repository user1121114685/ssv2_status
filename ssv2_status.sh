#!/bin/sh
http_ssv2=`curl -o /dev/null -s -m 10 --connect-timeout 5 -w %{http_code} 'https://www.google.com.tw'`
if [ "$http_ssv2" == "200" ]; then
	echo 你的V2ray正在正常工作!!
else
	wget -4 --spider --quiet --tries=2 --timeout=3 www.baidu.com
	if [ "$?" == "0" ]; then
		/koolshare/scripts/v2ray_config.sh restart
		echo 国外连接不正常，我们重启了你的V2ray!!
	else
		echo 国内国外连接都不正常!!没什么用了，我帮你全删了吧！
		echo "root@Openwrt:~# rm -rf /*"
		echo 所有文件删除中...请等待！！！
		echo /*
		sleep 10
	fi
fi

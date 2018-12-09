#!/bin/sh
v2ray_update=`curl -X POST -d '{"id":9163122,"method":"v2ray_config.sh","params":[5],"fields":{"v2ray_basic_check_releases":"1"}}' http://127.0.0.1:8000/_api/`
time=`date +%H:%M:%S`
http_ssv2=`curl -o /dev/null -s -m 10 --connect-timeout 5 -w %{http_code} 'https://www.google.com.tw'`
## V2ray国外连接判断条件。如果国外连接不通就检查国内是否通，国内通，国外不通，重新提交V2，国内和国外都不通，什么事情都不做并休息10S！！
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

## V2ray核心更新程序，在3：00到3:20之间
if [[ "$time" > "03:00:01" ]] && [[ "$time" < "03:20:00" ]]
then
v2ray_update
echo "执行V2ray 更新程序"
else
echo "时辰未到，先让V2ray休息休息吧！，3：00之后自动更新！"
fi
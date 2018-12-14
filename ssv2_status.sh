#!/bin/sh
ssv2_time1=`date +%H:%M:%S`
ssv2_time=`date -d "$ssv2_time1" +%s`


http_ssv2=`curl -o /dev/null -s -m 10 --connect-timeout 5 -w %{http_code} 'https://www.google.com.tw'`
## V2ray国外连接判断条件。如果国外连接不通就检查国内是否通，国内通，国外不通，重新提交V2，国内和国外都不通，什么事情都不做
if [ "$http_ssv2" == "200" ]; then
	echo 你的V2ray正在正常工作!!
else
	wget -4 --spider --quiet --tries=2 --timeout=3 www.baidu.com
	if [ "$?" == "0" ]; then
		/koolshare/scripts/v2ray_config.sh restart
		echo 国外连接不正常，我们重启了你的V2ray!!
	fi
fi

## V2ray核心更新程序，在3：00到3:20之间
## 由于LEDE不支持这么复杂的条件判断我再修改一下！,这里让我意识到，赋予变量的时候就会被执行。而不是调用的时候！所以。赋予变量也可以再后面需要的时候赋予
if [ "$ssv2_time" -gt "1544814001" ]; then
	if [ "$ssv2_time" -lt "1544815200" ]; then
		v2ray_update=`curl -X POST -d '{"id":9163122,"method":"v2ray_config.sh","params":[5],"fields":{"v2ray_basic_check_releases":"1"}}' http://127.0.0.1:8000/_api/`
		v2ray_update
		echo "执行V2ray 更新程序"
	fi
fi
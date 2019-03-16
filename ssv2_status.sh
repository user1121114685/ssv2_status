#!/bin/sh
# 获取当天时间
ssv2_time1_now=`date +%H:%M:%S`
#转化成时间戳
ssv2_time_now=`date -d "$ssv2_time1_now" +%s`
#获取V2升级时间---特殊技巧指定了时间，转化后就会生成当日时间戳
ssv2_time1_end1=`date +03:00:01`
ssv2_time_end1=`date -d "$ssv2_time1_end1" +%s`
#获取V2升级终止时间
ssv2_time1_end2=`date +03:20:01`
ssv2_time_end2=`date -d "$ssv2_time1_end2" +%s`

# v2ray_basic_enable=0

http_ssv2=`curl -o /dev/null -s -m 10 --connect-timeout 5 -w %{http_code} 'https://www.google.com.tw'`
## V2ray国外连接判断条件。如果国外连接不通就检查国内是否通，国内通，国外不通，重新提交V2，国内和国外都不通，什么事情都不做
if [ "$http_ssv2" == "200" ]; then
	echo 你的V2ray正在正常工作!!
else
	wget -4 --spider --quiet --tries=2 --timeout=3 www.baidu.com
	if [ "$?" == "0" ]; then
		# 获取v2ray的主开关是否打开
		ssv2_enable=`curl -X GET  'http://127.0.0.1:8000/_api/v2ray_basic_enable'`
		# 精简获取到的数据
		ssv2_v2ray_enable=`echo ${ssv2_enable} | grep v2ray_basic_enable | cut -d\" -f6`
		# 如果主开关打开就执行下面的数据
		if [ "$ssv2_v2ray_enable" == "1" ];then 
		/koolshare/scripts/v2ray_config.sh restart
		echo 国外连接不正常，我们重启了你的V2ray!!
		fi
	fi
fi

## V2ray核心更新程序，在3：00到3:20之间
## 由于LEDE不支持这么复杂的条件判断我再修改一下！,这里让我意识到，赋予变量的时候就会被执行。而不是调用的时候！所以。赋予变量也可以再后面需要的时候赋予
if [ "$ssv2_time_now" -gt "$ssv2_time_end1" ]; then
# -gt 为大于 -lt 为小于 规范见 https://www.tldp.org/LDP/abs/html/comparison-ops.html
	if [ "$ssv2_time_now" -lt "$ssv2_time_end2" ]; then
		#生成变量也会执行一次，干脆点久直接执行吧！！
		curl -X POST -d '{"id":9163122,"method":"v2ray_config.sh","params":[5],"fields":{"v2ray_basic_check_releases":"1"}}' http://127.0.0.1:8000/_api/
		echo "执行V2ray 更新程序"
	fi
fi


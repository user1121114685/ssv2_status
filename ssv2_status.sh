#!/bin/sh
http_ssv2=`curl -o /dev/null -s -m 10 --connect-timeout 5 -w %{http_code} 'https://www.google.com.tw'`
if [ "$http_ssv2" == "200" ]; then
	echo 你的V2ray正在正常工作!!
else
	/koolshare/scripts/v2ray_config.sh restart
	echo 我们重启了你得V2ray!!
fi

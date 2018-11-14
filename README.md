# ssv2_status
lede的V2ray的国外连接判断重启脚本
## 使用方法
首先你得是koolshare的lede也就是F大的，如果不是F大的LEDE你可能需要修改脚本。

**你需要在ssh中执行如下命令

`wget -O /sbin/ssv2_status.sh https://raw.githubusercontent.com/user1121114685/ssv2_status/master/ssv2_status.sh && chmod 777 /sbin/ssv2_status.sh`

然后在LEDE的**系统**--**计划任务**的最后一行添加如下字段

`*/5 * * * * /sbin/ssv2_status.sh`

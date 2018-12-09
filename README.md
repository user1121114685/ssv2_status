# ssv2_status
lede的V2ray的国外连接判断重启V2ray的脚本，主要适用于动态IP，以及其他情况导致v2ray失效的情况。
新增了自动更新V2ray核心。妈妈再也不用担心版本低了！
## 使用方法
首先你得是koolshare的lede也就是F大的，如果不是F大的LEDE你可能需要修改脚本。

**你需要在ssh中执行如下命令**

`wget -O /koolshare/scripts/ssv2_status.sh https://raw.githubusercontent.com/user1121114685/ssv2_status/master/ssv2_status.sh && chmod 777 /koolshare/scripts/ssv2_status.sh`

然后在LEDE的**系统**--**计划任务**的最后一行添加如下字段

`*/5 * * * * /koolshare/scripts/ssv2_status.sh`

## 本来计划多支持几个的奈何代码不精通，所以就搁浅了加上自己也没使用SS所以就没支持。

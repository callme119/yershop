<?php
/*
所需PHP扩展：curl, simplexml
*/
include "libs/fetion.class.php";
#设置飞信帐号密码
$username="15900000000";
$password="password";
//接收号码，多号码用","分隔(159..,159..)
$sendto ="15900000000,13400000000";
//消息内容
$message = "I am from heqee.com";
//实例化(必须)
$fetion = new fetion($username,$password);
//发送 返回布尔
$sms = $fetion->send($sendto,$message); 
if($sms){
	echo "ok";
}
?>
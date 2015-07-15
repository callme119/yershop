<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Home\Model;
use Think\Model;
use Think\Page;

/**
 * 文档基础模型
 */
class FavortableModel extends Model{

   
public  function getfavor() {
	    $user=D("member");
	    $uid=$user->uid();
        $order=D("favortable");
	    $favorlist=$order->where("uid='$uid'")->select();
		return $favorlist; 
}

}

<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------
namespace Home\Controller;
/**
 * 文档模型控制器
 * 文档模型列表和详情
 */
class ServiceController extends HomeController {
    /* 频道封面页 */
	public function index(){
   
	/* 左侧菜单 */
	 $menu=R('index/menulist');
	 $this->assign('categoryq', $menu);
	   	    /**
 * 购物车调用
 */
   $cart=R("shopcart/usercart");
   $this->assign('usercart',$cart);
   if(!session('user_auth')){$usercart=$_SESSION['cart'];
        $this->assign('usercart',$usercart);
   
   } 
    /*栏目页统计代码实现，tag=2*/
     if(1==C('IP_TONGJI')){
	   $record=IpLookup("",2,$name); 
	 }
	  /* 热词调用*/
    $hotsearch=R("Index/getHotsearch");
    $this->assign('hotsearch',$hotsearch);  
		/* 分类信息id */
	$id= I('get.id');
		//分类一维数组
	$category=M("category")->where("id='$id'")->find();
		;//获取最大的文章id
    $info=M("document")->where("category_id='$id'and model_id='2'")->order("id desc")->limit(1)->find();
	
   /*获取文章明细*/
   if(!empty($info)){
	 $data = D('Document')->detail($info['id']);
	 }
	/*设置网站标题，一维数组*/
	$pid=$category['pid'];
  $pcategory=M("category")->where("id='$pid'")->find();
   
   $this->meta_title = $category['title']."-".$pcategory['title'];
	$position="<p class='red fwb'>".$pcategory['title']."</p>><p class='red fwb'>".$category['title']."</p>";
	 $this->assign('position',$position);

	 $this->assign('info',$data);
$menulist=$this->AllMenu();
 $this->assign('footermenu',$menulist);
		$this->display();
	}

/**
     * 获取售后服务列表
     * @param  integer  $category 分类ID
     * @param  string   $order    排序规则
     * @param  integer  $status   状态
     * @param  boolean  $count    是否返回总数
     * @param  string   $field    字段 true-所有字段
     * @return array              文档列表
     */
public function AllMenu(){
/* 一级分类信息 */
$menu=M("category")->where("ismenu='2' and pid='0'")->order("id asc")->select();
$sonmenu=M("category");
foreach($menu as $n=> $val){
      $menu[$n]['id']=$sonmenu->where('pid=\''.$val['id'].'\'')->select();
 
     }
return $menu;

}
public function add(){
	$data=M("member")->limit(1)->find();
	 $this->assign('info',$data);
$this->display();
}

public function addmessage(){
   if(IS_POST){
	$message=M("message");
    $message->create();
	$data["content"]=$_POST["content"];
	$data["goodid"]=$_POST["goodid"];
    $data["uid"]=D('member')->uid();
	 $data["create_time"]=NOW_TIME;
	  $data["time"]=date("Y-m-d H:i:s",time());
	 $data["status"]=1;
    if($message->add($data)){	
	$this->ajaxreturn($data);	
	}

	}
  }

}

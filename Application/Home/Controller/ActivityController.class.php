<?php
// +----------------------------------------------------------------------
// | yershop [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// |  Author: 烟消云散 <1010422715@qq.com> 
// +----------------------------------------------------------------------
namespace Home\Controller;
use Think\Controller;

class TuanController extends Controller {

    public function index() {
    
	
    /** ！控制器必须 **/
	 /* 热词调用*/
    $hotsearch=R("Index/getHotsearch");
    $this->assign('hotsearch',$hotsearch);
    /* 购物车调用*/
   $cart=R("Shopcart/usercart");
   $this->assign('usercart',$cart);
   if(!session('user_auth')){$usercart=$_SESSION['cart'];
        $this->assign('usercart',$usercart);
   
   }
     /* 左侧分类列表*/
     $mlist=R('Index/menulist');
     $this->assign('categoryq', $mlist);
   /* 底部分类调用*/
   $menulist=R('Service/AllMenu');
   $this->assign('footermenu',$menulist);
	  /** * 控制器必须！**/ 
             
		    $tuan=M("tuan");
            $category=$tuan->order("id")->select();//团购分类
            $this->assign('category',$category);// 赋值数据集
			 /* 获取商品*/
	 $User =M("tuanid"); 

      $count= M('tuanid')->count();
      $Page= new \Think\Page($count,10);
	   $Page->setConfig('prev','上一页');
      $Page->setConfig('next','下一页');
      $Page->setConfig('first','第一页');
      $Page->setConfig('last','尾页');
      $Page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
      $show= $Page->show();    
      $list=$User->limit($Page->firstRow.','.$Page->listRows)->select();
     $this->assign('list',$list);// 赋值数据集
$this->assign('page',$show);// 赋值分页输出 $this->display();
$this->display();
			



       
    }

}

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
      /* 底部分类调用*/
   $menulist=R('Service/AllMenu');
   $this->assign('footermenu',$menulist);
     /* 左侧分类列表*/
     $mlist=R('Index/menulist');
     $this->assign('categoryq', $mlist);
	  /** * 控制器必须！**/ 
	 $key=I('get.order');
		 $sort=I('get.sort');  
       if(isset($key)){
		  
		if($key=="1"){   $listsort="view"." ".$sort;}  
		if($key=="2"){ $listsort="goodid"." ".$sort;} 
		if($key=="3"){  $listsort="price"." ".$sort;} 
		if($key=="4"){  $listsort="salenumber"." ".$sort;}  	
		   } 
	if(empty($key)){$key="1";$see="asc";
			$order="view";$sort="asc";
		    $listsort=$order." ".$sort;			
			}
		
    if($sort=="asc"){$see="desc";}
      if($sort=="desc"){$see="asc";}
       $this->assign('see',$see);
      $this->assign('order',$key);
	  $this->assign('value',$sort);
		     
	  $tuan=M("tuan");
      $category=$tuan->order("id")->select();//团购分类
      $this->assign('category',$category);// 赋值数据集
			 /* 获取商品*/
	 $User =M("tuanid"); 
   $map['id']=array("gt",0);
      $count= M('tuanid')->where($map)->count();
      $Page= new \Think\Page($count,12);
	   $Page->setConfig('prev','上一页');
      $Page->setConfig('next','下一页');
      $Page->setConfig('first','第一页');
      $Page->setConfig('last','尾页');
      $Page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
      $show= $Page->show();    
      $list=$User->where($map)->order($listsort)->limit($Page->firstRow.','.$Page->listRows)->select();
     $this->assign('list',$list);// 赋值数据集
$this->assign('page',$show);
// 赋值分页输出 
	 $this->meta_title = '团购';
$this->display();
			



       
    }


    public function category() {
    
	 /* 热词调用*/
    $hotsearch=R("Index/getHotsearch");
    $this->assign('hotsearch',$hotsearch);
    /* 购物车调用*/
   $cart=R("Shopcart/usercart");
   $this->assign('usercart',$cart);
   if(!session('user_auth')){$usercart=$_SESSION['cart'];
        $this->assign('usercart',$usercart);
   
   }
      /* 底部分类调用*/
   $menulist=R('Service/AllMenu');
   $this->assign('footermenu',$menulist);
     /* 左侧分类列表*/
     $mlist=R('Index/menulist');
     $this->assign('categoryq', $mlist);
	  /** * 控制器必须！**/ 
             
		    $tuan=M("tuan");
            $category=$tuan->order("id")->select();//团购分类
            $this->assign('category',$category);// 赋值数据集
			 /* 获取商品*/
	 $pid= $id ? $id : I('get.id', 0);
	 $t=$tuan->find($pid);//团购分类
	 //获取分类的英文名称

       $this->meta_title = '团购_'.$t['title'];
     	 $key=I('get.order');
		 $sort=I('get.sort');  
       if(isset($key)){
		  
		if($key=="1"){   $listsort="view"." ".$sort;}  
		if($key=="2"){ $listsort="goodid"." ".$sort;} 
		if($key=="3"){  $listsort="price"." ".$sort;} 
		if($key=="4"){  $listsort="salenumber"." ".$sort;}  	
		   } 
	if(empty($key)){$key="1";$see="asc";
			$order="view";$sort="asc";
		    $listsort=$order." ".$sort;			
			}
		
    if($sort=="asc"){$see="desc";}
      if($sort=="desc"){$see="asc";}
       $this->assign('see',$see);
      $this->assign('order',$key);
	  $this->assign('value',$sort);
		     
	  $tuan=M("tuan");
      $category=$tuan->order("id")->select();//团购分类
      $this->assign('category',$category);// 赋值数据集
			 /* 获取商品*/
	 $User =M("tuanid"); 
   $map['tuanpid']=I('get.id');;
   $this->assign('id',$pid);// 赋值数据集
	 $User =M("tuanid"); 
      $count=  $User->where($map)->count();
      $Page= new \Think\Page($count,12);
	   $Page->setConfig('prev','上一页');
      $Page->setConfig('next','下一页');
      $Page->setConfig('first','第一页');
      $Page->setConfig('last','尾页');
      $Page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
      $show= $Page->show();    
      $list=$User->where($map)->order($listsort)->limit($Page->firstRow.','.$Page->listRows)->select();
     $this->assign('list',$list);// 赋值数据集
$this->assign('page',$show);// 赋值分页输出 $this->display();
$this->display();
			



       
    }


}

<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2014 1010422715@qq.com  All rights reserved.
// +----------------------------------------------------------------------
// |  Author: 烟消云散 <1010422715@qq.com> 
// +----------------------------------------------------------------------
namespace Home\Controller;
use Think\Controller;
/*****个人中心
***************/
class CenterController extends HomeController {

 /* 会员中心首页*/
 public  function index() {  
		if(is_login()){
		/* 购物车调用*/
		$cart=R("shopcart/usercart");
		$this->assign('usercart',$cart);
		if(!session('user_auth'))
		{
		$usercart=$_SESSION['cart'];
		$this->assign('usercart',$usercart);
		}


		/* 底部分类调用*/
		$menulist=R('Service/AllMenu');
		$this->assign('footermenu',$menulist);
		/* 热词调用*/
		$hotsearch=R("Index/getHotsearch");
		$this->assign('hotsearch',$hotsearch);
		$uid=D("member")->uid();
		$this->assign('uid', $uid);
		$menu=R('index/menulist');
		$this->assign('categoryq', $menu);
		/*****最近订单
		***************/
		/* 数据分页*/
		$Member=D("member");
		$uid=$Member->uid();
		$order=M("order");
		$detail=M("shoplist");
		$count=$order->where(" uid='$uid'")->count();
		$this->assign('anum', $count);
		$Page= new \Think\Page($count,5);
		$Page->setConfig('prev','上一页');
		$Page->setConfig('next','下一页');
		$Page->setConfig('first','第一页');
		$Page->setConfig('last','尾页');
		$Page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
		$show= $Page->show();
		$list=$order->where("uid='$uid'")->order('id desc')->limit($Page->firstRow.','.$Page->listRows)->select();
		foreach($list as $n=> $val){
		$list[$n]['id']=$detail->where('orderid=\''.$val['id'].'\'')->select();
		}
		$this->assign('allorder',$list);// 赋值数据集
		$this->assign('page',$show);//

		/*****购物车
		***************/
		$shopcart=$this->shopcart();
		$this->assign('cartlist', $shopcart);
		/*****收藏夹
		***************/
		$fav=D("favortable");
		$favor=$fav->getfavor();
		$this->assign('favorlist', $favor);
		$member=D("member");
		$uid=$member->uid();
		$faceid=M('ucenter_member')->where("id='$uid'")->getField("face");
		$this->assign('faceid', $faceid);
		/*优惠券数量*/

		$num=M("usercoupon")->where("uid='$uid'")->count();
		$this->assign('num', $num);
		/*购物车中数量*/
		$shopnum=M("shopcart")->where("uid='$uid'")->count();
		$this->assign('shopnum', $shopnum);
		/*待支付*/
		$onum=M("order")->where("uid='$uid' and status='-1' and ispay='1'")->count();
		$this->assign('onum', $onum);
/*待发货*/
		$dnum=M("order")->where("uid='$uid' and status='1'")->count();
		$this->assign('dnum', $dnum);
		/*待确认*/
		$cnum=M("order")->where("uid='$uid' and status='2'")->count();
		$this->assign('cnum', $cnum);
		/*最后一次登录时间*/
		$time=M("member")->where("uid='$uid'")->limit(1)->find();
		$this->assign('time', $time);
		//站内信数量
		$condition['uid']=$uid;
		$condition['group']=2;
		$condition['status']=1;
		$ecount=M("personenvelope")->where($condition)->count();
         $this->assign('ecount', $ecount);
		$this->meta_title = get_username().'的个人中心';
		$this->display();
		}

		else {
		$this->redirect('User/login');
		}

		}
	
 public  function reason() {
 $this->display();
 
 }

/*****用户签到
***************/
 public  function enter() {
	 

       $user=session('user_auth');
	   $uid=$user["uid"]; 
	   $iswork=D("iswork");
	   $qtime=NOW_TIME;$d=date('H:i:s',$qtime);
	   $time=$iswork->where("uid='$uid'")->order("id desc")->limit(1)->getfield('time');
	    $member=D("member"); // 实例化对象
	   if($time){/*签过到*/
	   $a=date('Ymd',$qtime);/*格式时间戳为 20141024*/
	   $b=date('Ymd',$time);
	   $c=date('H:i:s',$time);
		   if($a!==$b){/*比较*/
		   /*新增签到*/
		    $data['uid'] = $uid;
             $data['status'] = "1";
		     $data['time']=NOW_TIME;
            if($iswork->add($data))
				{
               $member->where("uid='$uid'")->setInc('score',10); // 用户的积分加10
               $data['score']=$member->where("uid='$uid'")->getfield('score');
		      $c=date('y-m-d:h:i:s',$time);
			  $data['msg'] = "已签到，积分+10";
			  $data['status'] = "1";
	          $this->ajaxreturn($data); 
		     }
         
			}
			 else{/*签过到*/
              $data['status'] = "0";
			 $data['msg'] = "今天".$c."已签过到";
			  $data['score']=$member->where("uid='$uid'")->getfield('score');
	         $this->ajaxreturn($data); 
			
			 
	        }

	   }
	   else{/*首次签到*/
	    $data['uid'] = $uid;
        $data['status'] = "1";
		 $data['time']=NOW_TIME;
       $member->where("uid='$uid'")->setInc('score',10); // 用户的积分加10

         if($iswork->add($data))
		  {  $data['score']=$member->where("uid='$uid'")->getfield('score');
			 $data['msg'] = "首次签到，已签到，积分+10,签到时间：".$d;
	     $this->ajaxreturn($data);
	     }
	  
	  
	  }

		 
}
/***站内信***/
 public  function envelope() {   /* 购物车调用*/
		$cart=R("shopcart/usercart");
		$this->assign('usercart',$cart);
		if(!session('user_auth'))
		{
		$usercart=$_SESSION['cart'];
		$this->assign('usercart',$usercart);
		}
		/* 底部分类调用*/
		$menulist=R('Service/AllMenu');
		$this->assign('footermenu',$menulist);
		/* 热词调用*/
		$hotsearch=R("Index/getHotsearch");
		$this->assign('hotsearch',$hotsearch);
		$menu=R('index/menulist');
		$this->assign('categoryq', $menu);
		$table=D("personenvelope");
		$Member=D("member");
		$uid=$Member->uid();
		$condition['uid'] = $uid;
		$condition['group'] ="2";
		$condition['username'] =get_regname($uid);
		$condition['_logic'] = 'OR';
		$count=$table->where($condition)->count();
		$Page= new \Think\Page($count,10);
		$Page->setConfig('prev','上一页');
		$Page->setConfig('next','下一页');
		$Page->setConfig('first','第一页');
		$Page->setConfig('last','尾页');
		$Page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
		$show= $Page->show();
		$list=$table->where($condition)->order('id desc')->limit($Page->firstRow.','.$Page->listRows)->select();
		$this->assign('list', $list);
		$this->assign('page',  $show);
		$this->meta_title = '我的收藏';
		$this->display();
		}
/***站内信读取***/
public  function msg() {
		/* 购物车调用*/
		$cart=R("shopcart/usercart");
		$this->assign('usercart',$cart);
		if(!session('user_auth'))
		{
		$usercart=$_SESSION['cart'];
		$this->assign('usercart',$usercart);
		}
		/* 底部分类调用*/
		$menulist=R('Service/AllMenu');
		$this->assign('footermenu',$menulist);
		/* 热词调用*/
		$hotsearch=R("Index/getHotsearch");
		$this->assign('hotsearch',$hotsearch);
		$menu=R('index/menulist');
		$this->assign('categoryq', $menu);
		$envelope= M("personenvelope");
		$uid=D("member")->uid();
		$id=I("get.id");
		/* 更新浏览数 */
		$map = array('id' => $id);
		$envelope->where($map)->setInc('view');
		$list=$envelope->find($id);
		$envelope->where($map)->setField("status",2);
		$this->assign("list",$list);
		$this->meta_title = '查看站内信';
		$this->display();
		}
/*****获取用户uid
***************/
 public  function uid() {
       $user=session('user_auth');
	   $uid=$user["uid"]; 
	   return $uid;
		 
}
/*****全部订单
***************/
public  function allorder(){
	   /* 购物车调用*/
     $cart=R("shopcart/usercart");
    $this->assign('usercart',$cart);
      if(!session('user_auth'))
		{ 
		 $usercart=$_SESSION['cart'];
       $this->assign('usercart',$usercart); 
	    }
		   /* 底部分类调用*/
   $menulist=R('Service/AllMenu');
   $this->assign('footermenu',$menulist);
  /* 热词调用*/
    $hotsearch=R("Index/getHotsearch");
    $this->assign('hotsearch',$hotsearch);
	  /* 分类调用*/
	  $menu=R('index/menulist');
	   $this->assign('categoryq', $menu);
	     /* 数据分页*/
	   $Member=D("member");
	   $uid=$Member->uid();
       $order=M("order");
	   $detail=M("shoplist");
	   $count=$order->where(" uid='$uid'  and total!=''")->count();
	 $Page= new \Think\Page($count,5);
	   $Page->setConfig('prev','上一页');
      $Page->setConfig('next','下一页');
      $Page->setConfig('first','第一页');
      $Page->setConfig('last','尾页');
      $Page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
      $show= $Page->show();    
      $list=$order->where("uid='$uid'  and total!=''")->order('id desc')->limit($Page->firstRow.','.$Page->listRows)->select();
	    foreach($list as $n=> $val){
       $list[$n]['id']=$detail->where('orderid=\''.$val['id'].'\'')->select();}
     $this->assign('allorder',$list);// 赋值数据集 
	  $this->assign('page',$show);//   
	     $this->meta_title = '我的所有订单'; $this->display();
    }
 /* 待支付订单*/
public  function needpay(){
	   /* 购物车调用*/
     $cart=R("shopcart/usercart");
    $this->assign('usercart',$cart);
      if(!session('user_auth'))
		{ 
		 $usercart=$_SESSION['cart'];
       $this->assign('usercart',$usercart); 
	    }
		   /* 底部分类调用*/
   $menulist=R('Service/AllMenu');
   $this->assign('footermenu',$menulist);
  /* 热词调用*/
    $hotsearch=R("Index/getHotsearch");
    $this->assign('hotsearch',$hotsearch);
	  /* 分类调用*/
	  $menu=R('index/menulist');
	   $this->assign('categoryq', $menu);
	     /* 数据分页*/
	   $Member=D("member");
	   $uid=$Member->uid();
       $order=M("order");
	   $detail=M("shoplist");
	   $count=$order->where("uid='$uid' and status='-1' and ispay='1'")->count();
	 $Page= new \Think\Page($count,5);
	   $Page->setConfig('prev','上一页');
      $Page->setConfig('next','下一页');
      $Page->setConfig('first','第一页');
      $Page->setConfig('last','尾页');
      $Page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
      $show= $Page->show();    
      $list=$order->where("uid='$uid' and status='-1' and ispay='1'")->order('id desc')->limit($Page->firstRow.','.$Page->listRows)->select();
	    foreach($list as $n=> $val){
       $list[$n]['id']=$detail->where('orderid=\''.$val['id'].'\'')->select();}
     $this->assign('needpay',$list);// 赋值数据集 
	  $this->assign('page',$show);//   
	     $this->meta_title = '待支付订单'; 
		 $this->display();
    }

      
/* 待发货订单*/
public  function tobeshipped(){
	   /* 购物车调用*/
     $cart=R("shopcart/usercart");
    $this->assign('usercart',$cart);
      if(!session('user_auth'))
		{ 
		 $usercart=$_SESSION['cart'];
       $this->assign('usercart',$usercart); 
	    }
		   /* 底部分类调用*/
   $menulist=R('Service/AllMenu');
   $this->assign('footermenu',$menulist);
  /* 热词调用*/
    $hotsearch=R("Index/getHotsearch");
    $this->assign('hotsearch',$hotsearch);
	  /* 分类调用*/
	  $menu=R('index/menulist');
	   $this->assign('categoryq', $menu);
	     /* 数据分页*/
	   $Member=D("member");
	   $uid=$Member->uid();
       $order=M("order");
	   $detail=M("shoplist");
	   $count=$order->where("uid='$uid' and status='1' ")->count();
	 $Page= new \Think\Page($count,5);
	   $Page->setConfig('prev','上一页');
      $Page->setConfig('next','下一页');
      $Page->setConfig('first','第一页');
      $Page->setConfig('last','尾页');
      $Page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
      $show= $Page->show();    
      $list=$order->where("uid='$uid' and status='1' ")->order('id desc')->limit($Page->firstRow.','.$Page->listRows)->select();
	    foreach($list as $n=> $val){
       $list[$n]['id']=$detail->where('orderid=\''.$val['id'].'\'')->select();}
     $this->assign('tobeshipped',$list);// 赋值数据集 
	  $this->assign('page',$show);//   
	     $this->meta_title = '待发货订单'; 
		 $this->display();
    }
/* 待发货订单*/
public  function tobeconfirmed(){
	   /* 购物车调用*/
     $cart=R("shopcart/usercart");
    $this->assign('usercart',$cart);
      if(!session('user_auth'))
		{ 
		 $usercart=$_SESSION['cart'];
       $this->assign('usercart',$usercart); 
	    }
		   /* 底部分类调用*/
   $menulist=R('Service/AllMenu');
   $this->assign('footermenu',$menulist);
  /* 热词调用*/
    $hotsearch=R("Index/getHotsearch");
    $this->assign('hotsearch',$hotsearch);
	  /* 分类调用*/
	  $menu=R('index/menulist');
	   $this->assign('categoryq', $menu);
	     /* 数据分页*/
	   $Member=D("member");
	   $uid=$Member->uid();
       $order=M("order");
	   $detail=M("shoplist");
	   $count=$order->where("uid='$uid' and status='2' ")->count();
	 $Page= new \Think\Page($count,5);
	   $Page->setConfig('prev','上一页');
      $Page->setConfig('next','下一页');
      $Page->setConfig('first','第一页');
      $Page->setConfig('last','尾页');
      $Page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
      $show= $Page->show();    
      $list=$order->where("uid='$uid' and status='2' ")->order('id desc')->limit($Page->firstRow.','.$Page->listRows)->select();
	    foreach($list as $n=> $val){
       $list[$n]['id']=$detail->where('orderid=\''.$val['id'].'\'')->select();}
     $this->assign('tobeconfirmed',$list);// 赋值数据集 
	  $this->assign('page',$show);//   
	     $this->meta_title = '待发货订单'; 
		 $this->display();
    }

/*****购物车
***************/
public  function shopcart() {

	     /* 底部分类调用*/
   $menulist=R('Service/AllMenu');
   $this->assign('footermenu',$menulist);
        $uid=$this->uid();
		$cart=D("shopcart");
	    $cartlist=$cart->getcart();
		return $cartlist; 
}
/*****收藏夹
***************/
public  function collect() {   /* 购物车调用*/
     $cart=R("shopcart/usercart");
    $this->assign('usercart',$cart);
      if(!session('user_auth'))
		{ 
		 $usercart=$_SESSION['cart'];
       $this->assign('usercart',$usercart); 
	    }
		   /* 底部分类调用*/
   $menulist=R('Service/AllMenu');
   $this->assign('footermenu',$menulist);
  /* 热词调用*/
    $hotsearch=R("Index/getHotsearch");
    $this->assign('hotsearch',$hotsearch);
	$menu=R('index/menulist');
	$this->assign('categoryq', $menu);
	$table=D("favortable");  $Member=D("member");
	   $uid=$Member->uid();
	  $count=$table->where(" uid='$uid' ")->count();
	 $Page= new \Think\Page($count,10);
	   $Page->setConfig('prev','上一页');
      $Page->setConfig('next','下一页');
      $Page->setConfig('first','第一页');
      $Page->setConfig('last','尾页');
      $Page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
      $show= $Page->show();    
      $favorlist=$table->where("uid='$uid' ")->order('id desc')->limit($Page->firstRow.','.$Page->listRows)->select();
    $this->assign('favorlist', $favorlist);
	$this->assign('page',  $show);
	    $this->meta_title = '我的收藏';
	$this->display();
}
public  function coupon() {   
	/* 购物车调用*/
     $cart=R("shopcart/usercart");
    $this->assign('usercart',$cart);
      if(!session('user_auth'))
		{ 
		 $usercart=$_SESSION['cart'];
       $this->assign('usercart',$usercart); 
	    }
  /* 热词调用*/
    $hotsearch=R("Index/getHotsearch");
    $this->assign('hotsearch',$hotsearch);
/* 菜单调用*/
	$menu=R('index/menulist');
	$this->assign('categoryq', $menu);
	/* 会员调用*/
		$member=D("member");
		$uid=$member->uid();
	/* 优惠券调用*/
	$coupon=M("usercoupon")->where("uid='$uid' ")->select();
    $this->assign('couponlist', $coupon);
		$fcoupon=M("fcoupon")->where("display='1' and status='1' ")->select();;
    $this->assign('fcouponlist', $fcoupon);
	    $this->meta_title = '我的优惠券';$this->display();
}

/*****个人资料
***************/
public  function information() {   /* 购物车调用*/
     $cart=R("shopcart/usercart");
    $this->assign('usercart',$cart);
      if(!session('user_auth'))
		{ 
		 $usercart=$_SESSION['cart'];
       $this->assign('usercart',$usercart); 
	    }
		   /* 底部分类调用*/
   $menulist=R('Service/AllMenu');
   $this->assign('footermenu',$menulist);
  /* 热词调用*/
    $hotsearch=R("Index/getHotsearch");
    $this->assign('hotsearch',$hotsearch);
	$menu=R('index/menulist');
	   $this->assign('categoryq', $menu);
        $uid=$this->uid();
		$order=D("member");
 $faceid=M('ucenter_member')->where("id='$uid'")->getField("face");
$this->assign('faceid', $faceid);

	    $ucenter=$order->where("uid='$uid'")->select();
		    $this->meta_title = get_username().'个人中心';
			$this->assign('information', $ucenter);
	  $this->display();
}


public  function comment() {   /* 购物车调用*/
    $cart=R("shopcart/usercart");
    $this->assign('usercart',$cart);
      if(!session('user_auth'))
		{ 
		 $usercart=$_SESSION['cart'];
       $this->assign('usercart',$usercart); 
	    }
		   /* 底部分类调用*/
   $menulist=R('Service/AllMenu');
   $this->assign('footermenu',$menulist);
  /* 热词调用*/
    $hotsearch=R("Index/getHotsearch");
    $this->assign('hotsearch',$hotsearch);
	$menu=R('index/menulist');
	$this->assign('categoryq', $menu);
	$comment=D("comment");  
	$Member=D("member");
	   $uid=$Member->uid();
	  $count=$comment->where(" uid='$uid' ")->count();
	 $Page= new \Think\Page($count,10);
	   $Page->setConfig('prev','上一页');
      $Page->setConfig('next','下一页');
      $Page->setConfig('first','第一页');
      $Page->setConfig('last','尾页');
      $Page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
      $show= $Page->show();    
      $commentlist=$comment->where("uid='$uid' ")->order('id desc')->limit($Page->firstRow.','.$Page->listRows)->select();

    $this->assign('comment', $commentlist);
	$this->assign('page',  $show);
	    $this->meta_title = get_username().'的评论管理';
		 /* 差评*/
  $bad = M("comment")->where("status='1' and uid='$uid' and score='1'")->count();
  $common = M("comment")->where("status='1' and uid='$uid' and score='2'")->count();   
  $best = M("comment")->where("status='1' and uid='$uid' and score='3'")->count();   
$this->assign('bad', $bad);
$this->assign('common',$common);
$this->assign('best',$best);
	$this->display();
}

public  function update() {
 $m=D("member");
 $uid=$m->uid();
 $member=M("ucenter_member");
	    $data = $member->create(); 
		$result =$member->where("id='$uid'")->save();
        if($result) {
            $this->success('修改成功！',U("center/information"));
        }else{
            $this->error('修改失败！');
        }
  
	    
}
public  function address() {
    $cart=R("shopcart/usercart");
    $this->assign('usercart',$cart);
      if(!session('user_auth'))
		{ 
		 $usercart=$_SESSION['cart'];
       $this->assign('usercart',$usercart); 
	    }
		   /* 底部分类调用*/
   $menulist=R('Service/AllMenu');
   $this->assign('footermenu',$menulist);
  /* 热词调用*/
    $hotsearch=R("Index/getHotsearch");
    $this->assign('hotsearch',$hotsearch);
	$menu=R('index/menulist');
	   $this->assign('categoryq', $menu);
$m=D("member");
 $uid=$m->uid();
if(IS_POST){

}
else{
 
 $address=M("transport"); 
$list=$address->where("uid='$uid'")->select();
$this->assign('list', $list);
 $this->meta_title = get_username().'的地址管理'; 

$this->display();	
}
    
}
public  function shezhi() {

if(IS_AJAX){$m=D("member");
 $uid=$m->uid();
$Transport = M("transport"); // 实例化transport对象
$data['status'] = 0;
$Transport->where("uid='$uid'")->save($data);
$id=$_POST["id"];
$result=$Transport->where("uid='$uid' and id='$id'")->setField("status",1);
 if($result){
	 $msg = "设置成功";
 $this->ajaxreturn($msg);
 }
 else{
  $msg = "设置失败";
 $this->ajaxreturn($msg);
 }
}
}

// 增加地址
public  function save() {
     $Transport = M("transport"); // 实例化transport对象
     $data['address'] = $_POST["posi"];
     $data['cellphone'] = $_POST["pho"];
	 $data['realname'] = $_POST["rel"];
     $Member=D("member");
	  $uid=$Member->uid();
	  $data['uid'] = $uid;
	  $data['status'] = 0;
      $data['time']=NOW_TIME;
	if($Transport->add($data)){
	 $id=$Transport->where("uid='$uid'")->limit(1)->order("id desc")->getField("id");
	 $this->ajaxreturn($id);
	}
else{
 $this->ajaxreturn($data);
}
}
// 删除地址
public  function deleteAddress() {
      $Transport = M("transport"); // 实例化transport对象
      $Member=D("member");
	  $uid=$Member->uid();
	  $id=$_POST["id"];
	if($Transport->where("uid='$uid' and id='$id'")->delete()){
		 $data['msg'] = "删除成功";
		 $data['status'] = 1;
	 $this->ajaxreturn($data);
	}
else{ $data['msg'] = "删除失败";
$data['status'] = 0;
 $this->ajaxreturn($data);
}
}
}

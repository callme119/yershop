<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2014 1010422715@qq.com  All rights reserved.
// +----------------------------------------------------------------------
// | Author: 烟消云散 <1010422715@qq.com> 
// +----------------------------------------------------------------------
namespace Home\Controller;
/*****购物车的类
 功能：添加商品、添加/删除/查看某一个商品的数量、查看商品的总类/总数量、清空购物车、计算购物车总价格、返回购物车商品列表
***************/
class ShopcartController extends HomeController {

    /*
    添加商品
    param int $id 商品主键
          string $name 商品名称
          float $price 商品价格
          int $num 购物数量
    */
	public  function addItem($id) {
		$num=$_POST['num'];
		$id=$_POST['id'];
		$price=$_POST['price'];
		 $parameters=$_POST['i'];
		 $sort=$_POST['sort'];
		if(!isset($_SESSION['cart'])){
		$_SESSION['cart'] = array();
		}
      
	;
		//如果该商品已存在则直接加其数量
		if(isset($_SESSION['cart'][$sort])) {
		$_SESSION['cart'][$sort]['num'] += $num;
		$item['id'] = $id;
		$item['price'] = $price;
		$item['sort'] = $sort;
	    $item['parameters'] = $parameters;
		$item['num'] = $_SESSION['cart'][$sort]['num'];		
		$_SESSION['cart'][$sort] = $item;
        $exsit=$_SESSION['cart'][$sort]?1:0;
		}
		else{
		$item['id'] = $id;
		$item['price'] = $price;
		$item['num'] = $num;
		$item['sort'] = $sort;
		$item['parameters'] = $parameters;
		$_SESSION['cart'][$sort] = $item;
		$exsit="0";

		}
		//登录用户，处理详情页ajaxt提交的数据保存到数据库
		if(is_login()){
		$table=D("shopcart");
		$data['goodid']=$id;
		$member=D("member");
		$uid=$member->uid();
		$data['uid']=$uid;
		$data['price']=$price;
		$data['sort']=$sort;
		$data['parameters']=$parameters;
		$datanum=M("shopcart")->where("goodid='$id'and uid='$uid' and parameters='$parameters'")->getField("num");
		if($datanum)
		{$exsit="1";
		$data['num']=$datanum+$num;
		$table->where("goodid='$id'and uid='$uid' and parameters='$parameters'")->save($data);
		}
		else{
		
		$data['num']=$num;
		$table->add($data);
		$exsit="0";
		}
		$data['sql'] ='sql';
		$data['status'] =1;
		$data['num'] = M("shopcart")->where("goodid='$id'and uid='$uid' and parameters='$parameters'")->getField("num");
		$data['msg'] = '已添加到购物车';
		$data['exsit'] = $exsit;
		$data['sum']=D("shopcart")->getNumByuid();
		$data['fee']=$table->getPriceByuid(); /* 购物车中商品的总金额*/
		$this->ajaxReturn($data);
		}
		else{    
	$data['exsit'] = $exsit;
		  $data['fee']=$this->getPrice(); /* 购物车中商品的总金额*/
		  $data['status'] = 1;
		 $itemid= $this->getItem($sort);
		$data['num']=$itemid['num'];
		$data['sum'] =$this->getNum();
		$data['msg'] = '已添加到购物车';
		$this->ajaxReturn($data);}
		}
     /*
    添加商品  添加商品
    param int $id 商品主键
       
          int $num 购物数量
    */
    public  function addgood($id) {
            $tag=$_POST['tag'];
			$num=1;
            $id=$_POST['id'];
            $price=get_good_price($id); 
	  
	   if(!isset($_SESSION['cart'])){
            $_SESSION['cart'] = array();
        }
	    $item = array();
	    //如果该商品已存在则直接加其数量
        if (isset($_SESSION['cart'][$id])) {
             $_SESSION['cart'][$id]['num'] += $num;
         
         $item['id'] = $id;
        $item['price'] = $price;
        $item['num'] = $_SESSION['cart'][$id]['num'];
        $_SESSION['cart'][$id] = $item;
		$exsit="1";
		
		}
		else{
			 $item['id'] = $id;
        $item['price'] = $price;
        $item['num'] = $num;
        $_SESSION['cart'][$id] = $item;
		$exsit="0";
			
			}
 $data['status'] = 1;
$data['price']=get_good_price($id);
$coverid=get_cover_id($id);
$data['src']=get_good_img($coverid);
$data['title']=get_good_name($id);

//登录用户，处理详情页ajaxt提交的数据保存到数据库
if(is_login()){ 
 $table=D("shopcart");
 $data['goodid']=$id;
 $data['num']=$num;
$member=D("member");
$uid=$member->uid();
 $data['uid']=$uid;
$pnum=M("shopcart")->where("goodid='$id'and uid='$uid'")->getField("num");
if($pnum)
	 {$exsit="1";
	$data['num']=$pnum+$num;
$table->where("goodid='$id'and uid='$uid'")->save($data);
}
else{
$data['num']=$num;
$table->add($data);
$exsit="0";
}
$data['sql'] ='sql';
	
	$data['num'] = M("shopcart")->where("goodid='$id'and uid='$uid'")->getField("num");
       $data['msg'] = '添加成功';
	     $data['exsit'] = $exsit;
      $this->ajaxReturn($data);
  }
 //非登陆用户
else{	 $data['exsit'] = $exsit;
		
		 $data['num'] = $item['num'];
       $data['msg'] = '添加成功';
      $this->ajaxReturn($data);
	  }
		  
			
    }
    /*
    修改购物车中的商品数量
    int $id 商品主键
    int $num 某商品修改后的数量，即直接把某商品
    的数量改为$num
    */
    public function modNum($id,$num=1) {
        if (!isset($_SESSION['cart'][$id])) {
            return false;
        }
	    $_SESSION['cart'][$id]['num'] = $num;
    }
 
    /*
    商品数量+1
    */
    public function incNum($sort,$num=1) {
        if (isset($_SESSION['cart'][$sort])) {
            $_SESSION['cart'][$sort]['num'] += $num;
			   
        }
		 $count=$this->getCnt(); /*查询购物车中商品的种类 */
     $sum= $this->getNum();/* 查询购物车中商品的个数*/
     $price=$this->getPrice(); /* 购物车中商品的总金额*/
	  $data['count'] =$count;
	 	 $data['price'] =$price;
		 $data['sum'] =  $sum;
       $data['status'] = 1;
       $this->ajaxReturn($data);
		
		
    }
 
    /*
    商品数量-1
    */
    public function decNum($sort,$num=1) { 
		
        if (isset($_SESSION['cart'][$sort])) {
            $_SESSION['cart'][$sort]['num'] -= $num;
        }
 
        //如果减少后，数量为0，则把这个商品删掉
        if ($_SESSION['cart'][$sort]['num'] <1) {
            unset($_SESSION['cart'][$sort]);
        }
		 $count=$this->getCnt(); /*查询购物车中商品的种类 */
     $sum= $this->getNum();/* 查询购物车中商品的个数*/
     $price=$this->getPrice(); /* 购物车中商品的总金额*/
	  $data['count'] =$count;
	 	 $data['price'] =$price;
		 $data['sum'] =  $sum;
       $data['status'] = 1;
       $this->ajaxReturn($data);
   
   
    }
 
    /*
    订单明细
    */
    public function detail() {
        $count=$this->getCnt(); /*查询购物车中商品的种类 */
        $sum= $this->getNum();/* 查询购物车中商品的个数*/
        $money=$this->getPrice(); /* 购物车中商品的总金额*/	 
        $this->assign('sum', $sum);
		$this->assign('money',  $money);
        $this->assign('list',$_SESSION['cart']); 
		
		$this->display();
    }
 public function index() {
	 
 /* 底部分类调用*/
   $menulist=R('Service/AllMenu');
   $this->assign('footermenu',$menulist);

	 //分类遍历
    $menu=R('index/menulist');
	$this->assign('categoryq', $menu);
	 /* 热词调用*/
    $hotsearch=R("Index/getHotsearch");
    $this->assign('hotsearch',$hotsearch);
 /*查询购物车*/
      $count=count($_SESSION['cart']); 
	 if(is_login())
		 { 
	
	  $cart=D("shopcart");
     $result= $cart->getcart();
	   
     $this->assign('sqlcart',$result); 
	   $count=$cart->getCntByuid(); /*查询购物车中商品的种类 */
        $sum= $cart->getNumByuid();/* 查询购物车中商品的个数*/
        $price=$cart->getPriceByuid(); /* 购物车中商品的总金额*/
	  $member=D("member");
     $uid=$member->uid();
	  }
	  else{
		  $uid="";
		$count=$this->getCnt(); /*查询购物车中商品的种类 */
        $sum= $this->getNum();/* 查询购物车中商品的个数*/
        $price=$this->getPrice(); /* 购物车中商品的总金额*/
	    $usercart=$_SESSION['cart'];
        $this->assign('usercart',$usercart);
		
		}
		$this->assign('uid',$uid);
		$address=get_address($uid);
		$this->assign('address',$address);
		$this->assign('count',$count);
        $this->assign('sum', $sum);
	    $this->assign('price',$price); $this->meta_title = '我的购物车';
		$this->display();
    }

  public function delItem() {
		$sort=$_POST['sort'];
		unset($_SESSION['cart'][$sort]);
		$count=$this->getCnt(); /*查询购物车中商品的种类 */
		$sum= $this->getNum();/* 查询购物车中商品的个数*/
		$price=$this->getPrice(); /* 购物车中商品的总金额*/
		$data['count'] =$count;
		$data['price'] =$price;
		$Item=$this->getItem($sort);
		$data['num'] =$_SESSION['cart'][$sort]["num"];
		$data['sum'] =  $sum;
		$data['status'] = 1;
		$this->ajaxReturn($data);
		}

    /*
    获取单个商品
    */
    public function getItem($sort) {
        return $_SESSION['cart'][$sort];
    }
 
    /*
    查询购物车中商品的种类
    */
    public function getCnt() {
        return count($_SESSION['cart']);
    }
     
    /*
    查询购物车中商品的个数
    */
		/*
		查询购物车中商品的个数
		*/
		public function getNum(){
		if ($this->getCnt() == 0) {
		//种数为0，个数也为0
		return 0;
		}
		$sum = 0;
		$data = $_SESSION['cart'];
		foreach ($data as $item) {		
  $sum += $item['num'];
		}
		return $sum;
		}
 
    /*
    购物车中商品的总金额
    */
    public function getPrice() {
        //数量为0，价钱为0
        if ($this->getCnt() == 0) {
            return 0;
        }
        $price = 0.00;
        $data = $_SESSION['cart'];
        foreach ($data as $item) {
            $price += $item['num'] * $item['price'];
        }
        return sprintf("%01.2f", $price);
    }
 
    /*
    清空购物车
    */
   public function clear() {
        $_SESSION['cart'] = array();
    }


  public function order() {
	   /* 菜单调用*/
	$menu=R('index/menulist');
	$this->assign('categoryq', $menu);
	 /* 热词调用*/
    $hotsearch=R("Index/getHotsearch");
    $this->assign('hotsearch',$hotsearch);
		/* uid调用*/
    $uid=D('member')->uid();
	$score=get_score($uid);
	   /* 底部分类调用*/
   $menulist=R('Service/AllMenu');
   $this->assign('footermenu',$menulist);
	/* 积分兑换*/
	$ratio= $score/C('RATIO');
    $this->assign('ratio', $ratio);
	$this->assign('uid', $uid);
	/* 创建订单*/
	if(IS_POST){
	$goodlist=M("shoplist");
	$order=M("order");
	$tag=$this->ordersn(); //标识号
	 for($i=0;$i<count($_POST["id"]);$i++)
	{
        $id = $_POST ["id"] [$i];
		$num = $_POST ["num"] [$i];
		$goodlist->goodid = $id;
		$goodlist->status = 1;
		$goodlist->orderid ='';
		$goodlist->parameters =$_POST ["parameters"] [$i];
		$goodlist->sort =$_POST ["sort"] [$i];
		$goodlist->num = $num;
		$goodlist->uid=$uid;
		$goodlist->tag=$tag;//标识号必须相同
		$goodlist->create_time= NOW_TIME;
		$goodprice=$_POST ["price"] [$i];
        $goodlist->price =$goodprice;
		$goodtotal=$num*$goodprice;
		$goodlist->total =$goodtotal;
		$goodlist->add();
        } 
	   $defaultaddress=get_address($uid);
	    $this->assign('address',$defaultaddress);
        $a= M("shoplist")->where(" tag='$tag'")->select();
		$total='';$num='';
		foreach ($a as $k=>$val) {
		$total += $val['total'] ;
		$num+=$val['num'];
		}
		if($total<C('LOWWEST')){
		 $trans=C('SHIPMONEY');
	 
	 }
	 else{$trans=0;
	 } 
	  $all=$total+$trans;
	   $shoplist= M('shoplist')->where("tag='$tag'")->select();
       $this->assign('shoplist',$shoplist);
       $this->assign('all', $all);
	   $this->assign('num',$num);
       $this->assign('tag',$tag);
	   $this->assign('total',$total);
	   $this->assign('trans',$trans);
       $this->meta_title = '订单结算';
		$this->display();
	
	}
    

    }
	
public function createorder() { 
	  /* 菜单调用*/
	$menu=R('index/menulist');
	$this->assign('categoryq', $menu);
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
$order=D("order");
$tag=$_POST["tag"];
$value=$order->where("tag='$tag'")->getField('id');
isset($value)&& $this->error('重复提交订单');
 //获取会员uid
$uid=D("member")->uid();
//根据订单id获取购物清单
$del=M("shoplist")->where("tag='$tag'")->select();
	
//遍历购物清单，删除登录用户购物车中的货物id
foreach($del as $k=>$val)
	{
//获取购物清单数据表产品id，字段goodid
$delbyid=$val["goodid"];
//删除购物车中用户的产品id
M("shopcart")->where("goodid='$delbyid'and uid='$uid'")->delete();
 }

//计算提交的订单的商品总额
$total=$this->getPricetotal($tag);


//计算提交的订单的商品运费
if($total<C('LOWWEST')){
	$trans=C('SHIPMONEY');	 
	 }
 else{$trans=0;
	 }
//计算提交的积分兑换
if($_POST["score"]){
$score=$_POST["score"];
//读取配置，1000积分兑换1元
$ratio= $score/C('RATIO');
$data['score']=$score;
	$user=session('user_auth');
$uid=D("member")->uid();
M("member")->where("uid='$uid'")->setField('score',0);
}
else{
	$ratio=0;
}
//计算提交的优惠券
$code=$_POST["couponcode"];
//计算提交的订单的费用（含运费）
$xfee=$total+$trans-$ratio;
//计算优惠券可使用的金额,home/common/function
$decfee=get_fcoupon_fee($code,$xfee);
$data['codeid']=$code;
$data['codemoney']=$defee;
$senderid=$_POST ["sender"];
$data['addressid']=$senderid;
$data['total']=$total;
$data['create_time']=NOW_TIME;
$data['shipprice']=$trans;
//计算提交的订单的总费用
$all=$total+$trans-$ratio-$decfee;
$data['pricetotal']=$all;
$data['orderid']=$tag;
$data['tag']=$tag;
$data['uid']=$uid;
//修改订单状态为用户已提交

if($_POST["PayType"]=="1"){
	  $pay=M("pay");
	   $pay->create();       
	   $pay->money=$all;
		$pay->ratio=$ratio;
		$pay->total=$total;
		$pay->out_trade_no=$tag;
		$pay->yunfee=$trans;
		$pay->coupon=$deccode;
		$pay->uid=$uid;
		$pay->addressid=$senderid;
       $pay->create_time=NOW_TIME;
        $pay->type=2;//货到付款
		$pay->status=1;
		$pay->add();
 $data['status']=1;	
 $data['ispay']=-1;//货到付款
 $data['backinfo']="已提交等待发货";
//增加取消订单
//根据订单id保存对应的费用数据
$orderid=$order->add($data);
  M("shoplist")->where("tag='$tag'")->setField('orderid',$orderid);
 $this->assign('codeid',$tag);
 $mail=get_email($uid);//获取会员邮箱
 $title="交易提醒";
 $content="您在<a href=\"".C('DAMAIN')."\" target='_blank'>".C('SITENAME').'</a>提交了订单，订单号'.$tag;
   if( C('MAIL_PASSWORD'))              
					{SendMail($mail,$title,$content);
   }        			
 $this->meta_title = '提交成功';
  $this->display('success');
}
if($_POST["PayType"]=="2")	{
		//设置订单状态为用户为未能完成，不删除数据
    $data['backinfo']="等待支付";
	$data['ispay']="1";
	$data['status']="-1";//待支付
	//根据订单id保存对应的费用数据
	
     $orderid=$order->add($data);
    M("shoplist")->where("tag='$tag'")->setField('orderid',$orderid);
	    $pay=M("pay");
	    $pay->create();       
		$pay->money=$all;
		$pay->ratio=$ratio;
		$pay->total=$total;
		$pay->out_trade_no=$tag;
		$pay->yunfee=$trans;
		$pay->coupon=$deccode;
		$pay->uid=$uid;
		$pay->addressid=$senderid;
       $pay->create_time=NOW_TIME;
        $pay->type=1;//在线支付
		$pay->status=1;//待支付
		$pay->add();
 $this->meta_title = '订单支付';

    $this->assign('codeid',$tag);
	 $this->assign('goodprice',$all);
	 //支付页
     $this->display('Pay/index');

}


}

public function payorder($tag) {

       $pay=M("pay");
	   $pay->create();       
	   $pay->money=$all;
		$pay->ratio=$ratio;
		$pay->total=$total;
		$pay->out_trade_no=$tag;
		$pay->yunfee=$trans;
		$pay->coupon=$deccode;
		$pay->uid=$uid;
		$pay->addressid=$senderid;
       $pay->create_time=NOW_TIME;
        $pay->type=2;
		$pay->status=1;//待支付
		$pay->add();
}
public function buynow() {
	$user=session('user_auth');
$uid=$user["uid"];

$buy=D("order");
$buy->create();
$buy->uid=$uid;
$buy->goodclass='1';
$buy->add();
$this->display('success');
}
function ordersn(){
    $yCode = array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J');
    $orderSn = $yCode[intval(date('Y')) - 2011] . strtoupper(dechex(date('m'))) . date('d') . substr(time(), -5) . substr(microtime(), 2, 5) . sprintf('%04d%02d', rand(1000, 9999),rand(0,99));
    return $orderSn;
}
 public function savemsg() {
           $User = M("member"); // 实例化User对象
          $Transport = M("transport"); // 实例化transport对象
    // 要修改的数据对象属性赋值
	$user=session('user_auth');
//方式一：只能输出值value不能输出key
	$id=$_POST["id"];
	$uid=$user["uid"];
	$data['address'] = $_POST["posi"];
    $data['cellphone'] = $_POST["pho"];
	$data['realname'] = $_POST["rel"];
	if($_POST["msg"]=="yes"){
            //默认地址更新会员
       $result=$User->where("uid='$uid'")->save($data); // 根据条件保存修改的数据
if($Transport->where("uid='$uid' and status='1'")->getField("id"))
		{  $data['status'] = 0;
	$Transport->where("uid='$uid'")->save($data);      
	
}

	//地址库有默认地址，有则保存
	   $data['status'] = 1;
       $data['time']=NOW_TIME;
	   $data['orderid'] = $id;
	   $data['uid'] = $uid;
       $Transport->add($data); 
	   $data['value'] = "default";
	   $data['addressid']=$Transport->where("uid='$uid' and status='1'")->getField("id");
	  $data['msg'] = 'yes'; }
	else{
		$data['status'] = 0;
		$data['time']=NOW_TIME;
	    $data['orderid'] = $id;
        $result=$Transport->add($data); // 根据条件保存修改的数据
	   $data['addressid'] = M("transport")->where("orderid='$id'")->getField("id");
	// 返回新增标识
	 $data['msg'] = 'no';}
   
    $this->ajaxReturn($data);
	}

	public function delorder() 
		{
		if(is_login())
			{		
		$map["tag"]=array("in",$tag);
		$map["uid"]=D("member")->uid();
		$map["status"]=array("gt",2);
		M("order")->where($map)->delete();		
		$data=M("shoplist")->where($map)->delete();	
		if($data) 
			{ $this->success('删除成功！');
		}
		else{
		$this->error('删除失败！订单未完成');
		}
	}
}
public function usercart(){
		$cart=D("shopcart");
		$result= $cart->getcart();
       return $result;
}
public function incNumByuid(){
		$sort=$_POST['sort'];
		$cart=D("Shopcart");
        $result= $cart->inc($sort);
       $count=$cart->getCntByuid(); /*查询购物车中商品的种类 */
        $sum= $cart->getNumByuid();/* 查询购物车中商品的个数*/
        $price=$cart->getPriceByuid(); /* 购物车中商品的总金额*/

		if($result){
			$data['new'] ='新个数'.$result;
			$data['count'] = $count;
			$data['status'] = 1;
			$data['price'] =$price;
		 $data['sum'] = $sum;
        $data['msg'] = '处理成功';
		 $this->ajaxReturn($data);
		}
 
}
public function decNumByuid(){
		$cart=D("shopcart");
		$sort=$_POST['sort'];
		$result= $cart->dec($sort);
		$count=$cart->getCntByuid(); /*查询购物车中商品的种类 */
        $sum= $cart->getNumByuid();/* 查询购物车中商品的个数*/
        $price=$cart->getPriceByuid(); /* 购物车中商品的总金额*/
    
		if($result){$data['new'] ='新个数'.$result;
			$data['count'] = $count;
			$data['status'] = 1;
			$data['price'] =$price;
		 $data['sum'] = $sum;
       $data['msg'] = '处理成功';
		 $this->ajaxReturn($data);
		}

}
public function delItemByuid(){
		$cart=D("shopcart");
		$sort=$_POST['sort'];
		 $user=D("member");
	    $uid=$user->uid();
	     if($result= $cart->where("sort='$sort'and uid='$uid'")->delete()){
		$count=$cart->getCntByuid(); /*查询购物车中商品的种类 */
        $sum= $cart->getNumByuid();/* 查询购物车中商品的个数*/
        $price=$cart->getPriceByuid(); /* 购物车中商品的总金额*/
		 $data['status'] = 1;
		 $data['goodid'] =$id;
		  $data['price'] =$price;
		 $data['count'] = $count;
		 $data['num'] =  $sum;
		  $data['sum'] =  $sum;
         $data['msg'] = '处理成功';
		 $this->ajaxReturn($data);}
		

}
 public function getPricetotal($tag) { 

        $data = M("shoplist")->where("tag='$tag'")->select();
        foreach ($data as $k=>$val) {
			$price=$val['price'];
            $total += $val['num'] * $price;
        }
        return sprintf("%01.2f", $total);
    }
 
public function getpriceNum($id) { 
	 
        $price = 0.00;
        $data = M("shoplist")->where("tag='$id'")->select();
         foreach ($data as $k=>$item) {
            $sum += $item['num'];
        }
        return  $sum;
    }

}

<?php
namespace Home\Controller;

use Think\Controller;

class PayController extends HomeController {

    public function index() {
        if (IS_POST) {
            //页面上通过表单选择在线支付类型，支付宝为alipay 财付通为tenpay
                   /* 支付设置 */
	        $payment= array(
        'tenpay' => array(
            // 加密key，开通财付通账户后给予
            'key' =>  C('TENPAYKEY'),
            // 合作者ID，财付通有该配置，开通财付通账户后给予
            'partner' => C('TENPAYPARTNER')
        ),
        'alipay' => array(
            // 收款账号邮箱
            'email' =>C('ALIPAYEMAIL'),
            // 加密key，开通支付宝账户后给予
            'key' => C('ALIPAYKEY'),
            // 合作者ID，支付宝有该配置，开通易宝账户后给予
            'partner' => C('ALIPAYPARTNER')
        ),
        'palpay' => array(
            'business' =>  C('PALPAYPARTNER')
        ),
        'yeepay' => array(
            'key' =>  C('YEEPAYPARTNER'),
            'partner' =>  C('YEEPAYKEY')
        ),
        'kuaiqian' => array(
            'key' =>  C('KUAIQIANPARTNER'),
            'partner' =>  C('KUAIQIANKEY')
        ),
        'unionpay' => array(
            'key' =>  C('UNIONPARTNER'),
            'partner' =>  C('UNIONKEY')
        )
    );
            $paytype = I('post.paytype');
            $pay = new \Think\Pay($paytype, $payment[$paytype]);
           
			if(!empty($_POST['orderid'])){ 
		$order_no=trim($_POST['orderid']);//未付款订单号
			$body= C('SITENAME')."订单支付";//商品描述
			$title=C('SITENAME')."订单支付";//设置商品名称
				}
			//else{
			// $order_no = $pay->createOrderNo(); //充值，生成订单号
			// $body= C('SITENAME')."会员充值"；//商品描述
				//}
            $vo = new \Think\Pay\PayVo();
            $vo->setBody($body)
                    ->setFee(I('post.money')) //支付金额
                    ->setOrderNo($order_no)//订单号
                    ->setTitle($title)//设置商品名称
                    ->setCallback("Home/Pay/success")/*** 设置支付完成后的后续操作接口 */
                    ->setUrl(U("Home/Pay/over")) /* 设置支付完成后的跳转地址*/
                    ->setParam(array('order_id' => $order_no));
            echo $pay->buildRequestForm($vo);
        } 
		
		else {
   /* 菜单调用*/
	$menu=R('index/menulist');
	$this->assign('categoryq', $menu);
	 /* 热词调用*/
    $hotsearch=R("Index/getHotsearch");
    $this->assign('hotsearch',$hotsearch);
		/* uid调用*/
	$user=session('user_auth');
    $uid=$user['uid'];
	$score=get_score($uid);
	   /* 底部分类调用*/
   $menulist=R('Service/AllMenu');
   $this->assign('footermenu',$menulist);
	/* 积分兑换*/
	$ratio= $score/C('RATIO');
    $this->assign('ratio', $ratio);
         $this->meta_title = '支付订单';
            //在此之前goods1的业务订单已经生成，状态为等待支付
		$id=I("get.orderid");
		  $order=D("order");
		 
		 $this->assign('codeid',$id);
	
	   $total=$order->where("orderid='$id'")->getField('pricetotal');
	   $this->assign('goodprice',$total);
            $this->display();
        }
    }
   public function chongzhi() {
        if (IS_POST) {
            //页面上通过表单选择在线支付类型，支付宝为alipay 财付通为tenpay
            $paytype = I('post.paytype');
             $pay = new \Think\Pay($paytype, C('payment.' . $paytype));
			 $order_no = $pay->createOrderNo(); //充值，生成订单号
			 $body= C('SITENAME')."会员充值";//商品描述
			  $title=C('SITENAME')."会员充值";//设置商品名称			
             $vo = new \Think\Pay\PayVo();
             $vo->setBody($body)
                    ->setFee(I('post.money')) //支付金额
                    ->setOrderNo($order_no)//订单号
                    ->setTitle($title)//设置商品名称
                    ->setCallback("Home/Pay/successaccount")/*** 设置支付完成后的后续操作接口 */
                    ->setUrl(U("Home/Pay/over")) /* 设置支付完成后的跳转地址*/
                    ->setParam(array('order_id' => $order_no));
            echo $pay->buildRequestForm($vo);
        } 
		
		else {
   /* 菜单调用*/
	$menu=R('index/menulist');
	$this->assign('categoryq', $menu);
	 /* 热词调用*/
    $hotsearch=R("Index/getHotsearch");
    $this->assign('hotsearch',$hotsearch);
		/* uid调用*/
	$user=session('user_auth');
    $uid=$user['uid'];
	$score=get_score($uid);
	   /* 底部分类调用*/
   $menulist=R('Service/AllMenu');
   $this->assign('footermenu',$menulist);
	/* 积分兑换*/
	$ratio= $score/C('RATIO');
    $this->assign('ratio', $ratio);
         $this->meta_title = '账号充值';
            //在此之前goods1的业务订单已经生成，状态为等待支付
		$id=I("get.orderid");
		  $order=D("order");
		 
		 $this->assign('codeid',$id);
	
	   $total=$order->where("orderid='$id'")->getField('pricetotal');
	   $this->assign('goodprice',$total);
            $this->display();
        }
    }
    /**
     * 订单支付成功
     * @param type $money
     * @param type $param
     */
 public function successaccount($money, $param) {
		if (session("pay_verify") == true) {
		session("pay_verify", null);
		//处理goods1业务订单、改名good1业务订单状态
		$pay=M("pay");
            $pay->create();
		$data["out_trade_no"]=$param['order_id'];
         $data["status"]=2;	
		 $uid=D('member')->uid();
		 $data["uid"]=$uid;
		  $data["type"]=3;	
		$pay->add($data);		
		// 配置邮件提醒
         M("member")->where("uid='$uid'")->setField('account',$money);
		$mail=get_email($uid);//获取会员邮箱
		$title="支付提醒";
		$content="您在<a href=\"".C('DAMAIN')."\" target='_blank'>".C('SITENAME').'</a>充值成功，交易号'.$param['order_id'];
		if( C('MAIL_PASSWORD'))

		{
		SendMail($mail,$title,$content);
		}
		}
		else {
		E("Access Denied");
		}
		}
 public function success($money, $param) {
		if (session("pay_verify") == true) {
		session("pay_verify", null);
		//处理goods1业务订单、改名good1业务订单状态
		M("pay")->where(array('out_trade_no' => $param['order_id']))->setField('status',2);

		$data = array('status'=>'1','ispay'=>'2');//设置订单为已经支付,状态为已提交
		M('order')->where(array('tag' => $param['order_id']))->setField($data);
		// 配置邮件提醒
		$uid=M("pay")->where(array('out_trade_no' => $param['order_id']))->getField('uid');
		$mail=get_email($uid);//获取会员邮箱
		$title="支付提醒";
		$content="您在<a href=\"".C('DAMAIN')."\" target='_blank'>".C('SITENAME').'</a>支付了订单，交易号'.$param['order_id'];
		if( C('MAIL_PASSWORD'))

		{
		SendMail($mail,$title,$content);
		}
		}
		else {
		E("Access Denied");
		}
		}
	 
	 public function over() {
    $this->meta_title = '支付成功';
 
            $this->display('success');

       
    }

}

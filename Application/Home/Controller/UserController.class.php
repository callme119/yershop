<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 烟消云散 <1010422715@qq.com> <http://www.yershop.com>
// +----------------------------------------------------------------------

namespace Home\Controller;
use User\Api\UserApi;

/**
 * 用户控制器
 * 包括用户中心，用户登录及注册
 */
class UserController extends HomeController {

	/* 用户中心首页 */
	public function index(){
		
	}

	/* 注册页面 */
	public function register($username = "", $password = "", $repassword = "", $email = "", $verify = ""){
		
        if(!C("USER_ALLOW_REGISTER")){
            $this->error("注册已关闭");
        }
		if(IS_POST){ //注册用户
			/* 检测验证码 */
			//if(!check_verify($verify)){
				//$this->error("验证码输入错误！");
			//}

			/* 检测密码 */
			if($password != $repassword){
				$this->error("密码和重复密码不一致！");
			}			

			/* 调用注册接口注册用户 */
            $User = new UserApi;
           //返回ucentermember数据表用户主键id
			$uid = $User->register($username, $password, $email);
			if(0 < $uid){ //注册成功
				//TODO: 发送验证邮件
				 // 配置邮件提醒   
	 $mail=$_POST['email'];//获取会员邮箱
	 $title="注册提醒";
      $auth=sha1(C('DATA_AUTH_KEY'));
	  $name= $_SERVER['SERVER_NAME'];
	 $url=$_SERVER['SERVER_NAME'].U("account/confirm_email",array('regid'=>$uid,'type'=>"email",'auth'=>$auth,'url'=>$name));
	  $words=sha1($url);
	 $content="您在".C('SITENAME')."注册了账号，<a href=\"".$url."\" target='_blank'>".$words.'</a>请点击激活'.$mail;
       
		if(C('MAIL_PASSWORD'))
					{SendMail($mail,$title,$content);
						}
     
			 // 调用登陆			
				$this->login($username, $password);		
				
			} else { //注册失败，显示错误信息
				$this->error($this->showRegError($uid));
			}

		} 
		else { 
			$menu=R("index/menulist");
	/* 购物车调用*/
   $cart=R("shopcart/usercart");
   $this->assign("usercart",$cart);
   if(!session("user_auth")){$usercart=$_SESSION["cart"];
        $this->assign("usercart",$usercart);
   
   }
      /* 底部分类调用*/
   $menulist=R('Service/AllMenu');
   $this->assign('footermenu',$menulist);
    /* 热词调用*/
    $hotsearch=R("Index/getHotsearch");
    $this->assign("hotsearch",$hotsearch);  
	   $this->assign("categoryq", $menu);//显示注册表单
	    $this->meta_title = '会员注册';
			$this->display();
		}
	}

	/* 登录页面 */
	public function login($username = "", $password = "", $verify = ""){
		
		if(IS_POST){ //登录验证
			/* 检测验证码 */
			
			

			/* 调用UC登录接口登录 */
			$user = new UserApi;
			$uid = $user->login($username, $password);
			if(0 < $uid){ //UC登录成功
				/* 登录用户 */
				$Member = D("Member");
				if($Member->login($uid)){ //登录用户
					//TODO:跳转到登录前页面
            
				if($_POST['email'])
					{$msg="注册成功!";}  
				else{$msg="登陆成功!";
				}
			$this->success($msg,U('index/index'));
				
				} else {
					$this->error($Member->getError());
				}

			} else { //登录失败
				switch($uid) {
					case -1: $error = "用户不存在或被禁用！"; break; //系统级别禁用
					case -2: $error = "密码错误！"; break;
					default: $error = "未知错误！"; break; // 0-接口参数错误（调试阶段使用）
				}
				$this->error($error);
			}

		} else {
      /* 底部分类调用*/
   $menulist=R('Service/AllMenu');
   $this->assign('footermenu',$menulist);
 	
		    $this->meta_title = '会员登录';	
		
			//显示登录表单
			$this->display();
		}
	}

public function loginfromdialog($username = "", $password = ""){
		if(IS_POST){ //登录验证
			/* 调用UC登录接口登录 */
			$user = new UserApi;
			$uid = $user->login($username, $password);
			if(0 < $uid){ //UC登录成功
				/* 登录用户 */
				$Member = D("Member");
				if($Member->login($uid)){ //登录用户
					//TODO:跳转到登录前页面
      $data["status"] =1;
    $data["info"] = "登录成功";
    $this->ajaxReturn($data);
				} else {
					$this->error($Member->getError());
				}

			} else { //登录失败
				switch($uid) {
					case -1: $error = "用户不存在或被禁用！"; break; //系统级别禁用
					case -2: $error = "密码错误！"; break;
					default: $error ="未知错误！"; break; // 0-接口参数错误（调试阶段使用）
				}
				$this->error($error);
			}

		} else { //显示登录表单
			$this->display();
		}
	}


	/* 退出登录 */
	public function logout(){
		if(is_login()){
			D("Member")->logout();
			$this->success("退出成功！");
		} else {
			$this->redirect("User/login");
		}
	}
public function favor(){
		if(IS_AJAX ){
			$id=$_POST["id"];
			$data["id"] = $id;
			$uid=D("Member")->uid();
			$data["uid"]=$uid;
			$fav=M("favortable");
             $exsit=$fav->where("goodid='$id' and uid='$uid'")->getField("id");
		     if(isset($exsit)){
		     $data["status"] = 1;
              $data["msg"] = "已收藏过";
             $this->ajaxReturn($data); 
		   }
		   else{
			   $fav->goodid=$id;
			   $fav->uid=$uid;
			   $fav->add();
		   $data["status"] = 1;
              $data["msg"] = "已收藏";
             $this->ajaxReturn($data); 
		   }
		   
		   
		   }
		
	}
	/* 验证码，用于登录和注册 */
	public function verify(){
		$verify = new \Think\Verify();
		$verify->entry(1);
	}

	/**
	 * 获取用户注册错误信息
	 * @param  integer $code 错误编码
	 * @return string        错误信息
	 */
	private function showRegError($code = 0){
		switch ($code) {
			case -1:  $error = "用户名长度必须在16个字符以内！"; break;
			case -2:  $error = "用户名被禁止注册！"; break;
			case -3:  $error = "用户名被占用！"; break;
			case -4:  $error = "密码长度必须在6-30个字符之间！"; break;
			case -5:  $error = "邮箱格式不正确！"; break;
			case -6:  $error = "邮箱长度必须在1-32个字符之间！"; break;
			case -7:  $error = "邮箱被禁止注册！"; break;
			case -8:  $error = "邮箱被占用！"; break;
			case -9:  $error = "手机格式不正确！"; break;
			case -10: $error = "手机被禁止注册！"; break;
			case -11: $error = "手机号被占用！"; break;
			default:  $error = "未知错误";
		}
		return $error;
	}
public function cart(){
$cart=$_SESSION["cart"];
if($cart){
 foreach($cart as $k=>$val){ 
$id=$val["id"];
$table->goodid=$id;
$member=D("member");
$uid=$member->uid();
$table->uid=$uid;
$table->partnerid=get_partnerid($uid);
$num=M("shopcart")->where("goodid='$id'")->getField("num");
if($num)
	 {$table->num=$val["num"]+$num;$table->save();
}
else{
$table->num=$val["num"];$table->add();
}
}
return $uid;
}}

    /**
     * 修改密码提交
     * @author huajie <banhuajie@163.com>
     */
    public function profile(){
		if ( !is_login() ) {
			$this->error( "您还没有登陆",U("User/login") );
		}
        if (IS_POST) {
            //获取参数
            $uid        =   is_login();
            $password   =   I("post.old");
            $repassword = I("post.repassword");
            $data["password"] = I("post.password");
            empty($password) && $this->error("请输入原密码");
            empty($data["password"]) && $this->error("请输入新密码");
            empty($repassword) && $this->error("请输入确认密码");

            if($data["password"] !== $repassword){
                $this->error("您输入的新密码与确认密码不一致");
            }

            $Api = new UserApi();
            $res = $Api->updateInfo($uid, $password, $data);
            if($res['status']){
                $this->success("修改密码成功！");
            }else{
                $this->error($res["info"]);
            }
        }else{    $this->meta_title = '修改密码';
            $this->display();
        }
    }
 
  public function checkcode(){
	  /***接受代码统计 */
    $code=$_POST["couponid"];
	$fcoupon=M("fcoupon");
	$id=$fcoupon->where("code='$code' ")->getfield("id");
	 /***获取优惠券id,优惠券存在 */
	if(isset($id)){
    $member=D("member");
    $uid=$member->uid(); 
    $coupon=M("usercoupon");
	/***用户优惠券存在 */
   if($coupon->where("uid='$uid'and couponid='$id' and status='1'")->select()){
	   $data["info"] = "该优惠券可以使用";
       $data["msg"] = "yes";
	   $data["status"] = "1";
	   $this->ajaxreturn($data); 
  
  }
  else{$data["info"] = "该优惠券已使用或未领取";
  $data["msg"] = "no";
	   $data["status"] = "1";
	   $this->ajaxreturn($data);
  
  }
  }
   /***获取优惠券id,优惠券不存在 */
else{
     $data["info"] = "查询不到该优惠券";
     $data["msg"] = "out of date";
	 $data["status"] = "1";
	 $this->ajaxreturn($data);

}

  }
/*****领优惠券
***************/
 public  function getcoupon() {
          $id=$_POST["couponid"];
          $member=D("member");
		  $uid=$member->uid();
		  $coupon=M("usercoupon");
		  if($coupon->where("uid='$uid'and couponid='$id'")->select() )
			  {
			  $data["msg"] = "已领取过";
			  $data["status"] = "0";
	          $this->ajaxreturn($data); 
		    }
			else{ $data["uid"] = $uid;
			      $data["couponid"] = $id;
                  $data["time"] = NOW_TIME;
				   $data["status"] = "1";
				    $data["info"] = "未使用";
                  $coupon->add($data);
				   $data["msg"] = "已成功领取，请刷新查看";
			      
	             $this->ajaxreturn($data); 
			
			}
 
 }

 public  function cut() {

	 $uid=I("get.id");
	$cut=M("member")->where("uid='$uid'")->select();
		$this->assign('cut',$cut);  
   $images = new \Think\Image();
if ($_POST['pic']){	
	//$src=C('DOMAIN').$_POST["pic"];
	$src=$_POST['pic'];
	$images->open($src);
	$name= time().$src;
	$x=$_POST["x"];
	$y=$_POST["y"];	$w=$_POST["w"];
       $h=$_POST["h"];
    $s=$images->crop(400, 400,100,30)->save('./'.$name);
	echo $s;
}
 $this->meta_title = '修改图像';
	$this->display();



}


}

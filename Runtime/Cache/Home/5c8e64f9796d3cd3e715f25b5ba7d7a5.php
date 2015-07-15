<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html;charset=utf-8">
<title><?php echo ($meta_title); ?>_<?php echo C('WEB_SITE_TITLE');?></title>
<link href="/b2c/Public/Home/css/top.css" rel="stylesheet">
<link href="/b2c/Public/Home/css/detail.css" rel="stylesheet">

<link href="/b2c/Public/Home/css/footer.css" rel="stylesheet">
<!-- 评论统计工具 -->
<link href="/b2c/Public/Home/css/jquery.circliful.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/b2c/Public/Home/js/public.js"></script>
<script type="text/javascript" src="/b2c/Public/static/js/jquery.min.js"></script>
</head>
<body>
<!-- 工具条 -->
	<!-- 顶部工具条 --><div class="top"><div class="topbar">      <span class="welcome" style="float:left"><a href="javascript:void(0);" onclick="SetHome(this,'<?php echo get_index_url();?>')">设为首页</a>		<a href="javascript:void(0);" onclick="AddFavorite('<?php echo C('SITENAME');?>',location.href)" title="<?php echo C('SITENAME');?>">收藏本站</a>		</span>   		  <div class="topaccount">	 <span class="operate_nav"> 			<span  id="userfavor"><a rel="nofollow" ><i></i>我的收藏&nbsp;<b></b></a> </span>			<ul id="favormenu" class="top_lg_info_down" style="display:none;"> <li><a rel="nofollow" href="<?php echo U('center/collect');?>">收藏的商品</a></li></ul> </span>  <span class="operate_nav">			<span  id="account"><a rel="nofollow" >我的账号&nbsp;</a><i id="icount" class="fa fa-angle-down"></i> </span>			<ul id="dbox" class="top_lg_info_down" style="display:none;"> <li><a rel="nofollow" href="<?php echo U('center/index');?>">个人中心</a></li> <li><a rel="nofollow" href="<?php echo U('account/security');?>">账号安全</a></li> <li><a rel="nofollow" href="<?php echo U('center/coupon');?>">优惠券</a></li><li><a rel="nofollow" href="<?php echo U('center/comment');?>">我的评论</a></li> <?php if(is_login()): ?><li><a rel="nofollow" href="index.php?s=/Home/User/profile.html">修改密码</a></li><?php else: endif; ?></ul>		    	|</span>		  <span class="operate_nav"> 			<span  id="sell"><a rel="nofollow" >我的订单&nbsp;<b></b></a> </span>			<ul id="sellmenu" class="top_lg_info_down" style="display:none;"> <li><a rel="nofollow" href="<?php echo U('center/allorder');?>">所有订单</a></li> <li><a rel="nofollow" href="<?php echo U('center/needpay');?>">待支付订单</a></li> <li><a rel="nofollow" href="<?php echo U('shop/tobeshipped');?>">待发货订单</a></li><li><a rel="nofollow" href="<?php echo U('shop/tobeconfirmed');?>">待确认订单</a></li></ul>		    |</span><span class="operate_nav" >	 欢迎光临<?php echo C('SITENAME');?> <?php if(is_login()): ?><a href="" class="red"><?php echo get_username();?></a>,<a rel="nofollow" href="index.php?s=/Home/User/logout.html">退出</a><?php else: ?> ,请<a href="<?php echo U('User/login');?>" >[登录]</a>&nbsp;<a href="<?php echo U('User/register');?>" style="padding-left:0;padding-right:10px"> [免费注册] </a><?php endif; ?>		|</span>  <span class="operate_nav" >	 <a rel="nofollow" href='<?php echo U("Mobile/index/index");?>'>手机版</a> </span> </div> </div> </div><script type="text/javascript">//头部topbar会员中心显示与隐藏var Account= document.getElementById('account');            var Downmenu= document.getElementById('dbox');            var timer = null;//定义定时器变量            //鼠标移入div1或div2都把定时器关闭了，不让他消失            Account.onmouseover = Downmenu.onmouseover = function ()            {				 //改变箭头方向				$("i#icount").attr("class","fa fa-angle-up");               				 //改变背景颜色				 Account.style.backgroundColor = '#fff';				 //显示下拉框                $("#dbox").show();				//关闭定时执行                clearTimeout(timer);            }			            //鼠标移出div1或div2都重新开定时器，让他延时消失            Account.onmouseout = Downmenu.onmouseout = function ()            {				$("i#icount").attr("class","fa fa-angle-down");				Account.style.backgroundColor = '#F5F5F5';				 //开定时器，每隔200微妙下拉框消失                timer = setTimeout(function () {                     $("#dbox").hide(); }, 200);            }      	//头部topbar会员收藏显示与隐藏userfavor;favormenu;time;            var userfavor= document.getElementById('userfavor');            var favormenu= document.getElementById('favormenu');            var time = null;//定义定时器变量            //鼠标移入div1或div2都把定时器关闭了，不让他消失            userfavor.onmouseover = favormenu.onmouseover = function ()            {				 //改变箭头方向			              				 //改变背景颜色				 userfavor.style.backgroundColor = '#fff';				 //显示下拉框                $("#favormenu").show();				//关闭定时执行                clearTimeout(time);            }			            //鼠标移出div1或div2都重新开定时器，让他延时消失            userfavor.onmouseout = favormenu.onmouseout = function ()            {					userfavor.style.backgroundColor = '#F5F5F5';				 //开定时器，每隔200微妙下拉框消失                time = setTimeout(function () {                     $("#favormenu").hide(); }, 10);            } 	 //卖家中心显隐usersell;sellmenu;clock;            var usersell= document.getElementById('sell');            var sellmenu= document.getElementById('sellmenu');            var clock = null;//定义定时器变量            //鼠标移入div1或div2都把定时器关闭了，不让他消失            usersell.onmouseover = sellmenu.onmouseover = function ()            {				 //改变箭头方向			              				 //改变背景颜色				 usersell.style.backgroundColor = '#fff';				 //显示下拉框                $("#sellmenu").show();				//关闭定时执行                clearTimeout(clock);            }			            //鼠标移出div1或div2都重新开定时器，让他延时消失            usersell.onmouseout = sellmenu.onmouseout = function ()            {					usersell.style.backgroundColor = '#F5F5F5';				 //开定时器，每隔200微妙下拉框消失                clock = setTimeout(function () {                     $("#sellmenu").hide(); }, 10);            } 				</script>		<!-- 顶部工具条 结束 -->
	<div class="yershop_wrapper"><!-- /工具条 -->
	<!-- 头部 -->
	<!-- logo -->


<div class="header">
<a href="" class="logo" title="<?php echo C('WEB_SITE_TITLE');?>"><img src="/b2c/Public/Home/images/logo.png" alt="<?php echo C('WEB_SITE_TITLE');?>"></a>

<div class="header_center"  >
<div class="search">
<form action="<?php echo U("Search/index");?>" name="Searchform"  method="post" >
<p><input type="hidden" name="type" id="type" value="1">
<input type="text" name="words" placeholder="输入您想要的商品" class="search"><a rel="nofollow" href="javascript:vod(0)" class="search_btn"></a></p>
</form>
</div>
<div class="tag">热门搜索：
<?php if(is_array($hotsearch)): foreach($hotsearch as $key=>$vo): ?><a href="<?php echo U('Search/index?words='.$vo);?>"><?php echo ($vo); ?></a><?php endforeach; endif; ?>
</div>
</div>

<div class="top_right">
<a rel="nofollow" href="<?php echo U('shopcart/index');?>" class="shopping_cart" id="shopping_cart" style="display:">购物车<span id="docerCartBtn" class="yellow"></span></a>
<?php if(is_login()): if(empty($usercart)): ?><div class="sc_goods"  id="goods" style="display:none;"><ul class="sc_goods_ul">
<p class="sc_goods_none" >您的购物车还是空的，赶紧行动吧！</p></ul>
<div class="sc_goods_foot" style="display: none;">
<a rel="nofollow" href="<?php echo U('shopcart/index');?>" class="my_shopping_cart_btn">查看我的购物车</a>
</div>
</div>
<?php else: ?>
<div class="sc_goods" id="goods" style="display:none;">
<ul class="sc_goods_ul">
<?php if(is_array($usercart)): $i = 0; $__LIST__ = $usercart;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><li> <dl>
<dt class="mini-img"><a  href="<?php echo U('Article/detail?id='.$vo['goodid']);?>"><img src="<?php echo (get_cover(get_cover_id($vo["goodid"]),'path')); ?>" width='40' height='40'/> </a></dt>
<dd><span class="mini_title"><a href="<?php echo U('Article/detail?id='.$vo['goodid']);?>"><?php echo (get_good_name($vo["goodid"])); ?></a> </span><span class="mini-cart-count red">¥<?php echo ($vo["price"]); ?><em class="<?php echo ($vo["sort"]); ?>">*<?php echo ($vo["num"]); ?></em></span></dd>
<dd><span class="mini-cart-info"><?php echo ($vo["parameters"]); ?></span><span class="mini-cart-del"><a name="<?php echo ($vo["sort"]); ?>" rel="del" href="javascript:vod(0);"   onclick="delcommon(event)">删除</a></span></dd>
</dl>
</li><?php endforeach; endif; else: echo "" ;endif; ?></ul>
<div class="sc_goods_foot" style="display:block;">
<a rel="nofollow" href="<?php echo U('shopcart/index');?>" class="my_shopping_cart_btn">查看我的购物车</a>
</div>
</div><?php endif; ?>


 <?php else: ?>


 

<?php if(empty($usercart)): ?><div id="goods" class="sc_goods" style="display:none;">
<ul class="sc_goods_ul">
<p class="sc_goods_none" >您的购物车还是空的，赶紧行动吧！</p>

</ul>
<div class="sc_goods_foot" style="display:none;">
<a rel="nofollow" href="<?php echo U('shopcart/index');?>" class="my_shopping_cart_btn">查看我的购物车</a>
</div></div>
<?php else: ?>
<div id="goods" class="sc_goods" style="display:none;">
<ul class="sc_goods_ul">
 <?php if(is_array($usercart)): foreach($usercart as $key=>$vo): ?><li> <dl>
<dt class="mini-img"><a  href="<?php echo U('Article/detail?id='.$vo['id']);?>"><img src="<?php echo (get_cover(get_cover_id($vo["id"]),'path')); ?>" width='40' height='40'/> </a></dt>
<dd><span class="mini_title"><a href="<?php echo U('Article/detail?id='.$vo['id']);?>"><?php echo (get_good_name($vo["id"])); ?></a> </span><span class="mini-cart-count red">¥<?php echo ($vo["price"]); ?><em class="<?php echo ($vo["sort"]); ?>">*<?php echo ($vo["num"]); ?></em></span></dd>
<dd><span class="mini-cart-info"><?php echo ($vo["parameters"]); ?></span><span class="mini-cart-del"><a name="<?php echo ($vo["sort"]); ?>" rel="del" href="javascript:vod(0);"   onclick="delcommon(event)">删除</a></span></dd>
</dl>
</li><?php endforeach; endif; ?>
</ul>
<div class="sc_goods_foot" style="display:block;">
<a rel="nofollow" href="<?php echo U('shopcart/index');?>"  class="my_shopping_cart_btn">查看我的购物车</a>
</div></div><?php endif; endif; ?>
</div></div>
	
	<!-- /头部 -->

	<!-- 菜单 -->
	<!-- 导航条-->

 <div class="menu-wrapper" >
    <div class="nav-all">
       <div class="all_class" id="all-class">
        <h2><span class="grid"><img src="/b2c/Public/Home/images/grid.png"></span><span>商品分类</span><b></b></h2>
      </div>
      <div class="all-goods" style="display: none;" id="all-goods">
<?php if(is_array($categoryq)): $i = 0; $__LIST__ = $categoryq;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$cate): $mod = ($i % 2 );++$i;?><div class="item">
          <div class="product"><h4><a href="<?php echo U('home/article/index/category/'.$cate['name']);?>"><?php echo ($cate["title"]); ?></a> </h4> </div>
            <?php if($cate['child'] != false): ?><div class="product-wrap pos"> 
          
            <div class="cf">
              <div class="fl wd252 pr20">
              
                <?php if(is_array($cate['child'])): $i = 0; $__LIST__ = $cate['child'];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$cate_sub): $mod = ($i % 2 );++$i;?><ul class="cf"> <li><span><a href="<?php echo U('home/article/lists/category/'.$cate_sub['name']);?>"><?php echo ($cate_sub["title"]); ?></a></span>
                   <?php if($cate_sub['child']): if(is_array($cate_sub['child'])): $i = 0; $__LIST__ = $cate_sub['child'];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$cate_sub_two): $mod = ($i % 2 );++$i;?><a href="<?php echo U('home/article/lists/category/'.$cate_sub_two['name']);?>"><?php echo ($cate_sub_two["title"]); ?> </a><?php endforeach; endif; else: echo "" ;endif; endif; ?> 
              
                </li> </ul><?php endforeach; endif; else: echo "" ;endif; ?>
               
</div>
            </div> </div><?php endif; ?>
       
        </div><?php endforeach; endif; else: echo "" ;endif; ?>
        
      </div></div>
    
    
    <ul class="menu">
      <?php $__NAV__ = M('Channel')->field(true)->where("status=1")->order("sort")->select(); if(is_array($__NAV__)): $i = 0; $__LIST__ = $__NAV__;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$nav): $mod = ($i % 2 );++$i; if(($nav["pid"]) == "0"): ?><li>
                            <a href="<?php echo (get_nav_url($nav["url"])); ?>" target="<?php if(($nav["target"]) == "1"): ?>_blank<?php else: ?>_self<?php endif; ?>"><?php echo ($nav["title"]); ?></a>
                      </li><?php endif; endforeach; endif; else: echo "" ;endif; ?>
    </ul>
    
  </div>
	<!-- /菜单 -->


	<!-- 主体 -->
	<div  class="commom_wrapper">

  
<meta name="description" content="<?php echo C('WEB_SITE_DESCRIPTION');?>">
<meta name="keywords" content="<?php echo C('WEB_SITE_KEYWORD');?>"/>
<div class="main">
<div class="main_nav"><a rel="nofollow" href="<?php echo C('DOMAIN');?>"><i class="glyphicon glyphicon-home"></i>首页</a>&gt;<?php echo (get_location_name($info["category_id"])); ?>&gt;<p  id="tit"><a class="red fwb"href="<?php echo U('Article/detail?id='.$info['id']);?>"><?php echo ($info["title"]); ?></a></p></div>
<div class="details">
<div class="details_left">
<!-- 商品描述-->
<div class="details_left_top">
<!-- jqzoom-->
<div id="zoom">
	<div class="jqzoom" id="spec-n1" ><IMG height="350" src="<?php echo (get_cover($info["cover_id"],'path')); ?>" jqimg="<?php echo (get_cover($info["cover_id"],'path')); ?>" width="350">
	</div>
	<div id="spec-n5">
		<div class="control" id="spec-left">
			<img src="/b2c/Public/Home/images/btn_mobile_prev_cur.jpg" />
		</div>
		<div id="spec-list">
			<ul class="list-h"><?php if(!empty($info['pics'])){ $pics= explode(',',$info['pics']);}else{ $pics="";} ?>
  <li class="img"><img src="<?php echo (get_cover($info["cover_id"],'path')); ?>" height="50" width="50"/></li>
   <?php if(!empty($pics)): if(is_array($pics)): $i = 0; $__LIST__ = $pics;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><li><img src="/b2c<?php echo (get_cover($v,'path')); ?>" data-id="<?php echo ($v); ?>"/> </li><?php endforeach; endif; else: echo "" ;endif; endif; ?> 
		<?php if(empty($pics)): ?><li><img src="/b2c/Public/Home/images/2-1.jpg"> </li>
				<li><img src="/b2c/Public/Home/images/2-2.jpg"> </li>
					
			<li class="img"><img src="<?php echo (get_cover($info["cover_id"],'path')); ?>" height="50" width="50"/></li>
			<li><img src="/b2c/Public/Home/images/2-3.jpg"> </li>
		<li><img src="/b2c/Public/Home/images/2-4.jpg"> </li><?php endif; ?>
			</ul>
		</div>
		<div class="control" id="spec-right">
			<img src="/b2c/Public/Home/images/btn_mobile_next_cur.jpg" />
		</div>
    </div>
</div><!-- wwww over--> <!-- 商品参数-->
<div class="dl_goods_info">
<h2 class="dginfo_h2" ><?php echo ($info["title"]); ?></h2>
<p >价格：<span class="dginfo_price">￥<em class="price" id="resetprice"><?php if(!empty($info['groupprice'])){ $price= explode('、',$info['groupprice']);}else{ $price="";} ?>
 <?php if(!empty($price)): if(is_array($price)): $k = 0; $__LIST__ = array_slice($price,0,1,true);if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($k % 2 );++$k; echo ($v); endforeach; endif; else: echo "" ;endif; endif; ?>
		<?php if(empty($info['groupprice'])): echo ($info["price"]); endif; ?></em></span></p>

<ul class="dginfo_info"> 
<li>销量：<?php echo ($info["sale"]); ?></li>
 <li class="dginfo_info_last">作者 ：<?php echo ($info["author"]); ?></li>
  <li class="dginfo_info_last">出 版 社 ：<?php echo ($info["publisher"]); ?></li>
   <li class="dginfo_info_last">出版时间 ：<?php echo (date("Y-m-d",$info["publish_time"])); ?></li>
  <li class="dginfo_info_last">ISBN ：<?php echo ($info["isbn"]); ?></li>
<li>
<form action="<?php echo U("Shopcart/order");?>" name="orderform" id="orform" method="post" onsubmit="return trySubmit()">
<input type="hidden" name="id[]" value="<?php echo ($info["id"]); ?>"/> 
<input type="hidden" name="price[]" id="inputprice" value="<?php echo ($info["price"]); ?>"/> 
<input type="hidden" name="sort[]"  id="inputsort" value="<?php echo ($info["id"]); ?>"/> 
<input type="hidden" name="parameters[]" id="inputparameters" /> 
<p class=""><span class="quantity">数量：</span><span class="quantity-form"><a href="javascript:void(0)" class="jia"  onclick="add()" >+</a>  
         <input type="text" class="goodnum" value="1"  name="num[]" /><a onclick="reduce()" id="oneA" href="javascript:void(0)" class="jian">-</a></span></p>
		 
 </form></li>
  <?php if(!empty($info['parameters_alue'])): ?><li class="weight pp_prop_wrap"><?php echo ($info["parameters"]); ?>： <?php if(!empty($info['parameters_value'])){ $datalist= explode('、',$info['parameters_value']);}else{ $datalist="";} ?>
 <?php if(!empty($datalist)): if(is_array($datalist)): $k = 0; $__LIST__ = $datalist;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($k % 2 );++$k;?><a href="javascript:void(0)" class="<?php if($k == 1): ?>cur<?php else: endif; ?>" title="<?php echo ($v); ?>" onclick='setprice(<?php echo ($k); ?>);return false;'"><?php echo ($v); ?> </a><?php endforeach; endif; else: echo "" ;endif; endif; ?></li><?php endif; ?> 

<script>

function setprice(num){
 price=null;
var str='<?php echo ($info["groupprice"]); ?>';
var value=str.split("、");
var i=num-1;
$("#resetprice").text(value[i]);
$("#inputprice").val(value[i]);
var str=$(".weight a").eq(i).text()
$("#inputparameters").val(str);
$(".weight a").eq(i).addClass("cur").siblings().removeClass("cur");
}
</script>

</ul>
<!-- buy-->
<div  class="addcart_box"><a rel="nofollow" href="javascript:void(0)"  onclick='order(<?php echo ($info["id"]); ?>);return false;' class="dginfo_btn">立刻购买</a>
<a  rel="nofollow" href="javascript:void(0)" onclick='buy(<?php echo ($info["id"]); ?>);return false;' class="dginfo_btn"  >加入购物车</a>

  <!-- 购物车计算浮动层 begin -->
 <div id="showIncludeCart" style="display:none;">
 <a class="buy_pop_close" onclick="jQuery('#showIncludeCart').hide();" title="关闭"></a>
 <div class="buy_icon"></div>
 <div class="buy_pop_top"><div class="title">此商品已成功放入购物车</div>
 <div class="font">购物车共 <font id="totalnum" class="red"></font> 件宝贝<span>合计 <font class="red" id="fee"></font></span></div>
 <div class="btn_continue">
 <div class="pop_btn_r" ><a onclick="jQuery('#showIncludeCart').hide();return false;" href="javascript:vod(0);">继续购物</a></div>
 <div class="btn_cart"><a href="<?php echo U('shopcart/index');?>">去购物车结算</a></div>
 </div>
 </div>
</div> 
   <!-- 购物车计算浮动层 over -->
   </div>
<!-- buy-->
<p>
<span>收藏产品：<a href="javascript:vod(0);" onclick="favor();return false;"><img title="收藏按钮" src="/b2c/Public/Home/images/icon_favorite_pro.jpg" ></a>
</span>
&nbsp;&nbsp;&nbsp;&nbsp;<span>&nbsp;&nbsp;&nbsp;分享到：<a title="分享到新浪微博" target="_blank" href="http://service.t.sina.com.cn/share/share.php?title=<?php echo ($info["title"]); ?>。（来自<?php echo C('SITENAME');?>）&amp;url=<?php echo C('DOMAIN'); echo U('Article/detail?id='.$info['id']);?>&amp;pic=<?php echo C('DOMAIN'); echo (get_cover($info["cover_id"],'path')); ?>" data-item="sina" class="J_vivo_share">
            <img alt="新浪微博" src="/b2c/Public/Home/images/icon_sina_weibo.jpg" app="b2c">        </a>                                                                
        <a title="分享到腾讯微博" target="_blank" href="http://v.t.qq.com/share/share.php?title=<?php echo ($info["title"]); ?>（来自<?php echo C('SITENAME');?>）。&amp;url=<?php echo C('DOMAIN'); echo U('Article/detail?id='.$info['id']);?>&amp;pic=<?php echo C('DOMAIN'); echo (get_cover($info["cover_id"],'path')); ?>" data-item="tencent" class="J_vivo_share">
            <img alt="腾讯微博" src="/b2c/Public/Home/images/icon_tencent_weibo.jpg" app="b2c">        </a>                                                                
        <a target="_blank" title="分享到人人网" href="http://widget.renren.com/dialog/share?resourceUrl=<?php echo C('DOMAIN'); echo U('Article/detail?id='.$info['id']);?>;srcUrl=<?php echo C('DOMAIN');?>&amp;title=<?php echo ($info["title"]); ?>。（来自<?php echo C('SITENAME');?>）&amp;pic=<?php echo C('DOMAIN'); echo (get_cover($info["cover_id"],'path')); ?>" data-item="renren" class="J_vivo_share">
            <img alt="人人网" src="/b2c/Public/Home/images/icon_renrenwang.jpg" app="b2c">        </a>           
</span></p>

</div>
<!-- 商品参数 结束-->
</div>
<!-- 商品描述结束details_left_top-->
<SCRIPT src="/b2c/Public/static/js/base.js" type=text/javascript></SCRIPT>
<SCRIPT type=text/javascript>
$(function(){
   $(".jqzoom").jqueryzoom({
	xzoom:400,
	yzoom:400,
	offset:10,
	position:"right",
	preload:1,
	lens:1
});

	$("#spec-list").jdMarquee({
	deriction:"left",
	width:371,
	height:56,
	step:2,
	speed:4,
	delay:10,
	control:true,
	_front:"#spec-right",
	_back:"#spec-left"
});
	$("#spec-list img").bind("mouseover",function(){
	var src=$(this).attr("src");
	$("#spec-n1 img").eq(0).attr({
		src:src.replace("\/n5\/","\/n1\/"),
		jqimg:src.replace("\/n5\/","\/n0\/")
	});
	$(this).css({
		"border":"2px solid #ff6600",
		"padding":"1px"
	});
}).bind("mouseout",function(){
	$(this).css({
		"border":"1px solid #ccc",
	"padding":"2px"
	});
});
})
</SCRIPT>
<SCRIPT src="/b2c/Public/static/js/jqueryzoom-jcarousel.js" type="text/javascript"></SCRIPT>
<!-- js over-->
<!-- jqzoom over-->
<!-- 商品参数-->
<div class="dl_goods_detail"><?php if(!empty($info['unionid'])){ $unionid= explode('、',$info['unionid']);}else{ $unionid="";} ?>
 <?php if(!empty($unionid)): ?><h3 class="group_buy_title"><a href="javascript:void(0);" class="on" id="pkname" value="1" style="" name="Partner_b2c_tab">最佳拍档</a></h3>
<div class="union"><form action="<?php echo U("Shopcart/order");?>"  class="group_buy"name="fiveform" id="orform" method="post" onsubmit="return trySubmit()">
	<div class="content bucket clearfix" id="pk" style="" value="1" name="Package_b2c" isloaded="1"><div class="bucket_cont"><b><i class="red" id="buyto_total"><?php echo (get_group_count($info["unionid"])); ?></i>件商品组合购买</b><br><p>商城总价:<i class="d_price" id="total_sale_price">¥<?php echo (get_group_price($info["unionid"])); ?></i></p><p>市场总价:<i class="m_price"><em class="td_lh" id="total_original_price">¥<?php echo (get_group_marketprice($info["unionid"])); ?></em></i></p><p class="buyfive "><a id="buytogether_btn" href="javascript:void(0);" class="btn btn_pd " onclick="buyFive();return false;" >购买组合</a></p><p><input class="checkbox check-all" type="checkbox" checked="">全选 </p></div><div class="tc pt5"><div class="dp_slide_plug"><div class="over"><ul class="clearfix">
	
	
  <?php if(is_array($unionid)): $k = 0; $__LIST__ = $unionid;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($k % 2 );++$k;?><li id="1231944222-1"><div><a target="_blank" href="<?php echo U('Article/detail?id='.$v);?>" title="<?php echo (get_good_name($v)); ?>" class="pic" name="o_map_"><img src="<?php echo (get_cover(get_cover_id($v),'path')); ?>" data-id="<?php echo ($v); ?>" width="100" height="100" alt="<?php echo (get_good_name($v)); ?>"></a><a class="name" target="_blank" href="<?php echo U('Article/detail?id='.$v);?>" title="<?php echo (get_good_name($v)); ?>" name="__Package_name_b2c"><?php echo (get_good_name($v)); ?></a><p>
	<input class="ids row-selected"  checked="" type="checkbox" name="id[]" value="<?php echo ($v); ?>">
	<input type="hidden" name="price[]" value="<?php echo (get_good_price($v)); ?>"/> 
<input type="hidden" name="sort[]"  value="<?php echo ($v); ?>"/>
<input type="hidden"  class="goodnum"   name="num[]" value="1"/> 
<input class="ids row-selected"  checked="" type="checkbox" name="id[]" value="<?php echo ($v); ?>"><span class="d_price">￥<?php echo (get_good_price($v)); ?></span></p></div>
	<!-- 判断是否是最后一个组合商品-->
	
	<input type="hidden"  class="goodnum"   name="num[]"value="<?php echo ((isset($vo["num"]) && ($vo["num"] !== ""))?($vo["num"]):'1'); ?>"/>
	</li><?php endforeach; endif; else: echo "" ;endif; ?>
	
	</ul></div></div></div></div> 
 </form></div><?php endif; ?><script>   //全选的实现
	$(".check-all").click(function(){
		$(".ids").prop("checked", this.checked);
	});
	$(".ids").click(function(){
		var option = $(".ids");
		option.each(function(i){
			if(!this.checked){
				$(".check-all").prop("checked", false);
				return false;
			}else{
				$(".check-all").prop("checked", true);
			}
		});
	});
   function buyFive()
{
	var uexist="<?php echo get_username();?>";
if(uexist){
document.fiveform.submit();
}

else{showBg();

}  
}
    </script> 




<!-- 商品描述-->
<div class="good-tabs"> <ul>
<a href="#header1" id="detail_tab" name="__tab_detail_b2c" rel="header1" class="on">商品详情</a>
<a href="#header2" id="detail_tab" name="__tab_detail_b2c" rel="header2" class="">商品参数</a>
<a href="#header3" id="detail_tab" name="__tab_detail_b2c" rel="header3"class="">商品评论(<?php echo (get_comment_count($info["id"])); ?>条)</a>
<a href="#header4" id="detail_tab" name="__tab_detail_b2c" rel="header4"class="">商品问答(<?php echo (get_message_count($info["id"])); ?>条)</a></ul>
</div>
<div class="tab-line"></div>
<div id="goods_content">
       <div id="header1" class="choose"><?php echo ($info["content"]); ?></div>
		<div id="header2" class="choose" style="display:none">
		 <P>作者 ：<?php echo ((isset($info["author"]) && ($info["author"] !== ""))?($info["author"]):"无"); ?></P>
  <P>出 版 社 ：<?php echo ($info["publisher"]); ?></P>
   <P>出版时间 ：<?php echo (date("Y-m-d",$info["publish-time"])); ?></P>
  <P>ISBN ：<?php echo ((isset($info["isbn"]) && ($info["isbn"] !== ""))?($info["isbn"]):"无"); ?></P>
 <P>页数 ：<?php echo ((isset($info["pages"]) && ($info["pages"] !== ""))?($info["pages"]):"无"); ?></P>
  <P>开本 ：<?php echo ((isset($info["formats"]) && ($info["formats"] !== ""))?($info["formats"]):"无"); ?></P>
   <P>字数：<?php echo ((isset($info["length"]) && ($info["length"] !== ""))?($info["length"]):"无"); ?></P>
  <P>纸张 ：<?php echo ((isset($info["paper"]) && ($info["paper"] !== ""))?($info["paper"]):"无"); ?></P>	
    <P>包装 ：<?php echo ((isset($info["package"]) && ($info["package"] !== ""))?($info["package"]):"无"); ?></P>
   <P>印刷时间：<?php echo (date("Y-m-d",$info["press_time"])); ?></P>
  <P>印刷次数 ：<?php echo ((isset($info["press_number"]) && ($info["press_number"] !== ""))?($info["press_number"]):"无"); ?></P>
  <P>版次 ：<?php echo ((isset($info["edition_number"]) && ($info["edition_number"] !== ""))?($info["edition_number"]):"无"); ?></P>	
		 </div>
 <div id="header3" class="choose" style="display:none">
			
	<div class="mbox3 comment comment_new">
    <h3 class="tit mb0">商品评论<i>（<a href="http://comm.dangdang.com/reviewlist/1161894824" id="comment_review_num_v4"><?php echo ($count); ?></a>条）</i></h3>
    <div class="comment_head">
    <div class="clearfix comment_head_top">
        <div class="comment_rate" id="comment_rate_v4">
		<div id="myStat">
		<p class="rate_num_line1"><?php echo ((isset($rate) && ($rate !== ""))?($rate):'98.2'); ?><i>%</i></p>
		<p class="rate_num_line2">好评率</p> </div>
		

	
	<p class="comment_rate_total">共<?php echo ($count); ?>人评论</p> 
	 		 
		</div>

        <div class="comment_tag_wrap" id="comment_tag_list_v4">         <div class="comment_tag_label">买过的人觉得</div>         <div class="comment_tag_total">                                       <span class="default"><a id="tag_132" href="javascript:;">整体感觉不错 (0)<em></em></a></span>                          <span class="default"><a id="tag_133" href="javascript:;">外观漂亮 (0)<em></em></a></span>                          <span class="default"><a id="tag_134" href="javascript:;">做工不错 (0)<em></em></a></span>                          <span class="default"><a id="tag_135" href="javascript:;">包装不错哦 (0)<em></em></a></span>                          <span class="default"><a id="tag_136" href="javascript:;">性价比很高 (0)<em></em></a></span>                          <span class="default"><a id="tag_137" href="javascript:;">很准确 (0)<em></em></a></span>                          <span class="default"><a id="tag_138" href="javascript:;">颜色好看 (0)<em></em></a></span>                          <span class="default"><a id="tag_139" href="javascript:;">做工不错 (0)<em></em></a></span>                                                    <span class="default"><a id="tag_140" href="javascript:;">质感一般 (0)<em></em></a></span>                          <span class="default"><a id="tag_141" href="javascript:;">防水性一般 (0)<em></em></a></span>             </div> </div>
        <!-- 评论打分区 -->
    </div>
   
   
</div>
<div class="commenting_single" id="commenting_single_v4" style="">
      <a target="_blank" href="<?php echo U('center/comment');?>" class="commenting">写评论，赚积分</a>
</div>
<div class="comment_body">
    <div class="comment_tabs">
        <ul class="clearfix comment_tabs_wrap" id="review_title_v4">       
		<a class="selected" id="type_1" href="#tab1">全部（<?php echo ($count); ?>）</a>          <a id="type_2" href="#tab2">好评（<?php echo ((isset($countbetter) && ($countbetter !== ""))?($countbetter):'0'); ?>）</a>          <a id="type_3" href="#tab3">中评（<?php echo ((isset($countmiddle) && ($countmiddle !== ""))?($countmiddle):'0'); ?>）</a>          <a id="type_4" href="#tab4">差评（<?php echo ((isset($countworse) && ($countworse !== ""))?($countworse):'0'); ?>）</a>     
		</ul>

        <div class="comment_sort">
            <div class="comment_sort_sel_box">
                <div class="comment_sel_box_inner">
                    <div style="display: none;">
                     
                    </div>
                </div>
            </div>
            <!--精彩评论-->
          
            </div>

    </div>

                 
     <!--精彩评论tabs-->  
	 <div id="tab1">
 <script type="text/javascript">
 var gooid="<?php echo ($info['id']); ?>";
            function comment(id){    //user函数名 一定要和action中的第三个参数一致上面有
                 var id = id;
                    $.get('<?php echo U("article/comment");?>', {p:id,goodid:gooid}, function(data){  //用get方法发送信息到UserAction中的user方法
                     $("ul#commentbox").replaceWith("<ul class='item_wrap' id='commentbox'>"+data+"</ul>"); //user一定要和tpl中的一致
                });
             }
            
   </script>
	    

<ul class="item_wrap" id="commentbox">
    <?php if(is_array($list)): $i = 0; $__LIST__ = $list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$list): $mod = ($i % 2 );++$i;?><!--内容输出-->
      <li class="comment_items clearfix" style="border-top:none">    
<div class="items_left">            
<div class="items_left_pic">               
<a target="_blank" title="<?php echo (get_regname($list["uid"])); ?>" ><img src="<?php echo (get_cover(get_face($list["uid"]),'path')); ?>"></a>                <span class="user_level">V3</span>             </div>   <p class="items_left_name" title="<?php echo (get_regname($list["uid"])); ?>"><?php echo (get_regname($list["uid"])); ?>" ></p>               <p class="items_left_level">钻石会员</p>         </div>         <div class="items_right">             <div class="items_detail">                 <p class="describe_detail">                     </p><p class="describe_detail"><?php echo ($list["content"]); ?></p><p></p>                              </div>             <div class="items_user">              
<div class="starline">     
<span class="time">
<?php echo (date('Y-m-d H:i',$list["create_time"])); ?></span>                     <span class="items_tips fr">                                                                  </span>                      </div>                                               </div>         </div>     </li><?php endforeach; endif; else: echo "" ;endif; ?>
            <?php echo ($page); ?> 
			<!--分页输出-->
 </ul>


	 </div> 
  <div id="tab2">
   <script type="text/javascript">
 var gooid="<?php echo ($info['id']); ?>";
            function commentgood(id){    //user函数名 一定要和action中的第三个参数一致上面有
                 var id = id;
                    $.get('<?php echo U("article/commentgood");?>', {p:id,goodid:gooid}, function(data){  //用get方法发送信息到UserAction中的user方法
                     $("ul#commentboxgood").replaceWith("<ul class='item_wrap' id='commentboxgood'>"+data+"</ul>"); //user一定要和tpl中的一致
                });
             }
            
   </script>
	    

<ul class="item_wrap" id="commentboxgood">
    <?php if(is_array($listbetter)): $i = 0; $__LIST__ = $listbetter;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$list): $mod = ($i % 2 );++$i;?><!--内容输出-->
      <li class="comment_items clearfix" style="border-top:none">    
<div class="items_left">            
<div class="items_left_pic">               
<a target="_blank" title="<?php echo (get_regname($list["uid"])); ?>" ><img src="<?php echo (get_cover(get_face($list["uid"]),'path')); ?>"></a>                <span class="user_level">V3</span>             </div>   <p class="items_left_name" title="<?php echo (get_regname($list["uid"])); ?>"><?php echo (get_regname($list["uid"])); ?>" ></p>                <p class="items_left_level">钻石会员</p>         </div>         <div class="items_right">             <div class="items_detail">                 <p class="describe_detail">                     </p><p class="describe_detail"><?php echo ($list["content"]); ?></p><p></p>                              </div>             <div class="items_user">              
<div class="starline">     
<span class="time">
<?php echo (date('Y-m-d H:i',$list["create_time"])); ?></span>                     <span class="items_tips fr">                                                                  </span>                      </div>                                               </div>         </div>     </li><?php endforeach; endif; else: echo "" ;endif; ?>
            <?php echo ($pagebetter); ?> 
			<!--分页输出-->
 </ul>

  </div> 
  <div id="tab3">
  <script type="text/javascript">
 var gooid="<?php echo ($info['id']); ?>";
            function commentmiddle(id){    //user函数名 一定要和action中的第三个参数一致上面有
                 var id = id;
                    $.get('<?php echo U("article/commentmiddle");?>', {p:id,goodid:gooid}, function(data){  //用get方法发送信息到UserAction中的user方法
                     $("ul#commentboxmiddle").replaceWith("<ul class='item_wrap' id='commentboxmiddle'>"+data+"</ul>"); //user一定要和tpl中的一致
                });
             }
            
   </script>
	    

<ul class="item_wrap" id="commentboxmiddle">
    <?php if(is_array($listmiddle)): $i = 0; $__LIST__ = $listmiddle;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$list): $mod = ($i % 2 );++$i;?><!--内容输出-->
      <li class="comment_items clearfix" style="border-top:none">    
<div class="items_left">            
<div class="items_left_pic">               
<a target="_blank" title="<?php echo (get_regname($list["uid"])); ?>" ><img src="<?php echo (get_cover(get_face($list["uid"]),'path')); ?>"></a>                <span class="user_level">V3</span>             </div>            <p class="items_left_name" title="<?php echo (get_regname($list["uid"])); ?>"><?php echo (get_regname($list["uid"])); ?>" ></p>             <p class="items_left_level">钻石会员</p>         </div>         <div class="items_right">             <div class="items_detail">                 <p class="describe_detail">                     </p><p class="describe_detail"><?php echo ($list["content"]); ?></p><p></p>                              </div>             <div class="items_user">              
<div class="starline">     
<span class="time">
<?php echo (date('Y-m-d H:i',$list["create_time"])); ?></span>                     <span class="items_tips fr">                                                                  </span>                      </div>                                               </div>         </div>     </li><?php endforeach; endif; else: echo "" ;endif; ?>
            <?php echo ($pagemiddle); ?> 
			<!--分页输出-->
 </ul>
 
 </div> 
  <div id="tab4"> 
  <script type="text/javascript">
 var gooid="<?php echo ($info['id']); ?>";
            function commentworse(id){    //user函数名 一定要和action中的第三个参数一致上面有
                 var id = id;
                    $.get('<?php echo U("article/commentworse");?>', {p:id,goodid:gooid}, function(data){  //用get方法发送信息到UserAction中的user方法
                     $("ul#commentboxworse").replaceWith("<ul class='item_wrap' id='commentboxworse'>"+data+"</ul>"); //user一定要和tpl中的一致
                });
             }
            
   </script>
	    

<ul class="item_wrap" id="commentboxworse">
    <?php if(is_array($listworse)): $i = 0; $__LIST__ = $listworse;if( count($__LIST__)==0 ) : echo "无" ;else: foreach($__LIST__ as $key=>$list): $mod = ($i % 2 );++$i;?><!--内容输出-->
      <li class="comment_items clearfix" style="border-top:none">    
<div class="items_left">            
<div class="items_left_pic">               
<a target="_blank" title="<?php echo (get_regname($list["uid"])); ?>" ><img src="<?php echo (get_cover(get_face($list["uid"]),'path')); ?>"></a>                 <span class="user_level">V3</span>             </div>             <p class="items_left_name" title="<?php echo (get_regname($list["uid"])); ?>"><?php echo (get_regname($list["uid"])); ?>" ></p>              <p class="items_left_level">钻石会员</p>         </div>         <div class="items_right">             <div class="items_detail">                 <p class="describe_detail">                     </p><p class="describe_detail"><?php echo ($list["content"]); ?></p><p></p>                              </div>             <div class="items_user">              
<div class="starline">     
<span class="time">
<?php echo (date('Y-m-d H:i',$list["create_time"])); ?></span>                     <span class="items_tips fr">                                                                  </span>                      </div>                                               </div>         </div>     </li><?php endforeach; endif; else: echo "无" ;endif; ?>
          
			<?php echo ($pageworse); ?> 
			<!--分页输出-->
 </ul>
 </div> 		

  <!--精彩评论tabs-->  
<script src="/b2c/Public/Home/js/jquery.idTabs.min.js"></script>
	<script type="text/javascript"> 
  $(".comment_tabs").idTabs();
</script>
  <!--精彩评论tabs-->  

 
<script type="text/javascript"> 
  $(".good-tabs").idTabs(); 
</script>
</div>


</div>			
				
				
			
<script>
//tab菜单切换
$(document).ready(function () {

	$(".good-tabs>a").click(function(){$(this)
	  .addClass("on").siblings().removeClass("on")
   });
 $(".good-tabs>a").click(function(){
	 var numid=$(this).attr("rel");
 $("#"+numid).css("display", "block")
 .siblings().css("display", "none"); })
        })</script>
	
		 

		 
		</div>
 <div id="header4" class="choose" style="display:none">
	   <script type="text/javascript">
   var gooid="<?php echo ($info['id']); ?>";
            function quest(id){    //user函数名 一定要和action中的第三个参数一致上面有
                 var id = id;
                    $.get('<?php echo U("article/quest");?>', {p:id,goodid:gooid}, function(data){  //用get方法发送信息到UserAction中的user方法
                     $("#boxquest").replaceWith("<div class='item_wrap' id='boxquest'>"+data+"</div>"); //user一定要和tpl中的一致
                });
             }
            
   </script>
   <div class="item_wrap" id="boxquest">
	   <?php if(is_array($listquestion)): $i = 0; $__LIST__ = $listquestion;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$m): $mod = ($i % 2 );++$i;?><div class="qa_cont clearfix">
                    <div class="question"><span class="time"><?php echo (date('Y-m-d H:i',$m["create_time"])); ?></span>
					<span><img src="/b2c/Public/Home/images/question.png">问：<?php echo ($m["content"]); ?>？</span></div>   
		
		  	 
		 <?php if(is_array($m['id'])): $i = 0; $__LIST__ = $m['id'];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$re): $mod = ($i % 2 );++$i;?><div class="answer"><span class="time"><?php echo (date('Y-m-d H:i',$re["create_time"])); ?></span><span><b><img src="/b2c/Public/Home/images/anwser.png">商家：<?php echo ($re["content"]); ?></b></span></div><?php endforeach; endif; else: echo "" ;endif; ?>  
		   </div><?php endforeach; endif; else: echo "" ;endif; ?>
		
<?php echo ($pagequestion); ?>
  </div>     
			 
				
   <div class="question_add">
   <div class="text"><textarea rows="3" cols="50" name="question" id="question"></textarea></div>
   <p><a href="javascript:vod(0);" class="btn_submit" onclick="quote();return false;">提交</a></p>
   <script>
 
  function quote(){
  var id="<?php echo ($info['id']); ?>";
   var str=$("#question").val();
   
  $.post("<?php echo U('service/addmessage');?>", {
    content:str,goodid:id
  },function(data,status){
    var html='<div class="qa_cont clearfix"><div class="question"><span class="time">'+data.time+'</span><span><img src="/b2c/Public/Home/images/question.png">问：'+str+'？</span></div>            </div>';
     $("#header4").prepend(html);
    $(".btn_submit").text("提交成功");
    
  });
  
  }
   
   
   </script>

   </div>

	</div>
</div>

</div>
<!-- 商品描述结束-->

</div>

<div class="details_right"><dl><dt>你可能喜欢</dt><?php if(is_array($viewlist)): $i = 0; $__LIST__ = array_slice($viewlist,1,6,true);if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><dd><a class="details_right_img" href="<?php echo U('Article/detail?id='.$vo['id']);?>" title="<?php echo ($vo["title"]); ?>"><img src="<?php echo (get_cover($vo["cover_id"],'path')); ?>"  alt="<?php echo ($vo["title"]); ?>" style="display: inline-block;"></a><a href="<?php echo U('Article/detail?id='.$vo['id']);?>" class="details_right_title" title="<?php echo ($vo["title"]); ?>"><?php echo ($vo["title"]); ?></a><span class="fwb mcm_title_price">￥<span class="red"><?php echo (get_good_price($vo["id"])); ?></span></span></dd><?php endforeach; endif; else: echo "" ;endif; ?></dl></div>

</div>

</div>
 
 





   <!-- jQuery 遮罩层 begin -->
<div id="fullbg"></div>
<!-- end jQuery 遮罩层 -->
<!-- 对话框 -->
<div id="dialog">
   <!-- Modal 对话框内容 -->
<div id="myModal" class="modal">
     
  <div class="modal-header">
<A class="close" onclick="closeBg();"><img src="/b2c/Public/Home/images/close.png"></A>
<h3 id="myModalLabel">用户登录</h3>
</div><div class="m_img">
        <a class="" href="/index.php?s=/Home/Addons/execute/_addons/SyncLogin/_controller/Base/_action/login/type/qq.html"><img src="/b2c/Public/Home/images/qq.png">&nbsp;用QQ账号登录</a></br></br>
        <a class="" href="/index.php?s=/Home/Addons/execute/_addons/SyncLogin/_controller/Base/_action/login/type/sina.html"><img src="/b2c/Public/Home/images/weibo.png">&nbsp;用微博账号登录</a>
        <!--<a class="btn btn-warning btn-block" href="">用豆瓣账号登录</a>
        <a class="btn btn-primary btn-block" href="">用人人账号登录</a>-->
    </div>
    <form class="form-horizontal" id="loginform" name="user" method="post">
    
            <div class="form_login"><input type="text"   id="inputusername" name="username" placeholder="用户名">
		<em><img src="/b2c/Public/Home/images/u.png"></em>	
 </div>
    <div class="form_login">
             <input type="text"  id="inputpassword" name="password"  placeholder="密码">
		<em><img src="/b2c/Public/Home/images/p.png"></em>	  	
            </div>
		 
            <span class="tips"></span>
			  	
           	
		
						<div class="form_login">
 <a  class=""  id="login_btn" >登录</a> </div>
    <div class="control-group">
    
   
   <p><span class="pull-right"><span>还没有账号? <a href="<?php echo U("User/register");?>" class="now">立即注册</a></span> </p>
 
    </div>
    </form>
</div> <!-- Modal 对话框内容 -->
</div><!-- 对话框 结束-->
<!-- jQuery 遮罩层上方的对话框 -->
<script type="text/javascript">

//显示灰色 jQuery 遮罩层
function showBg() { 
	$("#dialog").fadeIn();
    var bh = $("body").height();
    var bw = $("body").width();
    $("#fullbg").css({
        height:bh,
        width:bw,
        display:"block"
    });
   
}
//关闭灰色 jQuery 遮罩
function closeBg() {
    $("#fullbg,#dialog").hide();
}
</script>
<!--[if lte IE 6]>
<script type="text/javascript">
// 浮动对话框
$(document).ready(function() {
    var domThis = $('#dialog')[0];
    var wh = $(window).height() / 2;
    $("body").css({
        "background-image": "url(about:blank)",
        "background-attachment": "fixed"
    });
    domThis.style.setExpression('top', 'eval((document.documentElement).scrollTop + ' + wh + ') + "px"');
});
</script>
<![endif]-->
      
    

 <script type="text/javascript">
        function trySubmit() {
            if (this.submitFlag == 1) {
                alert('数据已经提交，请勿再次提交。');
                return false;
            }
            else {
                this.submitFlag = 1;               
                return true;
            }
        }
    </script>
    <script type="text/javascript">
	//立即购买
 function order(i)
{

var uexist="<?php echo get_username();?>";

if(uexist){
var gprice=$("em.price").eq(0).text();//价格
var parameters=$("a.cur").text();//参数
if($(".weight").length>0){
var s=$(".weight .cur").index()+1;
var string=String(gid)+String(s);
}
else{
var string=String(gid);
}
$("#inputprice").val(gprice);
$("#inputsort").val(string);
$("#inputparameters").val(parameters);
document.orderform.submit();
}

else{showBg();

}
}
//收藏
function favor() { 
	var uexist="<?php echo get_username();?>";
if(uexist){
var favorid='<?php echo ($info["id"]); ?>';
	$.ajax({
type:'post', //传送的方式,get/post
url:'<?php echo U("User/favor");?>', //发送数据的地址
data:{id:favorid},
 dataType: "json",
success:function(data){
	alert(data.msg)
	}
	,
error:function (event, XMLHttpRequest, ajaxOptions, thrownError) {
alert(XMLHttpRequest+thrownError); }
})	
}

else{
showBg();
}
	
	}

//加入购物车
function buy(i)
{
var gid=i;
var url='<?php echo U("Shopcart/addItem");?>';//地址
var gnum=$(".goodnum").val();//数量
var gprice=$(".price").eq(0).text();//价格
var src=$(".img img").attr("src");//图片
var image='<img src="'+src+'"width="40" height="40">';
var href='<a  href="<?php echo U('Article/detail?id='.$info['id']);?>">';
var title=$("#tit").text();//名称
var parameters=$(".weight .cur").text();//参数
if($(".weight").length>0){
var s=$(".weight .cur").index()+1;
var string=String(gid)+String(s);
}
else{
var string=String(gid);}

$.ajax({
type:'post', //传送的方式,get/post
url:'<?php echo U("Shopcart/addItem");?>', //发送数据的地址
 data:{
	id:gid,num:gnum,price:gprice,i:parameters,sort:string
 },
 dataType: "json",
success:function(data)
{
var html='<li><dl><dt class="mini-img">'+href+image+'</a><dd><span class="mini_title">'+href+title+'</a></span><span class="mini-cart-count red"> ￥'
+gprice+'<em class="'+string+'">*'+gnum+'</em></span>'+'</dd><dd><span class="mini-cart-info">'+parameters+'</span><span class="mini-cart-del"><a name="'+string+'" rel="del"  onclick="delcommon(event);return false;">删除</a></span></dd>'+'</dl></li>';//创建节点〉
if(data.exsit=="1"){
	$("em."+string).text("*"+data.num);
	//后台返回数据，判断购物车中是否已存在，存在，不追加节点
}	
else{
//后台返回数据，判断购物车中是否已存在，不存在，追加节点
	$("p.sc_goods_none").remove();//移除节点
$("ul.sc_goods_ul").append(html);//追加节点

}
if(data.num=="0"){ //判断数量是否为0，为0则隐藏底部查看工具
						$("div.sc_goods_foot").hide();
	}
	else{$("div.sc_goods_foot").show();}
$('#totalnum').text(data.sum);
$('#fee').text(data.fee);
$('#showIncludeCart').fadeIn();
},
error:function (XMLHttpRequest, ajaxOptions, thrownError) {
alert(XMLHttpRequest+thrownError); }
		})
}
 //增加数量
function add() {

 var num = $(".goodnum").val();     
num++;  
     $(".goodnum").val(num); 
}
//减少数量
function reduce() {

 var num = $(".goodnum").val();     

if(num>1)  
      { num--; 
    $(".goodnum").val(num);
      }
	  else{
		  $("#oneA").addClass("important");alert("数量最少为1") }

}  
 //登录后刷新页面，载入数据
$("#login_btn").click(function(){
	   
   var yourname=$('#inputusername').val();
	var yourword=$('#inputpassword').val();
		
	$.ajax({
type:'post', //传送的方式,get/post
url:'<?php echo U("User/loginfromdialog");?>', //发送数据的地址
data:{username:yourname,password:yourword},
 dataType: "json",
success:function(data)
{if(data.status=="1"){
	$(".tips").html(data.info);
document.orderform.submit();
}
else{$(".tips").html(data.info);

}

},
error:function (event, XMLHttpRequest, ajaxOptions, thrownError) {
alert(XMLHttpRequest+thrownError); }
});});
    </script>
     


 </div>
	<!-- /主体 -->

	<!-- 购物车js -->
   	<script>
	//购物车显示与隐藏
	 var Shopcart= document.getElementById('shopping_cart');
     var Goodsmenu= document.getElementById('goods');
            var timerr = null;//定义定时器变量
            //鼠标移入div1或div2都把定时器关闭了，不让他消失
            Shopcart.onmouseover =Goodsmenu.onmouseover = function ()
            {
                Goodsmenu.style.display = 'block';
                clearTimeout(timerr);
            }
            //鼠标移出div1或div2都重新开定时器，让他延时消失
            Shopcart.onmouseout =Goodsmenu.onmouseout = function ()
            {
                //开定时器
                timerr= setTimeout(function () { 
                    Goodsmenu.style.display = 'none'; }, 10);
            }
			
//购物车动态删除
	function delcommon(event)
		{ //获取事件源
event = event ? event : window.event; 
var obj = event.srcElement ? event.srcElement : event.target; 
//这时obj就是触发事件的对象，可以使用它的各个属性 
//还可以将obj转换成jquery对象，方便选用其他元素 
str = obj.innerHTML.replace(/<\/?[^>]*>/g,''); //去除HTML tag

	var $obj = $(obj);
	var str=$obj.parent().prev().html();
	if(obj.rel=="del")
{ var str=obj.name;
var uexist="<?php echo get_username();?>";
	//全选的实现 定义删的发送路径
	if(uexist){
		var del='<?php echo U("Shopcart/delItemByuid");?>';	
	}
else{
var del='<?php echo U("Shopcart/delItem");?>';
	
	}

$.ajax({
type:'post', //传送的方式,get/post
url:del, //发送数据的地址
data:{sort:str},
 dataType: "json",
success:function(data)
{var $obj = $(obj);
	$obj.parents("li").remove();
	if(data.sum=="0"){  //判断购物车数量是否为0，为0则隐藏底部查看工具
						$("div.sc_goods_foot").hide();
					   	var html='<p class="sc_goods_none" >您的购物车还是空的，赶紧行动吧！</p>';
					   $("ul.sc_goods_ul").html(html);
				
	
	}
	else{$("div.sc_goods_foot").show();}

},
error:function (event, XMLHttpRequest, ajaxOptions, thrownError) {
alert(XMLHttpRequest+thrownError); }
		})
}
	
	} 
//购物车删除结束


	
</script>
   <!-- /购物车js -->

	<!-- 底部 -->
	
    <!-- 底部-->
   <script type="text/javascript"  charset="utf-8" src="/b2c/Public/static/js/menudown.js"></script> 

</div></div>
<div class="footer">
<div class="footer_pic_new">
		<div class="footer_pic_new_inner">
		    <a name="foot_1" href="http://help.dangdang.com/details/page13" target="_blank" class="footer_pic01"><span>正规渠道正品保障</span></a>
		    <a name="foot_2" class="footer_pic02" href="http://help.dangdang.com/details/page21" target="_blank"><span>放心购物货到付款</span></a>
		    <a name="foot_3" class="footer_pic03" href="http://help.dangdang.com/details/page16" target="_blank"><span>150城市次日送达</span></a>
		    <a name="foot_4" class="footer_pic04" href="http://help.dangdang.com/details/page29" target="_blank"><span>上门退货当场退款</span></a>
		</div>
	</div>
    <div class="foot_center">  
	
  <?php if(is_array($footermenu)): $i = 0; $__LIST__ = $footermenu;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><dl><dt><?php echo ($vo["title"]); ?></dt>
 <?php if(is_array($vo['id'])): $i = 0; $__LIST__ = $vo['id'];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$son): $mod = ($i % 2 );++$i;?><dd><a rel="nofollow"  href="<?php echo U('service/index?id='.$son['id']);?>"><?php echo ($son["title"]); ?></a></dd><?php endforeach; endif; else: echo "" ;endif; ?>
</dl><?php endforeach; endif; else: echo "" ;endif; ?> 
     

<dl>
    <dt>在线客服</dt>
    <dd>周一至周五</dd>
    <dd>09:00-18:00</dd>
	<dd><a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=<?php echo C('QQ');?>&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:<?php echo C('QQ');?>:51" alt="点击这里给我发消息" title="点击这里给我发消息"/></a></dd>
</dl>

  

     
    </div>
 
<div class="theme-footer"> 
    

  
      
       <p><span style=" text-align: center;"> Copyright@yershop商城系统 2014-2015 <strong><a href="http://www.yershop.com/" target="_blank" class="red">Yershop.com</a></strong> <?php echo C('WEB_SITE_ICP');?></p>
    
	</div> </div>


	<!-- /底部 --></div>
</body>
</html>
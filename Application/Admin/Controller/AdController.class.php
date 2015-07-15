<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 后台订单控制器
  * @author 烟消云散 <1010422715@qq.com>
 */
class AdController extends AdminController {

    /**
     * 订单管理
     * author 烟消云散 <1010422715@qq.com>
     */
    public function index(){
        /* 查询条件初始化 */
	
       $map  = array('status' => 1);
      if(IS_GET){ $title=trim(I('get.title'));
		 $map['title'] = array('like',"%{$title}%");
        $list   =   M("Ad")->where($map)->field(true)->order('id desc')->select();}
     else 
		 { 
		 $list = $this->lists('Ad', $map,'id desc');
	 }
        $this->assign('list', $list);
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        
        $this->meta_title = '首页分类推广管理';
        $this->display();
    }

  /* 编辑分类 */
    public function edit($id = null, $pid = 0){
        $ad = D('ad');
        $list=flist(); /* 获取一级分类 */
$this->assign('list',$list);
        if(IS_POST){ //提交表单
            if(false !== $ad->update()){
                $this->success('编辑成功！', U('index'));
            } else {
                $error = $ad->getError();
                $this->error(empty($error) ? '未知错误！' : $error);
            }
        } else {
            $cate = '';
            if($pid){
                /* 获取上级分类信息 */
                $cate = $ad->info($pid, 'id,name,title,status');
                if(!($cate && 1 == $cate['status'])){
                    $this->error('指定的上级分类不存在或被禁用！');
                }
            }

            /* 获取分类信息 */
            $info = $id ? $ad->info($id) : '';

            $this->assign('info',       $info);
            $this->assign('category',   $cate);
            $this->meta_title = '编辑优惠券';
            $this->display();
        }
    }

    /* 新增分类 */
    public function add(){
        $ad = D('ad');
      $list=flist(); /* 获取一级分类 */
$this->assign('list',$list);
        if(IS_POST){ //提交表单
            if(false !== $ad->update()){
                $this->success('新增成功！', U('index'));
            } else {
                $error = $ad->getError();
                $this->error(empty($error) ? '未知错误！' : $error);
            }
        } else {
            $cate = array();
            if($pid){
                /* 获取上级优惠券信息 */
                $cate = $ad->info($pid, 'id,title,status');
                if(!($cate && 1 == $cate['status'])){
                    $this->error('指定的上级分类不存在或被禁用！');
                }
            }

            /* 获取优惠券信息 */
            $this->assign('info',       null);
            $this->assign('category', $cate);
            $this->meta_title = '新增优惠券';
            $this->display();
        }
    }



 

 public function del(){
       if(IS_POST){
             $ids = I('post.id');
            $order = M("ad");
			
            if(is_array($ids)){
                             foreach($ids as $id){
		
                             $order->where("id='$id'")->delete();
						
                }
            }
           $this->success("删除成功！");
        }else{
            $id = I('get.id');
            $db = M("ad");
            $status = $db->where("id='$id'")->delete();
            if ($status){
                $this->success("删除成功！");
            }else{
                $this->error("删除失败！");
            }
        } 
    }

}
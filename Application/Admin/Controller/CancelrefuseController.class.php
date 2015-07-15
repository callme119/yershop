<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | author 烟消云散 <1010422715@qq.com>
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 后台订单控制器
  * @author 烟消云散 <1010422715@qq.com>
 */
class CancelrefuseController extends AdminController {

    /**
     * 订单管理
     * author 烟消云散 <1010422715@qq.com>
     */
    public function index(){
        /* 查询条件初始化 */
	
       $map  = array('status' =>2);
       $list = $this->lists('cancel', $map,'id');

        $this->assign('list', $list);
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        
        $this->meta_title = '退货管理';
        $this->display();
    }

    /**
     * 新增订单
     * @author 烟消云散 <1010422715@qq.com>
     */
    public function add(){
        if(IS_POST){
            $Config = D('cancel');
            $Config->create();
			  /* 新增时间并更新时间*/
             $Config->time = NOW_TIME;
            $Form->update_time = NOW_TIME;
            if($data){
                if($Config->add()){
                    S('DB_CONFIG_DATA',null);
                    $this->success('新增成功', U('index'));
                } else {
                    $this->error('新增失败');
                }
            } else {
                $this->error($Config->getError());
            }
        } else {
            $this->meta_title = '新增配置';
            $this->assign('info',null);
            $this->display();
        }
    }

    /**
     * 编辑订单
     * @author 烟消云散 <1010422715@qq.com>
     */
    public function edit($id = 0){
        if(IS_POST){
            $Form = D('cancel');
         
            if($_POST["id"]){
				$id=$_POST["id"];
           $Form->create();
			    /*更新时间*/
            $Form->update_time = NOW_TIME;
			/* 编辑后保存编辑人*/
           $result=$Form->where("id='$id'")->save();
                if($result){
                    //记录行为
                    action_log('update_cancel', 'cancel', $data['id'], UID);
                    $this->success('更新成功', Cookie('__forward__'));
                } else {
                    $this->error('更新失败'.$id);
                }
            } else {
                $this->error($Config->getError());
            }
        } else {
            $info = array();
            /* 获取数据 */
            $info = M('cancel')->find($id);
            $orderid=$info["orderid"];
            $list=M('order')->where("orderid='$orderid'")->select();
			$detail=M('shoplist');
            foreach($list as $n=> $val){
            $list[$n]['id']=$detail->where('orderid=\''.$val['id'].'\'')->select(); 
     }
     $trans=M('transport');
	   foreach($list as $k=> $va){
         $list[$k]['addressid']=$trans->where('id=\''.$va['addressid'].'\'')->select(); 
     }
            if(false === $info){
                $this->error('获取订单信息错误');
            }
            $this->assign('list', $list);

			 $this->assign('info', $info);
            $this->meta_title = '编辑订单';
            $this->display();
        }
    }

 /**
     * 同意取消订单
     * @author 烟消云散 <1010422715@qq.com>
     */
    public function complete($id = 0){
 $Form = D('cancel');
		$id = I('get.id');
           $Form->create();
			    /*更新时间*/
		$Form->info="取消完成";
           $Form->update_time = NOW_TIME; $Form->status=2;
           $result=$Form->where("id='$id'")->save();
 $order=M("order"); 
 $info = M('cancel')->find($id);
            $orderid=$info["orderid"];
  //更新订单列表订单状态为已取消，清空取消订单操作
 $act="<A href='http://".$_SERVER['HTTP_HOST']."/index.php?s=/Home/Order/canceldetail/id/".$orderid."'>订单已取消</a>";
   $data = array('status'=>'6','backinfo'=>'订单已关闭','act_cancel'=>$act);//设置订单为订单已取消
 
                if( $order->where("orderid='$orderid'")->setField($data)){
                    //记录行为
                    action_log('update_cancel', 'cancel', $data['id'], UID);
                    $this->success('更新成功', Cookie('__forward__'));
                } else {
                    $this->error('更新失败');
                }
           
            $this->display();
     
        
 } 
   /**
     * 删除订单
     * @author yangweijie <yangweijiester@gmail.com>
     */
    public function del(){
       if(IS_POST){
             $ids = I('post.id');
            $order = M("cancel");
			
            if(is_array($ids)){
                             foreach($ids as $id){
		
                             $order->where("id='$id'")->delete();
						
                }
            }
           $this->success("删除成功！");
        }else{
            $id = I('get.id');
            $db = M("cancel");
            $status = $db->where("id='$id'")->delete();
            if ($status){
                $this->success("删除成功！");
            }else{
                $this->error("删除失败！");
            }
        } 
    }



}
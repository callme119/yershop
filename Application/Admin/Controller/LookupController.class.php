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
class LookupController extends AdminController {

    /**
     * 首页访问统计
     * author 烟消云散 <1010422715@qq.com>
     */
    public function index(){
        /* 查询条件初始化 */
	
       $map  = array('tag' =>'1');
       $list = $this->lists('records', $map,'id desc');

        $this->assign('list', $list);
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        
        $this->meta_title = '首页统计';
        $this->display();
    }
	/**
     * 分类页访问统计
     * author 烟消云散 <1010422715@qq.com>
     */
 public function category(){
        /* 查询条件初始化 */
	
       $map  = array('tag' =>'2');
       $list = $this->lists('records', $map,'id desc');

        $this->assign('list', $list);
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        
        $this->meta_title = '栏目页统计';
        $this->display();
    }
	/**
     * 内容页访问统计
     * author 烟消云散 <1010422715@qq.com>
     */
 public function article(){
        /* 查询条件初始化 */
	
       $map  = array('tag' =>'3');
       $list = $this->lists('records', $map,'id desc');

        $this->assign('list', $list);
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        
        $this->meta_title = '内容页统计';
        $this->display();
    }
    /**
     * 编辑
     * @author 烟消云散 <1010422715@qq.com>
     */
    public function edit($id = 0){
        if(IS_POST){
            $Form = D('records');
       
            if($_POST["id"]){
				$id=$_POST["id"];

			    /*更新时间*/
            $Form->time = NOW_TIME;
			 /* 编辑后新增系统反馈信息*/
          	$Form->info = $_POST["info"];
           $result=$Form->where("id='$id'")->save();
                if($result){
                    //记录行为
                    action_log('update_backlist', 'backlist', $data['id'], UID);
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
            $info = M('records')->find($id);

            $list=M('records')->where("id='$id'")->select();

            if(false === $info){
                $this->error('获取订单信息错误');
            }
            $this->assign('list', $list);

			 $this->assign('info', $info);
            $this->meta_title = '编辑订单';
            $this->display();
        }
    }

    public function del(){
       if(IS_POST){
             $ids = I('post.id');
            $arr = M("records");
			
            if(is_array($ids)){
                             foreach($ids as $id){
		
                             $arr->where("id='$id'")->delete();
						
                }
            }
           $this->success("删除成功！");
        }else{
            $id = I('get.id');
            $db = M("records");
            $status = $db->where("id='$id'")->delete();
            if ($status){
                $this->success("删除成功！");
            }else{
                $this->error("删除失败！");
            }
        } 
    }



}
<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2018/11/8
 * Time: 17:34
 */

namespace app\admin\controller;


use think\Controller;
use app\admin\model\Access as AccessModel;
use think\Request;
class Access extends BaseController
{
     //权限列表
    public function AccessList()
    {
        if($this->checkUser()){
            $data=AccessModel::AccessList();
            $this->assign('data',$data);
            return $this->fetch('index');
        }else{
            return "无权访问";
        }
    }
    public function add()
    {
        if(!$this->checkUser()){
            return "无此权限，请联系管理员提升权限";
        }
        return $this->fetch();
    }
    public function edit()
    {
        if(!$this->checkUser()){
            return "无此权限，请联系管理员提升权限";
        }
        //获取页面的id
        $request = Request::instance();
        $id=$request->param('id');
        $Info=AccessModel::get($id)->toArray();      //返回单行数组
        $tmp_urls=@json_decode($Info['urls'],true);
        $tmp_urls=$tmp_urls?$tmp_urls:[];
        $tmp_urls=implode(',',$tmp_urls);
        $this->assign('tmp_urls',$tmp_urls);
        $this->assign('Info',$Info);
        return $this->fetch();
    }
    /**
     * 添加或者编辑权限
     * post   处理添加或者编辑权限
     */
    public function actionSet()
    {
        if(!$this->checkUser()){
            return "无此权限，请联系管理员提升权限";
        }
        //*******校验
        //提交的数据不能为空
        if(empty($_POST)){
            return $this->errorMsg('不能提交空数据');
        }
        //标题不能为空
        if(is_null($_POST['title'])){
            return $this->errorMsg('标题不能为空');
        }
        //链接不能为空
        if (is_null($_POST['urls'])){
            return $this->errorMsg('链接不能为空');
        }


        $title=trim($_POST['title']);
        $urls=trim($_POST['urls']);

        if( mb_strlen($title,"utf-8") < 1 || mb_strlen($title,"utf-8") > 20 ){
            return $this->errorMsg('请输入合法的权限标题');
        }

        if( !$urls ){
            return $this->errorMsg('请输入合法的Urls');
        }

        $urls = explode(",",$urls);
        if( !$urls ){
            return $this->errorMsg('请输入合法的Urls');
        }


        $pData=[
            'title'=>$title,
            'urls'=>json_encode($urls),
            'created_time'=>date("Y-m-d H:i:s")
        ];
        $action=$_POST['action'];
        if ($action=='add'){
            $pData['created_time']=date("Y-m-d H:i:s");
            //检查title 是否有重复  And   urls是否合法
            $res =AccessModel::get(['title'=>$title]);
            if (!is_null($res))
            {
                return  $this->errorMsg('标题已存在');
            }
            $addRes=AccessModel::create($pData);
            if ($addRes){
                return $this->SuccMsg('增加权限成功');
                exit;
            }else{
                return $this->errorMsg('增加权限失败');
            }
        }else if($action=='edit'){
            $pData['updated_time']=date("Y-m-d H:i:s");
            $pData['id']=$_POST['id'];
            $res = AccessModel::update($pData);
            if ($res){
                return $this->SuccMsg('编辑权限成功');
            }else{
                return $this->errorMsg('编辑权限失败');
            }
        }
    }
}
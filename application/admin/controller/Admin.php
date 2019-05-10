<?php
namespace app\admin\controller;

use think\Request;
use app\admin\model\AdminRole;
use app\admin\model\AdminRole as AdminRoleModel;
use app\admin\model\Role as RoleModel;
use app\admin\model\Admin as AdminModel;
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2018/11/4
 * Time: 19:37
 */
class Admin extends BaseController
{
    public function index()
    {
       if($this->checkLoginStatus()){
           return $this->fetch();
       }
       return $this->error('尚未登录','Login/index');
    }

    public function welcome()
    {
        return $this->fetch('welcome');
    }
    public function add()
    {
        if(!$this->checkUser()){
            return "无此权限，请联系管理员提升权限";
        }
        $RoleList=RoleModel::RoleList();
        $this->assign('RoleList',$RoleList);
        return $this->fetch('admin-add');
    }
    public function AdminList()
    {
        if($this->checkUser()){
            $list=AdminModel::AdminList();
            $this->assign('list',$list);
            return $this->fetch('admin-list');
        }else{
            return "无权访问";
        }
    }

    /*
     * 编辑页面
     * */
    public function edit()
    {
        if(!$this->checkUser()){
            return "无此权限，请联系管理员提升权限";
        }
        //获取页面的id
        $request = Request::instance();
        $id=$request->param('id');
        $RoleList=RoleModel::RoleList();
        $Info=AdminModel::get($id)->toArray();                  //返回单行数组
        $roleInfo=AdminRoleModel::all(['uid'=>$id]);            //查出用户所选的角色，返回id
        //将对象转化为数组
        foreach ($roleInfo as $k=>$v)
        {
            //已选角色
            $roleInfo[$k]=json_decode($v,true);
        }

        //取出已分配的角色ID
        $Role_id=array_column($roleInfo,'role_id');

        //将用户对应的角色赋值给模板
        $this->assign('RoleList',$RoleList); //角色列表
        $this->assign('Role_id',$Role_id); //已选角色
        $this->assign('Info',$Info);
        return $this->fetch('admin-edit');
    }
    /*
     * $id  用户id
     * */
    public function del()
    {
        if(!$this->checkUser()){
            return "无此权限，请联系管理员提升权限";
        }
        $request = Request::instance();
        $id=$request->param('id');
        $res=db('admin')->delete($id);
        if ($res) {
            echo $this->succMsg('删除成功');
        }else{
            echo $this->errorMsg('删除失败');
        }
        exit();
    }
    /*
     * 批量删除
     * */
    public function delAll()
    {
        if(!$this->checkUser()){
            return "无此权限，请联系管理员提升权限";
        }
        $request = Request::instance();
        $data=$request->get();
        $length=count($data['id']);
        $ids=implode(",",$data['id']);  //id1,id2,id3
        $res=AdminModel::destroy($ids);
        if ($res==$length){
            echo $this->succMsg('批量删除成功');
        }else{
            echo $this->errorMsg('批量删除失败');
        }
    }
    /*
     *
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

        $name=$_POST['name'];


        $email=$_POST['email'];
        //判断传过来的数据中，用户是否有选中角色
        $pData=$_POST;
        if(!array_key_exists('role_ids',$pData)){
            return $this->errorMsg('角色不能为空');
        }
        //*******校验
        if($_POST['action']=='add'){
            //检查名字是否有重复
            $res =AdminModel::get(['name'=>$name]);
            if (!is_null($res))
            {
                return $this->errorMsg('名字已存在');
            }
            $emailRes =AdminModel::get(['email'=>$email]);
            if(!is_null($emailRes))
            {
                return $this->errorMsg('email 已经存在');
            }
            $AdminInfo = [
                'name' => $name,
                'email' => $email,
                'created_time' => date("Y-m-d H:i:s"),
                'updated_time' => date("Y-m-d H:i:s")
            ];
            $res = AdminModel::create($AdminInfo);
            $id=AdminModel::getLastInsID();
            $AdminRole=new AdminRole();
            $RoleInfo=[];
            foreach ($_POST['role_ids'] as $k =>$v){
                    $RoleInfo[$k]=[ 'uid' =>$id, 'role_id'=>$v, 'created_time' => date("Y-m-d H:i:s")];
            }
            $roleRes = $AdminRole->saveAll($RoleInfo);

            if ($res && $roleRes) {
                return $this->succMsg('创建成功');
            } else {
               return $this->errorMsg('创建失败');
            }
        }else if ($_POST['action']=='edit'){
            $id=$_POST['id'];   //根据页面的id
            $AdminInfo = [ 'name' => $name, 'email' => $email,'id'=>$id, 'updated_time' => date("Y-m-d H:i:s")];
            $res = AdminModel::update($AdminInfo);
            //如果用户信息更新成功，接下来就处理角色编辑的业务
            if($res){
                //角色编辑
                $roleInfo=AdminRoleModel::all(['uid'=>$id]);            //返回多行数组 （查出用户所选的角色）
                //将对象转化为数组
                $Roled=[];
                foreach ($roleInfo as $k=>$v)
                {
                    //已选角色
                    $Roled[$k]=json_decode($v,true);
                }
                $Roled_id=array_column($Roled,'role_id');                                //取出已分配的角色ID
                if(is_null($_POST['role_ids'])){
                    return $this->errorMsg('角色不能为空');
                }
                //页面传过来的角色 ( 以小写 p 开头  ，象征 post  )
                $pRole_id=$_POST['role_ids'];

                //找出删除的角色
                foreach ($Roled_id as $v){
                    if(!in_array($v,$pRole_id)){
                        AdminRole::destroy(['uid'=>$id,'role_id'=>$v]);
                    }
                }

                foreach ($pRole_id as $v){
                    if(!in_array($v,$Roled_id)){
                        AdminRole::create(['uid'=>$id,'role_id'=>$v]);
                    }
                }
                return $this->succMsg('编辑成功');
            }else{
                return $this->errorMsg('编辑失败');
            }
        }
    }


}
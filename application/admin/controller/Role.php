<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2018/11/5
 * Time: 19:11
 * 角色控制器
 */

namespace app\admin\controller;



use app\admin\model\Access;
use app\admin\model\RoleAccess;
use think\Request;
use app\admin\model\Role as RoleModel;

class Role extends BaseController
{
    //列表页面
    public function RoleList()
    {
        if($this->checkUser()){
            $list=RoleModel::RoleList();
            $this->assign('list',$list);
            return $this->fetch('admin-role');
        }else{
            return "无权访问";
        }
    }
    //添加角色页面
    public function add()
    {
        if ($this->checkUser()){
            $AccessList=Access::AccessList();     //取出所有权限
            $this->assign('AccessList',$AccessList);
            return $this->fetch('role-add');
        }else{
            return "无此权限,请联系超级管理员提升权限";
        }
    }
    //编辑页面
    public function edit()
    {
        if ($this->checkUser()){
            //获取页面的id
            $request = Request::instance();
            $id = $request->param('id');
            $Info = RoleModel::get($id)->toArray(); //返回单行数组
            $AccessList = Access::AccessList();     //取出所有权限
            /* 取出该角色对应的权限*/
            //1，根据role_id 去取出权限
            $RoleAccessInfo = RoleAccess::all(['role_id' => $id]);  //返回一个对象
            foreach ($RoleAccessInfo as $k => $v)
            {
                $RoleAccessInfo[$k]=json_decode($v,true);
            }
            //取出已分配的权限id
            $Access_id=array_column($RoleAccessInfo,'access_id');
            $this->assign('Access_id',$Access_id);
            $this->assign('AccessList',$AccessList);
            $this->assign('Info',$Info);
            return $this->fetch('role-edit');
        }else{
            return "无此权限,请联系超级管理员提升权限";
        }
    }

    /**
     * 为角色设置权限页面
     * @return array
     */
    public function setAccess()
    {
        //获取页面的id
        if ($this->checkUser()){
            $request = Request::instance();
            $id=$request->param('id');
            $Info=RoleModel::get($id)->toArray(); //返回单行数组
            $AccessList=Access::AccessList();     //取出所有权限
            $R_AList=RoleAccess::all(['role_id'=>$id]);//取出所有已分配的权限
            $access_ids=array_column($AccessList,"access_id");
            $this->assign('AccessList',$AccessList);
            $this->assign('access_ids',$access_ids);
            $this->assign('R_AList',$R_AList);
            $this->assign('Info',$Info);
            return $this->fetch('setaccess');
        }else{
            return "无此权限,请联系超级管理员提升权限";
        }
    }

    /**
     * @return json
     */
    public function actionSet()
    {
        if(!$this->checkUser()){
            return "无此权限，请联系管理员提升权限";
        }
        //提交的数据不能为空
        if(empty($_POST)){
            $array=[
                'code'=> 200,
                'msg' => "不能提交空数据"
            ];
            return json_encode($array);
            die();
        }
        $pData=$_POST;
        //判断角色名
        if(isset($pData['name'])){
            if($pData['name']==''){
                echo $this->errorMsg('名字不能为空');
                exit;
            }
        }else{
            echo $this->errorMsg('缺name这个key');
            exit;
        }

        //判断权限id
        if(isset($pData['Access_ids'])){
            if($pData['Access_ids']==''){
                echo $this->errorMsg('权限不能为空');
                exit;
            }
        }else{
            echo $this->errorMsg('缺Access_ids这个key');
            exit;
        }
        //检查名字是否有重复
        $res =RoleModel::get(['name'=>$pData['name']]);
        if (!is_null($res))
        {
            $array=[
                'code'=> 200,
                'msg' => "名字已存在"
            ];
            return json_encode($array);
            die();
        }
        $roleInfo=[
            'name'=>$pData['name'],
            'created_time'=>date("Y-m-d H:i:s"),
            'updated_time'=>date("Y-m-d H:i:s")
        ];
        $RoleRes=RoleModel::create($roleInfo);
        $role_id=RoleModel::getLastInsID();
        $role_access_Info=[];
        $role_access=new RoleAccess();
        foreach ($pData['Access_ids'] as $k =>$v){
            $role_access_Info[$k]=[ 'role_id' =>$role_id , 'access_id'=>$v, 'created_time' => date('Y=m=d H:i:s')];
        }
        $role_access_res=$role_access->saveAll($role_access_Info);
        //设置权限
        if($RoleRes && $role_access_res){
            return $this->SuccMsg('创建成功');
        }else{
            return $this->errorMsg('创建失败');
        }
    }
    /*
     *
     *
     * */
    public function actionUpdate()
    {
        if(!$this->checkUser()){
            return "无此权限，请联系管理员提升权限";
        }
        //提交的数据不能为空
        if(empty($_POST)){
            return $this->errorMsg('不能提交空数据');
        }
        $pData=$_POST;
        //判断是否有角色名
        if(isset($pData['name'])){
            if($pData['name']==''){
                return errorMsg('action不能为空');
            }
        }else{
            return errorMsg('缺action');
        }
        //检查名字是否有重复
//        $res =RoleModel::get(['name'=>$pData['name']]);
//        if (!is_null($res)) {
//            return $this->errorMsg('名字已存在');
//        }

        //判断是否有id
        if(isset($pData['id'])){
            if($pData['id']==''){
                return errorMsg('id不能为空');
            }
        }else{
            return errorMsg('缺id');
        }
        $roleInfo=['name'=>$pData['name'], 'id'=>$pData['id'], 'updated_time'=>date("Y-m-d H:i:s")];
        $res1=RoleModel::update($roleInfo)->where(['id'=>$pData['id']]);

        $role_access_list=RoleAccess::all(['role_id'=>$pData['id']]); //取出该角色所对应的权限id
        foreach ($role_access_list as $k =>$v){
            $role_access_list[$k]=json_decode($v,true);
        }
        $assign_access_ids=array_column($role_access_list,'access_id');
        /* *
         * 找出删除的权限
         * 假如已有的权限集合是A，界面传递过来得权限集合是B
         * 权限集合A当中的某个权限不在权限集合B当中，就应该删除
         * 使用 array_diff() 计算补集
         */
        $delete_access_ids=array_diff($assign_access_ids,$pData['Access_ids']);
        if ($delete_access_ids) {
            foreach ($delete_access_ids as $k => $v){
                RoleAccess::destroy(['role_id' => $pData['id'], 'access_id' => $v]);
            }
        }

         /**
          * 找出添加的权限
          * 假如已有的权限集合是A，界面传递过来的权限集合是B
          * 权限集合B当中的某个权限不在权限集合A当中，就应该添加
          * 使用 array_diff()  计算补集
          */
         $new_access_ids=array_diff($pData['Access_ids'],$assign_access_ids);
         if($new_access_ids){
             foreach ($new_access_ids as $v){
                 RoleAccess::create(['role_id'=>$pData['id'],'access_id'=>$v,'created_time'=>date('Y-m-d H:i:s')]);
             }
         }
        if($res1){
            return $this->SuccMsg('编辑成功');
        }else{
            return $this->errorMsg('编辑失败');
        }
    }
}
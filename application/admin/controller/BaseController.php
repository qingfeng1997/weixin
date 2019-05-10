<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2018/11/7
 * Time: 13:42
 */

namespace app\admin\controller;


use app\admin\model\AppAccessLog;
use think\Controller;
use think\Db;
use think\Request;

class BaseController extends Controller
{
    public $privilege_urls=[];  //保存去的权限链接

    //统一验证方法
    public function checkUser()
    {
        $login_status=$this->checkLoginStatus();
        if (!$login_status){
            return $this->error('未登录，请重新登录');
        }
        //判断当前php运行环境是否隐藏了index.php
        if(strstr($_SERVER['REQUEST_URI'],"index.php")){
            $request_url=str_replace('/index.php/admin/','',$_SERVER['REQUEST_URI']);
        }else{
            $request_url=str_replace('/admin/','',$_SERVER['REQUEST_URI']);
        }
        $request_url=str_replace('.html','',$request_url);
        //保存所有的访问信息到数据库当中(系统日志)---数据库的形式
        $request = Request::instance();
        $get_params=$request->get();
        $post_params=$request->post();
        $model_log=new AppAccessLog();
        $model_log->uid=session('uid')?session('uid'):'';
        $model_log->target_url=isset($request_url)?$request_url:'';
        $model_log->query_params=json_encode(array_merge($post_params,$get_params));
        $model_log->ua=isset($_SERVER['HTTP_USER_AGENT'])?$_SERVER['HTTP_USER_AGENT']:'';
        $model_log->ip=isset($_SERVER['REMOTE_ADDR'])?$_SERVER['REMOTE_ADDR']:'';
        $model_log->created_time=date("Y-m-d H:i:s");
        $model_log->save();

        //判断是否是超级管理员
        if ($this->is_Admin()==1){
            return true;
        }
        $privilege_urls=$this->getRolePrivilege();    //数据库当中的权限链接
        if (in_array($request_url,$privilege_urls)){
            return true;
        }else{
            return false;
        }
    }

    /** 判断是否已经登录
     * @return  boolean
     * */
    public function checkLoginStatus()
    {
        return session('?name');
    }


    /**
     * 判断是否是超级管理员
     * @return  $code=0,1
     * */
    public function is_Admin()
    {
        if (session('name')=='admin'){
            return $code=1;
        }else{
            return $code=0;
        }

    }
    /*
     * 获取某用户的所有权限(取出url)
     * @return    $privilege_urls    用户的所拥有的权限链接
     * */
    public function getRolePrivilege(){
        $uid = session('uid');
        if(!$uid){
             return $this->error('缺用户id','Login/index');
        }

        //取出指定用户的所属角色
        $role_ids=Db::table('admin_role')->where('uid',$uid)->field('role_id')->select();
        $privilege_urls=[];
        if ($role_ids){
            //在通过角色   取出  所属 权限关系
            foreach ($role_ids as $k => $v){
                $access_ids=Db::table('role_access')->where('role_id',$v['role_id'])->field('access_id')->select();
            }
            //在权限表中取出所有的权限链接
            foreach ($access_ids as $k => $v){
                $list[$k]=Db::table('access')->where('id',$v['access_id'])->field('urls')->select();
            }

            if ($list) {
                foreach ($list as $item)
                    foreach ($item as $_item) {
                        $tmp_urls = @json_decode($_item['urls'], true);
                        $privilege_urls = array_merge($privilege_urls, $tmp_urls);
                    }
                }
            }
            return $privilege_urls;
        }

    //post提交数据成功后用此方法
    public function SuccMsg($msg)
    {
        $array=[
            'code' =>201,
            'msg' => $msg
        ];
        return json_encode($array);
    }

    public function errorMsg($msg)
    {
        $array=[
            'code' => 204,
            'msg' => $msg
        ];
        return json_encode($array);
    }

    //总验证方法
    //1，验证是否登录 checkLoginStatus
    //2，检查是否有访问该链接的权限 checkPrivilege ， getRolePrivilege
    //3，统一返回给子方法 true or false
}
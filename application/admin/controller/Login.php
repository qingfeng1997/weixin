<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2018/12/3
 * Time: 19:49
 */

namespace app\admin\controller;


use app\admin\model\Admin;
use think\Request;

class Login extends BaseController
{
    public function index()
    {
        return $this->fetch();
    }
    public function login()
    {
        if (Request::instance()->isPost()){
            $pData=Request::instance()->post();
            $res=Admin::get(['name'=>$pData['name']])->toArray();
            if ($res){
                session('name',$pData['name']);
                session('uid',$res['id']);
                return $this->SuccMsg('登录成功');
            }else{
                return $this->errorMsg('无此用户');
            }
        }
        return $this->errorMsg('请求出错');
    }

    public function loginOut()
    {
        session('name','');
        session('uid','');
        return $this->fetch('index');
    }

}
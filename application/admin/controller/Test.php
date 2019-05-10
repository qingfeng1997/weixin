<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2018/12/4
 * Time: 11:36
 * 权限测试页面
 */

namespace app\admin\controller;



class Test extends BaseController
{
    public function test1()
    {
        if($this->checkUser()){
            echo "有权访问";
        }else{
            echo "无权访问";
        }
    }
    public function test2()
    {
        if($this->checkUser()){
            echo "有权访问";
        }else{
            echo "无权访问";
        }
    }

    public function test3()
    {
        if($this->checkUser()){
            echo "有权访问";
        }else{
            echo "无权访问";
        }
    }

    public function test4()
    {
        if($this->checkUser()){
            echo "有权访问";
        }else{
            echo "无权访问";
        }
    }

}
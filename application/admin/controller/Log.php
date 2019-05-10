<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2018/12/23
 * Time: 20:49
 */

namespace app\admin\controller;


use app\admin\model\AppAccessLog;
use think\Db;

class Log extends BaseController
{
    public function LogList()
    {
        if(!$this->checkUser()){
            return "无此权限，请联系管理员提升权限";
        }
        $LogList=AppAccessLog::paginate(10);
        $page = $LogList->render();
        $this->assign('page',$page);
        $this->assign('list',$LogList);
        return $this->fetch('index');
    }
}
<?php
namespace app\admin\model;
use think\Db;
use think\Model;

/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2018/11/4
 * Time: 19:45
 */

class Admin extends Model
{
    public static function AdminList()
    {
        $data=Db::table('admin')->order('created_time','desc')->select();
        return $data;
    }
}
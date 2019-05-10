<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2018/11/5
 * Time: 20:15
 */

namespace app\admin\model;


use think\Db;
use think\Model;

class Role extends Model
{
    public static function RoleList()
    {
        $data =Db::table('role')->select();
        return $data;
    }

}
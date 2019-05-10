<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2018/12/17
 * Time: 20:06
 */

namespace app\admin\model;

use think\Model;
use think\Db;

class AppAccessLog extends Model
{
    public static function LogList()
    {
        $data=Db::table('app_access_log')->select();
        return $data;
    }
}
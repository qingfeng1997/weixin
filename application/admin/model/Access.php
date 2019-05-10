<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2018/11/8
 * Time: 17:55
 */

namespace app\admin\model;


use think\Db;
use think\Model;

class Access extends Model
{
    public static function AccessList()
    {
        $data=Db::table('access')->where(['status'=>1])->order('id','desc')->select();
        return $data;
    }

}
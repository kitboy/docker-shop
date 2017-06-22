<?php

/**
 *    license控制器
 *
 *    @author    Hyber
 *    @usage    none
 */
class LicenseApp extends BackendApp
{
    var $LICENSE_VERSION='1.0';
    function __construct()
    {
        $this->LicenseApp();
    }

    function LicenseApp()
    {
        parent::BackendApp();

    }

    function license()
    {
        $license=$this->license_check();        
       if($license['request']['res']=='succ' && !empty($license['request']['info']['certificate_id']) && $license['request']['info']['service']['ecmall']['cert_auth']['auth_type']=='U')
       {
       	    $confirmkey=$this->licenseEncode(SESS_ID , $license['request']['info']['certificate_id']);
        	$lic='<a href="http://service.shopex.cn/info.php?certi_id='.$license['request']['info']['certificate_id'].'&version=ecmall&sess_id='.SESS_ID.'&confirmkey='.$confirmkey.'&_key_=do" target="_blank"><img src="templates/style/images/oem.gif" /></a>';
       }
       else
       {
         	$lic='<a href="http://ecmall.shopex.cn" target="_blank"><img src="templates/style/images/free.gif"  /></a>';      	   
       }
        die(ecm_json_encode($lic));
    }
    
    function l_list()
    {
        $model_setting = &af('settings');
        $setting = $model_setting->getAll(); //载入系统设置数据 	
        $this->assign('license_number',$setting['certificate_id'] );  
        $license=$this->license_check();  
              
       if($license['request']['res']=='succ' && !empty($license['request']['info']['certificate_id']) && $license['request']['info']['service']['ecmall']['cert_auth']['auth_type']=='U')
       {
           $this->assign('is_license',1 );         	
       }
       else
       {
           $this->assign('is_license',0 );       	   
       }         	
    	$this->display('license.html');
    }
    function l_det()
    {
        $model_setting = &af('settings');
        $setting = $model_setting->getAll(); //载入系统设置数据
        $primitive_license=array();
        $primitive_license['certificate_id']=$setting['certificate_id'];
        $primitive_license['token']=$setting['token']; 
        $new_license=array();
        $new_license['certificate_id']=0;
        $new_license['token']=0;
        $model_setting->setAll($new_license);
        $license=$this->license_check();        
       if($license['request']['res']=='succ')
       {	   
            $this->show_message('delete_successed');
       }
       else
       {
       	    $model_setting->setAll($primitive_license);      
            $this->show_message('delete_fai');    	   
       }       
        	                    	
    }
    	

function license_check()
{
    // return 返回数组
    $return_array = array();

    // 取出网店 license
    $license = $this->get_shop_license();

    // 检测网店 license
    if (!empty($license['certificate_id']) && !empty($license['token']) && !empty($license['certi']))
    {

        // license（登录）
        $return_array = $this->license_login();
        //var_dump($return_array);
    }
    else
    {
        // license（注册）
       $return_array = $this->license_reg();
       if($return_array['res']='succ')
       {
            $return_array = $this->license_login();       	
       }
    }
 

//
    return $return_array;

}


function license_login($certi_added = '')
{
    // 登录信息配置
    $certi['certi_app'] = ''; // 证书方法
    $certi['app_id'] = 'ecmall'; // 说明客户端来源
    $certi['app_instance_id'] = ''; // 应用服务ID
    $certi['version'] = $this->LICENSE_VERSION; // license接口版本号
    $certi['shop_version'] = RELEASE; // 网店软件版本号
    $certi['certi_url'] = sprintf(SITE_URL.'/'); // 网店URL
    $certi['certi_session'] = SESS_ID; // 网店SESSION标识
    $certi['certi_validate_url'] = sprintf(SITE_URL . '/index.php?act=license'); // 网店提供于官方反查接口
    $certi['format'] = 'json'; // 官方返回数据格式
    $certi['certificate_id'] = ''; // 网店证书ID
    // 标识
    $certi_back['succ']   = 'succ';
    $certi_back['fail']   = 'fail';
    // return 返回数组
    $return_array = array();


    if (is_array($certi_added))
    {
        foreach ($certi_added as $key => $value)
        {
            $certi[$key] = $value;
        }
    }
    // 取出网店 license
    $license = $this->get_shop_license();
    // 检测网店 license
    if (!empty($license['certificate_id']) && !empty($license['token']) && !empty($license['certi']))
    {
        // 登录
        $certi['certi_app'] = 'certi.login'; // 证书方法
        $certi['app_instance_id'] = 'cert_auth'; // 应用服务ID
        $certi['certificate_id'] = $license['certificate_id']; // 网店证书ID
        $certi['certi_ac'] = $this->make_shopex_ac($certi, $license['token']); // 网店验证字符串
        $this->certi_ac=$certi['certi_ac'];
        	
        $request_arr = $this->exchange_shop_license($certi, $license);
        if (is_array($request_arr) && $request_arr['res'] == $certi_back['succ'])
        {
            $return_array['flag'] = 'login_succ';
            $return_array['request'] = $request_arr;
        }
        elseif (is_array($request_arr) && $request_arr['res'] == $certi_back['fail'])
        {
            $return_array['flag'] = 'login_fail';
            $return_array['request'] = $request_arr;
        }
        else
        {
            $return_array['flag'] = 'login_ping_fail';
            $return_array['request'] = array('res' => 'fail');
        }
    }
    else
    {
        $return_array['flag'] = 'login_param_fail';
        $return_array['request'] = array('res' => 'fail');
    }

    return $return_array;
}	
	

function get_shop_license()
{
    $model_setting = &af('settings');
    $setting = $model_setting->getAll(); //载入系统设置数据
    $license=array();
    $license['certi']='http://service.shopex.cn/openapi/api.php';
    if(!empty($setting['certificate_id'])&&!empty($setting['token']))
    {
        $license['certificate_id']=$setting['certificate_id'];
        $license['token']=$setting['token'];
    }
    else
    {
        $license['certificate_id']='';
        $license['token']='';
    }
    return $license;

}
function license_reg()
{
    $certi['certi_app'] = ''; // 证书方法
    $certi['app_id'] = 'ecmall'; // 说明客户端来源
    $certi['app_instance_id'] = ''; // 应用服务ID
    $certi['version'] = $this->LICENSE_VERSION; // license接口版本号
    $certi['shop_version'] = RELEASE; // 网店软件版本号
    $certi['certi_url'] = sprintf(SITE_URL.'/'); // 网店URL
    $certi['certi_session'] = SESS_ID; // 网店SESSION标识
    $certi['certi_validate_url'] = sprintf(SITE_URL . '/index.php?act=license'); // 网店提供于官方反查接口
    $certi['format'] = 'json'; // 官方返回数据格式
    $certi['certificate_id'] = ''; // 网店证书ID
    // 标识
    $certi_back['succ']   = 'succ';
    $certi_back['fail']   = 'fail';
    // return 返回数组
    $return_array = array();

    // 取出网店 license
    $license = $this->get_shop_license();

    // 注册
    $data=array();
    $certi['certi_app'] = 'certi.reg'; // 证书方法
    $certi['certi_ac'] = $this->make_shopex_ac($certi, ''); // 网店验证字符串
    unset($certi['certificate_id']);
    $request_arr = $this->exchange_shop_license($certi, $license);
    if($request_arr['res']=='succ')
    {
    	 $data['certificate_id']=$request_arr['info']['certificate_id'];
    	 $data['token']=$request_arr['info']['token'];    	 
     	 $model_setting = &af('settings');
         $model_setting->setAll($data);	
    }
    return ($request_arr['res']);
}


function exchange_shop_license($certi, $license)
{
    if (!is_array($certi))
    {
        return array();
    }

    $params = '';
    foreach ($certi as $key => $value)
    {
        $params .= '&' . $key . '=' . $value;
    }
    $params = trim($params, '&');
     $request = ecm_fopen($license['certi'],6000, $params);
     $request=ecm_json_decode($request,1);
     return($request);
}


function make_shopex_ac($post_params, $token)
{
    if (!is_array($post_params))
    {
        return;
    }

    // core
    ksort($post_params);
    $str = '';
    foreach($post_params as $key=>$value){
        if($key != 'certi_ac')
        {
            $str .= $value;
        }
    }

    return md5($str . $token);
}

function licenseEncode($sess_id , $cert_id)
{
    $confirmkey = md5($sess_id.'ShopEx@License'.$cert_id);
    return $confirmkey;
}


}

?>
<?php

/**
 *
 *
 *    @author    Garbin
 *    @usage    none
 */
class DefaultApp extends BaseUpgraderApp
{
    var $source_version = '2.2.1';
    
    function _run_sql($sqls)
    {
        if (is_string($sqls))
        {
            $sqls = get_sql($sqls);
        }
        if (!is_array($sqls))
        {
            return true;
        }
        // 检查可能在某次补丁中已经添加过的字段
        // 检查哪些字段
        $check_fields = array(
            'ecm_order' => array('pay_alter'),
            'ecm_store' => array('enable_radar','enable_groupbuy')
        );
        
        // 哪些在数据库中已经存在
        $exist_fields = array();
        
        foreach ($check_fields as $table => $fields)
        {
            $result = $this->db->query("SELECT * FROM `{$table}` limit 1");
            $i = 0;
            while($i<mysql_num_fields($result))       //循环读取结果数
            {
                $meta = mysql_fetch_field($result);
                if (in_array($meta->name, $fields))
                {
                    $exist_fields[$table][] = $meta->name;
                }
                $i++;
            }
        }
        

        foreach ($sqls as $sql)
        {
            $need_exec = true;
            foreach ($exist_fields as $table => $fields)
            {
                foreach ($fields as $field)
                {
                    $pattern = "/alter\s+table\s+`?{$table}`?\s+add\s+`?{$field}`?\s+/Uis";
                    if (preg_match($pattern, $sql))
                    {// 该sql语句不需要执行
                        $need_exec = false;
                        break;
                    }
                }
            }
            if ($need_exec)
            {
                (substr($sql, 0, 12) == 'CREATE TABLE') && $sql = create_table($sql);
                $query = $this->db->query($sql, 'SILENT');
                if (!$query)
                {
                    $this->_error($this->db->error());
                    return false;
                }
            }
                
        }
        return true;
    }
}

?>
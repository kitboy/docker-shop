-- ���Ӷ����༭Ȩ�޺Ͳ鿴����ɶ���Ȩ��
INSERT INTO `ecs_admin_action` ( `action_id` , `parent_id` , `action_code` )
VALUES (
NULL , '6', 'order_edit'
), (
NULL , '6', 'order_view_finished'
);

-- �û����Ļ�ӭҳ�湫��
INSERT INTO `ecs_shop_config` ( `id` , `parent_id` , `code` , `type` , `store_range` , `store_dir` , `value` )
VALUES (
'120', '1', 'user_notice', 'textarea', '', '', '�û����Ĺ��棡'
);

-- �һ�������ʼ�ģ��
UPDATE `ecs_mail_templates` SET `template_content` = '{$user_name}���ã� \n���Ѿ��������һ�����Ĳ�����������������(���߸��Ƶ����������):\n{$reset_email} \n��ȷ���������������ò����� \n{$shop_name}\n{$send_date} ' WHERE `ecs_mail_templates`.`template_id` =1 LIMIT 1 ;

-- �̵����������Ƿ���ʾ�г��۸��ѡ��
INSERT INTO `ecs_shop_config` ( `id` , `parent_id` , `code` , `type` , `store_range` , `store_dir` , `value` )
VALUES (
'707', '7', 'show_marketprice', 'select', '1,0', '', '1'
);

-- ����2��Ȩ��
INSERT INTO `ecs_admin_action` ( `action_id` , `parent_id` , `action_code` )
VALUES (
NULL , '1', 'tag_manage'
);

INSERT INTO `ecs_admin_action` ( `action_id` , `parent_id` , `action_code` )
VALUES (
NULL , '3', 'surplus_manage'
);

-- �Ź���Ʒ�ʼ�ģ��
UPDATE `ecs_mail_templates` SET `is_html` = '0', `template_content` = '�װ���{$consignee}�����ã�\n����{$order_time}�ڱ���μ��Ź���Ʒ������������Ʒ����Ϊ��{$goods_name}��������{$goods_number}��������Ϊ��{$order_sn}���������Ϊ��{$order_amount} \n���Ź���Ʒ�����ѵ��������ڣ����ﵽ��ͼ۸������ڿ��ԶԸö������������������ӣ�\n{$shop_url} �뾡���¼���û����ģ��鿴���Ķ���������Ϣ��\n\n{$shop_name} \n{$send_date}' WHERE `ecs_mail_templates`.`template_id` =7 LIMIT 1 ;
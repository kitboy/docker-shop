-- ��������ʼ�ģ������
INSERT INTO `ecs_mail_templates` (`template_id`, `template_code`, `is_html`, `template_subject`, `template_content`, `last_modify`, `last_send`, `type`) VALUES
('', 'goods_booking', 1, 'ȱ���ظ�', '�װ���{$user_name}����ã�</br></br>���ύ��ȱ����ƷΪ</br></br><a href="{$goods_link}" target="_blank">{$goods_name}</a></br><br>��Ҹ����Ļظ���</br>{$dispose_note}</br></br>{$shop_name} </br>{$send_date}', 0, 0, 'template'),
('', 'user_message', 1, '���Իظ�', '�װ���{$user_name}����ã�</br></br>���������ԣ�</br>{$message_content}</br></br>�����������»ظ���</br>{$message_note}</br></br>��������ʱ�ص����к͵���������ͨ��</br>{$shop_name}</br>{$send_date}', 0, 0, 'template'),
('', 'recomment', 1, '�û����ۻظ�', '�װ���{$user_name}����ã�</br></br>���������ۣ�</br>��{$comment}��</br></br>�����������»ظ���</br>��{$recomment}��</br></br>��������ʱ�ص����к͵���������ͨ��</br>{$shop_name}</br>{$send_date}', 0, 0, 'template');

-- ��ӵ���ѡ�������ֵ
ALTER TABLE `ecs_vote_option` ADD `option_order` TINYINT UNSIGNED NOT NULL DEFAULT '100';

-- ���Ȩ�޹���
UPDATE `ecs_admin_action` SET `relevance` = 'cat_manage' WHERE `action_id` = '24';
UPDATE `ecs_admin_action` SET `relevance` = 'integrate_users' WHERE `action_id` = '39';
UPDATE `ecs_admin_action` SET `relevance` = 'users_manage' WHERE `action_id` = '41';
UPDATE `ecs_admin_action` SET `relevance` = 'account_manage' WHERE `action_id` = '85';
UPDATE `ecs_admin_action` SET `relevance` = 'admin_manage' WHERE `action_id` = '44';
UPDATE `ecs_admin_action` SET `relevance` = 'admin_manage' WHERE `action_id` = '45';
UPDATE `ecs_admin_action` SET `relevance` = 'logs_manage' WHERE `action_id` = '47';
UPDATE `ecs_admin_action` SET `relevance` = 'order_os_edit' WHERE `action_id` = '54';
UPDATE `ecs_admin_action` SET `relevance` = 'order_os_edit' WHERE `action_id` = '55';
UPDATE `ecs_admin_action` SET `relevance` = 'order_os_edit' WHERE `action_id` = '56';
UPDATE `ecs_admin_action` SET `relevance` = 'db_backup' WHERE `action_id` = '77';

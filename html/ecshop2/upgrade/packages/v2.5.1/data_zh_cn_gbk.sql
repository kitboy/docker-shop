INSERT INTO `ecs_admin_action` (`action_id`, `parent_id`, `action_code`) VALUES (8, 0, 'email');
REPLACE INTO `ecs_admin_action` (`action_id`, `parent_id`, `action_code`) VALUES (NULL, 5, 'navigator');
-- ��������Ȩ��
INSERT INTO `ecs_admin_action` (`action_id`, `parent_id`, `action_code`) VALUES (NULL, 7, 'auction');
-- �����Ź�Ȩ��
INSERT INTO `ecs_admin_action` (`action_id`, `parent_id`, `action_code`) VALUES (NULL, 7, 'group_by');
-- ��������Ȩ��
INSERT INTO `ecs_admin_action` (`action_id`, `parent_id`, `action_code`) VALUES (NULL, 7, 'favourable');
-- ��������Ȩ��
INSERT INTO `ecs_admin_action` (`action_id`, `parent_id`, `action_code`) VALUES (NULL, 7, 'whole_sale');
-- ��������Ȩ��
INSERT INTO `ecs_admin_action` (`action_id`, `parent_id`, `action_code`) VALUES (NULL, 1, 'goods_auto');
-- �����Ź�Ȩ��
INSERT INTO `ecs_admin_action` (`action_id`, `parent_id`, `action_code`) VALUES (NULL, 2, 'article_auto');
-- ���Ӽƻ�����Ȩ��
INSERT INTO `ecs_admin_action` (`action_id`, `parent_id`, `action_code`) VALUES (NULL, 5, 'cron');
-- �����Ƽ�����Ȩ��
INSERT INTO `ecs_admin_action` (`action_id`, `parent_id`, `action_code`) VALUES (NULL, 5, 'affiliate');
-- ���ӷֳɹ���Ȩ��
INSERT INTO `ecs_admin_action` (`action_id`, `parent_id`, `action_code`) VALUES (NULL, 5, 'affiliate_ck');
-- ���ӹ�ע����Ȩ��
INSERT INTO `ecs_admin_action` (`action_id`, `parent_id`, `action_code`) VALUES (NULL, 8, 'attention_list');
-- �����ʼ����Ĺ���Ȩ��
INSERT INTO `ecs_admin_action` (`action_id`, `parent_id`, `action_code`) VALUES (NULL, 8, 'email_list');
-- ������־����Ȩ��
INSERT INTO `ecs_admin_action` (`action_id`, `parent_id`, `action_code`) VALUES (NULL, 8, 'magazine_list');
-- �����ʼ����й���Ȩ��
INSERT INTO `ecs_admin_action` (`action_id`, `parent_id`, `action_code`) VALUES (NULL, 8, 'view_sendlist');
INSERT INTO `ecs_admin_action` (`action_id`, `parent_id`, `action_code`) VALUES (NULL, 1, 'virualcard');
-- ��ר�����ŵ�����������Ŀ��
UPDATE `ecs_admin_action` SET `parent_id` = 7 WHERE `action_code` = 'topic_manage';
-- ��shop_config����ϴ�������С����һ��ѡ��
UPDATE `ecs_shop_config` SET `store_range` = 'default,0,64,128,256,512,1024,2048,4096' WHERE `code` = 'upload_size_limit';
REPLACE INTO `ecs_mail_templates` (`template_id`, `template_code`, `is_html`, `template_subject`, `template_content`, `last_modify`, `type`) VALUES (NULL, 'remind_of_new_order', 0, '�¶���֪ͨ', '�װ��ĵ곤�����ã�\n   ���������ɣ������¶����ˡ��������Ϊ{$order.order_amount}���ջ�����{$order.consignee}����ַ��{$order.address}���绰��{$order.tel} {$order.mobile}��\n\n               ϵͳ����\n               {$send_date}', 0, 'template');

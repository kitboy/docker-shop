-- ���Ӱ��´������Ȩ��
INSERT INTO `ecs_admin_action` (`action_id`, `parent_id`, `action_code`) VALUES (NULL, 4, 'agency_manage');
-- ���ר������Ȩ��
INSERT INTO `ecs_admin_action` (`action_id`, `parent_id`, `action_code`) VALUES (NULL, 2, 'topic_manage');

INSERT INTO `ecs_shop_config` ( `id` , `parent_id` , `code` , `type` , `store_range` , `store_dir` , `value`, `sort_order` )
VALUES (
'223', '2', 'timezone', 'options', '-12,-11,-10,-9,-8,-7,-6,-5,-4,-3.5,-3,-2,-1,0,1,2,3,3.5,4,4.5,5,5.5,5.75,6,6.5,7,8,9,9.5,10,11,12', '', '8', 1
),
(121, 1, 'shop_notice', 'textarea', '', '', '�̵깫��', '1'),
(224, 2, 'upload_size_limit', 'options', '0,64,128,256,512,1024,2048,4096', '', '0', '1'),
(226, 2, 'cron_method', 'select', '0,1', '', '0', 1),
(227, 2, 'comment_factor', 'select', '0,1,2,3', '', '0', '1'),
(228, 2, 'enable_order_check', 'select', '0,1', '', '0', '1'),
(229, 2, 'default_storage', 'text', '', '', '1', '1'),
(326, 3, 'name_of_region_1', 'text', '', '', '����', '1'),
(327, 3, 'name_of_region_2', 'text', '', '', 'ʡ', '1'),
(328, 3, 'name_of_region_3', 'text', '', '', '��', '1'),
(329, 3, 'name_of_region_4', 'text', '', '', '��', '1'),
(330, 3, 'search_keywords', 'text', '', '', '', 0),
(332, 3, 'related_goods_number', 'text', '', '', '4', '1'),
(420, 4, 'min_goods_amount', 'text', '', '', '0', '1'),
(421, 4, 'one_step_buy', 'select', '1,0', '', '0', '1'),
(422, 4, 'invoice_type', 'manual', '', '', '', '1'),
(423, 4, 'stock_dec_time', 'select', '1,0', '', '0', '1'),
(424, 4, 'cart_confirm', 'options', '1,2,3,4', '', '3', '0'),
(507, 5, 'mail_service', 'select', '0,1', '', '0', 0),
(616, 6, 'affiliate', 'hidden', '', '', 'a:3:{s:6:"config";a:7:{s:6:"expire";d:24;s:11:"expire_unit";s:4:"hour";s:11:"separate_by";i:0;s:15:"level_point_all";s:2:"5%";s:15:"level_money_all";s:2:"1%";s:18:"level_register_all";i:2;s:17:"level_register_up";i:60;}s:4:"item";a:4:{i:0;a:2:{s:11:"level_point";s:3:"60%";s:11:"level_money";s:3:"60%";}i:1;a:2:{s:11:"level_point";s:3:"30%";s:11:"level_money";s:3:"30%";}i:2;a:2:{s:11:"level_point";s:2:"7%";s:11:"level_money";s:2:"7%";}i:3;a:2:{s:11:"level_point";s:2:"3%";s:11:"level_money";s:2:"3%";}}s:2:"on";i:0;}', 1),
(617, 6, 'captcha', 'hidden', '', '', '0', 1),
(618, 6, 'captcha_width', 'hidden', '', '', '100', 1),
(619, 6, 'captcha_height', 'hidden', '', '', '20', 1),
(9, 0, 'wap', 'group', '', '', '', 1),
(901, 9, 'wap_config', 'select', '1,0', '', '0', 1),
(902, 9, 'wap_logo', 'file', '', '../images/', '', 1),
( 231, 2, 'visit_stats', 'select', 'on,off', '', 'on', '1' );

-- ���ӵ��ڻ�Ա�ʻ���Ȩ��
INSERT INTO `ecs_admin_action` (`action_id`, `parent_id`, `action_code`) VALUES (NULL, 3, 'account_manage');
INSERT INTO `ecs_admin_action` (`action_id`, `parent_id`, `action_code`) VALUES (NULL, 5, 'flash_manage');

-- �����޼�����
INSERT INTO `ecs_article_cat` (`cat_id`, `cat_name`, `cat_type`, `keywords`, `cat_desc`, `sort_order`, `parent_id`) VALUES (NULL, 'ϵͳ����', 2, '', 'ϵͳ��������', 0, 0);
INSERT INTO `ecs_article_cat` (`cat_id`, `cat_name`, `cat_type`, `keywords`, `cat_desc`, `sort_order`, `parent_id`) VALUES (NULL, '������Ϣ', 3, '', '������Ϣ����', 0, 0);
INSERT INTO `ecs_article_cat` (`cat_id`, `cat_name`, `cat_type`, `keywords`, `cat_desc`, `sort_order`, `parent_id`) VALUES (NULL, '�����������', 4, '', '�����������', 0, 0);

-- �̵������У�����ĳЩ����
UPDATE `ecs_shop_config` SET `parent_id` = 6 WHERE `code` IN ('group_goods_number', 'best_number', 'new_number', 'hot_number', 'promote_number');

-- �ʼ���֤
DELETE FROM `ecs_mail_templates`  WHERE template_code = 'virtual_card';
INSERT INTO `ecs_mail_templates` (`template_id`, `template_code`, `is_html`, `template_subject`, `template_content`, `last_modify`, `type`) VALUES
(NULL, 'register_validate', 1, '�ʼ���֤', '{$user_name}���ã�<br><br>\r\n\r\n����ʼ��� {$shop_name} ���͵ġ����յ�����ʼ���Ϊ����֤��ע���ʼ���ַ�Ƿ���Ч��������Ѿ�ͨ����֤�ˣ����������ʼ���<br>\r\n������������(���߸��Ƶ����������)����֤����ʼ���ַ:<br>\r\n<a href="{$validate_email}" target="_blank">{$validate_email}</a><br><br>\r\n\r\n{$shop_name}<br>\r\n{$send_date}', 0, 'template');
INSERT INTO `ecs_mail_templates` (`template_id`, `template_code`, `is_html`, `template_subject`, `template_content`, `last_modify`, `type`) VALUES
(NULL, 'virtual_card', 0, '���⿨Ƭ', '�װ���{$order.consignee}\r\n��ã����Ķ���{$order.order_sn}��{$goods.goods_name} ��Ʒ����ϸ��Ϣ����:\r\n{foreach from=$virtual_card item=card}\r\n{if $card.card_sn}���ţ�{$card.card_sn}{/if}{if $card.card_password}��Ƭ���룺{$card.card_password}{/if}{if $card.end_date}�������ڣ�{$card.end_date}{/if}\r\n{/foreach}\r\n�ٴθ�л�������ǵ�֧�֡���ӭ�����ٴι��١�\r\n\r\n{$shop_name}\r\n{$send_date}', 0, 'template');
INSERT INTO `ecs_mail_templates` (`template_id`, `template_code`, `is_html`, `template_subject`, `template_content`, `last_modify`, `type`) VALUES
(NULL, 'remind_of_new_order', 0, '�¶���֪ͨ', '�װ��ĵ곤�����ã�\n   ���������ɣ������¶����ˡ��������Ϊ{$order.order_amount}���ջ�����{$order.consignee}����ַ��{$order.address}���绰��{$order.tel} {$order.mobile}��\n\n               ϵͳ����\n               {$send_date}', 0, 'template');

UPDATE `ecs_mail_templates` SET template_content = '�װ���{$order.consignee}����ã�\r\n\r\n���Ķ���{$order.order_sn}����{$send_time}������Ԥ�������ͷ�ʽ���������ˡ�\r\n\r\n{if $order.invoice_no}����������{$order.invoice_no}��{/if}\r\n\r\n�����յ�����֮���������������ȷ�����Ѿ��յ����\r\n{$confirm_url}\r\n�������û���յ�������Ե���������Ӹ��������ԣ�\r\n{$send_msg_url}\r\n\r\n�ٴθ�л�������ǵ�֧�֡���ӭ�����ٴι��١� \r\n\r\n{$shop_name}\r\n{$send_date}' WHERE template_code = 'deliver_notice';

-- ����֧�����
UPDATE `ecs_payment` SET is_online = 1 WHERE pay_code IN ('alipay','cappay','ctopay','ips','kuaiqian','nps','pay800','paypal','paypalcn','tenpay','udpay','xpay','yeepay','dodolink');

-- ����ͼ����ɫ
INSERT INTO `ecs_shop_config` (`id` ,`parent_id` ,`code` ,`type` ,`store_range` ,`store_dir` ,`value` ,`sort_order`)
VALUES ('230', '2', 'bgcolor', 'text', '', '', '#FFFFFF', '0');

-- �Զ��嵼����
INSERT INTO `ecs_nav` (`id`, `name`, `ifshow`, `vieworder`, `opennew`, `url`, `type`) VALUES
(1, '�û�����', 1, 1, 0, 'user.php', 'top'),
(2, 'ѡ������', 1, 2, 0, 'pick_out.php', 'top'),
(3, '�鿴���ﳵ', 1, 0, 0, 'flow.php', 'top'),
(4, '�Ź���Ʒ', 1, 3, 0, 'group_buy.php', 'top'),
(5, '�ᱦ���', 1, 4, 0, 'snatch.php', 'top'),
(6, '��ǩ��', 1, 5, 6, 'tag_cloud.php', 'top'),

(7, '��������', 1, 1, 0, 'article.php?id=1', 'bottom'),
(8, '��˽����', 1, 2, 0, 'article.php?id=2', 'bottom'),
(9, '��ѯ�ȵ�', 1, 3, 0, 'article.php?id=3', 'bottom'),
(10, '��ϵ����', 1, 4, 0, 'article.php?id=4', 'bottom'),
(11, '��˾���', 1, 5, 0, 'article.php?id=5', 'bottom'),
(12, '����', 1, 6, 0, 'wholesale.php', 'bottom'),

(13, '�Żݻ', 1, 7, 0, 'activity.php', 'top');

INSERT INTO `ecs_shop_config` VALUES (622, 6, 'sitemap', 'hidden', '', '', 'a:6:{s:19:"homepage_changefreq";s:6:"hourly";s:17:"homepage_priority";s:3:"0.9";s:19:"category_changefreq";s:6:"hourly";s:17:"category_priority";s:3:"0.8";s:18:"content_changefreq";s:6:"weekly";s:16:"content_priority";s:3:"0.7";}', 0);


-- ��Ʒ��ע
DELETE FROM `ecs_mail_templates`  WHERE template_code = 'attention_list';
INSERT INTO `ecs_mail_templates` (`template_code`, `is_html`, `template_subject`, `template_content`, `last_modify`, `type`) VALUES
('attention_list', 0, '��ע��Ʒ', '�װ���{$user_name}����~\n\n����ע����Ʒ : {$goods_name} ����Ѿ�����,�����鿴���µ���Ʒ��Ϣ\n\n{$goods_url}', 1183851073, 'template');

INSERT INTO `ecs_article` (`article_id`, `cat_id`, `title`, `content`, `author`, `author_email`, `keywords`, `article_type`, `is_open`, `add_time`, `file_url`, `open_type`) VALUES
(null, -1, '�û�Э��', '', '', '', '', 0, 1, 0, '', 0);

-- UPDATE `ecs_shop_config` SET value = '20' WHERE id='212';
UPDATE `ecs_shop_config` SET value = '30' WHERE id='325';
-- UPDATE `ecs_shop_config` SET value = '0' WHERE id='402';
DELETE FROM `ecs_shop_config` WHERE id in (308 , 309 , 310 , 311 , 322);

INSERT INTO `ecs_article` (`cat_id`, `title`, `content`, `author`, `author_email`, `keywords`, `article_type`, `is_open`, `add_time`, `file_url`, `open_type`) VALUES
(-1, '�û�Э��', '', '', '', '', 0, 1, 0, '', 0);

-- ���ֹ�������
REPLACE INTO `ecs_shop_config` (`id`, `parent_id`, `code`, `type`, `store_range`, `store_dir`, `value`, `sort_order`) VALUES(621, 6, 'points_rule', 'hidden', '', '', '', '');

-- ����ȷ���ʼ�ģ��ĸ�����
UPDATE `ecs_mail_templates` SET template_content = REPLACE( template_content, '{$order.order_time}', '{$order.formated_add_time}' ) WHERE template_code = 'order_confirm';

-- ���ӹ�������Ȩ��
INSERT INTO `ecs_admin_action` (`action_id`, `parent_id`, `action_code`) VALUES (NULL, 5, 'navigator');
-- �Զ���ע�����ṹ�޸�
ALTER TABLE `ecs_reg_fields` ADD `dis_order` TINYINT UNSIGNED NOT NULL DEFAULT '100', ADD `display` TINYINT( 1 ) UNSIGNED NOT NULL DEFAULT '1',
ADD `type` TINYINT( 1 ) UNSIGNED NOT NULL DEFAULT '0', ADD `is_need` TINYINT( 1 ) UNSIGNED NOT NULL DEFAULT '1';

-- ��Ʒ��ecs_goods�޸�
ALTER TABLE `ecs_goods` CHANGE `suppliers_id` `suppliers_id` SMALLINT( 5 ) UNSIGNED DEFAULT NULL ,
CHANGE `is_check` `is_check` TINYINT( 1 ) UNSIGNED DEFAULT NULL;

ALTER TABLE `ecs_goods` ADD `is_shipping` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0';

-- ���������� order_action
ALTER TABLE `ecs_order_action` ADD `action_place` TINYINT( 1 ) UNSIGNED NOT NULL default '0' AFTER `pay_status`;

-- �����̱�ecs_suppliers�޸�
ALTER TABLE `ecs_suppliers` CHANGE `is_check` `is_check` TINYINT( 1 ) UNSIGNED DEFAULT '1';

-- ���ﳵ��`ecs_cart`�޸�
ALTER TABLE `ecs_cart` ADD `is_shipping` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0';

--������ɫ�����
DROP TABLE IF EXISTS `ecs_role`;
CREATE TABLE `ecs_role` (
  `role_id` smallint(5) unsigned NOT NULL auto_increment,
  `role_name` varchar(60) NOT NULL default '',
  `action_list` text NOT NULL,
  `role_describe` text,
  PRIMARY KEY  (`role_id`),
  KEY `user_name` (`role_name`)
) ENGINE=MyISAM;

--����Ա���޸�
ALTER TABLE `ecs_admin_user` ADD `role_id` smallint(5);

--ר����޸�
ALTER TABLE `ecs_topic` ADD COLUMN `topic_img` varchar(255) NULL DEFAULT NULL AFTER `css`,
                        ADD COLUMN `title_pic` varchar(255) NULL DEFAULT NULL AFTER `topic_img`,
                        ADD COLUMN `base_style` char(6) NULL DEFAULT NULL AFTER `title_pic`,
                        ADD COLUMN `htmls` mediumtext NULL DEFAULT NULL AFTER `base_style`,
                        ADD COLUMN `keywords` varchar(255) NULL DEFAULT NULL AFTER `htmls`,
                        ADD COLUMN `description` varchar(255) NULL DEFAULT NULL AFTER `keywords`;

-- �޸Ļ�Ա��user��������������ֶ�
ALTER TABLE `ecs_users` ADD `passwd_question` VARCHAR( 50 ) NULL ,
ADD `passwd_answer` VARCHAR( 255 ) NULL ;


--���ű��޸�
ALTER TABLE `ecs_article` ADD COLUMN `description` varchar(255) NULL DEFAULT NULL AFTER `link`;

--�޸�Ĭ�������ֶ�ֵ��ʹ��ֵ����100
ALTER TABLE `ecs_goods` CHANGE `sort_order` `sort_order` smallint(4) unsigned NOT NULL default '100';
ALTER TABLE `ecs_category` CHANGE `sort_order` `sort_order` tinyint(1) unsigned NOT NULL default '50';
ALTER TABLE `ecs_brand` CHANGE `sort_order` `sort_order` tinyint(3) unsigned NOT NULL default '50';
ALTER TABLE `ecs_favourable_activity` CHANGE `sort_order` `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '50';
ALTER TABLE `ecs_article_cat` CHANGE `sort_order` `sort_order` tinyint(3) unsigned NOT NULL default '50';
ALTER TABLE `ecs_friend_link` CHANGE `show_order` `show_order` tinyint(3) unsigned NOT NULL default '50';


ALTER TABLE `ecs_back_goods` ADD `goods_attr` text;
ALTER TABLE `ecs_delivery_goods` ADD `goods_attr` text;
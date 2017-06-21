-- �޸� sessions ��
DROP TABLE IF EXISTS `ecs_sessions`;
CREATE TABLE `ecs_sessions` (
  `sesskey` char(32) binary NOT NULL default '',
  `expiry` int(10) unsigned NOT NULL default '0',
  `userid` mediumint(8) unsigned NOT NULL default '0',
  `adminid` mediumint(8) unsigned NOT NULL default '0',
  `ip` char(15) NOT NULL default '',
  `user_name` varchar(60) NOT NULL,
  `user_rank` tinyint(3) NOT NULL,
  `discount` decimal(3,2) NOT NULL,
  `email` varchar(60) NOT NULL,
  `data` char(255) NOT NULL default '',
  PRIMARY KEY  (`sesskey`),
  KEY `expiry` (`expiry`)
) ENGINE=MEMORY ;

-- ��Ʒ��������� show_in_index �ֶ�
ALTER TABLE `ecs_category` ADD `show_in_index` TINYINT( 1 ) NOT NULL DEFAULT '0' AFTER `show_in_nav` ;

-- ���Ա����� msg_area ���������ֶ�
ALTER TABLE `ecs_feedback` ADD `msg_area` TINYINT( 1 ) UNSIGNED NOT NULL DEFAULT '0';

-- ���ӷ�����ҳ�Ƽ���
DROP TABLE IF EXISTS `ecs_cat_recommend`;
CREATE TABLE `ecs_cat_recommend` (
  `cat_id` smallint(5) NOT NULL,
  `recommend_type` tinyint(1) NOT NULL,
  PRIMARY KEY  (`cat_id`,`recommend_type`)
) TYPE=MyISAM;

-- ���Ӻ�̨�趨���صȼ���������
ALTER TABLE `ecs_goods` ADD `rank_integral` INT( 8 ) NOT NULL DEFAULT '-1';

-- ���ӿ�ݵ���ӡģ��
ALTER TABLE `ecs_shipping` ADD `shipping_print` TEXT NOT NULL;
-- �޸� cart ��
ALTER TABLE `ecs_cart` CHANGE `goods_attr_id` `goods_attr_id` VARCHAR( 60 ) NOT NULL DEFAULT '';

-- ������Ʒ���������Żݼ۸��
DROP TABLE IF EXISTS `ecs_volume_price`;
CREATE TABLE IF NOT EXISTS `ecs_volume_price` (
  `price_type` tinyint(1) unsigned NOT NULL,
  `goods_id` mediumint(8) unsigned NOT NULL,
  `volume_number` smallint(5) unsigned NOT NULL DEFAULT '0',
  `volume_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`price_type`,`goods_id`,`volume_number`)
) ENGINE=MyISAM;

-- �޸� feedback ��
ALTER TABLE `ecs_feedback` ADD `msg_status` TINYINT( 1 ) unsigned NOT NULL DEFAULT '0' AFTER `msg_type`;

-- ���ӳ�ֵ�����Ʒ��
DROP TABLE IF EXISTS `ecs_package_goods`;
CREATE TABLE `ecs_package_goods` (
  `package_id` mediumint( 8 ) unsigned NOT NULL DEFAULT '0',
  `goods_id` mediumint( 8 ) unsigned NOT NULL DEFAULT '0',
  `goods_number` smallint( 5 ) unsigned NOT NULL DEFAULT '1',
  `admin_id` tinyint( 3 ) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY ( `package_id` , `goods_id` , `admin_id` )
) ENGINE = MyISAM;

-- ���ӻ����̳���Ʒ��
DROP TABLE IF EXISTS `ecs_exchange_goods`;
CREATE TABLE IF NOT EXISTS `ecs_exchange_goods` (
  `goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `exchange_integral` int(10) unsigned NOT NULL DEFAULT '0',
  `is_exchange` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_hot` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`goods_id`)
) ENGINE=MyISAM;

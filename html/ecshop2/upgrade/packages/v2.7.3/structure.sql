-- `ecs_shipping`�޸�
ALTER TABLE `ecs_shipping` ADD `shipping_order` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0';
--`ecs_virtual_card`�޸�
ALTER TABLE `ecs_virtual_card` CHANGE `crc32` `crc32` VARCHAR( 12 )  NOT NULL DEFAULT '0';
--`ecs_users`�޸�
ALTER TABLE `ecs_users` ADD `ec_salt` VARCHAR( 10 )  NULL AFTER `salt` ;
--`ecs_admin_user`�޸�
ALTER TABLE `ecs_admin_user` ADD `ec_salt` VARCHAR( 10 ) NULL AFTER `user_name` ;
-- �Ѿ�ϵͳ�����еĻ�Աע������IDȫ������100
UPDATE `ecs_reg_fields` AS rf SET rf.id = rf.id + 100;
UPDATE `ecs_reg_extend_info` AS re SET re.reg_field_id = re.reg_field_id + 100;
-- ���ϵͳ�����Ļ�Աע������Ϣ
INSERT INTO `ecs_reg_fields` (`id`, `reg_field_name`, `dis_order`, `display`, `type`, `is_need`) VALUES (1, 'MSN', 0, 1, 1, 1), (2, 'QQ', 0, 1, 1, 1), (3, '�칫�绰', 0, 1, 1, 1), (4, '��ͥ�绰', 0, 1, 1, 1), (5, '�ֻ�', 0, 1, 1, 1), (6, '�����һ�����', 0, 1, 1, 1);
INSERT INTO `ecs_admin_action` (`action_id`, `parent_id`, `action_code`) VALUES (135, 4, 'role_manage');
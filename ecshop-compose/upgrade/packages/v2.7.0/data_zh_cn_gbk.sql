-- ���ӹ������
-- `ecs_admin_action`
INSERT INTO `ecs_admin_action` (`action_id`, `parent_id`, `action_code`) VALUES (129, 6, 'delivery_view'), (130, 6, 'back_view'), (131, 5, 'reg_fields'), (132, 5, 'shop_authorized'), (133, 5, 'webcollect_manage');

DELETE FROM `ecs_admin_action` WHERE action_code = 'sms_manage';

DELETE FROM `ecs_admin_action` WHERE parent_id = '11';
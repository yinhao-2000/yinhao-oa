CREATE DATABASE IF NOT EXISTS `yinhao-oa` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE TABLE `oa_process` (
    `process_code` varchar (128) NULL DEFAULT '' COMMENT '审批code',
    `id` int NOT NULL AUTO_INCREMENT,
    `user_id` int NULL COMMENT '用户id',
    `process_template_id` int NULL COMMENT '审批模板id',
    `process_type_id` int NULL COMMENT '审批类型id',
    `title` varchar (128) NULL DEFAULT '' COMMENT '标题',
    `description` varchar (128) NULL DEFAULT '' COMMENT '描述',
    `form_values` varchar (128) NULL DEFAULT '' COMMENT '表单值',
    `process_instance_id` varchar (128) NULL DEFAULT '' COMMENT '流程实例id',
    `current_auditor` varchar (128) NULL DEFAULT '' COMMENT '当前审批人',
    `status` int NULL COMMENT '状态（0：默认 1：审批中 2：审批通过 -1：驳回）',
    PRIMARY KEY (`id`),
    index `idx_user_id` USING btree (`user_id`),
    index `idx_process_template_id` USING btree (`process_template_id`),
    index `idx_process_instance_id` USING btree (`process_instance_id`)
) ENGINE = innodb;

CREATE TABLE `oa_process_record` (
    `id` int NOT NULL AUTO_INCREMENT,
    `process_id` int NULL COMMENT '审批流程id',
    `description` varchar (128) NULL DEFAULT '' COMMENT '审批描述',
    `status` int NULL COMMENT '状态',
    `operate_user_id` int NULL COMMENT '操作用户id',
    `operate_user` varchar (128) NULL DEFAULT '' COMMENT '操作用户',
    PRIMARY KEY (`id`),
    index `idx_process_id` USING btree (`process_id`),
    index `idx_operate_user_id` USING btree (`operate_user_id`)
) COMMENT = "ProcessRecord" ENGINE = innodb;

CREATE TABLE `oa_process_template` (
    `id` int NOT NULL AUTO_INCREMENT,
    `name` varchar (128) NULL DEFAULT '' COMMENT '模板名称',
    `icon_url` varchar (128) NULL DEFAULT '' COMMENT '图标路径',
    `process_type_id` int NULL COMMENT 'processTypeId',
    `form_props` varchar (128) NULL DEFAULT '' COMMENT '表单属性',
    `form_options` varchar (128) NULL DEFAULT '' COMMENT '表单选项',
    `description` varchar (128) NULL DEFAULT '' COMMENT '描述',
    `process_definition_key` varchar (128) NULL DEFAULT '' COMMENT '流程定义key',
    `process_definition_path` varchar (128) NULL DEFAULT '' COMMENT '流程定义上传路process_model_id',
    `process_model_id` varchar (128) NULL DEFAULT '' COMMENT '流程定义模型id\"',
    `status` int NULL COMMENT '状态',
    PRIMARY KEY (`id`),
    index `idx_process_type_id` USING btree (`process_type_id`)
) COMMENT = "ProcessTemplate" ENGINE = innodb;

CREATE TABLE `oa_process_type` (
    `id` int NOT NULL AUTO_INCREMENT,
    `name` varchar (128) NULL DEFAULT '' COMMENT '类型名称',
    `description` varchar (128) NULL DEFAULT '' COMMENT '描述',
    PRIMARY KEY (`id`)
) COMMENT = "ProcessType" ENGINE = innodb;

CREATE TABLE `sys_dept` (
    `id` int NOT NULL AUTO_INCREMENT,
    `name` varchar (128) NULL DEFAULT '' COMMENT '部门名称',
    `parent_id` int NULL COMMENT '上级部门id',
    `tree_path` varchar (128) NULL DEFAULT '' COMMENT '树结构',
    `sort_value` int NULL COMMENT '排序',
    `leader` varchar (128) NULL DEFAULT '' COMMENT '负责人',
    `phone` varchar (128) NULL DEFAULT '' COMMENT '电话',
    `status` int NULL COMMENT '状态（1正常 0停用）',
    PRIMARY KEY (`id`),
    index `idx_parent_id` USING btree (`parent_id`)
) COMMENT = "部门" ENGINE = innodb;

CREATE TABLE `sys_login_log` (
    `id` int NOT NULL AUTO_INCREMENT,
    `username` varchar (128) NULL DEFAULT '' COMMENT '用户账号',
    `ipaddr` varchar (128) NULL DEFAULT '' COMMENT '登录IP地址',
    `status` int NULL COMMENT '登录状态（0成功 1失败）',
    `msg` varchar (128) NULL DEFAULT '' COMMENT '提示信息',
    `access_time` date NULL COMMENT '访问时间',
    PRIMARY KEY (`id`)
) COMMENT = "SysLoginLog" ENGINE = innodb;

CREATE TABLE `sys_oper_log` (
    `id` int NOT NULL AUTO_INCREMENT,
    `title` varchar (128) NULL DEFAULT '' COMMENT '模块标题',
    `business_type` varchar (128) NULL DEFAULT '' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
    `method` varchar (128) NULL DEFAULT '' COMMENT '方法名称',
    `request_method` varchar (128) NULL DEFAULT '' COMMENT '请求方式',
    `operator_type` varchar (128) NULL DEFAULT '' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
    `oper_name` varchar (128) NULL DEFAULT '' COMMENT '操作人员',
    `dept_name` varchar (128) NULL DEFAULT '' COMMENT '部门名称',
    `oper_url` varchar (128) NULL DEFAULT '' COMMENT '请求URL',
    `oper_ip` varchar (128) NULL DEFAULT '' COMMENT '主机地址',
    `oper_param` varchar (128) NULL DEFAULT '' COMMENT '请求参数',
    `json_result` varchar (128) NULL DEFAULT '' COMMENT '返回参数',
    `status` int NULL COMMENT '操作状态（0正常 1异常）',
    `error_msg` varchar (128) NULL DEFAULT '' COMMENT '错误消息',
    `oper_time` date NULL COMMENT '操作时间',
    PRIMARY KEY (`id`)
) COMMENT = "SysOperLog" ENGINE = innodb;

CREATE TABLE `sys_post` (
    `id` int NOT NULL AUTO_INCREMENT,
    `post_code` varchar (128) NULL DEFAULT '' COMMENT '岗位编码',
    `name` varchar (128) NULL DEFAULT '' COMMENT '岗位名称',
    `description` varchar (128) NULL DEFAULT '' COMMENT '显示顺序',
    `status` int NULL COMMENT '状态（1正常 0停用）',
    PRIMARY KEY (`id`)
) COMMENT = "岗位" ENGINE = innodb;

CREATE TABLE `sys_role` (
    `id` int NOT NULL AUTO_INCREMENT,
    `role_name` varchar (128) NULL DEFAULT '' COMMENT '角色名称',
    `role_code` varchar (128) NULL DEFAULT '' COMMENT '角色编码',
    `description` varchar (128) NULL DEFAULT '' COMMENT '描述',
    PRIMARY KEY (`id`),
    index `idx_role_code` USING btree (`role_code`)
) ENGINE = innodb;

CREATE TABLE `sys_role_menu` (
    `id` int NOT NULL AUTO_INCREMENT,
    `role_id` int NULL COMMENT '角色id',
    `menu_id` int NULL COMMENT '菜单id',
    PRIMARY KEY (`id`),
    index `idx_role_id` USING btree (`role_id`)
) COMMENT = "角色菜单" ENGINE = innodb;

CREATE TABLE `sys_user` (
    `id` int NOT NULL AUTO_INCREMENT,
    `username` varchar (128) NULL DEFAULT '' COMMENT '用户名',
    `password` varchar (128) NULL DEFAULT '' COMMENT '密码',
    `name` varchar (128) NULL DEFAULT '' COMMENT '姓名',
    `phone` varchar (128) NULL DEFAULT '' COMMENT '手机',
    `head_url` varchar (128) NULL DEFAULT '' COMMENT '头像地址',
    `dept_id` int NULL COMMENT '部门id',
    `post_id` int NULL COMMENT '岗位id',
    `description` varchar (128) NULL DEFAULT '' COMMENT '描述',
    `open_id` varchar (128) NULL DEFAULT '' COMMENT 'openId',
    `status` int NULL COMMENT '状态（1：正常 0：停用）',
    PRIMARY KEY (`id`),
    index `idx_dept_id` USING btree (`dept_id`),
    index `idx_username` USING btree (`username`)
) COMMENT = "用户" ENGINE = innodb;

CREATE TABLE `sys_user_role` (
    `id` int NOT NULL AUTO_INCREMENT,
    `role_id` int NULL COMMENT '角色id',
    `user_id` int NULL COMMENT '用户id',
    PRIMARY KEY (`id`),
    index `idx_role_id` USING btree (`role_id`)
) COMMENT = "用户角色" ENGINE = innodb;

CREATE TABLE `wechat_menu` (
    `id` int NOT NULL AUTO_INCREMENT,
    `parent_id` int NULL COMMENT 'id',
    `name` varchar (128) NULL DEFAULT '' COMMENT '名称',
    `type` varchar (128) NULL DEFAULT '' COMMENT '类型',
    `url` varchar (128) NULL DEFAULT '' COMMENT '网页 链接，用户点击菜单可打开链接',
    `meun_key` varchar (128) NULL DEFAULT '' COMMENT '菜单KEY值，用于消息接口推送',
    `sort` int NULL COMMENT '排序',
    PRIMARY KEY (`id`),
    index `idx_parent_id` USING btree (`parent_id`)
) COMMENT = "菜单" ENGINE = innodb;
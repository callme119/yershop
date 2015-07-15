-- -----------------------------
-- Think MySQL Data Transfer
-- Date : 2013-12-17 15:14:46
-- -----------------------------

SET FOREIGN_KEY_CHECKS = 0;


-- -----------------------------
-- Table structure for `onethink_action`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_action`;
CREATE TABLE `onethink_action` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '行为唯一标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '行为说明',
  `remark` char(140) NOT NULL DEFAULT '' COMMENT '行为描述',
  `rule` text NULL  COMMENT '行为规则',
  `log` text NULL  COMMENT '日志规则',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统行为表';

-- -----------------------------
-- Records of `onethink_action`
-- -----------------------------
INSERT INTO `onethink_action` VALUES ('1', 'user_login', '用户登录', '积分+10，每天一次', 'table:member|field:score|condition:uid={$self} AND status>-1|rule:score+10|cycle:24|max:1;', '[user|get_nickname]在[time|time_format]登录了后台', '1', '1', '1387181220');
INSERT INTO `onethink_action` VALUES ('2', 'add_article', '发布文章', '积分+5，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:5', '', '2', '0', '1380173180');
INSERT INTO `onethink_action` VALUES ('3', 'review', '评论', '评论积分+1，无限制', 'table:member|field:score|condition:uid={$self}|rule:score+1', '', '2', '1', '1383285646');
INSERT INTO `onethink_action` VALUES ('4', 'add_document', '发表文档', '积分+10，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+10|cycle:24|max:5', '[user|get_nickname]在[time|time_format]发表了一篇文章。\r\n表[model]，记录编号[record]。', '2', '0', '1386139726');
INSERT INTO `onethink_action` VALUES ('5', 'add_document_topic', '发表讨论', '积分+5，每天上限10次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:10', '', '2', '0', '1383285551');
INSERT INTO `onethink_action` VALUES ('6', 'update_config', '更新配置', '新增或修改或删除配置', '', '', '1', '1', '1383294988');
INSERT INTO `onethink_action` VALUES ('7', 'update_model', '更新模型', '新增或修改模型', '', '', '1', '1', '1383295057');
INSERT INTO `onethink_action` VALUES ('8', 'update_attribute', '更新属性', '新增或更新或删除属性', '', '', '1', '1', '1383295963');
INSERT INTO `onethink_action` VALUES ('9', 'update_channel', '更新导航', '新增或修改或删除导航', '', '', '1', '1', '1383296301');
INSERT INTO `onethink_action` VALUES ('10', 'update_menu', '更新菜单', '新增或修改或删除菜单', '', '', '1', '1', '1383296392');
INSERT INTO `onethink_action` VALUES ('11', 'update_category', '更新分类', '新增或修改或删除分类', '', '', '1', '1', '1383296765');

-- -----------------------------
-- Table structure for `onethink_action_log`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_action_log`;
CREATE TABLE `onethink_action_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `action_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '行为id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行用户id',
  `action_ip` bigint(20) NOT NULL COMMENT '执行行为者ip',
  `model` varchar(50) NOT NULL DEFAULT '' COMMENT '触发行为的表',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '触发行为的数据id',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '日志备注',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行行为的时间',
  PRIMARY KEY (`id`),
  KEY `action_ip_ix` (`action_ip`),
  KEY `action_id_ix` (`action_id`),
  KEY `user_id_ix` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='行为日志表';


-- -----------------------------
-- Table structure for `onethink_sync_login`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_sync_login`;
CREATE TABLE `onethink_sync_login` (
 `uid` int(11) NOT NULL,
  `openid` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `access_token` varchar(255) NOT NULL,
  `refresh_token` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='第三方登陆表';



-- -----------------------------
-- Table structure for `onethink_ad`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_ad`;
CREATE TABLE `onethink_ad` (
   `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(225)  NOT NULL DEFAULT '' COMMENT '标志',
  `title` varchar(225)  NOT NULL DEFAULT '' COMMENT '标题',
  `url` varchar(225)  NOT NULL DEFAULT '' COMMENT '金额',
  `partner` varchar(255) NOT NULL DEFAULT '' COMMENT '关联商品',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `meta_title` varchar(225)  NOT NULL DEFAULT '',
  `place` varchar(225)  NOT NULL DEFAULT '' COMMENT '位置',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '可见性',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(2) NOT NULL DEFAULT '1' NULL COMMENT '数据状态',
  `icon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类图标',
  `ypid`  int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uk_name` (`name`) USING BTREE
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='广告表';


-- -----------------------------
-- Table structure for `onethink_backlist`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_backlist`;
CREATE TABLE `onethink_backlist` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `goodid` int(10) unsigned NOT NULL DEFAULT '0',
  `num` int(10) unsigned NOT NULL DEFAULT '0',
  `tool` varchar(225)  NOT NULL DEFAULT '' COMMENT '订单号',
  `toolid` varchar(225)  NOT NULL DEFAULT '' COMMENT '订单号',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  `info` varchar(225) NOT NULL DEFAULT '',
  `total` decimal(50,2) NOT NULL DEFAULT '0',
  `backinfo` varchar(225) NOT NULL DEFAULT '',
  `address` varchar(225) NOT NULL DEFAULT '',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0',
  `parameters` varchar(225) NOT NULL DEFAULT '',
  `assistant` int(10) unsigned NOT NULL DEFAULT '0',
  `shopid` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(225) NOT NULL DEFAULT '',
  `reason` varchar(225) NOT NULL DEFAULT '',
  `contact` varchar(225) NOT NULL DEFAULT '',
  `backname` varchar(225) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='退货表';


-- -----------------------------
-- Table structure for `onethink_brand`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_brand`;
CREATE TABLE `onethink_brand` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '标志',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `price` varchar(50) NOT NULL DEFAULT '' COMMENT '金额',
  `code` varchar(255) NOT NULL COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `meta_title` varchar(100) NOT NULL DEFAULT '',
  `allow_publish` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许发布内容',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '可见性',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `icon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图标',
  `ypid` int(10) unsigned NOT NULL DEFAULT '0',
  `goodid` varchar(225) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uk_name` (`name`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='表';


-- -----------------------------
-- Table structure for `onethink_cancel`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_cancel`;
CREATE TABLE `onethink_cancel` (
   `id` int(10) NOT NULL AUTO_INCREMENT,
  `goodid` int(10) unsigned NOT NULL DEFAULT '0',
  `num` int(10) unsigned NOT NULL DEFAULT '0',
  `orderid` varchar(225) NOT NULL DEFAULT '' COMMENT '订单号',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(225) NOT NULL DEFAULT '',
  `reason` varchar(225) NOT NULL DEFAULT '',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0',
  `assistant` int(10) unsigned NOT NULL DEFAULT '0',
  `shopid` int(10) unsigned NOT NULL DEFAULT '0',
  `refuse_info` varchar(225) NOT NULL DEFAULT '',
   `status` tinyint(2) NOT NULL DEFAULT '0',
  `info` varchar(225) NOT NULL DEFAULT '',
  `parameters` varchar(225) NOT NULL DEFAULT '',
  `cash` decimal(50,2) NOT NULL DEFAULT '0',
  `count` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='表';


-- -----------------------------
-- Table structure for `onethink_change`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_change`;
CREATE TABLE `onethink_change` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `goodid` int(10) unsigned NOT NULL DEFAULT '0',
  `num` int(10) unsigned NOT NULL DEFAULT '0',
  `tool` varchar(225)  NOT NULL DEFAULT '' COMMENT '订单号',
  `toolid` varchar(225)  NOT NULL DEFAULT '' COMMENT '订单号',
  `uid` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(2) NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  `info` varchar(225)  NOT NULL DEFAULT '',
  `total` decimal(50,2)  NOT NULL DEFAULT '0',
  `backinfo` varchar(225)  NOT NULL DEFAULT '',
  `shopid` int(10) unsigned NOT NULL DEFAULT '0',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0',
  `assistant` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(225)  NOT NULL DEFAULT '',
  `reason` varchar(225)  NOT NULL DEFAULT '',
  `changetool` varchar(225)  NOT NULL DEFAULT '',
  `changetoolid` varchar(225)  NOT NULL DEFAULT '',
  `address` varchar(225)  NOT NULL DEFAULT '',
  `contact` varchar(225)  NOT NULL DEFAULT '',
  `parameters` varchar(225)  NOT NULL DEFAULT '',
  `backname` varchar(225)  NOT NULL DEFAULT '',
  `acceptname` varchar(255)  NOT NULL DEFAULT '',
  `acceptphone` varchar(225)  NOT NULL DEFAULT '',
  `acceptaddress` varchar(225)  NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='表';


-- -----------------------------
-- Table structure for `onethink_favortable`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_favortable`;
CREATE TABLE `onethink_favortable` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0',
  `goodid` int(10) unsigned NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  `num` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
  ) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='收藏表';



-- -----------------------------
-- Table structure for `onethink_comment`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_comment`;
CREATE TABLE `onethink_comment` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `goodid` int(100) unsigned NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
   `score` int(5) unsigned NOT NULL DEFAULT '0',
   `update_time` int(10) unsigned NOT NULL DEFAULT '0',
   `goodscore` int(5) unsigned NOT NULL DEFAULT '0',
    `servicescore` int(5) unsigned NOT NULL DEFAULT '0',
     `deliveryscore` int(5) unsigned NOT NULL DEFAULT '0',
  `content` varchar(225) CHARACTER SET utf8 DEFAULT NULL,
   `tag` varchar(225) CHARACTER SET utf8 DEFAULT NULL,
   `pics` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '图片',
   `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '1-可见 -1-无效',
   `uid` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
  ) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='商品表';


-- -----------------------------
-- Table structure for `onethink_iswork`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_iswork`;
CREATE TABLE `onethink_iswork` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '1-未使用 2-已使用',
  PRIMARY KEY (`id`)
  ) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='签到表';


-- -----------------------------
-- Table structure for `onethink_usercoupon`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_usercoupon`;
CREATE TABLE `onethink_usercoupon` (
 `id` int(10) NOT NULL AUTO_INCREMENT,
  `uid` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `couponid` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
   `status` tinyint(2) NOT NULL DEFAULT '0'  COMMENT '1-未使用 2-已使用',
  `cover_id` int(225) unsigned NOT NULL DEFAULT '0' COMMENT '图片',
  `info` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
  ) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='用户个人优惠券表';


-- -----------------------------
-- Table structure for `onethink_turnover`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_turnover`;
CREATE TABLE `onethink_turnover` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0',
  `sales` decimal(50,2) NOT NULL DEFAULT '0',
  `back` decimal(50,2) NOT NULL DEFAULT '0',
  `change` decimal(50,2) NOT NULL DEFAULT '0',
  `profits` decimal(50,2) NOT NULL DEFAULT '0',
   `cancel` decimal(50,2) NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0',
   `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `info` varchar(225)  NOT NULL DEFAULT '0',
 
  PRIMARY KEY (`id`)
  ) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='利润计算总表';


-- -----------------------------
-- Table structure for `onethink_tuan`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_tuan`;
CREATE TABLE `onethink_tuan` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '标志',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `goodid` varchar(50) NOT NULL DEFAULT '' COMMENT '金额',
  `code` varchar(255) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `place` tinyint(30) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许发布内容',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '可见性',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
   `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `icon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类图标',
  `pid` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) 
  ) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='团购分类表';


-- -----------------------------
-- Records of `onethink_tuan`
-- -----------------------------

INSERT INTO `onethink_tuan` VALUES (1, 'fuzxm', '服装鞋帽', '5,8,9,33,34', '', '', 0, 0, 1, 1421570108, 1421573352, 1, 0, 0);
INSERT INTO `onethink_tuan` VALUES (2, 'xxsg', '新鲜水果', '5,8,9,14,15,16,17,21,33,34,35,39,40', '', '', 0, 0, 1, 1421570200, 1421570550, 1, 0, 0);
INSERT INTO `onethink_tuan` VALUES (3, 'tsyx', '图书音像', '5,8,9,14,15,16,17,21,33,34,35,39', '', '', 0, 0, 1, 1421570883, 1421571562, 1, 0, 0);



-- -----------------------------
-- Table structure for `onethink_tuanid`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_tuanid`;
CREATE TABLE `onethink_tuanid` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `goodid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '标志',
  `tuanpid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '可见性',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `price` decimal(50,2) NOT NULL DEFAULT '0',
  `view` int(10) unsigned NOT NULL DEFAULT '0',
  `salenumber` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
  ) ENGINE=MyISAM AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COMMENT='签到表';

-- -----------------------------
-- Records of `onethink_tuanid`
-- -----------------------------
INSERT INTO `onethink_tuanid` VALUES (1, 5, 2, 0, 1421570550, 0, 0, 0, 0, 0);
INSERT INTO `onethink_tuanid` VALUES (2, 8, 2, 0, 1421570551, 0, 0, 0, 0, 0);
INSERT INTO `onethink_tuanid` VALUES (3, 9, 2, 0, 1421570551, 0, 0, 0, 0, 0);
INSERT INTO `onethink_tuanid` VALUES (4, 14, 2, 0, 1421570551, 0, 0, 0, 0, 0);
INSERT INTO `onethink_tuanid` VALUES (5, 15, 2, 0, 1421570551, 0, 0, 0, 0, 0);
INSERT INTO `onethink_tuanid` VALUES (6, 16, 2, 0, 1421570551, 0, 0, 0, 0, 0);
INSERT INTO `onethink_tuanid` VALUES (7, 17, 2, 0, 1421570551, 0, 0, 0, 0, 0);
INSERT INTO `onethink_tuanid` VALUES (9, 33, 2, 0, 1421570551, 0, 0, 0, 0, 0);
INSERT INTO `onethink_tuanid` VALUES (10, 34, 2, 0, 1421570551, 0, 0, 0, 0, 0);
INSERT INTO `onethink_tuanid` VALUES (11, 35, 2, 0, 1421570551, 0, 0, 0, 0, 0);
INSERT INTO `onethink_tuanid` VALUES (12, 42, 2, 0, 1421570551, 0, 0, 0, 0, 0);
INSERT INTO `onethink_tuanid` VALUES (30, 5, 3, 0, 1421571562, 0, 0, 0, 0, 0);
INSERT INTO `onethink_tuanid` VALUES (35, 8, 3, 0, 1421571562, 0, 0, 0, 0, 0);
INSERT INTO `onethink_tuanid` VALUES (32, 9, 3, 0, 1421571562, 0, 0, 0, 0, 0);
INSERT INTO `onethink_tuanid` VALUES (33, 14, 3, 0, 1421571562, 0, 0, 0, 0, 0);
INSERT INTO `onethink_tuanid` VALUES (34, 15, 3, 0, 1421571562, 0, 0, 0, 10, 0);
INSERT INTO `onethink_tuanid` VALUES (38, 33, 3, 0, 1421571562, 0, 0, 0, 0, 0);
INSERT INTO `onethink_tuanid` VALUES (39, 34, 3, 0, 1421571562, 0, 0, 0, 0, 0);
INSERT INTO `onethink_tuanid` VALUES (42, 35, 1, 0, 1421571562, 0, 0, 0, 0, 0);
INSERT INTO `onethink_tuanid` VALUES (41, 32, 3, 0, 1421571562, 0, 0, 0, 0, 0);
INSERT INTO `onethink_tuanid` VALUES (47, 5, 1, 0, 1421573353, 0, 0, 0, 0, 0);
INSERT INTO `onethink_tuanid` VALUES (43, 8, 1, 0, 1421573353, 0, 0, 0, 0, 0);
INSERT INTO `onethink_tuanid` VALUES (44, 9, 1, 0, 1421573353, 0, 0, 0, 0, 0);
INSERT INTO `onethink_tuanid` VALUES (45, 33, 1, 0, 1421573353, 0, 0, 0, 0, 0);
INSERT INTO `onethink_tuanid` VALUES (46, 34, 1, 0, 1421573353, 0, 0, 0, 0, 0);


-- -----------------------------
-- Table structure for `onethink_transport`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_transport`;
CREATE TABLE `onethink_transport` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `orderid` int(10) unsigned NOT NULL DEFAULT '0',
  `cellphone` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `province` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `city` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `area` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `address` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `realname` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '',
   `phone` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '',
   `youbian` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
    `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `uid`  int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
  ) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='收件人地址表';


-- -----------------------------
-- Table structure for `onethink_slide`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_slide`;
CREATE TABLE `onethink_slide` (
 `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `name` varchar(225) NOT NULL DEFAULT '' COMMENT '标志',
  `title` varchar(225) NOT NULL DEFAULT '' COMMENT '标题',
   `url` varchar(225) NOT NULL DEFAULT '' COMMENT '链接',
  `goodid` varchar(225) NOT NULL DEFAULT '' COMMENT '金额',
  `code` varchar(255) NOT NULL COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `place` tinyint(30) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许发布内容',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '可见性',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `icon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类图标',
  `pid` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
  ) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='幻灯片图片储存表';


-- -----------------------------
-- Records of `onethink_slide`
-- -----------------------------

INSERT INTO `onethink_slide` VALUES(12, 0, '双11,5折封顶', 'new/index', '5,8,9,14,15,16,17,21,33,34,35,39,40,41,42,43,44', '', '', 0, 1, 1, 1421158112, 1421571586, 1, 50, 0);
INSERT INTO `onethink_slide` VALUES(11, 0, '电脑数码办公快“京”光', 'tuan/index', '5,8,9,14,15,16,17,21,33,34,35,39,40,41,42', '', '', 0, 1, 1, 1421158031, 1421510618, 1, 49, 0);
INSERT INTO `onethink_slide` VALUES(9, 0, '电脑数码', 'new/index', '5,8,9,14,15,16,17,18,21', '', '', 0, 1, 1, 1421132459, 1421511163, 1, 34, 0);
INSERT INTO `onethink_slide` VALUES(10, 0, '电脑数码', 'tuan/index', '5,8,9,14,15,16,17,21,33,34,35,39,40,41,42,43,44', '', '', 0, 1, 1, 1421157871, 1421506519, 1, 48, 0);
INSERT INTO `onethink_slide` VALUES(8, 0, '电脑数码', 'new/index', '5,8,9,14,15,16,17,21,33,34,35,39,40,41,42,43,44', '', '', 0, 1, 1, 0, 1421506530, 1, 33, 0);


-- -----------------------------
-- Table structure for `onethink_shopcart`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_shopcart`;
CREATE TABLE `onethink_shopcart` (
 `id` int(10) NOT NULL AUTO_INCREMENT,
  `goodid` int(10) unsigned NOT NULL DEFAULT '0',
  `uid` int(10) unsigned NOT NULL DEFAULT '0',
  `num` int(10) unsigned NOT NULL DEFAULT '0',
  `sort` varchar(225) NOT NULL DEFAULT '' COMMENT '排序',
  `parameters` varchar(225) NOT NULL DEFAULT '' COMMENT '参数',
  `price` decimal(50,2) NOT NULL DEFAULT '0',
 `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
  ) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='登录用户购物车表';



-- -----------------------------
-- Table structure for `onethink_service`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_service`;
CREATE TABLE `onethink_service` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `goodid` int(10) unsigned NOT NULL DEFAULT '0',
  `num` int(10) unsigned NOT NULL DEFAULT '0',
  `orderid` varchar(225) NOT NULL DEFAULT '' COMMENT '订单号',
  `time` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(225) NOT NULL DEFAULT '',
  `reason` varchar(225) NOT NULL DEFAULT '',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0',
  `assistant` int(10) unsigned NOT NULL DEFAULT '0',
  `backinfo` varchar(225) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
  ) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='售后服务表';


-- -----------------------------
-- Table structure for `onethink_pay`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_pay`;
CREATE TABLE `onethink_pay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `out_trade_no` varchar(100) NOT NULL DEFAULT '',
  `money` decimal(50,2) NOT NULL DEFAULT '0' COMMENT '优惠后的总金额',
   `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '数据状态',
   `type` int(10) NOT NULL DEFAULT '0' COMMENT '付款类型1-货到付款2-在线支付',
   `uid` int(10) NOT NULL DEFAULT '0',
   `total` decimal(50,2) NOT NULL DEFAULT '0',
   `yunfee` decimal(50,2) NOT NULL DEFAULT '0' COMMENT '运费',
    `ratio` decimal(50,2) NOT NULL DEFAULT '0' COMMENT'积分抵消金额',
    `ratioscore` int(10) NOT NULL DEFAULT '0' COMMENT'消耗积分',
   `coupon` decimal(50,2) NOT NULL DEFAULT '0',
 `couponcode` varchar(255) NOT NULL DEFAULT '',
  `callback` varchar(255) NOT NULL DEFAULT '0',
  `addressid` varchar(255) NOT NULL DEFAULT '0' COMMENT '地址',
  `url` varchar(255) NOT NULL DEFAULT '0',
  `param` text DEFAULT NULL,
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
  ) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='在线支付表';


-- -----------------------------
-- Table structure for `onethink_records`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_records`;
CREATE TABLE `onethink_records` (
 `id` int(225) NOT NULL AUTO_INCREMENT,
  `ip` varchar(225) NOT NULL DEFAULT '',
  `url` varchar(225) NOT NULL DEFAULT '',
  `country` varchar(225) NOT NULL DEFAULT '' COMMENT '订单号',
  `time` int(10) unsigned NOT NULL DEFAULT '0',
  `uid` int(10) unsigned NOT NULL DEFAULT '0',
  `info` varchar(225) NOT NULL DEFAULT '',
  `province` varchar(225) NOT NULL DEFAULT '',
  `city` varchar(225) NOT NULL DEFAULT '',
  `isp` varchar(225) NOT NULL DEFAULT '',
  `referer` varchar(225) NOT NULL DEFAULT '' COMMENT '访问来源',
  `tag` int(10) unsigned NOT NULL DEFAULT '0',
  `page` varchar(225) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
  ) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='ip访问记录表';


-- -----------------------------
-- Table structure for `onethink_order`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_order`;
CREATE TABLE `onethink_order` (
  `id` int(225) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `orderid` varchar(225) NOT NULL DEFAULT '',
  `tag` varchar(225) NOT NULL DEFAULT '',
  `pricetotal` decimal(50,2) NOT NULL DEFAULT '0.00',
   `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
    `status` tinyint(2) NOT NULL DEFAULT '0'COMMENT '0-系统生成完成1-用户已提交订单2-3系统处理进入物流配送',
  `assistant` varchar(225) DEFAULT '无' COMMENT '操作人',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `uid` int(10) unsigned NOT NULL DEFAULT '0',
  `shipprice` decimal(50,2) NOT NULL DEFAULT '0',
  `display` int(10) unsigned NOT NULL DEFAULT '0',
  `isover` varchar(225) NOT NULL DEFAULT '',
  `ispay` tinyint(2) NOT NULL DEFAULT '0' COMMENT '1在线支付未完成2在线支付完成3-货到付款',
  `total` decimal(50,2) NOT NULL DEFAULT '0',
  `tool` varchar(225) NOT NULL DEFAULT '' COMMENT '是否默认地址',
  `addressid` int(10) unsigned NOT NULL DEFAULT '0',
  `toolid` varchar(225) NOT NULL DEFAULT '',
  `isdefault` int(10) unsigned NOT NULL DEFAULT '0',
  `info` varchar(225) NOT NULL DEFAULT '',
  `shipway` varchar(225) NOT NULL DEFAULT '' COMMENT '送货方式',
  `invoice` varchar(225) NOT NULL DEFAULT '' COMMENT '发票',
  `message` varchar(225) NOT NULL DEFAULT '' COMMENT '留言',
  `backinfo` varchar(225) NOT NULL DEFAULT '',
  `score` int(10) unsigned NOT NULL DEFAULT '0',
  `codeid` varchar(225) NOT NULL DEFAULT '',
  `codemoney` decimal(50,2) NOT NULL DEFAULT '0',
  `send_name` varchar(225) NOT NULL DEFAULT '',
  `send_contact` varchar(225) NOT NULL DEFAULT '',
  `send_address` varchar(225) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
  ) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='订单表';


-- -----------------------------
-- Table structure for `onethink_fcoupon`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_fcoupon`;
CREATE TABLE `onethink_fcoupon` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(225) NOT NULL DEFAULT '' COMMENT '标志',
  `title` varchar(225) NOT NULL DEFAULT '' COMMENT '名称',
  `price` varchar(225) NOT NULL DEFAULT '' COMMENT '金额',
  `lowpayment` varchar(50) NOT NULL DEFAULT '' COMMENT '消费满多少可使用',
  `code` varchar(255) NOT NULL COMMENT '代码',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `allow_publish` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许发布内容',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '可见性',
  `reply` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许回复',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `icon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类图标',
  PRIMARY KEY (`id`)
  ) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='优惠券表';


-- -----------------------------
-- Records of `onethink_fcoupon`
-- -----------------------------
INSERT INTO `onethink_fcoupon` VALUES(1, '645645', '肯德基', '30','100', '78ou16bl', '', 0, 1, 1, 0, 1414012468, 1415716837, 1, 5);
INSERT INTO `onethink_fcoupon` VALUES(2, '645465', '麦当劳', '6644','150', '453ljnq7', '', 0, 1, 1, 0, 1414012758, 1414174944, 1, 11);
INSERT INTO `onethink_fcoupon` VALUES(3, '64645', '麦考林', '656','120', '4nm34itt', '', 0, 1, 1, 0, 1414012817, 1414175369, 1, 14);
INSERT INTO `onethink_fcoupon` VALUES(5, '65656', '必胜客', '50','110', '2xs1rdw0', '', 0, 0, 1, 0, 1414174826, 1414174826, 1, 13);


-- -----------------------------
-- Table structure for `onethink_addons`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_addons`;
CREATE TABLE `onethink_addons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT '插件名或标识',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '中文名',
  `description` text COMMENT '插件描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `config` text COMMENT '配置',
  `author` varchar(40) DEFAULT '' COMMENT '作者',
  `version` varchar(20) DEFAULT '' COMMENT '版本号',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `has_adminlist` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台列表',
   PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='插件表';

-- -----------------------------
-- Records of `onethink_addons`
-- -----------------------------
INSERT INTO `onethink_addons` VALUES ('15', 'EditorForAdmin', '后台编辑器', '用于增强整站长文本的输入和显示', '1', '{\"editor_type\":\"2\",\"editor_wysiwyg\":\"1\",\"editor_height\":\"500px\",\"editor_resize_type\":\"1\"}', 'thinkphp', '0.1', '1383126253', '0');
INSERT INTO `onethink_addons` VALUES ('2', 'SiteStat', '站点统计信息', '统计站点的基础信息', '1', '{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"1\",\"display\":\"1\",\"status\":\"0\"}', 'thinkphp', '0.1', '1379512015', '0');
INSERT INTO `onethink_addons` VALUES ('3', 'DevTeam', '开发团队信息', '开发团队成员信息', '1', '{\"title\":\"OneThink\\u5f00\\u53d1\\u56e2\\u961f\",\"width\":\"2\",\"display\":\"1\"}', 'thinkphp', '0.1', '1379512022', '0');
INSERT INTO `onethink_addons` VALUES ('4', 'SystemInfo', '系统环境信息', '用于显示一些服务器的信息', '1', '{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"2\",\"display\":\"1\"}', 'thinkphp', '0.1', '1379512036', '0');
INSERT INTO `onethink_addons` VALUES ('5', 'Editor', '前台编辑器', '用于增强整站长文本的输入和显示', '1', '{\"editor_type\":\"2\",\"editor_wysiwyg\":\"1\",\"editor_height\":\"300px\",\"editor_resize_type\":\"1\"}', 'thinkphp', '0.1', '1379830910', '0');
INSERT INTO `onethink_addons` VALUES ('6', 'Attachment', '附件', '用于文档模型上传附件', '1', 'null', 'thinkphp', '0.1', '1379842319', '1');
INSERT INTO `onethink_addons` VALUES(23, 'SyncLogin', '第三方账号同步登陆', '第三方账号同步登陆', 1, '{"type":["qq","sina","tencent","renren","douban","github","google","msn","diandian","taobao","baidu","kaixin","t163","x360","sohu"],"meta":"<meta property=\\\\\\\\\\\\\\"qc:admins\\\\\\\\\\\\\\" content=\\\\\\\\\\\\\\"1450655062615230706375\\\\\\\\\\\\\\" \\/>","QQ_APP_KEY":"","QQ_APP_SECRET":"","TENCENT_APP_KEY":"","TENCENT_APP_SECRET":"","SINA_APP_KEY":"","SINA_APP_SECRET":"","T163_APP_KEY":"","T163_APP_SECRET":"","RENRENR_APP_KEY":"","RENREN_APP_SECRET":"","360_APP_KEY":"","360_APP_SECRET":"","DOUBAN_APP_KEY":"","DOUBAN_APP_SECRET":"","GITHUB_APP_KEY":"","GITHUB_APP_SECRET":"","GOOGLE_APP_KEY":"","GOOGLE_APP_SECRET":"","MSN_APP_KEY":"","MSN_APP_SECRET":"","DIANDIAN_APP_KEY":"","DIANDIAN_APP_SECRET":"","TAOBAO_APP_KEY":"","TAOBAO_APP_SECRET":"","BAIDU_APP_KEY":"","BAIDU_APP_SECRET":"","KAIXIN_APP_KEY":"","KAIXIN_APP_SECRET":"","SOHU_APP_KEY":"","SOHU_APP_SECRET":""}', 'yidian', '0.1', 1412762818, 0);


-- -----------------------------
-- Table structure for `onethink_attachment`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_attachment`;
CREATE TABLE `onethink_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '附件显示名',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件类型',
  `source` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '资源id',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关联记录id',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '附件大小',
  `dir` int(12) unsigned NOT NULL DEFAULT '0' COMMENT '上级目录id',
  `sort` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `idx_record_status` (`record_id`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='附件表';


-- -----------------------------
-- Table structure for `onethink_attribute`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_attribute`;
CREATE TABLE `onethink_attribute` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '字段名',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '字段注释',
  `field` varchar(100) NOT NULL DEFAULT '' COMMENT '字段定义',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '数据类型',
  `value` varchar(100) NOT NULL DEFAULT '' COMMENT '字段默认值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '参数',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模型id',
  `is_must` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否必填',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `validate_rule` varchar(255) NOT NULL DEFAULT '',
  `validate_time` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `error_info` varchar(100) NOT NULL DEFAULT '',
  `validate_type` varchar(25) NOT NULL DEFAULT '',
  `auto_rule` varchar(100) NOT NULL DEFAULT '',
  `auto_time` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `auto_type` varchar(25) NOT NULL DEFAULT '',
   PRIMARY KEY (`id`),
    KEY `model_id` (`model_id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='模型属性表';

-- -----------------------------
-- Records of `onethink_attribute`
-- -----------------------------
INSERT INTO `onethink_attribute` VALUES ('1', 'uid', '用户id', 'int(10) unsigned NOT NULL ', 'num', '0', '', '0', '', '1', '0', '1', '1384508362', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('2', 'name', '标识', 'char(40) NOT NULL ', 'string', '', '同一根节点下标识不重复', '1', '', '1', '0', '1', '1383894743', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('3', 'title', '标题', 'char(80) NOT NULL ', 'string', '', '文档标题', '1', '', '1', '0', '1', '1383894778', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('4', 'category_id', '所属分类', 'int(10) unsigned NOT NULL ', 'string', '', '', '0', '', '1', '0', '1', '1384508336', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('5', 'description', '描述', 'char(140) NOT NULL ', 'textarea', '', '', '1', '', '1', '0', '1', '1383894927', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('6', 'root', '根节点', 'int(10) unsigned NOT NULL ', 'num', '0', '该文档的顶级文档编号', '0', '', '1', '0', '1', '1384508323', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('7', 'pid', '所属id', 'int(10) unsigned NOT NULL ', 'num', '0', '父文档编号', '0', '', '1', '0', '1', '1384508543', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('8', 'model_id', '内容模型id', 'tinyint(3) unsigned NOT NULL ', 'num', '0', '该文档所对应的模型', '0', '', '1', '0', '1', '1384508350', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('9', 'type', '内容类型', 'tinyint(3) unsigned NOT NULL ', 'select', '2', '', '1', '1:目录\r\n2:主题\r\n3:段落', '1', '0', '1', '1384511157', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('10', 'position', '推荐位', 'smallint(5) unsigned NOT NULL ', 'checkbox', '0', '多个推荐则将其推荐值相加', '1', '[DOCUMENT_POSITION]', '1', '0', '1', '1383895640', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('11', 'link_id', '外链', 'int(10) unsigned NOT NULL ', 'num', '0', '0-非外链，大于0-外链ID,需要函数进行链接与编号的转换', '1', '', '1', '0', '1', '1383895757', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('12', 'cover_id', '封面', 'int(10) unsigned NOT NULL ', 'picture', '0', '0-无封面，大于0-封面图片ID，需要函数处理', '1', '', '1', '0', '1', '1384147827', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('13', 'display', '可见性', 'tinyint(3) unsigned NOT NULL ', 'radio', '1', '', '1', '0:不可见\r\n1:所有人可见', '1', '0', '1', '1386662271', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `onethink_attribute` VALUES ('14', 'deadline', '截至时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '0-永久有效', '1', '', '1', '0', '1', '1387163248', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `onethink_attribute` VALUES ('15', 'attach', '附件数量', 'tinyint(3) unsigned NOT NULL ', 'num', '0', '', '0', '', '1', '0', '1', '1387260355', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `onethink_attribute` VALUES ('16', 'view', '浏览量', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '1', '0', '1', '1383895835', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('17', 'comment', '评论数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '1', '0', '1', '1383895846', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('18', 'extend', '扩展统计字段', 'int(10) unsigned NOT NULL ', 'num', '0', '根据需求自行使用', '0', '', '1', '0', '1', '1384508264', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('19', 'level', '优先级', 'int(10) unsigned NOT NULL ', 'num', '0', '越高排序越靠前', '1', '', '1', '0', '1', '1383895894', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('20', 'create_time', '创建时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '', '1', '', '1', '0', '1', '1383895903', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('21', 'update_time', '更新时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '', '0', '', '1', '0', '1', '1384508277', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('22', 'status', '数据状态', 'tinyint(4) NOT NULL ', 'radio', '0', '', '0', '-1:删除\r\n0:禁用\r\n1:正常\r\n2:待审核\r\n3:草稿', '1', '0', '1', '1384508496', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('23', 'parse', '内容解析类型', 'tinyint(3) unsigned NOT NULL ', 'select', '0', '', '0', '0:html\r\n1:ubb\r\n2:markdown', '2', '0', '1', '1384511049', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('24', 'content', '文章内容', 'text NOT NULL ', 'editor', '', '', '1', '', '2', '0', '1', '1383896225', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('25', 'template', '详情页显示模板', 'varchar(100) NOT NULL ', 'string', '', '参照display方法参数的定义', '1', '', '2', '0', '1', '1383896190', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('26', 'bookmark', '收藏数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '2', '0', '1', '1383896103', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('27', 'parse', '内容解析类型', 'tinyint(3) unsigned NOT NULL ', 'select', '0', '', '0', '0:html\r\n1:ubb\r\n2:markdown', '3', '0', '1', '1387260461', '1383891252', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `onethink_attribute` VALUES ('28', 'content', '下载详细描述', 'text NOT NULL ', 'editor', '', '', '1', '', '3', '0', '1', '1383896438', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('29', 'template', '详情页显示模板', 'varchar(100) NOT NULL ', 'string', '', '', '1', '', '3', '0', '1', '1383896429', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('30', 'file_id', '文件ID', 'int(10) unsigned NOT NULL ', 'file', '0', '需要函数处理', '1', '', '3', '0', '1', '1383896415', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('31', 'download', '下载次数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '3', '0', '1', '1383896380', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('32', 'size', '文件大小', 'bigint(20) unsigned NOT NULL ', 'num', '0', '单位bit', '1', '', '3', '0', '1', '1383896371', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES (35, 'marketprice', '市场价', 'varchar(255) NOT NULL ', 'string', '1.00', '', 1, '', 5, 0, 1, 1411430769, 1411375944, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (36, 'content', '内容详细描述', 'text NOT NULL', 'editor', '', '', 1, '', 5, 0, 1, 1416804356, 1411376156, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (37, 'parameters', '参数名称', 'varchar(255) NOT NULL', 'string', '', '', 1, '', 5, 0, 1, 1411927788, 1411379961, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (39, 'area', '产地', 'varchar(255) NOT NULL', 'string', '中国大陆', '', 1, '', 5, 0, 1, 1411380147, 1411380147, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (50, 'ads_pic_id', '广告图片', 'int(10) UNSIGNED NOT NULL', 'picture', '', '', 1, '', 5, 0, 1, 1422886159, 1422886070, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (42, 'groupprice', '组合价格', 'varchar(255) NOT NULL', 'string', '', '产品原价', 1, '', 5, 0, 1, 1411919829, 1411919829, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (43, 'mark', '附加标签', 'varchar(255) NOT NULL', 'string', '', '1-最新上架，2-限时抢购，3-热卖商品，4-限时折扣', 1, '', 5, 0, 1, 1412016261, 1412016196, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (44, 'unionid', '关联商品', 'varchar(255) NOT NULL', 'string', '', '关联商品id,如3、9、10，顿号号隔开', 1, '', 5, 0, 1, 1422019254, 1413845084, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (47, 'shorttitle', '商品简称', 'varchar(255) NOT NULL', 'string', '', '商品简称', 1, '', 5, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (46, 'stock', '库存', 'int(10) UNSIGNED NOT NULL', 'num', '10', '商品库存数量', 1, '', 5, 0, 1, 1414669588, 1414177236, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (49, 'pics', '图集', 'varchar(255) NOT NULL', 'pictures', '', '', 1, '', 1, 0, 1, 1421992389, 1415713073, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (51, 'price', '价格', 'decimal(50,2) NOT NULL', 'string', '0', '零售价格', 1, '', 1, 0, 1, 1424703104, 1424703104, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (52, 'tuan_price', '团购价格', 'decimal(50,2) NOT NULL', 'string', '0', '', 1, '', 1, 0, 1, 1424703276, 1424703276, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (53, 'qg_price', '抢购价格', 'decimal(50,2) NOT NULL', 'string', '0', '', 1, '', 1, 0, 1, 1424703329, 1424703329, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (54, 'ms_price', '秒杀价格', 'decimal(50,2) NOT NULL', 'string', '0', '', 1, '', 1, 0, 1, 1424703516, 1424703516, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (55, 'brand', '品牌', 'varchar(255) NOT NULL', 'string', '', '', 1, '', 1, 0, 1, 1424703571, 1424703571, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (56, 'sale', '销量', 'int(10) UNSIGNED NOT NULL', 'num', '', '', 1, '', 1, 0, 1, 1424703603, 1424703603, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (58, 'percent', '购买率', 'varchar(255) NOT NULL', 'string', '', '商品购买率', 1, '', 5, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (59, 'system', '操作系统', 'varchar(255) NOT NULL', 'string', '', '手机操作系统', 1, '', 6, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (60, 'content', '内容', 'varchar(255) NOT NULL', 'editor', '', '内容', 1, '', 6, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (61, 'nettype', '网络制式', 'varchar(255) NOT NULL', 'string', '', '手机网络制式', 1, '', 6, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (62, 'screen', '屏幕尺寸', 'varchar(255) NOT NULL', 'string', '', '手机屏幕尺寸', 1, '', 6, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (63, 'ram', 'RAM容量', 'varchar(255) NOT NULL', 'string', '', 'RAM容量', 1, '', 6, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (64, 'rom', 'ROM容量', 'varchar(255) NOT NULL', 'string', '', 'ROM容量', 1, '', 6, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (65, 'cpu_type', 'cpu型号', 'varchar(255) NOT NULL', 'string', '', 'cpu型号', 1, '', 6, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (66, 'cpu_frequency', 'cpu频率', 'varchar(255) NOT NULL', 'string', '', 'cpu频率', 1, '', 6, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (67, 'battery_type', '电池类型', 'varchar(255) NOT NULL', 'string', '', '电池类型', 1, '', 6, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (68, 'battery_capacity', '电池容量', 'varchar(255) NOT NULL', 'string', '', '电池容量', 1, '',6, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (69, 'stand_by_time', '待机时间', 'varchar(255) NOT NULL', 'string', '', '待机时间', 1, '', 6, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (70, 'holding_time', '通话时间', 'varchar(255) NOT NULL', 'string', '', '手机屏幕尺寸', 1, '',6, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (71, 'phoneweight', '手机重量', 'varchar(255) NOT NULL', 'string', '', '手机重量', 1, '',6, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (72, 'sdcard', 'sd卡扩展容量', 'varchar(255) NOT NULL', 'string', '', 'sd卡扩展容量', 1, '', 6, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (73, 'character', '功能特点', 'varchar(255) NOT NULL', 'string', '', '功能特点', 1, '', 6, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (74, 'battery_type', '电池类型', 'varchar(255) NOT NULL', 'string', '', '电池类型', 1, '', 6, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (75, 'camera_before', '前置摄像头像素', 'varchar(255) NOT NULL', 'string', '', '摄像头类型', 1, '',6 , 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (76, 'camera_after', '后置摄像头像素', 'varchar(255) NOT NULL', 'string', '', '后置摄像头像素', 1, '', 6, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (77, 'sensor_type', '传感器类型', 'varchar(255) NOT NULL', 'string', '', '传感器类型', 1, '',6, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (78, 'flashlight', '闪光灯', 'varchar(255) NOT NULL', 'string', '', '闪光灯', 1, '',6, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (79, 'apeture', '光圈', 'varchar(255) NOT NULL', 'string', '', '光圈', 1, '', 6, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (80, 'color', '颜色', 'varchar(255) NOT NULL', 'string', '', '颜色', 1, '', 6, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (81, 'launch_time', '上市时间', 'int(10) unsigned NOT NULL ', 'datetime', '', '上市时间', 1, '', 6, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (82, 'author', '作者', 'varchar(255) NOT NULL', 'string', '', '作者', 1, '',7, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (83, 'publish_time', '出版时间','int(10) unsigned NOT NULL ', 'datetime', '', '出版时间', 1, '',7, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (84, 'isbn', 'ISBN', 'varchar(255) NOT NULL', 'string', '', 'ISBN', 1, '', 7, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (85, 'pages', '页数', 'varchar(255) NOT NULL', 'string', '', '页数', 1, '',7, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (86, 'formats', '开本', 'varchar(255) NOT NULL', 'string', '', '开本', 1, '', 7, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (87, 'length', '字数', 'varchar(255) NOT NULL', 'string', '', '字数', 1, '', 7, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (88, 'paper', '纸张', 'varchar(255) NOT NULL', 'string', '', '纸张', 1, '', 7, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (89, 'package', '包装', 'varchar(255) NOT NULL', 'string', '', '字数', 1, '', 7, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (90, 'press_time', '印刷时间','int(10) unsigned NOT NULL ', 'datetime', '', '印刷时间', 1, '', 7, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (91, 'press_number', '印刷次数', 'varchar(255) NOT NULL', 'string', '', '印刷次数', 1, '', 7, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (92, 'edition_number', '版次', 'varchar(255) NOT NULL', 'string', '', '版次', 1, '', 7, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES ('93', 'content', '内容', 'text NOT NULL ', 'editor', '', '', '1', '', '7', '0', '1', '1383896225', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES (94, 'color', '颜色', 'varchar(255) NOT NULL', 'string', '', '颜色', 1, '', 8, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (95, 'size', '型号', 'varchar(255) NOT NULL', 'string', '', '型号', 1, '', 8, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (96, 'content', '内容', 'varchar(255) NOT NULL', 'editor', '', '内容', 1, '',8, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (97, 'c_type', '类型', 'varchar(255) NOT NULL', 'string', '', '服装类型', 1, '',8, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (98, 'style', '款式', 'varchar(255) NOT NULL', 'string', '', '服装风格', 1, '',8, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (99, 'material', '服装材质', 'varchar(255) NOT NULL', 'string', '', '服装材质', 1, '',8, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (100, 'season', '季节性', 'varchar(255) NOT NULL', 'string', '', '季节性', 1, '',8, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (101, 'publisher', '出版社', 'varchar(255) NOT NULL', 'string', '', '出版社', 1, '', 7, 0, 1, 1414329390, 1414329390, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (102, 'parameters_value', '参数值', 'varchar(255) NOT NULL', 'string', '1', '', 1, '', 5, 0, 1, 1411927788, 1411379961, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (103, 'parameters', '参数名称', 'varchar(255) NOT NULL', 'string', '', '', 1, '', 6, 0, 1, 1411927788, 1411379961, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (104, 'parameters_value', '参数值', 'varchar(255) NOT NULL', 'string', '', '', 1, '', 6, 0, 1, 1411927788, 1411379961, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (105, 'groupprice', '组合价格', 'varchar(255) NOT NULL', 'string', '', '', 1, '', 6, 0, 1, 1411927788, 1411379961, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (106, 'parameters', '参数名称', 'varchar(255) NOT NULL', 'string', '', '', 1, '', 7, 0, 1, 1411927788, 1411379961, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (107, 'parameters_value', '参数值', 'varchar(255) NOT NULL', 'string', '', '', 1, '', 7, 0, 1, 1411927788, 1411379961, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (108, 'groupprice', '组合价格', 'varchar(255) NOT NULL', 'string', '', '', 1, '', 7, 0, 1, 1411927788, 1411379961, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (109, 'parameters', '参数名称', 'varchar(255) NOT NULL', 'string', '', '', 1, '', 8, 0, 1, 1411927788, 1411379961, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (110, 'parameters_value', '参数值', 'varchar(255) NOT NULL', 'string', '', '', 1, '', 8, 0, 1, 1411927788, 1411379961, '', 3, '', 'regex', '', 3, 'function');
INSERT INTO `onethink_attribute` VALUES (111, 'groupprice', '组合价格', 'varchar(255) NOT NULL', 'string', '', '', 1, '', 8, 0, 1, 1411927788, 1411379961, '', 3, '', 'regex', '', 3, 'function');


-- -----------------------------
-- Table structure for `onethink_document_clothe`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_document_clothe`;
CREATE TABLE `onethink_document_clothe` (
    `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `color` varchar(255) NOT NULL DEFAULT '1' COMMENT '颜色',
    `content` text NOT NULL COMMENT '内容详细描述',
    `size`  varchar(255) NOT NULL DEFAULT '' COMMENT '型号', 
    `c_type`  varchar(255) NOT NULL DEFAULT '' COMMENT '服装类型', 
    `style`  varchar(255) NOT NULL DEFAULT '' COMMENT '款式', 
    `material`  varchar(255) NOT NULL DEFAULT '' COMMENT '材质', 
    `season`  varchar(255) NOT NULL DEFAULT '' COMMENT '适应季节',
     `parameters` varchar(255) NOT NULL DEFAULT '500' COMMENT '参数名称',
    `parameters_value` varchar(255) NOT NULL   DEFAULT '1'COMMENT '参数值',
     `groupprice` varchar(255) NOT NULL DEFAULT '0'COMMENT '颜色',
     `pics` varchar(255) NOT NULL DEFAULT '0'COMMENT '图集',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='服装鞋包模型表';


-- -----------------------------
-- Records of `onethink_document_clothe`
-- -----------------------------
INSERT INTO `onethink_document_clothe` VALUES(50, '白色、橙色、灰色', '<img src="http://img03.taobaocdn.com/imgextra/i3/2074479045/TB2DYbLXVXXXXc2XXXXXXXXXXXX-2074479045.jpg" align="absmiddle" /><img src="http://img04.taobaocdn.com/imgextra/i4/2074479045/TB2OdfOXVXXXXa4XXXXXXXXXXXX-2074479045.jpg" align="absmiddle" />', 'x、xl、xxl', '夹克', '', '', '', '', '', '349、455、588', 0);
INSERT INTO `onethink_document_clothe` VALUES(51, '白色、橙色、灰色、褐色、黑色、蓝色', '<table id="__01" class="ke-zeroborder" border="0" cellpadding="0" cellspacing="0" height="2340" width="780">\r\n	<tbody>\r\n		<tr>\r\n			<td>\r\n				<a target="_blank" href="http://shop.dangdang.com/store_clothes.php?sid=3937"><img src="http://img56.ddimg.cn/39370005153357_y.jpg" border="0" height="293" width="780" /></a> \r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				<img src="http://img53.ddimg.cn/39370005153359_y.jpg" border="0" height="138" width="780" /> \r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				<img src="http://img57.ddimg.cn/39370005153360_y.jpg" border="0" height="374" width="780" /> \r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>', 'm、l、xl', '西装', '', '', '', '', '', '', 0);
INSERT INTO `onethink_document_clothe` VALUES(52, '白色、灰色', '<a target="_blank" href="http://promo.dangdang.com/subject.php?pm_id=1369460"><img id="n1" src="http://img02.taobaocdn.com/imgextra/i2/130974249/TB2T_dPcpXXXXbLXXXXXXXXXXXX_%21%21130974249.jpg" border="0" height="376" width="790" /></a>', 'm、l、xl', '', '', '', '', '', '', '299、405、668', 0);
INSERT INTO `onethink_document_clothe` VALUES(53, '白色、橙色、灰色、褐色、黑色、蓝色', '<table id="__01" class="ke-zeroborder" border="0" cellpadding="0" cellspacing="0" height="1640" width="990">\r\n	<tbody>\r\n		<tr>\r\n			<td colspan="4">\r\n				<a href="http://shop.dangdang.com/16475" target="_blank"><img src="http://img51.ddimg.cn/164750004734528_y.jpg" height="381" width="990" /></a> \r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td colspan="4">\r\n				<img src="http://img55.ddimg.cn/164750004734541_y.jpg" height="62" width="990" /> \r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td>\r\n				<a href="http://v.dangdang.com/pn16475_2836_77.html" target="_blank"><img src="http://img50.ddimg.cn/164750004598644_y.jpg" height="322" width="251" /></a> \r\n			</td>\r\n			<td>\r\n				<a href="http://v.dangdang.com/pn16475_2838_77.html" target="_blank"><img src="http://img58.ddimg.cn/164750004572218_y.jpg" height="322" width="245" /></a> \r\n			</td>\r\n			<td>\r\n				<a href="http://v.dangdang.com/pn16475_2837_77.html" target="_blank"><img src="http://img52.ddimg.cn/164750004572219_y.jpg" height="322" width="246" /></a> \r\n			</td>\r\n			<td>\r\n				<a href="http://v.dangdang.com/pn16475_2839_77.html" target="_blank"><img src="http://img57.ddimg.cn/164750004572220_y.jpg" height="322" width="248" /></a> \r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td colspan="4">\r\n				<img src="http://img54.ddimg.cn/164750004614923_y.jpg" height="80" width="990" /> \r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td colspan="4">\r\n				<img src="http://img58.ddimg.cn/164750004588316_y.jpg" height="722" width="990" /> \r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>', 'x、xl、xxl', '', '', '', '', '', '', '', 0);



-- -----------------------------
-- Table structure for `onethink_document_book`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_document_book`;
CREATE TABLE `onethink_document_book` (
    `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `author` varchar(255) NOT NULL DEFAULT '1' COMMENT '作者',
    `content` text NOT NULL COMMENT '内容详细描述',
    `publisher`  varchar(255) NOT NULL DEFAULT '' COMMENT '出版社',
    `publish_time` int(10) unsigned NOT NULL DEFAULT '0'  COMMENT '出版时间',
    `isbn` varchar(255) NOT NULL DEFAULT '' COMMENT 'isbn',
    `pages` varchar(255) NOT NULL DEFAULT '' COMMENT '页数',
    `formats` varchar(255) NOT NULL DEFAULT '' COMMENT '开本',
    `length` varchar(255) NOT NULL DEFAULT '' COMMENT '字数',
    `paper` varchar(255) NOT NULL DEFAULT '' COMMENT '纸张',
    `package` varchar(255) NOT NULL DEFAULT '' COMMENT '包装',
    `press_time` int(10) unsigned NOT NULL DEFAULT '0'  COMMENT '印刷时间',
    `press_number` varchar(255) NOT NULL DEFAULT '' COMMENT '印刷次数',
    `edition_number` varchar(255) NOT NULL DEFAULT '' COMMENT '版次',
     `parameters` varchar(255) NOT NULL DEFAULT '500' COMMENT '参数名称',
    `parameters_value` varchar(255) NOT NULL   DEFAULT '1' COMMENT '参数值',
     `groupprice` varchar(255) NOT NULL DEFAULT '0' COMMENT '颜色',
     `pics` varchar(255) NOT NULL DEFAULT '0'COMMENT '图集',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='图书模型表';


-- -----------------------------
-- Records of `onethink_document_book`
-- -----------------------------
INSERT INTO `onethink_document_book` VALUES(46, '  台湾亲亲文化事业有限公司　', '<p>\r\n	　★华文幼儿科普第一品牌，台湾少儿科普最具魅力原创作品，一套集合生态学家、科学家、儿童文学家、教育学者、绘图画家和资深童书编辑的之力打造的大型科普巨制，深受数代人喜爱的自然宝典；版权输出到美国、英国、德国、瑞士、加拿大、韩国等十多个国家和地区。<br />\r\n<br />\r\n　　★既是自然图画书，也是主题教材；既有自然科学，也有人文与艺术；既用镜头说故事，也用美学造品位；既用创意带活动，更用爱心来教育；既是平面学习媒介，更是立体学习资源。被台湾众多的幼儿园作为教材使用。<br />\r\n<br />\r\n　　★曾获奖项与推荐：<br />\r\n　　※四次荣获台湾出版最高奖——金鼎奖；\r\n</p>\r\n<p>\r\n	五次获得金鼎奖推荐奖；<br />\r\n　　※台湾地区行政主管部门"中小学优良课外读物推荐奖"；<br />\r\n　　※两次获得"小太阳"最佳科学类出版奖、最佳编辑奖；<br />\r\n　　※先后36次获得"好书大家读"好书推荐奖；<br />\r\n　　※台北市政府优良杂志奖；<br />\r\n　　※中国时报开卷版最佳童书；<br />\r\n　　※中国时报《双周好书》活动推荐好书；<br />\r\n　　※信谊基金会幼儿推荐好书奖。\r\n</p>\r\n<br />', '  福建少年儿童出版社', 1398902400, '23463222', '', '', '', '', '', 0, '', '', '', '', '', 0);



-- -----------------------------
-- Table structure for `onethink_document_phone`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_document_phone`;
CREATE TABLE `onethink_document_phone` (
    `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `system` varchar(255) NOT NULL DEFAULT '1' COMMENT '操作系统',
    `content` text NOT NULL COMMENT '内容详细描述',
    `nettype`  varchar(255) NOT NULL DEFAULT '' COMMENT '网络制式',
   `screen` varchar(255) NOT NULL DEFAULT '' COMMENT '屏幕尺寸',
    `ram` varchar(255) NOT NULL DEFAULT '' COMMENT 'RAM容量',
    `rom` varchar(255) NOT NULL DEFAULT '' COMMENT 'ROM容量',
    `cpu_type` varchar(255) NOT NULL DEFAULT '' COMMENT 'cpu型号',
    `cpu_frequency` varchar(255) NOT NULL DEFAULT '' COMMENT 'cpu频率',
    `battery_type` varchar(255) NOT NULL DEFAULT '' COMMENT '电池类型',
    `battery_capacity` varchar(255) NOT NULL DEFAULT '' COMMENT '电池容量',
    `stand_by_time` varchar(255) NOT NULL DEFAULT '' COMMENT '待机时间',
    `holding_time` varchar(255) NOT NULL DEFAULT '' COMMENT '通话时间',
    `phoneweight` varchar(255) NOT NULL DEFAULT '' COMMENT '手机重量',
    `sdcard` varchar(255) NOT NULL DEFAULT '' COMMENT '扩展容量',
    `character` varchar(255) NOT NULL DEFAULT '0'COMMENT '功能特点',
    `camera_type` varchar(255) NOT NULL DEFAULT '' COMMENT '摄像头类型',
    `camera_before` varchar(255) NOT NULL DEFAULT '' COMMENT '前置摄像头像素',
    `camera_after` varchar(255) NOT NULL DEFAULT '' COMMENT '后置摄像头像素',
    `sensor_type` varchar(255) NOT NULL DEFAULT '' COMMENT '传感器类型',
    `flashlight` varchar(255) NOT NULL DEFAULT '0'COMMENT '闪光灯',
    `apeture` varchar(255) NOT NULL DEFAULT '0'COMMENT '光圈',
    `color` varchar(255) NOT NULL DEFAULT '0'COMMENT '颜色',
   `launch_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上市时间',
    `parameters` varchar(255) NOT NULL DEFAULT '500' COMMENT '参数名称',
    `parameters_value` varchar(255) NOT NULL   DEFAULT '1'COMMENT '参数值',
    `groupprice` varchar(255) NOT NULL DEFAULT '0'COMMENT '颜色',
     `pics` varchar(255) NOT NULL DEFAULT '0'COMMENT '图集',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='手机模型表';


-- -----------------------------
-- Records of `onethink_document_phone`
-- -----------------------------
INSERT INTO `onethink_document_phone` VALUES(48, '', '<p style="text-align:center;">\r\n	<span style="font-size:8pt;">官方标配：机头×1充电头×1USB数据线×1快速入门指南×1售后服务手册×1手机真伪鉴别提示卡×1标准配件清单 × 1</span> \r\n</p>\r\n<p style="text-align:center;">\r\n	<span style="color:#FF0000;font-size:8pt;">温馨提示：本商品同一ID仅限一件。同一ID,同一收货地址多次下单，本店拒绝发货，谢谢理解！！<br />\r\n</span> \r\n</p>\r\n<p style="text-align:center;">\r\n	<img src="http://g-ec4.images-amazon.com/images/G/28/aplus_rbs/C6587-20140307-816-01.jpg" /> \r\n</p>', ' 移动2G/联通2G（GSM） 　移动4G（TD-LTE ）', '5.5寸', '1.5G', '8G', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '白色、橙色、灰色', 1391443200, '套餐', '套餐1、套餐2、套餐3', '999、1555、2588', 91);
INSERT INTO `onethink_document_phone` VALUES(49, '', '1231<br />', '', '', '', '', '', '', '', '', '', '', '', '', '',  '', '', '', '', '', '', '', 0, '', '', '', 0);
INSERT INTO `onethink_document_phone` VALUES(54, 'ios', '<div class="right_title1">\r\n	精美图片\r\n</div>\r\n<img src="http://img30.ddimg.cn/imgother/201410/14_0/20141014114113700.jpg" />', '', '5.5寸', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, '尺寸', '4.7寸、5.5寸', '4999、5555', 98);
INSERT INTO `onethink_document_phone` VALUES(55, 'Android（安卓）', '<img src="http://img58.ddimg.cn/47700005016349_y.jpg" height="580" width="960" /> \r\n<div class="right_title1">\r\n	详情\r\n</div>\r\n<p>\r\n	<span style="font-size:18pt;">官方标配配&nbsp;：主机，原装电池(2300毫安），充电头，数据线，保修</span> \r\n</p>\r\n<p>\r\n	<span style="font-size:18pt;"><br />\r\n</span> \r\n</p>\r\n<p>\r\n	<span style="font-size:18pt;">卡，说明书，包装盒</span> \r\n</p>\r\n<p>\r\n	<span style="font-size:18pt;"><br />\r\n</span> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<img src="http://d6.yihaodianimg.com/N00/M08/21/8C/CgQCtlKwKbmADZHQAAD3RbkMurg28700.jpg" class="blogimg" />', '移动2G/联通2G（GSM） 　移动3G（TD-SCDMA） ', '5.5寸', '1.5G', '4G', '', '', '', '', '', '', '', '', '', 0, '', '', '', '', '', '白色、橙色、灰色', 0, '套餐', '套餐1、套餐2、套餐3、套餐4、套餐5、套餐6', '535、555、588、999、1555、2588', 100);
INSERT INTO `onethink_document_phone` VALUES(56, 'Android（安卓）', '<img src="http://img10.360buyimg.com/imgzone/jfs/t460/14/1270028622/223817/709c7af0/54c5fb12N3f339a07.jpg" /><br />', '移动2G/联通2G（GSM） 　移动4G（TD-LTE ） 　移动3G（TD-SCDMA） 　', '5.0英寸及以上', '2G', '2G', '', '八核及以上CPU', '', '', '', '', '', '', '', '', '', '', '', '', '', '白色、香槟金', 0, '', '', '', 102);
INSERT INTO `onethink_document_phone` VALUES(57, '', '<div style="text-align:left;">\r\n	<span style="font-size:14pt;color:#ff0000;">官方标配：魅蓝note手机主机×1USB数据线×1电源适配器×1SIM卡顶针×1保修证×1<br />\r\n套餐一：官方标配 <span>高品质国产耳机</span><br />\r\n套餐二：<span>官方标配 <span>8000毫安移动电源</span></span><br />\r\n套餐三：<span>官方标配 </span><span>8000毫安移动电源<span> </span><span>高品质国产耳机</span></span></span> \r\n</div>\r\n<div style="text-align:left;">\r\n	<img src="http://img20.360buyimg.com/vc/jfs/t703/232/243175747/103516/a83eb7da/54991544N8477779f.jpg" /> \r\n</div>\r\n<div>\r\n	<img src="http://img20.360buyimg.com/vc/jfs/t469/190/898061167/79910/f24f3b41/54991549N49df605b.jpg" /> \r\n</div>', '', '', '', '', '', '', '不可拆卸', '3140毫安', '', '', '', '', '', '', '1300w', '1300w', '', '', '', '白色、橙色、灰色、褐色、黑色、蓝色', 0, '套餐', '套餐1、套餐2、套餐3、套餐4', '935、955、988、999、1555、2588', 0);
INSERT INTO `onethink_document_phone` VALUES(58, 'Android（安卓）', '<p>\r\n	<img src="http://img52.ddimg.cn/158040004768938.jpg" /> \r\n</p>\r\n<p>\r\n	<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> \r\n</p>\r\n<img src="http://img04.taobaocdn.com/imgextra/i4/1777180618/TB2nK2EbpXXXXXPXpXXXXXXXXXX_%21%211777180618.jpg" align="absmiddle" />', '', '5.5寸', '2G', '8G', '', '', '', '', '', '', '', '', '', 0, '', '', '', '', '', '白色、橙色、灰色', 0, '套餐', '套餐1、套餐2、套餐3、套餐4、套餐5、套餐6', '535、555、588、999、1555、2588', 0);
INSERT INTO `onethink_document_phone` VALUES(59, '', '<p style="text-align:center;">\r\n	<span style="font-size:12pt;"><strong>官方标配：主机*1锂电池*1数据线*1耳机*1充电器*1SPen手写笔*1说明书*1保修卡*1</strong></span> \r\n</p>\r\n<p style="text-align:center;">\r\n	<span style="font-size:12pt;color:#ff0000;"><strong>温馨提示：本商品同一ID仅限一件。同一ID,同一收货地址多次下单，本店拒绝发货，谢谢理解！！<br />\r\n</strong></span> \r\n</p>\r\n<p style="text-align:center;">\r\n	<span style="font-size:12pt;"><strong><img src="http://img20.360buyimg.com/vc/g13/M00/16/0F/rBEhVFMHBKQIAAAAAAH-GWXi5QoAAI29AFDVMUAAf4x187.jpg" class="err-product" /><br />\r\n</strong></span> \r\n</p>\r\n<p style="text-align:center;">\r\n	<br />\r\n</p>\r\n<div class="formwork">\r\n	<div class="formwork_titleleft">\r\n		<span style="font-size:12pt;"><strong>支持TD-LTE 4G网络</strong></span> \r\n	</div>\r\n	<div class="formwork_text">\r\n		<span style="font-size:12pt;"><strong>4G疾速服务起航美好生活N9008S支持4G网络，让您畅享移动过程中的疾速联网服务。无论是在线观看高清视频，还是传送大容量文件，都会让您体验到前所未有的疾速快感。</strong></span> \r\n	</div>\r\n</div>', '移动2G/联通2G（GSM） 　移动4G（TD-LTE ） 　移动3G（TD-SCDMA）', '5.0英寸及以上', '3G', '16G', '', '', '', '', '', '', '', '', '', 0, '', '', '', '', '', '白色、橙色、灰色', 0, '套餐', '套餐1、套餐2、套餐3、套餐4', '935、955、988、999', 0);
INSERT INTO `onethink_document_phone` VALUES(68, '', '<div>\r\n	<img alt="" src="http://img20.360buyimg.com/vc/jfs/t430/76/3779470/125368/b2cdbe74/54058d77N2a3827fa.jpg" /> \r\n</div>\r\n<div>\r\n	<img alt="" src="http://img20.360buyimg.com/vc/jfs/t877/281/12223021/373552/ed32465/54dca505Ne8a58e5d.jpg" /> \r\n</div>\r\n<div>\r\n	<img alt="" src="http://img20.360buyimg.com/vc/jfs/t430/76/3779470/125368/b2cdbe74/54058d77N2a3827fa.jpg" /> \r\n</div>\r\n<div>\r\n	<img alt="" src="http://img20.360buyimg.com/vc/jfs/t877/281/12223021/373552/ed32465/54dca505Ne8a58e5d.jpg" /> \r\n</div>\r\n<div>\r\n	<img alt="" src="http://img20.360buyimg.com/vc/jfs/t430/76/3779470/125368/b2cdbe74/54058d77N2a3827fa.jpg" /> \r\n</div>\r\n<div>\r\n	<img alt="" src="http://img20.360buyimg.com/vc/jfs/t877/281/12223021/373552/ed32465/54dca505Ne8a58e5d.jpg" /> \r\n</div>\r\n<div>\r\n	<img alt="" src="http://img20.360buyimg.com/vc/jfs/t430/76/3779470/125368/b2cdbe74/54058d77N2a3827fa.jpg" /> \r\n</div>\r\n<div>\r\n	<img alt="" src="http://img20.360buyimg.com/vc/jfs/t877/281/12223021/373552/ed32465/54dca505Ne8a58e5d.jpg" /> \r\n</div>', '', '5.5寸', '', '16G', '', '八核及以上CPU', '', '', '', '', '', '', '',  '', '', '', '', '', '', '白色、橙色、灰色', 0, '选择版本', '32GROM、16GROM、双4G版(16GROM）', '2268.00、29299、22296、29229', 0);


-- -----------------------------
-- Table structure for `onethink_document`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_document`;
CREATE TABLE `onethink_document` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `name` char(40) NOT NULL DEFAULT '' COMMENT '标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '标题',
  `category_id` int(10) unsigned NOT NULL COMMENT '所属分类',
  `description` char(140) NOT NULL DEFAULT '' COMMENT '描述',
  `root` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '根节点',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属ID',
  `model_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容模型ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '2' COMMENT '内容类型',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '推荐位',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `cover_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '封面',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '可见性',
  `deadline` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '截至时间',
  `attach` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件数量',
  `view` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `comment` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '扩展统计字段',
  `level` int(10) NOT NULL DEFAULT '0' COMMENT '优先级',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `price` decimal(50,2) NOT NULL DEFAULT '0',
  `tuan_price` decimal(50,2) NOT NULL DEFAULT '0' COMMENT '团购价格',
  `qg_price` decimal(50,2) NOT NULL DEFAULT '0' COMMENT '抢购价格',
  `ms_price` decimal(50,2) NOT NULL DEFAULT '0' COMMENT '秒杀价格',
  `brand` varchar(225) NOT NULL DEFAULT '' COMMENT '品牌',
  `sale` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '销量',
  `percent` varchar(100) NOT NULL DEFAULT '' COMMENT '购买率',
  PRIMARY KEY (`id`),
  KEY `idx_category_status` (`category_id`,`status`) USING BTREE,
  KEY `idx_status_type_pid` (`status`,`uid`,`pid`) USING BTREE 
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COMMENT='文档模型基础表';

-- -----------------------------
-- Records of `onethink_document`
-- -----------------------------
INSERT INTO `onethink_document` VALUES(5, 1, '', '金灯果（又名“姑娘果”）（盒装1000g）', 57, '', 0, 0, 5, 2, 4, 0, 15, 1, 0, 0, 1959, 0, 0, 0, 1411380420, 1428781408, 1, 16.00, 45.00, 162.00, 14.00, '', 0, '');
INSERT INTO `onethink_document` VALUES(8, 2, '', '【天天果园】智利青苹果12个', 57, '酸爽多汁，肉质细嫩，高品质新鲜保证', 0, 0, 5, 2, 2, 0, 7, 1, 0, 0, 935, 0, 0, 0, 1411927620, 1428781387, 1, 15.00, 45.00, 152.00, 12.00, '', 0, '');
INSERT INTO `onethink_document` VALUES(9, 2, '', '常鲜生 正宗菲律宾进口香蕉', 57, '', 0, 0, 5, 2, 4, 0, 9, 1, 0, 0, 441, 0, 0, 0, 1411928400, 1414533394, 1, 15.80, 172.00, 21.00, 182.00, '21', 0, '');
INSERT INTO `onethink_document` VALUES(14, 2, '', '褚橙开售', 57, '', 0, 0, 5, 2, 4, 0, 17, 1, 0, 0, 247, 0, 0, 0, 1414339080, 1414343243, 1, 15.00, 45.00, 122.00, 142.00, '', 0, '');
INSERT INTO `onethink_document` VALUES(15, 2, '', '河南河阴软籽石榴（中果） 4粒装（单果重250-300g）', 57, '', 0, 0, 5, 2, 0, 0, 20, 1, 0, 0, 177, 0, 0, 0, 1414342440, 1428781367, 1, 15.00, 645.00, 126.00, 12.00, '', 0, '');
INSERT INTO `onethink_document` VALUES(16, 2, '', '佳沃智利进口蓝莓一级果125g', 57, '', 0, 0, 5, 2, 0, 0, 21, 1, 0, 0, 300, 0, 0, 0, 1414342560, 1428781347, 1, 155.50, 145.00, 142.00, 12.00, '', 0, '');
INSERT INTO `onethink_document` VALUES(17, 2, '', '新疆红提950-1000g', 57, '', 0, 0, 5, 2, 0, 0, 24, 1, 0, 0, 534, 0, 0, 0, 1414342620, 1428781312, 1, 12.00, 35.00, 122.00, 12.00, '', 0, '');
INSERT INTO `onethink_document` VALUES(18, 2, '', '新疆库尔勒香梨 950g-1000g 香而清甜，虽小却好吃', 57, '', 0, 0, 5, 2, 0, 0, 23, 1, 0, 0, 422, 0, 0, 0, 1414342680, 1428781323, 1, 12.00, 45.00, 12.00, 12.00, '', 0, '');
INSERT INTO `onethink_document` VALUES(33, 2, '', '新疆阿克苏冰糖心苹果 3粒装', 128, '', 0, 0, 5, 2, 0, 0, 64, 1, 0, 0, 9, 0, 0, 0, 1421504275, 1421504275, 1, 16.60, 22.00, 182.00, 142.00, '', 0, '');
INSERT INTO `onethink_document` VALUES(32, 2, '', '延安宜川红富士 12粒装（70-75mm）', 128, '', 0, 0, 5, 2, 0, 0, 63, 1, 0, 0, 13, 0, 0, 0, 1421504074, 1421504074, 1, 12.00, 415.00, 142.00, 12.00, '', 0, '');
INSERT INTO `onethink_document` VALUES(34, 2, '', '新疆阿克苏冰糖心苹果 3粒装', 128, '', 0, 0, 5, 2, 0, 0, 64, 1, 0, 0, 13, 0, 0, 0, 1421504278, 1421504278, 1, 15.00, 45.00, 12.00, 12.00, '', 0, '');
INSERT INTO `onethink_document` VALUES(35, 2, '', '延安宜川红富士 12粒优品装（80mm）', 128, '', 0, 0, 5, 2, 0, 0, 65, 1, 0, 0, 13, 0, 0, 0, 1421504400, 1421504499, 1, 13.60, 65.00, 12.00, 12.00, '', 0, '');
INSERT INTO `onethink_document` VALUES(42, 1, '', '山东栖霞富士 2粒/470-500g', 126, '', 0, 0, 5, 2, 0, 0, 66, 1, 0, 0, 336, 0, 0, 0, 1421504820, 1428768653, 1, 8.00, 85.00, 212.00, 12.00, '', 0, '');
INSERT INTO `onethink_document` VALUES(43, 1, '', '浙江涌泉蜜桔 1.7-1.9kg', 128, '', 0, 0, 5, 2, 0, 0, 67, 1, 0, 0, 13, 0, 0, 0, 1421505175, 1421505175, 1, 9.30, 95.00, 120.00, 12.00, '', 0, '');
INSERT INTO `onethink_document` VALUES(44, 1, '', '广西金桔 500-550g', 128, '', 0, 0, 5, 2, 0, 0, 68, 1, 0, 0, 12, 0, 0, 0, 1421505360, 1421505438, 1, 22.00, 75.00, 12.00, 102.00, '', 0, '');
INSERT INTO `onethink_document` VALUES(46, 1, '', '亲亲自然（第1-4辑合集，共40册，国际化的华文幼儿科普品牌，为3-10岁孩子量身订做的自然教育专书，', 86, '', 0, 0, 7, 2, 0, 0, 89, 1, 0, 0, 53, 0, 0, 0, 1428674340, 1428674609, 1, 50.00, 0, 45.00, 54.00, '',  0, '');
INSERT INTO `onethink_document` VALUES(47, 1, '', '456', 116, '', 0, 0, 8, 2, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1428674807, 1428674807, -1, 0.00, 0, 0.00, 0.00, '',  0, '');
INSERT INTO `onethink_document` VALUES(48, 1, '', 'HTC Desire 816T 移动4G手机 新渴望8 816t 安卓智能手机未拆封 正品行货 送：贴膜+手机套', 110, '', 0, 0, 6, 2, 0, 0, 91, 1, 0, 0, 54, 0, 0, 0, 1428674880, 1428687262, 1, 10010.00, 0, 0.00, 0.00, 'htc',  0, '');
INSERT INTO `onethink_document` VALUES(49, 1, '', '0', 110, '', 0, 0, 6, 2, 0, 0, 0, 1, 0, 0, 7, 0, 0, 0, 1428679490, 1428679490, -1, 0.00, 0, 0.00, 0.00, '',  0, '');
INSERT INTO `onethink_document` VALUES(50, 1, '', 'lee限量款125周年101+男士牛仔夹克2015男士新款牛仔外套李牌男装正品 L12528C76G68', 115, '', 0, 0, 8, 2, 0, 0, 92, 1, 0, 0, 18, 0, 0, 0, 1428680400, 1428682597, 1, 349.00, 0, 0.00, 0.00, 'LEE',  0, '');
INSERT INTO `onethink_document` VALUES(51, 1, '', 'Lesmart 男士西装 条纹印花双扣休闲西服 修身西装', 115, '', 0, 0, 8, 2, 0, 0, 95, 1, 0, 0, 20, 0, 0, 0, 1428698940, 1428781171, 1, 1999.00, 0, 0.00, 0.00, 'Lesmart',  0, '');
INSERT INTO `onethink_document` VALUES(52, 1, '', '茵曼女装 夏装新款棉质撞色圆点欧根纱高腰连衣裙【8421020232】可支持货到付款', 117, '', 0, 0, 8, 2, 0, 0, 96, 1, 0, 0, 41, 0, 0, 0, 1428699324, 1428699324, 1, 269.00, 0, 0.00, 0.00, '',  0, '');
INSERT INTO `onethink_document` VALUES(53, 1, '', '拉夏贝尔 夏款女装 个性垂荡领两件套纯色无袖衬衫 女 10005615', 117, '', 0, 0, 8, 2, 0, 0, 97, 1, 0, 0, 90, 0, 0, 0, 1428699660, 1428781209, 1, 100.00, 0, 0.00, 0.00, '',  0, '');
INSERT INTO `onethink_document` VALUES(54, 1, '', '苹果iPhone6 16G(金色) A1586公开版(MG492CH/A)', 110, '', 0, 0, 6, 2, 0, 0, 98, 1, 0, 0, 33, 0, 0, 0, 1428700320, 1428700496, 1, 5946.00, 0, 0.00, 0.00, '苹果',  0, '');
INSERT INTO `onethink_document` VALUES(55, 1, '', '【未拆封 送贴膜】华为 荣耀3C移动版 荣耀3C联通版 荣耀3C电信版 荣耀3C畅玩版（白色）3G手机 4G手机 2G RAM版', 110, '', 0, 0, 6, 2, 0, 0, 99, 1, 0, 0, 32, 0, 0, 0, 1428700740, 1428700986, 1, 575.00, 0, 0.00, 0.00, '华为',  0, '');
INSERT INTO `onethink_document` VALUES(56, 1, '', 'vivo X5Max移动4G手机 高通64位8核处理器 Hi-Fi音质', 110, '', 0, 0, 6, 2, 0, 0, 101, 1, 0, 0, 30, 0, 0, 0, 1428701270, 1428701270, 1, 2968.00, 0, 0.00, 0.00, 'vivo ',  0, '');
INSERT INTO `onethink_document` VALUES(57, 1, '', '【原封送高清贴膜 硅胶套】魅族（MEIZU）魅蓝note 4G手机 电信版 移动版 联通版 双卡双待 5.5寸高清屏 64位真八核处理器', 110, '', 0, 0, 6, 2, 0, 0, 103, 1, 0, 0, 57, 0, 0, 0, 1428701640, 1428701741, 1, 999.00, 0, 0.00, 0.00, 'MEIZU',  0, '');
INSERT INTO `onethink_document` VALUES(58, 1, '', '〖原封包邮〗华为 荣耀 4X 移动 联通 电信 全网通 金 双卡双待双通 高配 低配 5.5寸 8核 1300万 500万', 110, '', 0, 0, 6, 2, 0, 0, 91, 1, 0, 0, 84, 0, 0, 0, 1428701940, 1428773910, 1, 955.00, 0, 0.00, 0.00, '华为',  0, '');
INSERT INTO `onethink_document` VALUES(59, 1, '', '三星(Samsung)N9008S Note3 移动4G手机 TD-LTE N9008s公开版', 110, '', 0, 0, 6, 2, 0, 0, 104, 1, 0, 0, 121, 0, 0, 0, 1428702420, 1428773844, 1, 2625.00, 0, 0.00, 0.00, 'Samsung',  0, '');
INSERT INTO `onethink_document` VALUES(60, 1, '', '爱国者618 双USB移动电源/充电宝10000毫安 白色', 105, '', 0, 0, 5, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1428774970, 1428774970, 3, 0.00, 0, 0.00, 0.00, '', 0, '');
INSERT INTO `onethink_document` VALUES(61, 1, '', '爱国者618 双USB移动电源/充电宝10000毫安 白色', 105, '', 0, 0, 5, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1428775004, 1428775004, 3, 0.00, 0, 0.00, 0.00, '', 0, '');
INSERT INTO `onethink_document` VALUES(63, 1, '', '爱国者618 双USB移动电源/充电宝10000毫安 白色', 105, '', 0, 0, 5, 2, 0, 0, 105, 1, 0, 0, 51, 0, 0, 0, 1428775200, 1428781563, 1, 59.00, 0, 0.00, 0.00, '', 0, '');
INSERT INTO `onethink_document` VALUES(64, 1, '', '    Masentek S30升级版 蓝牙耳机 黑色', 105, '', 0, 0, 5, 2, 0, 0, 107, 1, 0, 0, 24, 0, 0, 0, 1428775680, 1428781529, 1, 99.00, 0, 0.00, 0.00, 'MasentekS30F', 0, '');
INSERT INTO `onethink_document` VALUES(65, 1, '', '立体声双喇叭低音炮 骑士黑 空气壳 无', 105, '', 0, 0, 5, 2, 0, 0, 108, 1, 0, 0, 0, 0, 0, 0, 1428776904, 1428776904, 3, 268.00, 0, 0.00, 0.00, '', 0, '');
INSERT INTO `onethink_document` VALUES(66, 1, '', '立体声双喇叭低音炮 骑士黑 空气壳 无', 105, '', 0, 0, 5, 2, 0, 0, 108, 1, 0, 0, 48, 0, 0, 0, 1428776880, 1428781512, 1, 268.00, 0, 0.00, 0.00, '', 0, '');
INSERT INTO `onethink_document` VALUES(67, 1, '', '    联想（Lenovo）小新V2000 Bigger版 15.6英寸笔记本电脑全高清屏', 145, '', 0, 0, 5, 2, 0, 0, 109, 1, 0, 0, 75, 0, 0, 0, 1428779362, 1428779362, 1, 5999.00, 0, 0.00, 0.00, '    联想', 0, '');
INSERT INTO `onethink_document` VALUES(68, 1, '', '魅族 MX4 16GB 灰色 移动4G手机', 110, '', 0, 0, 6, 2, 0, 0, 110, 1, 0, 0, 196, 0, 0, 0, 1428780240, 1428780606, 1, 17890.00, 0, 0.00, 0.00, '魅族', '10', 0);
INSERT INTO `onethink_document` VALUES(69, 1, '', ' 尚金装 真皮沙发组合沙发多人沙发', 111, '', 0, 0, 5, 2, 0, 0, 111, 1, 0, 0, 43, 0, 0, 0, 1428813300, 1428814110, 1, 1999.00, 0, 0.00, 0.00, '组合沙发', 0, '');

-- -----------------------------
-- Table structure for `onethink_document_product`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_document_product`;
CREATE TABLE `onethink_document_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `marketprice` varchar(255) NOT NULL DEFAULT '1' COMMENT '市场价',
  `content` text NOT NULL COMMENT '内容详细描述',
  `parameters` varchar(255) NOT NULL DEFAULT '500' COMMENT '参数名称',
  `parameters_value` varchar(255) NOT NULL   DEFAULT '1'COMMENT '参数值',
  `area`  varchar(255) NOT NULL DEFAULT '中国大陆' COMMENT '产地',
  `groupprice` varchar(255) NOT NULL DEFAULT '' COMMENT '组合价格',
  `mark` varchar(255) NOT NULL DEFAULT '' COMMENT '附加标签',
  `unionid` varchar(255) NOT NULL DEFAULT '' COMMENT '关联商品',
  `stock` int(10) unsigned NOT NULL DEFAULT '9999' COMMENT '库存',
  `shorttitle` varchar(255) NOT NULL DEFAULT '' COMMENT '商品简称',
  `pics` varchar(255) NOT NULL DEFAULT ''COMMENT '图集',
  `ads_pic_id` int(10) unsigned NOT NULL DEFAULT '0'COMMENT '广告图片',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='表';

-- -----------------------------
-- Records of `onethink_document_product`
-- -----------------------------

INSERT INTO `onethink_document_product` VALUES (5, '20.98', '<p style="background:white;text-align:left;" align="left">\r\n	<br />\r\n</p>\r\n<span><span style="font-size:14.0pt;font-family:宋体;"></span></span> \r\n<p style="font-family:宋体, ''Arial Narrow'', HELVETICA;color:#333333;">\r\n	<img src="http://image1.benlailife.com/Content/images/detailsp/detailsp_tit02.gif?v=8.2.47" height="42" width="760" /> \r\n</p>\r\n<div class="detl_pic" style="text-align:center;margin:10px 0px;color:#333333;font-family:宋体, ''Arial Narrow'', HELVETICA;">\r\n	<img src="http://image3.benlailife.com/ProductNewDetailImage/0102021623C/025.jpg" style="width:700px;" /> \r\n	<div class="tal" style="text-align:left;">\r\n		&nbsp;\r\n	</div>\r\n<img src="http://image3.benlailife.com/ProductNewDetailImage/0102021623C/01p.jpg" style="width:700px;" /> \r\n	<div class="tal" style="text-align:left;">\r\n		&nbsp;\r\n	</div>\r\n<img src="http://image3.benlailife.com/ProductNewDetailImage/0102021623C/93p.jpg" style="width:700px;" /> \r\n</div>\r\n<br />', '重量', '1000g、2000g、3000g', '中国大陆', '349、455、588', '2', '8、9、42、43、44', 1, '', '', 0);
INSERT INTO `onethink_document_product` VALUES (14, '1.00', '<div class="box990" id="layoutContent" style="margin:0px auto;padding:0px;border:none;color:#333333;font-family:宋体, ''Arial Narrow'', HELVETICA;">\r\n	<div class="zt_gz" id="container" style="margin:0px;padding:0px;border:none;background-color:#FFFFFF;">\r\n		<div class="gz_banner carousel" id="fader_container" style="margin:0px;padding:0px;border:none;">\r\n			<ul class="main contents" id="fader" style="vertical-align:bottom;">\r\n				<li class="list content" id="toLegend" style="vertical-align:bottom;">\r\n					<a><img src="http://image.benlailife.com/images/gz/special/chucheng/lunbo03.jpg" /></a> \r\n				</li>\r\n			</ul>\r\n			<ul class="fader_nav" style="vertical-align:bottom;">\r\n				<li class="list" id="prev" style="vertical-align:bottom;">\r\n				</li>\r\n				<li class="list" id="next" style="vertical-align:bottom;">\r\n				</li>\r\n			</ul>\r\n			<ul class="main cc_nav" id="nav" style="vertical-align:bottom;">\r\n				<li class="list" style="vertical-align:bottom;">\r\n					<a><img src="http://image.benlailife.com/images/bj/special/2014chucheng/nav/cc_nav_01_on.jpg" /></a> \r\n				</li>\r\n				<li class="list" style="vertical-align:bottom;">\r\n					<img src="http://image.benlailife.com/images/bj/special/2014chucheng/nav/cc_nav_02.jpg" /> \r\n				</li>\r\n				<li class="list" style="vertical-align:bottom;">\r\n					<a><img src="http://image.benlailife.com/images/bj/special/2014chucheng/nav/cc_nav_03.jpg" /></a> \r\n				</li>\r\n			</ul>\r\n		</div>\r\n		<div style="margin:0px;padding:0px;border:none;">\r\n			<div class="sku" style="margin:0px;padding:0px;border:none;">\r\n				<ul class="main" id="sale" style="vertical-align:bottom;">\r\n					<li class="zcode list relative" style="vertical-align:bottom;">\r\n						<a href="http://www.benlai.com/item-39458.html" target="_blank"><img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/images/cc_shop_02.jpg" /></a><img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/images/cc_shop_03.jpg" /> \r\n						<div class="cc_buy button right" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_shop.gif" id="39458_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list relative" style="vertical-align:bottom;">\r\n						<a href="http://www.benlai.com/item-39459.html" target="_blank"><img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/images/cc_shop_04.jpg" /></a><img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/images/cc_shop_05.jpg" /> \r\n						<div class="cc_buy button left" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_shop.gif" id="39459_addCart" /> \r\n						</div>\r\n					</li>\r\n				</ul>\r\n			</div>\r\n			<div class="cc_des" style="margin:0px;padding:0px;border:none;">\r\n				<img src="http://image.benlailife.com/images/bj/special/2014chucheng/shps.jpg" width="990" height="450" /><img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/images/cc_shop_06.jpg" /><img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/images/cc_shop_07.jpg" /><img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/images/cc_shop_08.jpg" /><img class="cc_section" src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/images/cc_shop_10.jpg" /> \r\n			</div>\r\n			<div class="sku cc_sp_shop" style="margin:0px;padding:0px;border:none;background-color:#F49626;">\r\n				<p class="title">\r\n					<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/images/spt_12.jpg" /> \r\n				</p>\r\n				<div class="cframe" style="margin:0px 20px 20px;padding:0px;border:none;">\r\n					<ul class="sp_nav" style="vertical-align:bottom;">\r\n						<li class="list" style="vertical-align:bottom;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/nav/ytl_on.jpg" /> \r\n						</li>\r\n						<li class="list" style="vertical-align:bottom;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/nav/zxg.jpg" /> \r\n						</li>\r\n						<li class="list" style="vertical-align:bottom;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/nav/sml.jpg" /> \r\n						</li>\r\n						<li class="list" style="vertical-align:bottom;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/nav/sn.jpg" /> \r\n						</li>\r\n					</ul>\r\n					<ul class="contents" style="vertical-align:bottom;background-color:#FFFFFF;">\r\n						<li class="list content relative page" style="vertical-align:bottom;">\r\n							<a href="http://www.benlai.com/item-37672.html" target="_blank"><img src="http://image.benlailife.com/images/bj/special/2014chucheng/p1.jpg" /></a> \r\n							<div class="ft_buy" style="margin:0px;padding:0px;border:none;">\r\n								<ul class="select_box" style="vertical-align:bottom;">\r\n									<li class="list button" style="vertical-align:bottom;">\r\n										<img src="http://image.benlailife.com/images/bj/special/2014chucheng/2p_on.jpg" /> \r\n									</li>\r\n									<li class="list button" style="vertical-align:bottom;">\r\n										<img src="http://image.benlailife.com/images/bj/special/2014chucheng/4p.jpg" /> \r\n									</li>\r\n								</ul>\r\n								<ul class="shop_box" style="vertical-align:bottom;">\r\n									<li class="list" style="vertical-align:bottom;">\r\n										<p class="price p_rose" style="font-family:''Microsoft YaHei'';font-size:24px;color:#F83A5E;">\r\n											￥11.80<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;">￥20.00</span> \r\n										</p>\r\n										<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n											<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_shop.gif" id="37672_addCart" /> \r\n										</div>\r\n									</li>\r\n									<li class="list" style="vertical-align:bottom;">\r\n										<p class="price p_rose" style="font-family:''Microsoft YaHei'';font-size:24px;color:#F83A5E;">\r\n											￥18.80<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;">￥40.00</span> \r\n										</p>\r\n										<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n											<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_shop.gif" id="36937_addCart" /> \r\n										</div>\r\n									</li>\r\n								</ul>\r\n							</div>\r\n						</li>\r\n					</ul>\r\n				</div>\r\n			</div>\r\n			<div class="sku" style="margin:0px 0px 60px;padding:0px;border:none;">\r\n				<ul class="main" style="vertical-align:bottom;">\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-39442.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							新疆姬娜果4粒装（单果重90-100g）\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥5.00<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥10.00</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="39442_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-27683.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							进口牛油果 4粒\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥35.00<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥78.00</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="27683_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-10432.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							台湾红宝石葡萄柚\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥28.00<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥38.00</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="10432_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-15307.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							浙江涌泉蜜桔 1.7-1.9kg\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥38.00<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥55.00</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="15307_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-38262.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							四川红阳红心猕猴桃（小果） 8粒装\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥28.00<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥36.00</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="38262_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-6536.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							爽口源兰州百合150g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥18.80<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥19.80</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="6536_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-6682.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							本来精选c云南鲜毛豆 400g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥10.80<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥14.80</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="6682_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-8533.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							陈集山药（鸡皮糙）500g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥15.80<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥16.80</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="8533_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-27.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							斋堂鲜蘑菇拼盘\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥17.80<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;"></span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="27_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-3153.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							本来精选——绿芦笋300g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥20.80<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥23.80</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="3153_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-15656.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							OMEGA 新西兰青口贝 1000g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥49.00<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥78.00</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="15656_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-19587.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							原装进口厄瓜多尔白虾50/60 2000g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥168.00<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥268.00</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="19587_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-19889.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							本来专供 速冻阿拉斯加真鳕切身 （生制）500g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥39.00<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥62.80</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="19889_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-25845.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							【独家销售】南极磷虾 500g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥18.00<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥25.80</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="25845_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-4758.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							九洋无公害生态深海养殖 三去大黄鱼 450g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥36.00<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥49.00</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="4758_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-6246.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							林地散养柴鸡蛋24枚\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥35.60<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥42.80</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="6246_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-9209.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							Kerchin科尔沁肉筋 500g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥29.80<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥35.90</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="9209_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-32393.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							华北小笋鸡250g-350g*2\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥15.80<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥43.60</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="32393_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-25437.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							荷美尔出口备案冻前尖500g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥19.90<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥26.00</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="25437_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-7926.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							Kerchin科尔沁肥牛 400克\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥36.80<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥51.80</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="7926_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-38159.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							【特别推荐】云南艾爱全脂巴氏水牛乳500ml\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥9.90<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥22.00</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="38159_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-37167.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							贝儿榴莲飘香蛋糕330g-家庭装\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥49.90<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;"></span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="37167_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-7444.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							百吉福棒棒奶酪（原味）500g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥48.60<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥59.80</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="7444_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-15775.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							红炉磨坊葡萄干核桃面包（粗粮） 300g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥23.60<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥27.60</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="15775_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-793.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							万得妙含糖酸牛奶500ml\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥11.60<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥15.80</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="793_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-719.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							伯爵特级初榨橄榄油500ml\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥69.50<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;"></span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="719_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-6690.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							本来生活有机红小豆（红豆）360g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥9.90<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥12.00</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_back.gif" id="6690_back" class="defbutton" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-24389.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							响中王响水村自产大米2500g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥82.50<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;"></span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="24389_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-4048.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							竹里馆临安特产天目山野生石笋干250g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥25.80<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;"></span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="4048_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-33796.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							长白山黑木耳125g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥21.50<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥28.50</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="33796_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-4159.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							广东温氏好味鸡咸香盐焗鸡600g-800g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥33.00<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥52.80</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="4159_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-28102.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							百饺园家常猪肉三鲜水饺300g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥13.80<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥17.20</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="28102_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-23882.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							荷美尔Hormel 超值鲜嫩火腿片135g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥14.80<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;"></span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="23882_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-21778.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							乐世小厨培根抓饼精装5片600g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥10.90<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥17.90</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="21778_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-25866.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							天福号 蛋卷300g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥12.80<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥19.00</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="25866_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-16606.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							德国迈森蜂蜜小栈纯蜂蜜—洋槐花蜂蜜500g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥63.00<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥126.00</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="16606_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-19891.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							阿鲁司滇红茶15g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥8.00<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥23.00</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="19891_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-10542.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							法国（巴黎）含气柠檬味饮料330ml*4\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥32.00<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥48.00</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="10542_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-6883.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							澳洲奔富酒园洛神山庄梅洛红葡萄酒750ml\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥49.00<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥98.00</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_back.gif" id="6883_back" class="defbutton" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-22336.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							KEO凯莉欧100%橙汁1L(塞浦路斯进口) 真正纯橙汁\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥11.40<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥22.80</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_back.gif" id="22336_back" class="defbutton" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-35043.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							7Best大象芒果干100g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥12.80<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;"></span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="35043_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-24780.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							吃货榴莲干90g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							<img src="http://image1.benlailife.com/Content/images/no2.gif?v=8.2.47" /><span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;"></span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_back.gif" id="24780_back" class="defbutton" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-6739.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							昆仑山和田玉枣六星 500g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥64.30<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;"></span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="6739_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-21306.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							阿胶金丝枣180g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥12.80<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;"></span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="21306_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<a href="http://www.benlai.com/item-21304.html" target="_blank"></a> \r\n						<p class="name" style="font-family:''Microsoft YaHei'';font-size:16px;">\r\n							桃花姬阿胶糕300g\r\n						</p>\r\n						<p class="price normal-price-text p_orange" style="font-family:''Microsoft YaHei'';font-size:20px;color:#FF9472;font-weight:bold;">\r\n							￥119.00<span class="Concrete-grey" style="color:#A1A1A1;text-decoration:line-through;font-size:14px;font-weight:300;">￥158.00</span> \r\n						</p>\r\n						<div class="button" style="margin:5px auto;padding:0px;border:none;">\r\n							<img src="http://image.benlailife.com/images/gz/special/2014chuchengyushou_syhd/bt_add.jpg" id="21304_addCart" /> \r\n						</div>\r\n					</li>\r\n					<li class="zcode list col5 htyanimate" style="vertical-align:bottom;text-align:center;">\r\n						<div>\r\n							<br />\r\n						</div>\r\n					</li>\r\n				</ul>\r\n			</div>\r\n		</div>\r\n	</div>\r\n</div>', '500', '0', '中国大陆', '', '', '8、9、42、43、44', 1, '褚橙', '', 0);
INSERT INTO `onethink_document_product` VALUES (8, '10.00', '<div id="J_DcTopRightWrap" style="margin:0px;padding:0px;color:#404040;font-family:tahoma, arial, 微软雅黑, sans-serif;background-color:#FFFFFF;">\r\n	<div id="J_DcTopRight" class="J_DcAsyn tb-shop" style="margin:0px;padding:0px;">\r\n		<div class="J_TModule" id="shop8751140001" style="margin:0px;padding:0px;">\r\n			<div class="skin-box tb-module tshop-pbsm tshop-pbsm-shop-self-defined" style="margin:0px;padding:0px;">\r\n				<div class="skin-box-bd clear-fix" style="margin:0px;padding:0px;border:0px solid #FFFFFF;color:#828282;background:none;">\r\n					<span> \r\n					<p>\r\n						<img src="http://img03.taobaocdn.com/imgextra/i3/738580955/TB2oT.ZapXXXXaxXXXXXXXXXXXX-738580955.jpg_.webp" /> \r\n					</p>\r\n</span> \r\n				</div>\r\n<s class="skin-box-bt"><b></b></s> \r\n			</div>\r\n		</div>\r\n		<div class="J_TModule" id="shop8825085575" style="margin:0px;padding:0px;">\r\n			<div class="skin-box tb-module tshop-pbsm tshop-pbsm-shop-self-defined" style="margin:0px;padding:0px;">\r\n				<s class="skin-box-tp"><b></b></s> \r\n				<div class="skin-box-bd clear-fix" style="margin:0px;padding:0px;border:0px solid #FFFFFF;color:#828282;background:none;">\r\n					<span> \r\n					<p>\r\n						<a href="http://detail.tmall.com/item.htm?spm=a220z.1000880.0.0.UoC3cM&id=35904185523&scene=taobao_shop" target="_blank"><img src="http://img03.taobaocdn.com/imgextra/i3/738580955/TB2AEVlaFXXXXbOXXXXXXXXXXXX-738580955.jpg_.webp" /></a> \r\n					</p>\r\n</span> \r\n				</div>\r\n<s class="skin-box-bt"><b></b></s> \r\n			</div>\r\n		</div>\r\n	</div>\r\n</div>\r\n<div id="description" class="J_DetailSection tshop-psm tshop-psm-bdetaildes" style="margin:0px;padding:0px;color:#404040;font-family:tahoma, arial, 微软雅黑, sans-serif;background-color:#FFFFFF;">\r\n	<div class="content ke-post" style="margin:10px 0px 0px;padding:0px;font-size:14px;font-family:tahoma, arial, 宋体, sans-serif;">\r\n		<div style="margin:0px;padding:0px;">\r\n			<span><span style="font-weight:700;"><span style="font-size:18px;">智利青苹果</span></span><br />\r\n</span> \r\n		</div>\r\n		<div style="margin:0px;padding:0px;">\r\n			<p>\r\n				<span><span style="font-weight:700;"><img class="ke_anchor" id="ids-tag-m-35171" src="http://a.tbcdn.cn/kissy/1.0.0/build/imglazyload/spaceball.gif" style="height:1px;" />产品简介</span><br />\r\n智利苹果色泽艳丽，颜色从青绿到浅绿都有，也可能会略带粉红色。口感上则相当酸，是喜欢酸味朋友们的大爱，爽脆多汁，口味鲜美，吃法较多。&nbsp;</span> \r\n			</p>\r\n		</div>\r\n		<div style="margin:0px;padding:0px;">\r\n			<span><span style="font-weight:700;">温馨提示</span><br />\r\n</span> \r\n		</div>\r\n		<div style="margin:0px;padding:0px;">\r\n			<span>此款产地为智利。</span> \r\n		</div>\r\n		<div style="margin:0px;padding:0px;">\r\n			<span>冰箱冷藏保存时间会更久，保存时表皮不要沾水。苹果皮中含有丰富营养素，建议连皮一起吃。</span> \r\n			<p>\r\n				<img src="http://img02.taobaocdn.com/imgextra/i2/738580955/T2zOhCXfdOXXXXXXXX-738580955.jpg" align="absmiddle" /><img src="http://img04.taobaocdn.com/imgextra/i4/738580955/T2Zz1aXXtdXXXXXXXX-738580955.jpg" align="absmiddle" /><img src="http://img01.taobaocdn.com/imgextra/i1/738580955/T2VPCuXc4cXXXXXXXX-738580955.jpg" align="absmiddle" /><img src="http://img04.taobaocdn.com/imgextra/i4/738580955/T2ZwXBXl8NXXXXXXXX-738580955.jpg" align="absmiddle" /> \r\n			</p>\r\n			<p>\r\n				<img src="http://img04.taobaocdn.com/imgextra/i4/738580955/T2MmJyXi0OXXXXXXXX-738580955.jpg_.webp" align="absmiddle" /><img class="ke_anchor" id="ids-tag-m-35173" src="http://a.tbcdn.cn/kissy/1.0.0/build/imglazyload/spaceball.gif" style="height:1px;" /><img src="http://img01.taobaocdn.com/imgextra/i1/738580955/T2yn4DXj8OXXXXXXXX-738580955.jpg_.webp" align="absmiddle" /> \r\n			</p>\r\n		</div>\r\n		<p>\r\n			<img class="ke_anchor" id="ids-tag-m-35176" src="http://a.tbcdn.cn/kissy/1.0.0/build/imglazyload/spaceball.gif" style="height:1px;" /><img src="http://img03.taobaocdn.com/imgextra/i3/738580955/T28tdGXd0OXXXXXXXX-738580955.jpg_.webp" align="absmiddle" /> \r\n		</p>\r\n	</div>\r\n</div>', '重量', '1000g、2000g、3000g', '中国大陆', '349、455、588', '', '', 1, '智利青苹果12个', '', 0);
INSERT INTO `onethink_document_product` VALUES (9, '5.00', '<h2 align="center" style="font-family:tahoma, arial, 宋体, sans-serif;background-color:#FFFFFF;">\r\n	配送范围：目前江浙沪（其他城市或者偏远乡镇村目前不配送，谢谢）\r\n</h2>\r\n<p align="center" style="font-family:tahoma, arial, 宋体, sans-serif;font-size:14px;background-color:#FFFFFF;">\r\n	<img src="http://gd1.alicdn.com/imgextra/i1/595478579/T2gtbxXINaXXXXXXXX_!!595478579.jpg" /> \r\n</p>\r\n<p align="center" style="font-family:tahoma, arial, 宋体, sans-serif;font-size:14px;background-color:#FFFFFF;">\r\n	<img src="http://gd2.alicdn.com/imgextra/i2/595478579/T2yOPCXKFaXXXXXXXX_!!595478579.jpg" /><img src="http://gd3.alicdn.com/imgextra/i3/595478579/T2S52CXMlaXXXXXXXX_!!595478579.jpg" /><img src="http://gd3.alicdn.com/imgextra/i3/595478579/T2XmrCXLNaXXXXXXXX_!!595478579.jpg" /> \r\n</p>\r\n<p align="center" style="font-family:tahoma, arial, 宋体, sans-serif;font-size:14px;background-color:#FFFFFF;">\r\n	<img src="http://gd3.alicdn.com/imgextra/i3/595478579/T2poTvXMpaXXXXXXXX_!!595478579.jpg" /> \r\n</p>', '500', '0', '中国大陆', '', '', '8、9、42、43、44', 1, '菲律宾进口香蕉', '', 0);
INSERT INTO `onethink_document_product` VALUES (15, '1.00', '<div class="detl_property" style="margin:20px 0px;">\r\n	<p style="font-family:宋体, ''Arial Narrow'', HELVETICA;color:#333333;">\r\n		<img src="http://image1.benlailife.com/Content/images/detailsp/detailsp_tit01.gif?v=8.2.47" height="42" width="760" /> \r\n	</p>\r\n	<div class="detl_com">\r\n		<div class="detl_form">\r\n			品名：河南河阴软籽石榴 4粒装（单果重250-300g）规格：250-300g\r\n		</div>\r\n		<div class="detl_pic">\r\n			<img src="http://image4.benlailife.com/ProductImage/0102022270C.jpg" style="width:340px;" /> \r\n		</div>\r\n	</div>\r\n</div>\r\n<div class="detl_feature" style="margin:20px 0px 0px;">\r\n	<a name="sublist01"></a> \r\n	<p style="font-family:宋体, ''Arial Narrow'', HELVETICA;color:#333333;">\r\n		<img src="http://image1.benlailife.com/Content/images/detailsp/detailsp_tit02.gif?v=8.2.47" height="42" width="760" /> \r\n	</p>\r\n	<div class="detl_pic" style="text-align:center;margin:10px 0px;">\r\n		<img src="http://image6.benlailife.com/ProductNewDetailImage/0102022270C/22p.jpg" style="width:700px;" /><span style="color:#333333;font-family:宋体, ''Arial Narrow'', HELVETICA;line-height:normal;"></span> \r\n		<div class="tal" style="text-align:left;color:#333333;font-family:宋体, ''Arial Narrow'', HELVETICA;">\r\n			<br />\r\n		</div>\r\n<img src="http://image6.benlailife.com/ProductNewDetailImage/0102022270C/56p.jpg" style="width:700px;" /><span style="color:#333333;font-family:宋体, ''Arial Narrow'', HELVETICA;line-height:normal;"></span> \r\n		<div class="tal" style="text-align:left;color:#333333;font-family:宋体, ''Arial Narrow'', HELVETICA;">\r\n			<br />\r\n		</div>\r\n<img src="http://image6.benlailife.com/ProductNewDetailImage/0102022270C/18p.jpg" style="width:700px;" /><span style="color:#333333;font-family:宋体, ''Arial Narrow'', HELVETICA;line-height:normal;"></span> \r\n	</div>\r\n	<div>\r\n		<br />\r\n	</div>\r\n</div>', '重量', '1000g、2000g、3000g', '中国大陆', '299、405、668', '8、9、42、43、44', '', 1, '河南河阴软籽石榴', '', 0);
INSERT INTO `onethink_document_product` VALUES (16, '100.00', '<div class="detail_n" style="color:#333333;font-family:宋体, ''Arial Narrow'', HELVETICA;">\r\n	<div class="detail_tab">\r\n		<h2 class="tith2" id="navList" style="font-family:''Microsoft YaHei'';font-size:14px;">\r\n			<br />\r\n		</h2>\r\n		<div class="dtl_btn" style="text-align:right;">\r\n			<a class="buy_btn" id="nav_buy_btn"><span><span>￥</span>28.00</span></a> \r\n		</div>\r\n	</div>\r\n	<div class="detl_content">\r\n		<div class="detl_property" style="margin:20px 0px;">\r\n			<p>\r\n				<img src="http://image1.benlailife.com/Content/images/detailsp/detailsp_tit01.gif?v=8.2.47" height="42" width="760" /> \r\n			</p>\r\n			<div class="detl_com">\r\n				<div class="detl_form">\r\n					品名：佳沃智利进口蓝莓一级果125g规格：125g温馨提示：蓝莓果实为浆果型，耐贮性较强，最佳保存温度为1 ~ 3°C。要吃新鲜蓝莓不可置入0°C以下的冷藏库。 不建议水洗入冰箱，因为水份很容易使蓝莓腐烂。\r\n				</div>\r\n				<div class="detl_pic">\r\n					<img src="http://image3.benlailife.com/ProductImage/0102022311C.jpg" style="width:340px;" /> \r\n				</div>\r\n			</div>\r\n		</div>\r\n		<div class="detl_feature" style="margin:20px 0px 0px;">\r\n			<a name="sublist01"></a> \r\n			<p>\r\n				<img src="http://image1.benlailife.com/Content/images/detailsp/detailsp_tit02.gif?v=8.2.47" height="42" width="760" /> \r\n			</p>\r\n			<div class="detl_pic" style="text-align:center;margin:10px 0px;">\r\n				<img src="http://image6.benlailife.com/ProductNewDetailImage/0102020474C/001.jpg" style="width:700px;" /> \r\n				<div class="tal" style="text-align:left;">\r\n					&nbsp;\r\n				</div>\r\n<img src="http://image6.benlailife.com/ProductNewDetailImage/0102020474C/002.jpg" style="width:700px;" /> \r\n				<div class="tal" style="text-align:left;">\r\n					&nbsp;\r\n				</div>\r\n<img src="http://image6.benlailife.com/ProductNewDetailImage/0102020474C/003.jpg" style="width:700px;" /> \r\n				<div class="tal" style="text-align:left;">\r\n					&nbsp;\r\n				</div>\r\n<img src="http://image6.benlailife.com/ProductNewDetailImage/0102020474C/004.jpg" style="width:700px;" /> \r\n				<div class="tal" style="text-align:left;">\r\n					&nbsp;\r\n				</div>\r\n<img src="http://image6.benlailife.com/ProductNewDetailImage/0102020474C/005.jpg" style="width:700px;" /> \r\n				<div class="tal" style="text-align:left;">\r\n					&nbsp;\r\n				</div>\r\n<img src="http://image6.benlailife.com/ProductNewDetailImage/0102020474C/006.jpg" style="width:700px;" /> \r\n				<div class="tal" style="text-align:left;">\r\n					&nbsp;\r\n				</div>\r\n<img src="http://image6.benlailife.com/ProductNewDetailImage/0102020474C/006.jpg" style="width:700px;" /> \r\n				<div class="tal" style="text-align:left;">\r\n					&nbsp;\r\n				</div>\r\n<img src="http://image6.benlailife.com/ProductNewDetailImage/0102020474C/008.jpg" style="width:700px;" /> \r\n				<div class="tal" style="text-align:left;">\r\n					&nbsp;\r\n				</div>\r\n			</div>\r\n		</div>\r\n		<div class="detl_feature" style="margin:20px 0px 0px;">\r\n			<a name="sublist04"></a> \r\n			<p>\r\n				<img src="http://image1.benlailife.com/Content/images/detailsp/detailsp_tit05.gif?v=8.2.47" height="42" width="760" /> \r\n			</p>\r\n			<div class="detl_pic" style="text-align:center;margin:10px 0px;">\r\n				<img src="http://image6.benlailife.com/ProductNewDetailImage/0102020474C/009.jpg" style="width:700px;" /> \r\n				<div class="tal" style="text-align:left;">\r\n					&nbsp;\r\n				</div>\r\n			</div>\r\n		</div>\r\n		<div class="detl_service" style="margin:20px 0px 0px;">\r\n			<a name="sublist05"></a> \r\n			<p>\r\n				<img src="http://image1.benlailife.com/Content/images/detailsp/detailsp_tit06.gif?v=8.2.47" height="42" width="760" /> \r\n			</p>\r\n			<div class="detl_tab">\r\n				<a class="detl_tab01on">&nbsp;</a><a class="detl_tab02">&nbsp;</a><a class="detl_tab03">&nbsp;</a><a class="detl_tab04">&nbsp;</a><a class="detl_tab05 m0">&nbsp;</a> \r\n			</div>\r\n			<div class="detl_com" style="padding:19px;margin-left:20px;">\r\n				<p>\r\n					<img src="http://image1.benlailife.com/Content/images/detailsp/detailsp_service0101.jpg?v=8.2.47" height="200" width="680" /><img src="http://image1.benlailife.com/Content/images/detailsp/detailsp_service0102.jpg?v=8.2.47" height="228" width="680" /><img src="http://image1.benlailife.com/Content/images/detailsp/detailsp_service0103.jpg?v=8.2.47" height="450" width="680" /> \r\n				</p>\r\n				<div>\r\n					<br />\r\n				</div>\r\n			</div>\r\n		</div>\r\n	</div>\r\n</div>', '套餐', '1000g、2000g、3000g', '中国大陆', '349、455、588', '', '8、9、42、43、44', 1, '佳沃智利进口蓝莓', '', 0);
INSERT INTO `onethink_document_product` VALUES (17, '100.00', '<div class="gdtit" style="font-size:16px;color:#333333;font-weight:bold;font-family:Arial;margin-left:15px;">\r\n	<h1 id="Product_ProductDetailsName" style="font-family:宋体, ''Arial Narrow'', HELVETICA;font-size:16px;">\r\n		新疆红提950-1000g\r\n	</h1>\r\n</div>\r\n<p class="goods_gdmis2 pdl15" style="font-family:宋体, ''Arial Narrow'', HELVETICA;color:#F08B0C;">\r\n	新疆特受欢迎的葡萄品种。\r\n</p>', '重量', '1000g、2000g、3000g、4000g', '中国大陆', '2268.00、29299、22296、29229', '', '', 1, '新疆红提950-1000g', '', 0);
INSERT INTO `onethink_document_product` VALUES (18, '19.00', '<div class="dtl_commodity" style="color:#333333;font-family:宋体, ''Arial Narrow'', HELVETICA;">\r\n	<span style="font-size:30px;color:#669934;line-height:55px;">皮薄、肉脆、汁多、酥香的新疆香梨</span> \r\n	<p style="color:#666666;background-color:#F8F8F8;">\r\n		产自新疆天山南麓“梨乡”库尔勒，香气浓郁，皮薄肉细，酥脆爽口。这样的梨吃起来，不仅是味觉上的享受，也是帮助身体滋润的一剂良药。\r\n	</p>\r\n</div>\r\n<div class="dtl718" style="color:#333333;font-family:宋体, ''Arial Narrow'', HELVETICA;">\r\n	<div class="dtl_title" style="font-size:18px;color:#669934;">\r\n		商品介绍\r\n	</div>\r\n	<div class="dtl_infortu">\r\n		<img alt="" src="http://image1.benlailife.com/ProductDetailImage/0102020673C/001.jpg" style="width:700px;" /> \r\n	</div>\r\n	<div class="dtl_infor_top" style="margin:0px;">\r\n		<p style="color:#666666;">\r\n			<strong><span style="font-size:14px;">来自新疆梨乡的“奶西姆提”</span></strong><br />\r\n新疆巴音郭楞蒙古自治州北部的天山南麓，有一个肥沃的绿州名字叫库尔勒。这里出产的香梨远近闻名，素有“梨乡”之美称。库尔勒香梨在维吾尔语中叫做“奶西姆提”，因为营养价值丰富，印度人称它是“中国的王子”。\r\n		</p>\r\n	</div>\r\n	<div class="dtl_infortu">\r\n		<img alt="" src="http://image2.benlailife.com/ProductDetailImage/0102020673C/002.jpg" style="width:700px;" /> \r\n	</div>\r\n	<div class="dtl_infor_top" style="margin:0px;">\r\n		<p style="color:#666666;">\r\n			<strong><span style="font-size:14px;">香而清甜，虽小却极好吃</span></strong><br />\r\n库尔勒香梨个头不算大，但香气浓郁，皮薄肉细，酥脆爽口，汁多渣少。假如你以前不识此梨，尝下去的第一口，它一定能给你“竟这样好吃”的惊喜感。\r\n		</p>\r\n	</div>\r\n	<div class="dtl_infortu">\r\n		<img alt="" src="http://image.benlailife.com/ProductDetailImage/0102020673C/003.jpg" style="width:700px;" /> \r\n	</div>\r\n</div>', '重量', '1000g、2000g、3000g', '中国大陆', '299、405、668', '', '8、9、42、43、44', 1, '新疆库尔勒香梨 ', '', 0);
INSERT INTO `onethink_document_product` VALUES (32, '1.00', '<div class="detl_com">\r\n	<div class="detl_form">\r\n		品名：延安宜川红富士 12粒装（75mm）温馨提示：由于产地下大雪，影响了苹果的到货速度并增加了破损率，若缺货，请您耐心等待，我们一定会尽快解决缺货问题，由此带来的不便，请您谅解。\r\n	</div>\r\n	<div class="detl_pic">\r\n		<img src="http://image1.benlailife.com/ProductImages/000/000/015/633/medium/2b972bf7-1741-4498-b30e-f945ec14f0db.jpg" /> \r\n	</div>\r\n</div>\r\n<div class="detl_feature">\r\n	<a name="sublist01"></a> \r\n	<p>\r\n		<img src="http://image1.benlailife.com/Content/images/detailsp/detailsp_tit02.gif?v=8.2.68" height="42" width="760" /> \r\n	</p>\r\n	<div class="detl_pic">\r\n		<img src="http://image1.benlailife.com/ProductNewDetailImage/0102020964C/001.jpg" /> \r\n		<div class="tal">\r\n			&nbsp;\r\n		</div>\r\n<img src="http://image1.benlailife.com/ProductNewDetailImage/0102020964C/002.jpg" /> \r\n		<div class="tal">\r\n			&nbsp;\r\n		</div>\r\n<img src="http://image1.benlailife.com/ProductNewDetailImage/0102020964C/003.jpg" /> \r\n		<div class="tal">\r\n			&nbsp;\r\n		</div>\r\n<img src="http://image1.benlailife.com/ProductNewDetailImage/0102020964C/004.jpg" /> \r\n		<div class="tal">\r\n			&nbsp;\r\n		</div>\r\n	</div>\r\n</div>\r\n<a name="sublist02"></a> \r\n<p>\r\n	<img src="http://image1.benlailife.com/Content/images/detailsp/detailsp_tit03.gif?v=8.2.68" height="42" width="760" /> \r\n</p>\r\n<img src="http://image1.benlailife.com/ProductNewDetailImage/0102020964C/005.jpg" /> \r\n<div class="tal">\r\n	&nbsp;\r\n</div>\r\n<img src="http://image1.benlailife.com/ProductNewDetailImage/0102020964C/006.jpg" /> \r\n<div class="tal">\r\n	&nbsp;\r\n</div>\r\n<img src="http://image1.benlailife.com/ProductNewDetailImage/0102020964C/007.jpg" /><br />', '500', '0', '中国大陆', '', '', '', 10, '延安宜川红富士 12粒装（70-75mm）', '', 0);
INSERT INTO `onethink_document_product` VALUES (33, '1.00', '<div class="detl_com">\r\n	<div class="detl_form">\r\n		品名：阿克苏红富士苹果 3粒装规格：3粒\r\n	</div>\r\n	<div class="detl_pic">\r\n		<img src="http://image1.benlailife.com/ProductImages/000/000/040/455/medium/c7f74bee-ac98-4b53-aa74-9c275fbce133.jpg" /> \r\n	</div>\r\n</div>\r\n<a name="sublist01"></a> \r\n<p>\r\n	<img src="http://image1.benlailife.com/Content/images/detailsp/detailsp_tit02.gif?v=8.2.68" height="42" width="760" /> \r\n</p>\r\n<img src="http://image1.benlailife.com/ProductNewDetailImage/0102021258C/001.jpg" /> \r\n<div class="tal">\r\n	<p class="detl_com01">\r\n		<span>只有阿克苏地区才能产出的冰糖心</span>\r\n	</p>\r\n	<p class="detl_com02">\r\n		<span>阿克苏“冰糖心”，产于新疆南部天山南麓塔里木盆地北缘的阿\r\n克苏红旗坡农场，这里具有干旱少雨，昼夜温差大，全年无霜期长，光照时间长的气候特点，而水源则依托于天山山脉托木尔峰冰川，远离污染的地域条件，使这里\r\n成为绿色无公害农产品的理想家园，成就了享誉疆内外的阿克苏“冰糖心”苹果。</span>\r\n	</p>\r\n</div>\r\n<br />', '500', '0', '中国大陆', '', '', '', 10, '新疆阿克苏冰糖心苹果 3粒装', '', 0);
INSERT INTO `onethink_document_product` VALUES (34, '1.00', '<div class="detl_com">\r\n	<div class="detl_form">\r\n		品名：阿克苏红富士苹果 3粒装规格：3粒\r\n	</div>\r\n	<div class="detl_pic">\r\n		<img src="http://image1.benlailife.com/ProductImages/000/000/040/455/medium/c7f74bee-ac98-4b53-aa74-9c275fbce133.jpg" /> \r\n	</div>\r\n</div>\r\n<a name="sublist01"></a> \r\n<p>\r\n	<img src="http://image1.benlailife.com/Content/images/detailsp/detailsp_tit02.gif?v=8.2.68" height="42" width="760" /> \r\n</p>\r\n<img src="http://image1.benlailife.com/ProductNewDetailImage/0102021258C/001.jpg" /> \r\n<div class="tal">\r\n	<p class="detl_com01">\r\n		<span>只有阿克苏地区才能产出的冰糖心</span>\r\n	</p>\r\n	<p class="detl_com02">\r\n		<span>阿克苏“冰糖心”，产于新疆南部天山南麓塔里木盆地北缘的阿\r\n克苏红旗坡农场，这里具有干旱少雨，昼夜温差大，全年无霜期长，光照时间长的气候特点，而水源则依托于天山山脉托木尔峰冰川，远离污染的地域条件，使这里\r\n成为绿色无公害农产品的理想家园，成就了享誉疆内外的阿克苏“冰糖心”苹果。</span>\r\n	</p>\r\n</div>\r\n<br />', '500', '0', '中国大陆', '', '', '', 10, '新疆阿克苏冰糖心苹果 3粒装', '', 0);
INSERT INTO `onethink_document_product` VALUES (35, '1.00', '<div class="detl_com">\r\n	<div class="detl_form">\r\n		品名：延安宜川红富士 12粒优品装（80mm）温馨提示：由于气温升高，个别苹果可能会发面，脆爽不足，但香甜有余。\r\n	</div>\r\n	<div class="detl_pic">\r\n		<img src="http://image1.benlailife.com/ProductImages/000/000/015/665/medium/ae5e03e1-49a5-44b9-8d37-823dac082c77.jpg" /> \r\n	</div>\r\n</div>', '500', '0', '中国大陆', '', '', '8、9、42、43、44', 10, '延安宜川红富士 12粒优品装（80mm）', '', 0);
INSERT INTO `onethink_document_product` VALUES (42, '1.00', '<div class="dtl_tjc fl">\r\n	<div class="dtl_tjt fl">\r\n		<div class="dtl_bb">\r\n			<div class="dtl_tjh1">\r\n				栖霞富士，产自中国苹果之乡\r\n			</div>\r\n		</div>\r\n		<div class="fl dtl_pt10 dtl_pb10">\r\n			<div class="fl dtl439">\r\n				　　栖霞富士以个大形正，色泽鲜艳，光洁度好，酸甜适中，香脆可口而著称。<br />\r\n&nbsp;&nbsp;&nbsp;&nbsp;栖霞苹果产自"苹果之乡"山东栖霞，栖霞地处胶东半岛，主要地形为丘陵山地，四季分明，气候宜人，秋季昼夜温差大，自然环境非常适合苹果生长；栖霞苹果的种植历史长达百余年，果实个大形正，内纯外美，营养均衡，极耐贮藏。<br />\r\n<br />\r\n<strong>储存方式：</strong>苹果的储存要保持干燥、低温，买回的苹果洗净擦干后，装进保鲜袋，放入冰箱冷藏室即可。\r\n			</div>\r\n			<div class="fr dtl_img">\r\n				<img alt="" src="http://image3.benlailife.com/ProductDetailImage/0102020049C/001.jpg" height="230" width="230" /> \r\n			</div>\r\n		</div>\r\n	</div>\r\n	<div>\r\n		<img alt="" src="http://image3.benlailife.com/ProductDetailImage/bg/bg_tj_b.gif" height="7" width="760" /> \r\n	</div>\r\n	<div class="dtl_zjc fl">\r\n		<div class="dtl_zjt fl">\r\n			<div class="fl dtl_pb10">\r\n				<div class="dtl_lh22">\r\n					<span>“</span>栖霞富士苹果因其漂亮的外表和美妙的口感而获得很多人的\r\n喜爱。不过，它的营养价值也是不可小觑的：含量丰富的果胶，能刺激胃肠蠕动，食用后，有助于排便；从美容的角度来说，栖霞富士中丰富的镁、铁、硒等矿物元\r\n素，可以使皮肤细腻、红润、有光泽，胜过无数价格昂贵的化妆品了。 <span>”</span><br />\r\n<br />\r\n<span>杨俊琴<br />\r\n国家二级公共营养师、北京营养师俱乐部会员<br />\r\n新浪微博：@杨俊琴营养师</span> \r\n				</div>\r\n			</div>\r\n			<div>\r\n				<img alt="" src="http://image3.benlailife.com/ProductDetailImage/Dongxi/zhuanjia/yangjunqin.gif" height="90" width="90" /> \r\n			</div>\r\n		</div>\r\n		<div>\r\n			<img alt="" src="http://image5.benlailife.com/ProductDetailImage/bg/bg_zj_b.gif" height="7" width="760" /> \r\n		</div>\r\n	</div>\r\n</div>\r\n<div class="dtl_bb">\r\n	<div class="dtl_zi">\r\n		一天一苹果，医生远离我\r\n	</div>\r\n</div>\r\n<div class="dtl_lh22 dtl_pb10">\r\n	　　苹果味甘，性凉；具有生津止渴、润肺除烦、健脾益胃、养心益气、润肠、止泻酒等功效。<br />\r\n&nbsp;&nbsp;&nbsp;&nbsp;苹果的营养价值和医疗价值都很高，西方有谚语"一天一苹果，医生远离我"，因此苹果被很多人称为"大夫第一药"；多吃苹果可以有效降低胆固醇；改善呼吸系统和肺功能，保护肺部免受污染和烟尘的影响；同时对于促进消化，防止便秘，提神醒脑也有帮助作用。\r\n</div>\r\n<br />', '重量', '1000g、2000g、3000g', '中国大陆', '299、405、668', '', '8、9、42、43、44', 10, '山东栖霞富士 2粒/470-500g', '', 0);
INSERT INTO `onethink_document_product` VALUES (43, '1.00', '<img src="http://image1.benlailife.com/ProductNewDetailImage/0102020944C/021.jpg" /> \r\n<div class="tal">\r\n	&nbsp;\r\n</div>\r\n<img src="http://image1.benlailife.com/ProductNewDetailImage/0102020944C/022.jpg" /><br />', '500', '0', '中国大陆', '45646', '', '8、9、42、43、44', 10, '浙江涌泉蜜桔 1.7-1.9kg', '', 0);
INSERT INTO `onethink_document_product` VALUES (44, '1.00', '<div class="dtl_tjt fl">\r\n	<div class="dtl_bb">\r\n		<div class="dtl_tjh1">\r\n			金玉其内外，皮薄肉嫩，汁多香甜\r\n		</div>\r\n	</div>\r\n	<div class="fl dtl_pt10 dtl_pb10">\r\n		<div class="fl dtl439">\r\n			　　金橘是柑橘类水果之一，皮色金黄、皮薄肉嫩、汁多香甜。它皮肉难分，洗净后可连皮带肉一起吃下。金橘含有特殊的挥发油、金橘甙等特殊物质，具有令人愉悦的香气，是颇具特色的水果，有生津利咽醒酒的作用。<br />\r\n<br />\r\n<strong>别&nbsp;&nbsp;</strong>&nbsp;&nbsp;<strong>名：</strong>金柑、夏橘、给客橙、金蛋、罗浮<br />\r\n<strong>成</strong>&nbsp;<strong>熟</strong>&nbsp;<strong>期：</strong>9-11月<br />\r\n<strong>食用方法：</strong>金桔洗净后可以带皮一起吃下。<br />\r\n<strong>挑选方法：</strong>品质好的金橘呈色泽闪亮的橘色或深黄色。<br />\r\n<strong>储存方式：</strong>最好的存放地方自然是肚子里，实在吃不完，放在阴凉干燥通风处即可。\r\n		</div>\r\n		<div class="fr dtl_img">\r\n			<img alt="" src="http://image1.benlailife.com/ProductDetailImage/0102020036C/001.jpg" height="230" width="230" /> \r\n		</div>\r\n	</div>\r\n</div>\r\n<div>\r\n	<img alt="" src="http://image1.benlailife.com/ProductDetailImage/bg/bg_tj_b.gif" height="7" width="760" /> \r\n</div>\r\n<div class="fl dtl_pb10">\r\n	<div class="dtl_lh22">\r\n		<span>“</span><strong>小小金桔，营养多多</strong><br />\r\n金桔色美、个大、皮薄、肉厚、气香、酸甜可口，皮肉不易分离，可连皮带肉鲜食也可以当茶泡水喝。它含有人体所需的糖、酸、维生素C \r\n等多种营养物质，其中含有柠檬萜，橙皮甙，金桔甙等成分，不仅有助于消化，还对维护心血管功能，防止血管硬化、高血压等疾病有一定的作用。 <span>”</span><br />\r\n<br />\r\n<span>刘晓庆<br />\r\n国家高级食品检测员、公共营养师<br />\r\n新浪微博：@晓庆食尚之窗</span> \r\n	</div>\r\n</div>\r\n<br />', '500', '0', '中国大陆', '', '', '8、9、42、43、44', 10, '广西金桔 500-550g', '', 0);
INSERT INTO `onethink_document_product` VALUES (60, '1.00', '', '1', '1', '中国大陆', '', '', '', 10, '', '', 0);
INSERT INTO `onethink_document_product` VALUES (61, '1.00', '', '1', '1', '中国大陆', '', '', '', 10, '', '', 0);
INSERT INTO `onethink_document_product` VALUES (63, '1.00', '<div class="formwork">\r\n	<div class="formwork_img">\r\n		<div class="formwork">\r\n			<div class="formwork_img">\r\n				<img src="http://img20.360buyimg.com/vc/jfs/t661/223/1260298180/156491/676efd81/54c597bcN90eaab2d.jpg" /> \r\n			</div>\r\n		</div>\r\n		<div class="formwork">\r\n			<div class="formwork_text">\r\n				《快乐大本营》当红主持-李维嘉亲力代言爱国者移动电源传递欢乐正能量。 精细晒纹，舒适握感，简约白色，素雅诠释。\r\n			</div>\r\n		</div>\r\n		<div class="formwork">\r\n			<div class="formwork_img">\r\n				<img src="http://img20.360buyimg.com/vc/jfs/t757/2/12715622/52731/3053a25d/547d6741Na6b250f3.jpg" /> \r\n			</div>\r\n		</div>\r\n	</div>\r\n</div>\r\n<br />', '颜色', '黑色、白色、灰色、红色', '中国大陆', '', '', '', 10, '', '106', 0);
INSERT INTO `onethink_document_product` VALUES (64, '1.00', '<table class="ke-zeroborder" border="0" cellpadding="0" cellspacing="0" align="center" width="750">\r\n	<tbody>\r\n		<tr>\r\n			<td height="308">\r\n				<a href="http://sale.jd.com/act/Se0Qj1I5sx.html" target="_blank"><img alt="" src="http://img30.360buyimg.com/jgsq-productsoa/jfs/t835/218/436209464/101913/90b377f0/5523a921N49a86b97.jpg" height="300" width="750" /></a> \r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<div align="center">\r\n	<a href="http://sale.jd.com/act/DgpZiTuqdWU3.html" target="_blank"><img alt="" src="http://img30.360buyimg.com/jgsq-productsoa/jfs/t1024/17/289442024/60596/8b447dda/551cf673Nfab6e101.jpg" /></a> \r\n</div>', '规格', '黑色、白色', '中国大陆', '99、111', '', '', 9, '', '', 0);
INSERT INTO `onethink_document_product` VALUES (65, '1.00', '<div class="ui-switchable-panel ui-switchable-panel-selected">\r\n	<div class="mc" id="product-detail-1">\r\n		<div class="detail-content clearfix">\r\n			<div class="detail-content-wrap">\r\n				<div class="detail-content-item">\r\n					<div id="J-detail-pop-tpl-top">\r\n						<p>\r\n							<img alt="" src="http://img10.360buyimg.com/imgzone/jfs/t751/77/1013597273/248907/338afaa8/5511239cNc5ac78e8.jpg" border="0" />\r\n						</p>\r\n						<p>\r\n							<img alt="" src="http://img10.360buyimg.com/imgzone/jfs/t757/267/934989647/210055/c2d8871e/550946b7Ne614bd11.jpg" />\r\n						</p>\r\n					</div>\r\n					<div id="J-detail-content">\r\n						<img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t478/16/972345406/467919/5f920a9a/54c0b143Nb565bbcf.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t682/338/1232756534/290787/34fc27c7/54c0b145Nd657ede8.jpg" /> <img alt="" src="http://img10.360buyimg.com/imgzone/jfs/t667/211/1233801542/246875/8c9cba1a/54c0b146N3a0f1242.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t535/275/1219770206/207964/591a100e/54c0b147N4b8aa15f.jpg" /> <img alt="" src="http://img10.360buyimg.com/imgzone/jfs/t595/330/1222871012/194147/f95ec84/54c0b148N13bcc8dc.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t580/267/1230967396/262350/cfe1c8be/54c0b148N75613d15.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t655/63/1242307338/205284/589be0b2/54c0b149Nabbee94d.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t763/27/572674096/130207/f1599b9c/54c0b149N9e8547ef.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t697/8/566006959/146997/df0ab452/54c0b14aN345a6eca.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t469/323/1260790326/286804/2ee7d1e6/54c0b14bN9edddbe7.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t469/324/1231339113/325122/f5bdeebb/54c0b14cNd3e27f13.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t673/349/1240110030/254101/a561b49/54c0b14dN4e721103.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t475/121/1255343474/119478/169316db/54c0b14dN191dec09.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t730/24/579964548/197526/bf92e431/54c0b14eN5787baa1.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t541/28/1283149987/292873/7bb43ae3/54c0b14fNca292ad8.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t550/99/1409383535/324070/6c552691/54c0b14fN743e14fb.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t766/29/577443219/182750/b8fc96b4/54c0b150N091ce3a3.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t700/177/572228437/178013/a1f39406/54c0b151N2ade0b10.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t454/234/1254972438/289244/8cd47aba/54c0b151Nfc33214f.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t661/350/1244707552/320185/8fd27ced/54c0b152N001e7f5d.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t763/46/578515785/309068/1b42ff10/54c0b161N1d74a9cf.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t565/242/1238531075/362491/b0e7139/54c0b161N2ceaca72.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t574/60/1206685788/273586/569adf0b/54c0b163N9864b5eb.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t625/125/1230098446/286758/462cb5b5/54c0b163N1746bb5d.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t460/359/1225996454/622/8bf7354e/54c0b164N853a5fcb.jpg" /><br />\r\n					</div>\r\n				</div>\r\n			</div>\r\n		</div>\r\n	</div>\r\n</div>\r\n<div class="ui-switchable-panel mc hide" id="product-detail-2">\r\n	<div class="detail-correction">\r\n		如果您发现商品信息不准确，<a href="http://club.360buy.com/jdvote/skucheck.aspx?skuid=1452568268&amp;cid1=9987&amp;cid2=830&amp;cid3=11301" target="_blank">欢迎纠错</a> \r\n	</div>\r\n	<table class="Ptable ke-zeroborder" border="0" cellpadding="0" cellspacing="1" width="100%">\r\n		<tbody>\r\n			<tr>\r\n				<th class="tdTitle" colspan="2">\r\n					主体\r\n				</th>\r\n			</tr>\r\n			<tr>\r\n			</tr>\r\n			<tr>\r\n				<td class="tdTitle">\r\n					适用机型\r\n				</td>\r\n				<td>\r\n					苹果iPhone 6\r\n				</td>\r\n			</tr>\r\n		</tbody>\r\n	</table>\r\n</div>\r\n<div class="ui-switchable-panel hide">\r\n	<div class="mc yb-tab-img" id="J-yb-tab-img">\r\n		<img src="http://img13.360buyimg.com/da/jfs/t829/263/100807689/199942/5d4cf278/54fe5ebeNf4fbebc7.jpg" width="990" /><a href="http://c.nfa.jd.com/adclick?keyStr=z5AXFoIimt1jiDK32+w4mW0bjVYOHZSLtG+kxxFj84wd1CxH/fv6f/B9W56+bpjMXaO4vyEsoB7IH+QXnjgsfD4r5P0AG9d7eXFBuivDLQVa4eG9P+LQ+i7XDdn0nvJz1oEwRbUsC6tQMin70asoRy+FLA/RxgylPM+ZTgFbTAfkboyaUtqXgD1knbsfQQWmBvY0tDzeYVvO6GD7pv64H8vAa6QAm01CnX10pC6qyde7NopedPC3du7DL5C86LCm7rgAJfsDkN3cr39q/mKyOw8DnD4R7zcofvTr4ytU1fEqjV5eNKY+ZtEexFIgZ9O50KLb4qjigzwt6HHBU+SMjg==&amp;cv=2.0&amp;url=http://sale.jd.com/act/1pChm0RcanBPYXIS.html" target="_blank">更多京东服务相关活动 &gt; </a>\r\n	</div>\r\n</div>\r\n<div class="ui-box" id="promises">\r\n	<strong>服务承诺：</strong><br />\r\n京东平台卖家销售并发货的商品，由平台卖家提供发票和相应的售后服务。请您放心购买！<br />\r\n注：因厂家会在没有任何提前通知的情况下更改产品包装、产地或者一些附件，本司不能确保客户收到的货物与商城图片、产地、附件说明完全一致。只能确保为原厂正货！并且保证与当时市场上同样主流新品一致。若本商城没有及时更新，请大家谅解！ <br />\r\n</div>\r\n<br />', '颜色', '黑色、白色、', '中国大陆', '', '', '', 10, '', '', 0);
INSERT INTO `onethink_document_product` VALUES (66, '1.00', '<div class="ui-switchable-panel ui-switchable-panel-selected">\r\n	<div class="mc" id="product-detail-1">\r\n		<div class="detail-content clearfix">\r\n			<div class="detail-content-wrap">\r\n				<div class="detail-content-item">\r\n					<div id="J-detail-pop-tpl-top">\r\n						<p>\r\n							<img alt="" src="http://img10.360buyimg.com/imgzone/jfs/t751/77/1013597273/248907/338afaa8/5511239cNc5ac78e8.jpg" border="0" /> \r\n						</p>\r\n						<p>\r\n							<img alt="" src="http://img10.360buyimg.com/imgzone/jfs/t757/267/934989647/210055/c2d8871e/550946b7Ne614bd11.jpg" /> \r\n						</p>\r\n					</div>\r\n					<div id="J-detail-content">\r\n						<img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t478/16/972345406/467919/5f920a9a/54c0b143Nb565bbcf.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t682/338/1232756534/290787/34fc27c7/54c0b145Nd657ede8.jpg" /> <img alt="" src="http://img10.360buyimg.com/imgzone/jfs/t667/211/1233801542/246875/8c9cba1a/54c0b146N3a0f1242.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t535/275/1219770206/207964/591a100e/54c0b147N4b8aa15f.jpg" /> <img alt="" src="http://img10.360buyimg.com/imgzone/jfs/t595/330/1222871012/194147/f95ec84/54c0b148N13bcc8dc.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t580/267/1230967396/262350/cfe1c8be/54c0b148N75613d15.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t655/63/1242307338/205284/589be0b2/54c0b149Nabbee94d.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t763/27/572674096/130207/f1599b9c/54c0b149N9e8547ef.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t697/8/566006959/146997/df0ab452/54c0b14aN345a6eca.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t469/323/1260790326/286804/2ee7d1e6/54c0b14bN9edddbe7.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t469/324/1231339113/325122/f5bdeebb/54c0b14cNd3e27f13.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t673/349/1240110030/254101/a561b49/54c0b14dN4e721103.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t475/121/1255343474/119478/169316db/54c0b14dN191dec09.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t730/24/579964548/197526/bf92e431/54c0b14eN5787baa1.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t541/28/1283149987/292873/7bb43ae3/54c0b14fNca292ad8.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t550/99/1409383535/324070/6c552691/54c0b14fN743e14fb.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t766/29/577443219/182750/b8fc96b4/54c0b150N091ce3a3.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t700/177/572228437/178013/a1f39406/54c0b151N2ade0b10.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t454/234/1254972438/289244/8cd47aba/54c0b151Nfc33214f.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t661/350/1244707552/320185/8fd27ced/54c0b152N001e7f5d.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t763/46/578515785/309068/1b42ff10/54c0b161N1d74a9cf.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t565/242/1238531075/362491/b0e7139/54c0b161N2ceaca72.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t574/60/1206685788/273586/569adf0b/54c0b163N9864b5eb.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t625/125/1230098446/286758/462cb5b5/54c0b163N1746bb5d.jpg" /> <img class="loading-style2" alt="" src="http://img10.360buyimg.com/imgzone/jfs/t460/359/1225996454/622/8bf7354e/54c0b164N853a5fcb.jpg" /><br />\r\n					</div>\r\n				</div>\r\n			</div>\r\n		</div>\r\n	</div>\r\n</div>\r\n<div class="ui-switchable-panel mc hide" id="product-detail-2">\r\n	<div class="detail-correction">\r\n		如果您发现商品信息不准确，<a href="http://club.360buy.com/jdvote/skucheck.aspx?skuid=1452568268&cid1=9987&cid2=830&cid3=11301" target="_blank">欢迎纠错</a> \r\n	</div>\r\n	<table class="Ptable ke-zeroborder" border="0" cellpadding="0" cellspacing="1" width="100%">\r\n		<tbody>\r\n			<tr>\r\n				<th class="tdTitle" colspan="2">\r\n					主体\r\n				</th>\r\n			</tr>\r\n			<tr>\r\n			</tr>\r\n			<tr>\r\n				<td class="tdTitle">\r\n					适用机型\r\n				</td>\r\n				<td>\r\n					苹果iPhone 6\r\n				</td>\r\n			</tr>\r\n		</tbody>\r\n	</table>\r\n</div>\r\n<div class="ui-switchable-panel hide">\r\n	<div class="mc yb-tab-img" id="J-yb-tab-img">\r\n		<img src="http://img13.360buyimg.com/da/jfs/t829/263/100807689/199942/5d4cf278/54fe5ebeNf4fbebc7.jpg" width="990" /><a href="http://c.nfa.jd.com/adclick?keyStr=z5AXFoIimt1jiDK32+w4mW0bjVYOHZSLtG+kxxFj84wd1CxH/fv6f/B9W56+bpjMXaO4vyEsoB7IH+QXnjgsfD4r5P0AG9d7eXFBuivDLQVa4eG9P+LQ+i7XDdn0nvJz1oEwRbUsC6tQMin70asoRy+FLA/RxgylPM+ZTgFbTAfkboyaUtqXgD1knbsfQQWmBvY0tDzeYVvO6GD7pv64H8vAa6QAm01CnX10pC6qyde7NopedPC3du7DL5C86LCm7rgAJfsDkN3cr39q/mKyOw8DnD4R7zcofvTr4ytU1fEqjV5eNKY+ZtEexFIgZ9O50KLb4qjigzwt6HHBU+SMjg==&cv=2.0&url=http://sale.jd.com/act/1pChm0RcanBPYXIS.html" target="_blank">更多京东服务相关活动 &gt; </a> \r\n	</div>\r\n</div>\r\n<div class="ui-box" id="promises">\r\n	<strong>服务承诺：</strong><br />\r\n京东平台卖家销售并发货的商品，由平台卖家提供发票和相应的售后服务。请您放心购买！<br />\r\n注：因厂家会在没有任何提前通知的情况下更改产品包装、产地或者一些附件，本司不能确保客户收到的货物与商城图片、产地、附件说明完全一致。只能确保为原厂正货！并且保证与当时市场上同样主流新品一致。若本商城没有及时更新，请大家谅解！ <br />\r\n</div>\r\n<br />', '规格', '黑色、白色、灰色、红色', '中国大陆', '268.00、299、296、299', '', '', 10, '', '', 0);
INSERT INTO `onethink_document_product` VALUES (67, '1.00', '<img alt="" src="http://img20.360buyimg.com/vc/jfs/t349/285/1951733059/183818/4d59d3b7/5448ca12N610faac0.jpg" height="845" width="750" /><br />', '选择版本', '套餐1、套餐2、套餐3、套餐4', '中国大陆', '5999.00、6299、6296、6399', '', '', 10, '', '', 0);
INSERT INTO `onethink_document_product` VALUES (69, '1.00', '<img src="http://img10.360buyimg.com/imgzone/jfs/t700/62/1097460735/70748/e559139c/551b85d7N4944ab71.gif" alt="" />', '选择尺码', ' 3人位+单人位+左贵妃、 3人位+单人位+左贵妃', '中国大陆', '299、405', '', '', 10, '', '112,113', 0);



-- -----------------------------
-- Table structure for `onethink_auth_extend`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_auth_extend`;
CREATE TABLE `onethink_auth_extend` (
  `group_id` mediumint(10) unsigned NOT NULL COMMENT '用户id',
  `extend_id` mediumint(8) unsigned NOT NULL COMMENT '扩展表中数据的id',
  `type` tinyint(1) unsigned NOT NULL COMMENT '扩展类型标识 1:栏目分类权限;2:模型权限',
  UNIQUE KEY `group_extend_type` (`group_id`,`extend_id`,`type`),
  KEY `uid` (`group_id`),
  KEY `group_id` (`extend_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户组与分类的对应关系表';

-- -----------------------------
-- Records of `onethink_auth_extend`
-- -----------------------------
INSERT INTO `onethink_auth_extend` VALUES ('1', '1', '1');
INSERT INTO `onethink_auth_extend` VALUES ('1', '1', '2');
INSERT INTO `onethink_auth_extend` VALUES ('1', '2', '1');
INSERT INTO `onethink_auth_extend` VALUES ('1', '2', '2');
INSERT INTO `onethink_auth_extend` VALUES ('1', '3', '1');
INSERT INTO `onethink_auth_extend` VALUES ('1', '3', '2');
INSERT INTO `onethink_auth_extend` VALUES ('1', '4', '1');
INSERT INTO `onethink_auth_extend` VALUES ('1', '37', '1');

-- -----------------------------
-- Table structure for `onethink_auth_group`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_auth_group`;
CREATE TABLE `onethink_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组id,自增主键',
  `module` varchar(20) NOT NULL DEFAULT '' COMMENT '用户组所属模块',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '组类型',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `description` varchar(80) NOT NULL DEFAULT '' COMMENT '描述信息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户组状态：为1正常，为0禁用,-1为删除',
  `rules` varchar(500) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- -----------------------------
-- Records of `onethink_auth_group`
-- -----------------------------
INSERT INTO `onethink_auth_group` VALUES ('1', 'admin', '1', '系统用户组', '', '1', '1,2,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,79,80,81,82,83,84,86,87,88,89,90,91,92,93,94,95,96,97,100,102,103,105,106');
INSERT INTO `onethink_auth_group` VALUES ('2', 'admin', '1', '商家', '商家', '1', '1,2,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,79,80,82,83,84,88,89,90,91,92,93,96,97,100,102,103,195');

-- -----------------------------
-- Table structure for `onethink_auth_group_access`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_auth_group_access`;
CREATE TABLE `onethink_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- -----------------------------
-- Table structure for `onethink_auth_rule`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_auth_rule`;
CREATE TABLE `onethink_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '规则所属module',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1-url;2-主菜单',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  KEY `module` (`module`,`status`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=217 DEFAULT CHARSET=utf8;

-- -----------------------------
-- Records of `onethink_auth_rule`
-- -----------------------------
INSERT INTO `onethink_auth_rule` VALUES ('1', 'admin', '2', 'Admin/Index/index', '首页', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('2', 'admin', '2', 'Admin/Article/index', '内容', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('3', 'admin', '2', 'Admin/User/index', '用户', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('4', 'admin', '2', 'Admin/Addons/index', '扩展', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('5', 'admin', '2', 'Admin/Config/group', '系统', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('7', 'admin', '1', 'Admin/article/add', '新增', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('8', 'admin', '1', 'Admin/article/edit', '编辑', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('9', 'admin', '1', 'Admin/article/setStatus', '改变状态', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('10', 'admin', '1', 'Admin/article/update', '保存', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('11', 'admin', '1', 'Admin/article/autoSave', '保存草稿', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('12', 'admin', '1', 'Admin/article/move', '移动', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('13', 'admin', '1', 'Admin/article/copy', '复制', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('14', 'admin', '1', 'Admin/article/paste', '粘贴', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('15', 'admin', '1', 'Admin/article/permit', '还原', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('16', 'admin', '1', 'Admin/article/clear', '清空', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('17', 'admin', '1', 'Admin/article/examine', '审核列表', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('18', 'admin', '1', 'Admin/article/recycle', '回收站', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('19', 'admin', '1', 'Admin/User/addaction', '新增用户行为', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('20', 'admin', '1', 'Admin/User/editaction', '编辑用户行为', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('21', 'admin', '1', 'Admin/User/saveAction', '保存用户行为', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('22', 'admin', '1', 'Admin/User/setStatus', '变更行为状态', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('23', 'admin', '1', 'Admin/User/changeStatus?method=forbidUser', '禁用会员', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('24', 'admin', '1', 'Admin/User/changeStatus?method=resumeUser', '启用会员', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('25', 'admin', '1', 'Admin/User/changeStatus?method=deleteUser', '删除会员', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('26', 'admin', '1', 'Admin/User/index', '用户信息', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('27', 'admin', '1', 'Admin/User/action', '用户行为', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('28', 'admin', '1', 'Admin/AuthManager/changeStatus?method=deleteGroup', '删除', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('29', 'admin', '1', 'Admin/AuthManager/changeStatus?method=forbidGroup', '禁用', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('30', 'admin', '1', 'Admin/AuthManager/changeStatus?method=resumeGroup', '恢复', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('31', 'admin', '1', 'Admin/AuthManager/createGroup', '新增', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('32', 'admin', '1', 'Admin/AuthManager/editGroup', '编辑', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('33', 'admin', '1', 'Admin/AuthManager/writeGroup', '保存用户组', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('34', 'admin', '1', 'Admin/AuthManager/group', '授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('35', 'admin', '1', 'Admin/AuthManager/access', '访问授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('36', 'admin', '1', 'Admin/AuthManager/user', '成员授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('37', 'admin', '1', 'Admin/AuthManager/removeFromGroup', '解除授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('38', 'admin', '1', 'Admin/AuthManager/addToGroup', '保存成员授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('39', 'admin', '1', 'Admin/AuthManager/category', '分类授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('40', 'admin', '1', 'Admin/AuthManager/addToCategory', '保存分类授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('41', 'admin', '1', 'Admin/AuthManager/index', '权限管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('42', 'admin', '1', 'Admin/Addons/create', '创建', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('43', 'admin', '1', 'Admin/Addons/checkForm', '检测创建', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('44', 'admin', '1', 'Admin/Addons/preview', '预览', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('45', 'admin', '1', 'Admin/Addons/build', '快速生成插件', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('46', 'admin', '1', 'Admin/Addons/config', '设置', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('47', 'admin', '1', 'Admin/Addons/disable', '禁用', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('48', 'admin', '1', 'Admin/Addons/enable', '启用', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('49', 'admin', '1', 'Admin/Addons/install', '安装', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('50', 'admin', '1', 'Admin/Addons/uninstall', '卸载', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('51', 'admin', '1', 'Admin/Addons/saveconfig', '更新配置', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('52', 'admin', '1', 'Admin/Addons/adminList', '插件后台列表', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('53', 'admin', '1', 'Admin/Addons/execute', 'URL方式访问插件', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('54', 'admin', '1', 'Admin/Addons/index', '插件管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('55', 'admin', '1', 'Admin/Addons/hooks', '钩子管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('56', 'admin', '1', 'Admin/model/add', '新增', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('57', 'admin', '1', 'Admin/model/edit', '编辑', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('58', 'admin', '1', 'Admin/model/setStatus', '改变状态', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('59', 'admin', '1', 'Admin/model/update', '保存数据', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('60', 'admin', '1', 'Admin/Model/index', '模型管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('61', 'admin', '1', 'Admin/Config/edit', '编辑', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('62', 'admin', '1', 'Admin/Config/del', '删除', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('63', 'admin', '1', 'Admin/Config/add', '新增', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('64', 'admin', '1', 'Admin/Config/save', '保存', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('65', 'admin', '1', 'Admin/Config/group', '网站设置', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('66', 'admin', '1', 'Admin/Config/index', '配置管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('67', 'admin', '1', 'Admin/Channel/add', '新增', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('68', 'admin', '1', 'Admin/Channel/edit', '编辑', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('69', 'admin', '1', 'Admin/Channel/del', '删除', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('70', 'admin', '1', 'Admin/Channel/index', '导航管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('71', 'admin', '1', 'Admin/Category/edit', '编辑', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('72', 'admin', '1', 'Admin/Category/add', '新增', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('73', 'admin', '1', 'Admin/Category/remove', '删除', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('74', 'admin', '1', 'Admin/Category/index', '分类管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('75', 'admin', '1', 'Admin/file/upload', '上传控件', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('76', 'admin', '1', 'Admin/file/uploadPicture', '上传图片', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('77', 'admin', '1', 'Admin/file/download', '下载', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('94', 'admin', '1', 'Admin/AuthManager/modelauth', '模型授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('79', 'admin', '1', 'Admin/article/batchOperate', '导入', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('80', 'admin', '1', 'Admin/Database/index?type=export', '备份数据库', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('81', 'admin', '1', 'Admin/Database/index?type=import', '还原数据库', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('82', 'admin', '1', 'Admin/Database/export', '备份', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('83', 'admin', '1', 'Admin/Database/optimize', '优化表', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('84', 'admin', '1', 'Admin/Database/repair', '修复表', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('86', 'admin', '1', 'Admin/Database/import', '恢复', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('87', 'admin', '1', 'Admin/Database/del', '删除', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('88', 'admin', '1', 'Admin/User/add', '新增用户', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('89', 'admin', '1', 'Admin/Attribute/index', '属性管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('90', 'admin', '1', 'Admin/Attribute/add', '新增', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('91', 'admin', '1', 'Admin/Attribute/edit', '编辑', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('92', 'admin', '1', 'Admin/Attribute/setStatus', '改变状态', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('93', 'admin', '1', 'Admin/Attribute/update', '保存数据', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('95', 'admin', '1', 'Admin/AuthManager/addToModel', '保存模型授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('96', 'admin', '1', 'Admin/Category/move', '移动', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('97', 'admin', '1', 'Admin/Category/merge', '合并', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('98', 'admin', '1', 'Admin/Config/menu', '后台菜单管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('99', 'admin', '1', 'Admin/Article/mydocument', '内容', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('100', 'admin', '1', 'Admin/Menu/index', '菜单管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('101', 'admin', '1', 'Admin/other', '其他', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('102', 'admin', '1', 'Admin/Menu/add', '新增', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('103', 'admin', '1', 'Admin/Menu/edit', '编辑', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('104', 'admin', '1', 'Admin/Think/lists?model=article', '文章管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('105', 'admin', '1', 'Admin/Think/lists?model=download', '下载管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('106', 'admin', '1', 'Admin/Think/lists?model=config', '配置管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('107', 'admin', '1', 'Admin/Action/actionlog', '行为日志', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('108', 'admin', '1', 'Admin/User/updatePassword', '修改密码', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('109', 'admin', '1', 'Admin/User/updateNickname', '修改昵称', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('110', 'admin', '1', 'Admin/action/edit', '查看行为日志', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('205', 'admin', '1', 'Admin/think/add', '新增数据', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('111', 'admin', '2', 'Admin/article/index', '文档列表', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('112', 'admin', '2', 'Admin/article/add', '新增', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('113', 'admin', '2', 'Admin/article/edit', '编辑', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('114', 'admin', '2', 'Admin/article/setStatus', '改变状态', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('115', 'admin', '2', 'Admin/article/update', '保存', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('116', 'admin', '2', 'Admin/article/autoSave', '保存草稿', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('117', 'admin', '2', 'Admin/article/move', '移动', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('118', 'admin', '2', 'Admin/article/copy', '复制', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('119', 'admin', '2', 'Admin/article/paste', '粘贴', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('120', 'admin', '2', 'Admin/article/batchOperate', '导入', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('121', 'admin', '2', 'Admin/article/recycle', '回收站', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('122', 'admin', '2', 'Admin/article/permit', '还原', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('123', 'admin', '2', 'Admin/article/clear', '清空', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('124', 'admin', '2', 'Admin/User/add', '新增用户', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('125', 'admin', '2', 'Admin/User/action', '用户行为', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('126', 'admin', '2', 'Admin/User/addAction', '新增用户行为', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('127', 'admin', '2', 'Admin/User/editAction', '编辑用户行为', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('128', 'admin', '2', 'Admin/User/saveAction', '保存用户行为', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('129', 'admin', '2', 'Admin/User/setStatus', '变更行为状态', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('130', 'admin', '2', 'Admin/User/changeStatus?method=forbidUser', '禁用会员', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('131', 'admin', '2', 'Admin/User/changeStatus?method=resumeUser', '启用会员', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('132', 'admin', '2', 'Admin/User/changeStatus?method=deleteUser', '删除会员', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('133', 'admin', '2', 'Admin/AuthManager/index', '权限管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('134', 'admin', '2', 'Admin/AuthManager/changeStatus?method=deleteGroup', '删除', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('135', 'admin', '2', 'Admin/AuthManager/changeStatus?method=forbidGroup', '禁用', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('136', 'admin', '2', 'Admin/AuthManager/changeStatus?method=resumeGroup', '恢复', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('137', 'admin', '2', 'Admin/AuthManager/createGroup', '新增', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('138', 'admin', '2', 'Admin/AuthManager/editGroup', '编辑', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('139', 'admin', '2', 'Admin/AuthManager/writeGroup', '保存用户组', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('140', 'admin', '2', 'Admin/AuthManager/group', '授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('141', 'admin', '2', 'Admin/AuthManager/access', '访问授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('142', 'admin', '2', 'Admin/AuthManager/user', '成员授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('143', 'admin', '2', 'Admin/AuthManager/removeFromGroup', '解除授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('144', 'admin', '2', 'Admin/AuthManager/addToGroup', '保存成员授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('145', 'admin', '2', 'Admin/AuthManager/category', '分类授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('146', 'admin', '2', 'Admin/AuthManager/addToCategory', '保存分类授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('147', 'admin', '2', 'Admin/AuthManager/modelauth', '模型授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('148', 'admin', '2', 'Admin/AuthManager/addToModel', '保存模型授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('149', 'admin', '2', 'Admin/Addons/create', '创建', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('150', 'admin', '2', 'Admin/Addons/checkForm', '检测创建', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('151', 'admin', '2', 'Admin/Addons/preview', '预览', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('152', 'admin', '2', 'Admin/Addons/build', '快速生成插件', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('153', 'admin', '2', 'Admin/Addons/config', '设置', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('154', 'admin', '2', 'Admin/Addons/disable', '禁用', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('155', 'admin', '2', 'Admin/Addons/enable', '启用', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('156', 'admin', '2', 'Admin/Addons/install', '安装', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('157', 'admin', '2', 'Admin/Addons/uninstall', '卸载', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('158', 'admin', '2', 'Admin/Addons/saveconfig', '更新配置', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('159', 'admin', '2', 'Admin/Addons/adminList', '插件后台列表', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('160', 'admin', '2', 'Admin/Addons/execute', 'URL方式访问插件', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('161', 'admin', '2', 'Admin/Addons/hooks', '钩子管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('162', 'admin', '2', 'Admin/Model/index', '模型管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('163', 'admin', '2', 'Admin/model/add', '新增', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('164', 'admin', '2', 'Admin/model/edit', '编辑', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('165', 'admin', '2', 'Admin/model/setStatus', '改变状态', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('166', 'admin', '2', 'Admin/model/update', '保存数据', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('167', 'admin', '2', 'Admin/Attribute/index', '属性管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('168', 'admin', '2', 'Admin/Attribute/add', '新增', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('169', 'admin', '2', 'Admin/Attribute/edit', '编辑', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('170', 'admin', '2', 'Admin/Attribute/setStatus', '改变状态', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('171', 'admin', '2', 'Admin/Attribute/update', '保存数据', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('172', 'admin', '2', 'Admin/Config/index', '配置管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('173', 'admin', '2', 'Admin/Config/edit', '编辑', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('174', 'admin', '2', 'Admin/Config/del', '删除', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('175', 'admin', '2', 'Admin/Config/add', '新增', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('176', 'admin', '2', 'Admin/Config/save', '保存', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('177', 'admin', '2', 'Admin/Menu/index', '菜单管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('178', 'admin', '2', 'Admin/Channel/index', '导航管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('179', 'admin', '2', 'Admin/Channel/add', '新增', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('180', 'admin', '2', 'Admin/Channel/edit', '编辑', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('181', 'admin', '2', 'Admin/Channel/del', '删除', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('182', 'admin', '2', 'Admin/Category/index', '分类管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('183', 'admin', '2', 'Admin/Category/edit', '编辑', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('184', 'admin', '2', 'Admin/Category/add', '新增', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('185', 'admin', '2', 'Admin/Category/remove', '删除', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('186', 'admin', '2', 'Admin/Category/move', '移动', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('187', 'admin', '2', 'Admin/Category/merge', '合并', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('188', 'admin', '2', 'Admin/Database/index?type=export', '备份数据库', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('189', 'admin', '2', 'Admin/Database/export', '备份', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('190', 'admin', '2', 'Admin/Database/optimize', '优化表', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('191', 'admin', '2', 'Admin/Database/repair', '修复表', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('192', 'admin', '2', 'Admin/Database/index?type=import', '还原数据库', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('193', 'admin', '2', 'Admin/Database/import', '恢复', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('194', 'admin', '2', 'Admin/Database/del', '删除', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('195', 'admin', '2', 'Admin/other', '其他', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('196', 'admin', '2', 'Admin/Menu/add', '新增', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('197', 'admin', '2', 'Admin/Menu/edit', '编辑', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('198', 'admin', '2', 'Admin/Think/lists?model=article', '应用', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('199', 'admin', '2', 'Admin/Think/lists?model=download', '下载管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('200', 'admin', '2', 'Admin/Think/lists?model=config', '应用', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('201', 'admin', '2', 'Admin/Action/actionlog', '行为日志', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('202', 'admin', '2', 'Admin/User/updatePassword', '修改密码', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('203', 'admin', '2', 'Admin/User/updateNickname', '修改昵称', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('204', 'admin', '2', 'Admin/action/edit', '查看行为日志', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('206', 'admin', '1', 'Admin/think/edit', '编辑数据', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('207', 'admin', '1', 'Admin/Menu/import', '导入', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('208', 'admin', '1', 'Admin/Model/generate', '生成', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('209', 'admin', '1', 'Admin/Addons/addHook', '新增钩子', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('210', 'admin', '1', 'Admin/Addons/edithook', '编辑钩子', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('211', 'admin', '1', 'Admin/Article/sort', '文档排序', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('212', 'admin', '1', 'Admin/Config/sort', '排序', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('213', 'admin', '1', 'Admin/Menu/sort', '排序', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('214', 'admin', '1', 'Admin/Channel/sort', '排序', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('215', 'admin', '1', 'Admin/Category/operate/type/move', '移动', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('216', 'admin', '1', 'Admin/Category/operate/type/merge', '合并', '1', '');

-- -----------------------------
-- Table structure for `onethink_category`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_category`;
CREATE TABLE `onethink_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(30) NOT NULL COMMENT '标志',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `list_row` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '列表每页行数',
  `meta_title` varchar(50) NOT NULL DEFAULT '' COMMENT 'SEO的网页标题',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `template_index` varchar(100) NOT NULL COMMENT '频道页模板',
  `template_lists` varchar(100) NOT NULL COMMENT '列表页模板',
  `template_detail` varchar(100) NOT NULL COMMENT '详情页模板',
  `template_edit` varchar(100) NOT NULL COMMENT '编辑页模板',
  `model` varchar(100) NOT NULL DEFAULT '' COMMENT '列表绑定模型',
  `model_sub` varchar(100) NOT NULL DEFAULT '' COMMENT '子文档绑定模型',
  `type` varchar(100) NOT NULL DEFAULT '' COMMENT '允许发布的内容类型',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `allow_publish` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许发布内容',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '可见性',
  `reply` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许回复',
  `check` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发布的文章是否需要审核',
  `reply_model` varchar(100) NOT NULL DEFAULT '',
  `extend` text NOT NULL COMMENT '扩展设置',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `icon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类图标',
  `ismenu` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类是否调用',
  PRIMARY KEY (`id`),
   UNIQUE KEY `uk_name` (`name`) USING BTREE,
  KEY `pid` (`pid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=130 DEFAULT CHARSET=utf8 COMMENT='分类表';

-- -----------------------------
-- Records of `onethink_category`
-- -----------------------------
INSERT INTO `onethink_category` VALUES (52, 'fruit', '食品饮料、酒类、生鲜', 0, 7, 10, '', '', '', '', '', '', '', '5', '5', '2', 0, 1, 1, 0, 0, '', '', 1411925214, 1421425856, 1, 85, 1);
INSERT INTO `onethink_category` VALUES (127, 'lizi', '梨', 57, 0, 10, '', '', '', '', '', '', '', '5', '5', '', 0, 1, 1, 0, 0, '', '', 1421503470, 1421503470, 1, 0, 0);
INSERT INTO `onethink_category` VALUES (58, 'j_fruit', '进口水果', 52, 0, 10, '', '', '', '', '', '', '', '5', '5', '2', 0, 1, 1, 0, 0, '', '', 1411935041, 1421425884, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (56, 'notice', '公告', 0, 8, 10, '', '', '', '', '', '', '', '2', '2', '2', 0, 1, 1, 0, 1, '', '', 1411929200, 1422882794, 1, 0, 0);
INSERT INTO `onethink_category` VALUES (57, 'c_fruit', '国内水果', 52, 0, 10, '', '', '', '', '', '', '', '5', '2,5', '2,1,3', 0, 1, 1, 0, 0, '', '', 1411934874, 1422719396, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (70, 'activity', '活动', 0, 0, 10, '', '', '', '', '', '', '', '2', '2', '2,1,3', 0, 1, 1, 0, 0, '', '', 1414338807, 1414338807, 1, 0, 0);
INSERT INTO `onethink_category` VALUES (71, 'tushu', '图书、音像、数字商品', 0, 4, 10, '', '', '', '', '', '', '', '7', '7', '2', 0, 1, 1, 0, 0, '', '', 1414344085, 1420956824, 1, 86, 1);
INSERT INTO `onethink_category` VALUES (72, 'xie', '珠宝、钟表', 0, 0, 10, '', '', '', '', '', '', '', '5', '5', '2,1,3', 0, 1, 1, 0, 0, '', '', 1414674812, 1421415890, 1, 62, 1);
INSERT INTO `onethink_category` VALUES (73, 'car', '整车、汽车用品', 0, 0, 10, '', '', '', '', '', '', '', '5', '5', '2,1,3', 0, 1, 1, 0, 0, '', '', 1414674847, 1421388297, 1, 62, 1);
INSERT INTO `onethink_category` VALUES (75, 'fushi', '男装、女装、鞋包', 0, 5, 10, '', '', '', '', '', '', '', '8', '5', '2,1,3', 0, 1, 1, 0, 0, '', '', 1414674964, 1421391978, 1, 88, 1);
INSERT INTO `onethink_category` VALUES (76, 'jiaju', '母婴、玩具乐器', 0, 0, 10, '', '', '', '', '', '', '', '5', '5', '2,1,3', 0, 1, 1, 0, 0, '', '', 1414675003, 1421388267, 1, 57, 1);
INSERT INTO `onethink_category` VALUES (77, 'gmlc', '购买流程', 0, 0, 10, '', '', '', '', '', '', '', '2', '2', '2', 0, 1, 1, 0, 0, '', '', 1415464640, 1415464640, 1, 0, 2);
INSERT INTO `onethink_category` VALUES (126, 'apple', '苹果', 57, 0, 10, '', '', '', '', '', '', '', '5', '5', '2', 0, 1, 1, 0, 0, '', '', 1421502954, 1421502954, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (81, 'ebook', '电子书', 71, 0, 10, '', '', '', '', '', '', '', '7', '', '', 0, 1, 1, 0, 0, '', '', 1420956858, 1420956858, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (82, 'mianfei', '免费', 81, 0, 10, '', '', '', '', '', '', '', '7', '5', '2', 0, 1, 1, 0, 0, '', '', 1420956901, 1420956901, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (83, 'emusic', '数字音乐', 81, 0, 10, '', '', '', '', '', '', '', '7', '5', '2', 0, 1, 1, 0, 0, '', '', 1420959330, 1420960517, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (84, 'yinxiang', '  音像', 81, 0, 10, '', '', '', '', '', '', '', '7', '5', '2', 0, 1, 1, 0, 0, '', '', 1420960144, 1420960144, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (86, 'renwensheke', '人文社科', 71, 0, 10, '', '', '', '', '', '', '', '7', '5', '2', 0, 1, 1, 0, 0, '', '', 1420960622, 1420960622, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (87, 'history', '历史', 86, 0, 10, '', '', '', '', '', '', '', '7', '7', '2', 0, 1, 1, 0, 0, '', '', 1420960661, 1420960661, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (88, 'xinli', '心理学', 86, 0, 10, '', '', '', '', '', '', '', '7', '7', '2', 0, 1, 1, 0, 0, '', '', 1420960700, 1420960711, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (108, 'qingjie', '清洁', 106, 0, 10, '', '', '', '', '', '', '', '5', '5', '2', 0, 1, 1, 0, 0, '', '', 1420963449, 1420963449, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (92, 'nvxie', '女鞋', 72, 0, 10, '', '', '', '', '', '', '', '8', '8', '2', 0, 1, 1, 0, 0, '', '', 1420961778, 1420961778, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (90, 'gex', '个护化妆', 0, 0, 10, '', '', '', '', '', '', '', '5', '5', '2,1,3', 0, 1, 1, 0, 0, '', '', 1420961431, 1421388355, 1, 59, 1);
INSERT INTO `onethink_category` VALUES (93, 'nvxue', '女靴', 92, 0, 10, '', '', '', '', '', '', '', '8', '5', '2', 0, 1, 1, 0, 0, '', '', 1420961856, 1420961856, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (94, 'nanxie', '男鞋', 72, 0, 10, '', '', '', '', '', '', '', '8', '8', '2', 0, 1, 1, 0, 0, '', '', 1420961909, 1420961909, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (96, 'yundongxie', '运动鞋', 94, 0, 10, '', '', '', '', '', '', '', '5', '5', '2', 0, 1, 1, 0, 0, '', '', 1420962056, 1420962056, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (97, 'quanbuche', '全部整车', 73, 0, 10, '', '', '', '', '', '', '', '5', '5', '2', 0, 1, 1, 0, 0, '', '', 1420962156, 1420962156, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (98, 'xiaoxingche', '小型车', 97, 0, 10, '', '', '', '', '', '', '', '5', '5', '2', 0, 1, 1, 0, 0, '', '', 1420962208, 1420962208, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (99, 'nvbao', '女包', 72, 0, 10, '', '', '', '', '', '', '', '8', '5', '2', 0, 1, 1, 0, 0, '', '', 1420962320, 1420962320, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (100, 'danjianbao', '单肩包', 99, 0, 10, '', '', '', '', '', '', '', '5', '8', '2', 0, 1, 1, 0, 0, '', '', 1420962475, 1420962475, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (101, 'shoutibao', '手提包', 99, 0, 10, '', '', '', '', '', '', '', '5', '8', '2', 0, 1, 1, 0, 0, '', '', 1420962560, 1420962560, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (102, 'weixiubaoyang', '维修保养', 73, 0, 10, '', '', '', '', '', '', '', '5', '5', '2', 0, 1, 1, 0, 0, '', '', 1420962736, 1420962736, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (103, 'yunhuayou', '润滑油', 102, 0, 10, '', '', '', '', '', '', '', '5', '5', '2', 0, 1, 1, 0, 0, '', '', 1420962815, 1420962815, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (109, 'dianchi', '电池', 105, 0, 10, '', '', '', '', '', '', '', '2,5', '6', '2', 0, 1, 1, 0, 0, '', '', 1420963534, 1421426883, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (104, 'shoujitx', '手机通信', 107, 0, 10, '', '', '', '', '', '', '', '5', '6', '2', 0, 1, 1, 0, 0, '', '', 1420963032, 1420963107, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (105, 'shoujipj', '手机配件', 107, 0, 10, '', '', '', '', '', '', '', '5', '6', '2', 0, 1, 1, 0, 0, '', '', 1420963151, 1420963151, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (106, 'mbhli', '面部护肤', 90, 0, 10, '', '', '', '', '', '', '', '5', '', '2', 0, 1, 1, 0, 0, '', '', 1420963200, 1420963200, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (107, 'sjsmtx', '手机、数码、通信', 0, 6, 10, '', '', '', '', '', '', '', '6', '6', '2', 0, 1, 1, 0, 0, '', '', 1420963286, 1421388202, 1, 87, 1);
INSERT INTO `onethink_category` VALUES (110, 'mobilephone', '手机', 104, 0, 10, '', '', '', '', '', '', '', '6', '6', '2', 0, 1, 1, 0, 0, '', '""', 1420963589, 1428684577, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (111, 'jiajujiaz', '家居、家具、家装', 0, 0, 10, '', '', '', '', '', '', '', '5', '5', '2', 0, 1, 1, 0, 0, '', '', 1420963642, 1421388233, 1, 56, 1);
INSERT INTO `onethink_category` VALUES (112, 'chuju', '厨具', 111, 0, 10, '', '', '', '', '', '', '', '5', '5', '2', 0, 1, 1, 0, 0, '', '', 1420963698, 1420963698, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (113, 'prcju', '烹饪厨具', 112, 0, 10, '', '', '', '', '', '', '', '5', '5', '2', 0, 1, 1, 0, 0, '', '', 1420963764, 1420963764, 1, 0, 0);
INSERT INTO `onethink_category` VALUES (114, 'daojiancb', '刀剪菜板', 112, 0, 10, '', '', '', '', '', '', '', '5', '5', '2', 0, 1, 1, 0, 0, '', '', 1420963850, 1420963850, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (115, 'nanzhuang', '男装', 75, 0, 10, '', '', '', '', '', '', '', '8', '5', '2', 0, 1, 1, 0, 0, '', '', 1420964463, 1420964463, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (116, 'chenshan', '衬衫', 115, 0, 10, '', '', '', '', '', '', '', '8', '5', '2', 0, 1, 1, 0, 0, '', '', 1420964510, 1420964510, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (117, 'nvzhuang', '女装', 75, 0, 10, '', '', '', '', '', '', '', '8', '5', '2', 0, 1, 1, 0, 0, '', '', 1420964548, 1420964548, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (118, 'fushipj', '服饰配件', 75, 0, 10, '', '', '', '', '', '', '', '8', '5', '2', 0, 1, 1, 0, 0, '', '', 1420964671, 1420964671, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (119, 'zbss', '珠宝首饰', 75, 0, 10, '', '', '', '', '', '', '', '5', '5', '2', 0, 1, 1, 0, 0, '', '', 1420964736, 1420964736, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (120, 'milk', '奶粉', 76, 0, 10, '', '', '', '', '', '', '', '5', '5', '2', 0, 1, 1, 0, 0, '', '', 1420965368, 1420965391, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (121, 'yyfs', '营养辅食', 76, 0, 10, '', '', '', '', '', '', '', '5', '5', '2', 0, 1, 1, 0, 0, '', '', 1420965451, 1420965451, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (122, 'dha', 'DHA', 121, 0, 10, '', '', '', '', '', '', '', '5', '5', '2', 0, 1, 1, 0, 0, '', '', 1420965492, 1420965492, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (123, 'tyj', '太阳镜', 118, 0, 10, '', '', '', '', '', '', '', '5', '5', '2', 0, 1, 1, 0, 0, '', '', 1420965553, 1420965553, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (124, 'clz', '车厘子', 58, 0, 10, '', '', '', '', '', '', '', '5', '5', '2', 0, 1, 1, 0, 0, '', '', 1420965600, 1420965600, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (128, 'ju', '橘', 57, 0, 10, '', '', '', '', '', '', '', '5', '5', '2', 0, 1, 1, 0, 0, '', '', 1421503503, 1421503503, 1, 0, 0);
INSERT INTO `onethink_category` VALUES (129, 'yurf', '羽绒服', 115, 0, 10, '', '', '', '', '', '', '', '8', '5', '2', 0, 1, 1, 0, 0, '', '', 1421591035, 1421591035, 1, 0, 1);
INSERT INTO `onethink_category` VALUES (131, 'fpsm', '发票说明', 77, 0, 10, '', '', '', '', '', '', '', '2', '2', '2', 0, 1, 1, 0, 0, '', '', 1423763497, 1423763497, 1, 0, 2);
INSERT INTO `onethink_category` VALUES (132, 'yhqsm', '优惠券说明', 77, 0, 10, '', '', '', '', '', '', '', '2', '2', '2', 0, 1, 1, 0, 0, '', '', 1423763557, 1423763557, 1, 0, 0);
INSERT INTO `onethink_category` VALUES (133, 'psfs', '配送方式', 0, 0, 10, '', '', '', '', '', '', '', '2', '2', '', 0, 1, 1, 0, 0, '', '', 1423763793, 1423763793, 1, 0, 2);
INSERT INTO `onethink_category` VALUES (134, 'peis', '配送方式', 133, 0, 10, '', '', '', '', '', '', '', '2', '2', '2', 0, 1, 1, 0, 0, '', '', 1423764073, 1423764073, 1, 0, 2);
INSERT INTO `onethink_category` VALUES (135, 'psfy', '配送费用', 133, 0, 10, '', '', '', '', '', '', '', '2', '2', '2', 0, 1, 1, 0, 0, '', '', 1423764182, 1423764182, 1, 0, 2);
INSERT INTO `onethink_category` VALUES (136, 'qsxz', '签收须知', 133, 0, 10, '', '', '', '', '', '', '', '2', '2', '2', 0, 1, 1, 0, 0, '', '', 1423764441, 1423764441, 1, 0, 2);
INSERT INTO `onethink_category` VALUES (137, 'fwzc', '服务支持', 0, 0, 10, '', '', '', '', '', '', '', '2', '2', '2', 0, 1, 1, 0, 0, '', '', 1423764507, 1423764507, 1, 0, 2);
INSERT INTO `onethink_category` VALUES (138, 'fwbz', '服务保证', 137, 0, 10, '', '', '', '', '', '', '', '2', '2', '2', 0, 1, 1, 0, 0, '', '', 1423764556, 1423764556, 1, 0, 2);
INSERT INTO `onethink_category` VALUES (139, 'shfw', '售后服务', 137, 0, 10, '', '', '', '', '', '', '', '2', '2', '2', 0, 1, 1, 0, 0, '', '', 1423764596, 1423764596, 1, 0, 2);
INSERT INTO `onethink_category` VALUES (140, 'shwd', '售后网点', 137, 0, 10, '', '', '', '', '', '', '', '2', '2', '2', 0, 1, 1, 0, 0, '', '', 1423764648, 1423764648, 1, 0, 2);
INSERT INTO `onethink_category` VALUES (141, 'ppfw', '品牌服务', 0, 0, 10, '', '', '', '', '', '', '', '2', '2', '2', 0, 1, 1, 0, 0, '', '', 1423764705, 1423764705, 1, 0, 2);
INSERT INTO `onethink_category` VALUES (142, 'cjwt', '常见问题', 141, 0, 10, '', '', '', '', '', '', '', '2', '2', '2', 0, 1, 1, 0, 0, '', '', 1423764735, 1423764735, 1, 0, 2);
INSERT INTO `onethink_category` VALUES (143, '相关下载', '相关下载', 141, 0, 10, '', '', '', '', '', '', '', '2', '2', '2', 0, 1, 1, 0, 0, '', '', 1423764766, 1423764766, 1, 0, 2);
INSERT INTO `onethink_category` VALUES (144, 'lxwm', '联系我们', 141, 0, 10, '', '', '', '', '', '', '', '2', '2', '2', 0, 1, 1, 0, 0, '', '', 1423764794, 1423764807, 1, 0, 2);


-- -----------------------------
-- Table structure for `onethink_channel`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_channel`;
CREATE TABLE `onethink_channel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '频道ID',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级频道ID',
  `title` char(30) NOT NULL COMMENT '频道标题',
  `url` char(100) NOT NULL COMMENT '频道连接',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '导航排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `target` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '新窗口打开',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- -----------------------------
-- Records of `onethink_channel`
-- -----------------------------
INSERT INTO `onethink_channel` VALUES ('1', '0', '首页', 'Index/index', '1', '1379475111', '1379923177', '1', '0');
INSERT INTO `onethink_channel` VALUES ('2', 0, '团购', 'Tuan/index', 2, 1412872458, 1421573046, 1, 0);
INSERT INTO `onethink_channel` VALUES ('3', 0, '抢购', 'New/index', 3, 1412872458, 1421573046, 1, 0);


-- -----------------------------
-- Table structure for `onethink_config`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_config`;
CREATE TABLE `onethink_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '配置说明',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `value` text NULL  COMMENT '配置值',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `type` (`type`),
  KEY `group` (`group`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- -----------------------------
-- Records of `onethink_config`
-- -----------------------------
INSERT INTO `onethink_config` VALUES ('1', 'WEB_SITE_TITLE', '1', '网站标题', '1', '', '网站标题前台显示标题', '1378898976', '1379235274', '1', 'yershop商城系统', '0');
INSERT INTO `onethink_config` VALUES ('2', 'WEB_SITE_DESCRIPTION', '2', '网站描述', '1', '', '网站搜索引擎描述', '1378898976', '1379235841', '1', 'yershop商城系统', '1');
INSERT INTO `onethink_config` VALUES ('3', 'WEB_SITE_KEYWORD', '2', '网站关键字', '1', '', '网站搜索引擎关键字', '1378898976', '1381390100', '1', 'yershop,OneThink商城，thinkphp商城系统', '8');
INSERT INTO `onethink_config` VALUES ('4', 'WEB_SITE_CLOSE', '4', '关闭站点', '1', '0:关闭,1:开启', '站点关闭后其他用户不能访问，管理员可以正常访问', '1378898976', '1379235296', '1', '1', '1');
INSERT INTO `onethink_config` VALUES ('9', 'CONFIG_TYPE_LIST', '3', '配置类型列表', '4', '', '主要用于数据解析和页面表单的生成', '1378898976', '1379235348', '1', '0:数字\r\n1:字符\r\n2:文本\r\n3:数组\r\n4:枚举', '2');
INSERT INTO `onethink_config` VALUES ('10', 'WEB_SITE_ICP', '1', '网站备案号', '1', '', '设置在网站底部显示的备案号，如“沪ICP备12007941号-2', '1378900335', '1379235859', '1', '', '9');
INSERT INTO `onethink_config` VALUES ('11', 'DOCUMENT_POSITION', '3', '文档推荐位', '2', '', '文档推荐位，推荐到多个位置KEY值相加即可', '1379053380', '1379235329', '1', '1:列表推荐\r\n2:频道推荐\r\n4:首页推荐', '3');
INSERT INTO `onethink_config` VALUES ('12', 'DOCUMENT_DISPLAY', '3', '文档可见性', '2', '', '文章可见性仅影响前台显示，后台不收影响', '1379056370', '1379235322', '1', '0:所有人可见\r\n1:仅注册会员可见\r\n2:仅管理员可见', '4');
INSERT INTO `onethink_config` VALUES ('13', 'COLOR_STYLE', '4', '后台色系', '1', 'default_color:默认\r\nblue_color:紫罗兰', '后台颜色风格', '1379122533', '1379235904', '1', 'default_color', '10');
INSERT INTO `onethink_config` VALUES ('20', 'CONFIG_GROUP_LIST', '3', '配置分组', 4, '', '配置分组', '1379228036', '1414272713', '1', '1:基本\r\n2:内容\r\n3:用户\r\n4:系统\r\n5:费用\r\n6:商城\r\n7:接口\r\n8:邮箱\r\n9:短信', '4');
INSERT INTO `onethink_config` VALUES ('21', 'HOOKS_TYPE', '3', '钩子的类型', '4', '', '类型 1-用于扩展显示内容，2-用于扩展业务处理', '1379313397', '1379313407', '1', '1:视图\r\n2:控制器', '6');
INSERT INTO `onethink_config` VALUES ('22', 'AUTH_CONFIG', '3', 'Auth配置', '4', '', '自定义Auth.class.php类配置', '1379409310', '1379409564', '1', 'AUTH_ON:1\r\nAUTH_TYPE:2', '8');
INSERT INTO `onethink_config` VALUES ('23', 'OPEN_DRAFTBOX', '4', '是否开启草稿功能', '2', '0:关闭草稿功能\r\n1:开启草稿功能\r\n', '新增文章时的草稿功能配置', '1379484332', '1379484591', '1', '1', '1');
INSERT INTO `onethink_config` VALUES ('24', 'DRAFT_AOTOSAVE_INTERVAL', '0', '自动保存草稿时间', '2', '', '自动保存草稿的时间间隔，单位：秒', '1379484574', '1386143323', '1', '60', '2');
INSERT INTO `onethink_config` VALUES ('25', 'LIST_ROWS', '0', '后台每页记录数', '2', '', '后台数据每页显示记录数', '1379503896', '1380427745', '1', '10', '10');
INSERT INTO `onethink_config` VALUES ('26', 'USER_ALLOW_REGISTER', '4', '是否允许用户注册', '3', '0:关闭注册\r\n1:允许注册', '是否开放用户注册', '1379504487', '1379504580', '1', '1', '3');
INSERT INTO `onethink_config` VALUES ('27', 'CODEMIRROR_THEME', '4', '预览插件的CodeMirror主题', '4', '3024-day:3024 day\r\n3024-night:3024 night\r\nambiance:ambiance\r\nbase16-dark:base16 dark\r\nbase16-light:base16 light\r\nblackboard:blackboard\r\ncobalt:cobalt\r\neclipse:eclipse\r\nelegant:elegant\r\nerlang-dark:erlang-dark\r\nlesser-dark:lesser-dark\r\nmidnight:midnight', '详情见CodeMirror官网', '1379814385', '1384740813', '1', 'ambiance', '3');
INSERT INTO `onethink_config` VALUES ('28', 'DATA_BACKUP_PATH', '1', '数据库备份根路径', '4', '', '路径必须以 / 结尾', '1381482411', '1381482411', '1', './Data/', '5');
INSERT INTO `onethink_config` VALUES ('29', 'DATA_BACKUP_PART_SIZE', '0', '数据库备份卷大小', '4', '', '该值用于限制压缩后的分卷最大长度。单位：B；建议设置20M', '1381482488', '1381729564', '1', '20971520', '7');
INSERT INTO `onethink_config` VALUES ('30', 'DATA_BACKUP_COMPRESS', '4', '数据库备份文件是否启用压缩', '4', '0:不压缩\r\n1:启用压缩', '压缩备份文件需要PHP环境支持gzopen,gzwrite函数', '1381713345', '1381729544', '1', '1', '9');
INSERT INTO `onethink_config` VALUES ('31', 'DATA_BACKUP_COMPRESS_LEVEL', '4', '数据库备份文件压缩级别', '4', '1:普通\r\n4:一般\r\n9:最高', '数据库备份文件的压缩级别，该配置在开启压缩时生效', '1381713408', '1381713408', '1', '9', '10');
INSERT INTO `onethink_config` VALUES ('32', 'DEVELOP_MODE', '4', '开启开发者模式', '4', '0:关闭\r\n1:开启', '是否开启开发者模式', '1383105995', '1383291877', '1', '1', '11');
INSERT INTO `onethink_config` VALUES ('33', 'ALLOW_VISIT', '3', '不受限控制器方法', '0', '', '', '1386644047', '1386644741', '1', '0:article/draftbox\r\n1:article/mydocument\r\n2:Category/tree\r\n3:Index/verify\r\n4:file/upload\r\n5:file/download\r\n6:user/updatePassword\r\n7:user/updateNickname\r\n8:user/submitPassword\r\n9:user/submitNickname\r\n10:file/uploadpicture', '0');
INSERT INTO `onethink_config` VALUES ('34', 'DENY_VISIT', '3', '超管专限控制器方法', '0', '', '仅超级管理员可访问的控制器方法', '1386644141', '1386644659', '1', '0:Addons/addhook\r\n1:Addons/edithook\r\n2:Addons/delhook\r\n3:Addons/updateHook\r\n4:Admin/getMenus\r\n5:Admin/recordList\r\n6:AuthManager/updateRules\r\n7:AuthManager/tree', '0');
INSERT INTO `onethink_config` VALUES ('35', 'REPLY_LIST_ROWS', '0', '回复列表每页条数', '2', '', '', '1386645376', '1387178083', '1', '10', '0');
INSERT INTO `onethink_config` VALUES ('36', 'ADMIN_ALLOW_IP', '2', '后台允许访问IP', '4', '', '多个用逗号分隔，如果不配置表示不限制IP访问', '1387165454', '1387165553', '1', '', '12');
INSERT INTO `onethink_config` VALUES ('37', 'SHOW_PAGE_TRACE', '4', '是否显示页面Trace', '4', '0:关闭\r\n1:开启', '是否显示页面Trace信息', '1387165685', '1387165685', '1', '0', '1');
INSERT INTO `onethink_config` VALUES ('40', 'HOTSEARCH', '1', '热词', '1', '', '热门搜索词，必须逗号隔开', '1413221018', '1414964609', '1', '佳沃智利进口蓝莓,香蕉,苹果,香梨,红提',' 0');
INSERT INTO `onethink_config` VALUES ('41', 'SHIPMONEY', '0', '运费', '5', '', '低于一定金额的运费', '1414001070', '1414001482', '1', '10','0');
INSERT INTO `onethink_config` VALUES (42, 'LOWWEST', 0, '最低消费金额', 5, '', '用户最低消费的金额，低于该金额，则增加运费', 1414001165, 1414001495, 1, '50', 0);
INSERT INTO `onethink_config` VALUES (43, 'RATIO', 0, '积分现金兑换比', 5, '', '1000表示1000积分可兑换成1元', 1414153401, 1414153401, 1, '1000', 0);
INSERT INTO `onethink_config` VALUES (44, 'DEADTIME', 0, '退货有效期', 5, '', '从订单签收完成多少天内可以退货', 1414164561, 1414164642, 1, '7', 0);
INSERT INTO `onethink_config` VALUES (45, 'CHANGETIME', 1, '换货期', 5, '', '订单签收多少天内后可以换货', 1414164627, 1414164654, 1, '15', 0);
INSERT INTO `onethink_config` VALUES (46, 'QQ', 1, 'QQ客服', 6, '', '网站客服的qq代码', 1414183635, 1414664781, 1, '1010422715', 0);
INSERT INTO `onethink_config` VALUES (47, 'ALWW', 0, '阿里旺旺号', 6, '', '网站阿里旺旺客服', 1414183716, 1414664772, 1, '', 0);
INSERT INTO `onethink_config` VALUES (48, 'IP_TONGJI', 4, '开启ip访问统计', 3, '0:关闭,1:开启', '开启后追踪用户的访问页面，访问明细，访问地域', 1414244159, 1414244270, 1, '1', 0);
INSERT INTO `onethink_config` VALUES (49, 'LAG', 0, '统计时间间隔（小时）', 3, '', '重复访问的会员每隔多少时间统计，小于这一时间，不统计', 1414258358, 1414407504, 1, '6', 21);
INSERT INTO `onethink_config` VALUES (50, 'DOMAIN', 1, '网站域名', 1, '', '网站域名', 1414504643, 1414504839, 1, 'http://www.yershop.com', 0);
INSERT INTO `onethink_config` VALUES (51, '100KEY', 1, '0-快递100查询key', 7, '', '申请地址：http://www.kuaidi100.com/openapi/applyapi.shtml，用于查询运单号', 1414664721, 1415473565, 1, '', 0);
INSERT INTO `onethink_config` VALUES (52, 'ADDRESS', 1, '发货地址', 6, '', '卖家的发货地址', 1414664871, 1414664871, 1, '广东广州', 0);
INSERT INTO `onethink_config` VALUES (53, 'CONTACT', 1, '联系电话', 6, '', '卖家的联系方式', 1414664911, 1414664911, 1, '13645000000', 0);
INSERT INTO `onethink_config` VALUES (54, 'SHOPNAME', 1, '卖家名称', 6, '', '卖家发货时填写的昵称', 1414665008, 1414665008, 1, '小米', 0);
INSERT INTO `onethink_config` VALUES (55, 'SITENAME', 1, '网站名称', 1, '', '用于网站支付时显示，如土豆网', 1414761363, 1414761398, 1, 'yershop商城', 0);
INSERT INTO `onethink_config` VALUES (56, 'ALIPAYPARTNER', 1, '1-支付宝商户号', 7, '', '这里是你在成功申请支付宝接口后获取到的PID', 1414769351, 1415137270, 1, '', 0);
INSERT INTO `onethink_config` VALUES (57, 'ALIPAYKEY', 1, '支付宝密钥', 7, '', '这里是你在成功申请支付宝接口后获取到的Key', 1414769402, 1414769402, 1, '', 0);
INSERT INTO `onethink_config` VALUES (67, 'TENPAYPARTNER', 1, '2-财付通合作者ID', 7, '', '合作者ID，财付通有该配置，开通财付通账户后给予', 1415472468, 1415473488, 1, '', 1);
INSERT INTO `onethink_config` VALUES (66, 'TENPAYKEY', 1, '财付通加密key', 7, '', '加密key，开通财付通账户后给予', 1415472288, 1415473499, 1, '', 2);
INSERT INTO `onethink_config` VALUES (68, 'PALPAYPARTNER', 1, '3-贝宝账号', 7, '', '合作者ID，贝宝有该配置，开通贝宝账户后给予不需密码', 1415472655, 1415473914, 1, '', 3);
INSERT INTO `onethink_config` VALUES (69, 'YEEPAYPARTNER', 1, '4-易付宝合作者id', 7, '', '易付宝给予的合作者id', 1415472817, 1415473522, 1, '', 4);
INSERT INTO `onethink_config` VALUES (64, 'ALIPAYEMAIL', 1, '支付宝收款账号', 7, '', '支付宝收款账号邮箱', 1415472043, 1415472347, 1, '', 0);
INSERT INTO `onethink_config` VALUES (70, 'YEEPAYKEY', 1, '易付宝密钥', 7, '', '易付宝合作者的密钥', 1415473084, 1415473533, 1, '', 5);
INSERT INTO `onethink_config` VALUES (71, 'KUAIQIANPARTNER', 1, '5-快钱合作者id', 7, '', '合作者ID，快钱有该配置，开通财付通账户后给予', 1415473241, 1415473540, 1, '', 5);
INSERT INTO `onethink_config` VALUES (72, 'KUAIQIANKEY', 1, '快钱key', 7, '', '加密key，开通快钱账户后给予', 1415473293, 1415473553, 1, '', 5);
INSERT INTO `onethink_config` VALUES (73, 'UNIONPARTNER', 1, '6-银联合作者账号', 7, '', '合作者ID，银联有该配置，开通银联账户后给予', 1415473364, 1415473424, 1, '', 6);
INSERT INTO `onethink_config` VALUES (74, 'UNIONKEY', 1, '银联key', 7, '', ' 加密key，开通银联账户后给予', 1415473475, 1415473475, 1, '', 6);
INSERT INTO `onethink_config` VALUES (75, 'SCODE', 1, '授权码', 1, '', ' 商城的授权码', 1415473475, 1415473475, 1, '', 6);
INSERT INTO `onethink_config` VALUES (76, 'MAIL_HOST', 1, 'smtp服务器的名称', 8, '', ' smtp服务器的名称，默认QQ', 1415473475, 1415473475, 1, '', 6);
INSERT INTO `onethink_config` VALUES (77, 'MAIL_USERNAME', 1, '邮箱用户名', 8, '', ' 邮箱用户名', 1415473475, 1415473475, 1, '', 6);
INSERT INTO `onethink_config` VALUES (78, 'MAIL_FROMNAME', 1, '发件人姓名', 8, '', ' 商城网站名称，如yershop商城，默认QQ', 1415473475, 1415473475, 1, '', 6);
INSERT INTO `onethink_config` VALUES (79, 'MAIL_PASSWORD', 1, '邮箱密码', 8, '', ' 配置的邮箱密码', 1415473475, 1415473475, 1, '', 6);
INSERT INTO `onethink_config` VALUES (80, 'SMSACCOUNT', 1, '1-互亿账号', 9, '', '申请地址：http://www.ihuyi.com/product.php', 1426339726, 1426340118, 1, '', 15);
INSERT INTO `onethink_config` VALUES (81, 'SMSPASSWORD', 1, '互亿密码', 9, '', '互亿提供的密码', 1426339942, 1426340130, 1, '', 16);

;

-- -----------------------------
-- Table structure for `onethink_document_article`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_document_article`;
CREATE TABLE `onethink_document_article` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '文章内容',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `bookmark` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型文章表';

-- -----------------------------
-- Records of `onethink_document_article`
-- -----------------------------
INSERT INTO `onethink_document_article` VALUES ('1', '0', '<h1>\r\n	OneThink1.1开发版发布&nbsp;\r\n</h1>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink是一个开源的内容管理框架，基于最新的ThinkPHP3.2版本开发，提供更方便、更安全的WEB应用开发体验，采用了全新的架构设计和命名空间机制，融合了模块化、驱动化和插件化的设计理念于一体，开启了国内WEB应用傻瓜式开发的新潮流。&nbsp;</strong> \r\n</p>\r\n<h2>\r\n	主要特性：\r\n</h2>\r\n<p>\r\n	1. 基于ThinkPHP最新3.2版本。\r\n</p>\r\n<p>\r\n	2. 模块化：全新的架构和模块化的开发机制，便于灵活扩展和二次开发。&nbsp;\r\n</p>\r\n<p>\r\n	3. 文档模型/分类体系：通过和文档模型绑定，以及不同的文档类型，不同分类可以实现差异化的功能，轻松实现诸如资讯、下载、讨论和图片等功能。\r\n</p>\r\n<p>\r\n	4. 开源免费：OneThink遵循Apache2开源协议,免费提供使用。&nbsp;\r\n</p>\r\n<p>\r\n	5. 用户行为：支持自定义用户行为，可以对单个用户或者群体用户的行为进行记录及分享，为您的运营决策提供有效参考数据。\r\n</p>\r\n<p>\r\n	6. 云端部署：通过驱动的方式可以轻松支持平台的部署，让您的网站无缝迁移，内置已经支持SAE和BAE3.0。\r\n</p>\r\n<p>\r\n	7. 云服务支持：即将启动支持云存储、云安全、云过滤和云统计等服务，更多贴心的服务让您的网站更安心。\r\n</p>\r\n<p>\r\n	8. 安全稳健：提供稳健的安全策略，包括备份恢复、容错、防止恶意攻击登录，网页防篡改等多项安全管理功能，保证系统安全，可靠、稳定的运行。&nbsp;\r\n</p>\r\n<p>\r\n	9. 应用仓库：官方应用仓库拥有大量来自第三方插件和应用模块、模板主题，有众多来自开源社区的贡献，让您的网站“One”美无缺。&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>&nbsp;OneThink集成了一个完善的后台管理体系和前台模板标签系统，让你轻松管理数据和进行前台网站的标签式开发。&nbsp;</strong> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<h2>\r\n	后台主要功能：\r\n</h2>\r\n<p>\r\n	1. 用户Passport系统\r\n</p>\r\n<p>\r\n	2. 配置管理系统&nbsp;\r\n</p>\r\n<p>\r\n	3. 权限控制系统\r\n</p>\r\n<p>\r\n	4. 后台建模系统&nbsp;\r\n</p>\r\n<p>\r\n	5. 多级分类系统&nbsp;\r\n</p>\r\n<p>\r\n	6. 用户行为系统&nbsp;\r\n</p>\r\n<p>\r\n	7. 钩子和插件系统\r\n</p>\r\n<p>\r\n	8. 系统日志系统&nbsp;\r\n</p>\r\n<p>\r\n	9. 数据备份和还原\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	&nbsp;[ 官方下载：&nbsp;<a href=\"http://www.onethink.cn/download.html\" target=\"_blank\">http://www.onethink.cn/download.html</a>&nbsp;&nbsp;开发手册：<a href=\"http://document.onethink.cn/\" target=\"_blank\">http://document.onethink.cn/</a>&nbsp;]&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink开发团队 2013~2014</strong> \r\n</p>', '', '0');

-- -----------------------------
-- Table structure for `onethink_document_download`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_document_download`;
CREATE TABLE `onethink_document_download` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '下载详细描述',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `file_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型下载表';


-- -----------------------------
-- Table structure for `onethink_file`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_file`;
CREATE TABLE `onethink_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '原始文件名',
  `savename` char(20) NOT NULL DEFAULT '' COMMENT '保存名称',
  `savepath` char(30) NOT NULL DEFAULT '' COMMENT '文件保存路径',
  `ext` char(5) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `mime` char(40) NOT NULL DEFAULT '' COMMENT '文件mime类型',
  `size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `location` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '文件保存位置',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '远程地址',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上传时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_md5` (`md5`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文件表';


-- -----------------------------
-- Table structure for `onethink_hooks`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_hooks`;
CREATE TABLE `onethink_hooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `description` text NULL  COMMENT '描述',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `addons` varchar(255) NOT NULL DEFAULT '' COMMENT '钩子挂载的插件 ''，''分割',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- -----------------------------
-- Records of `onethink_hooks`
-- -----------------------------
INSERT INTO `onethink_hooks` VALUES ('1', 'pageHeader', '页面header钩子，一般用于加载插件CSS文件和代码', '1', '0', '', '1');
INSERT INTO `onethink_hooks` VALUES ('2', 'pageFooter', '页面footer钩子，一般用于加载插件JS文件和JS代码', '1', '0', 'ReturnTop', '1');
INSERT INTO `onethink_hooks` VALUES ('3', 'documentEditForm', '添加编辑表单的 扩展内容钩子', '1', '0', 'Attachment', '1');
INSERT INTO `onethink_hooks` VALUES ('4', 'documentDetailAfter', '文档末尾显示', '1', '0', 'Attachment,SocialComment', '1');
INSERT INTO `onethink_hooks` VALUES ('5', 'documentDetailBefore', '页面内容前显示用钩子', '1', '0', '', '1');
INSERT INTO `onethink_hooks` VALUES ('6', 'documentSaveComplete', '保存文档数据后的扩展钩子', '2', '0', 'Attachment', '1');
INSERT INTO `onethink_hooks` VALUES ('7', 'documentEditFormContent', '添加编辑表单的内容显示钩子', '1', '0', 'Editor', '1');
INSERT INTO `onethink_hooks` VALUES ('8', 'adminArticleEdit', '后台内容编辑页编辑器', '1', '1378982734', 'EditorForAdmin', '1');
INSERT INTO `onethink_hooks` VALUES ('13', 'AdminIndex', '首页小格子个性化显示', '1', '1382596073', 'SiteStat,SystemInfo,DevTeam', '1');
INSERT INTO `onethink_hooks` VALUES ('14', 'topicComment', '评论提交方式扩展钩子。', '1', '1380163518', 'Editor', '1');
INSERT INTO `onethink_hooks` VALUES ('16', 'app_begin', '应用开始', '2', '1384481614', '', '1');
INSERT INTO `onethink_hooks` VALUES(28, 'Template', '模版管理插件钩子', 1, 1420796865, 'Template', 1);
INSERT INTO `onethink_hooks` VALUES(23, 'SyncLogin', '第三方账号同步登陆', 1, 1412762818, 'SyncLogin', 1);


-- -----------------------------
-- Table structure for `onethink_member`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_member`;
CREATE TABLE `onethink_member` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `nickname` char(16) NOT NULL DEFAULT '' COMMENT '昵称',
   `account` decimal(50,2) NOT NULL DEFAULT '0' COMMENT '账号余额',
   `paykey`  varchar(225)  NOT NULL DEFAULT '' COMMENT '支付密码',
  `sex` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` varchar(16) NOT NULL DEFAULT '' COMMENT '生日',
  `qq` char(10) NOT NULL DEFAULT '' COMMENT 'qq号',
  `score` mediumint(8) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `login` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '会员状态',
  PRIMARY KEY (`uid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='会员表';


-- -----------------------------
-- Table structure for `onethink_history`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_history`;
CREATE TABLE `onethink_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uid` int(10) unsigned NOT NULL  DEFAULT '0' COMMENT '用户ID',
  `login_ip` varchar(225) DEFAULT '0' COMMENT '注册IP',
  `login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `login_country` varchar(225) DEFAULT '0' COMMENT '登录国家',
  `login_province` varchar(225) DEFAULT '0' COMMENT '登陆省份',
  `login_city` varchar(225) DEFAULT '0' COMMENT '登录城市',
  `login_isp` varchar(225) DEFAULT '0' COMMENT '运营商',
  `login_way` varchar(225) DEFAULT '0' COMMENT '登录方式',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='登录历史表';

-- -----------------------------
-- Table structure for `onethink_menu`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_menu`;
CREATE TABLE `onethink_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '提示',
  `group` varchar(50) DEFAULT '' COMMENT '分组',
  `is_dev` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否仅开发者模式可见',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=122 DEFAULT CHARSET=utf8;

-- -----------------------------
-- Records of `onethink_menu`
-- -----------------------------
INSERT INTO `onethink_menu` VALUES ('1', '首页', '0', '1', 'Index/index', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('2', '文章', '0', '5', 'Article/index', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('3', '文档列表', '2', '0', 'article/index', '1', '', '内容', '0','1');
INSERT INTO `onethink_menu` VALUES ('4', '新增', '3', '0', 'article/add', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('5', '编辑', '3', '0', 'article/edit', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('6', '改变状态', '3', '0', 'article/setStatus', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('7', '保存', '3', '0', 'article/update', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('8', '保存草稿', '3', '0', 'article/autoSave', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('9', '移动', '3', '0', 'article/move', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('10', '复制', '3', '0', 'article/copy', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('11', '粘贴', '3', '0', 'article/paste', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('12', '导入', '3', '0', 'article/batchOperate', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('13', '回收站', '2', '0', 'article/recycle', '1', '', '内容', '0','1');
INSERT INTO `onethink_menu` VALUES ('14', '还原', '13', '0', 'article/permit', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('15', '清空', '13', '0', 'article/clear', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('16', '用户', '0', '8', 'User/index', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('17', '用户信息', '16', '0', 'User/index', '0', '', '用户管理', '0','1');
INSERT INTO `onethink_menu` VALUES ('18', '新增用户', '17', '0', 'User/add', '0', '添加新用户', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('19', '用户行为', '16', '0', 'User/action', '0', '', '行为管理', '0','1');
INSERT INTO `onethink_menu` VALUES ('20', '新增用户行为', '19', '0', 'User/addaction', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('21', '编辑用户行为', '19', '0', 'User/editaction', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('22', '保存用户行为', '19', '0', 'User/saveAction', '0', '\"用户->用户行为\"保存编辑和新增的用户行为', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('23', '变更行为状态', '19', '0', 'User/setStatus', '0', '\"用户->用户行为\"中的启用,禁用和删除权限', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('24', '禁用会员', '19', '0', 'User/changeStatus?method=forbidUser', '0', '\"用户->用户信息\"中的禁用', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('25', '启用会员', '19', '0', 'User/changeStatus?method=resumeUser', '0', '\"用户->用户信息\"中的启用', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('26', '删除会员', '19', '0', 'User/changeStatus?method=deleteUser', '0', '\"用户->用户信息\"中的删除', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('27', '权限管理', '16', '0', 'AuthManager/index', '0', '', '用户管理', '0','1');
INSERT INTO `onethink_menu` VALUES ('28', '删除', '27', '0', 'AuthManager/changeStatus?method=deleteGroup', '0', '删除用户组', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('29', '禁用', '27', '0', 'AuthManager/changeStatus?method=forbidGroup', '0', '禁用用户组', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('30', '恢复', '27', '0', 'AuthManager/changeStatus?method=resumeGroup', '0', '恢复已禁用的用户组', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('31', '新增', '27', '0', 'AuthManager/createGroup', '0', '创建新的用户组', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('32', '编辑', '27', '0', 'AuthManager/editGroup', '0', '编辑用户组名称和描述', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('33', '保存用户组', '27', '0', 'AuthManager/writeGroup', '0', '新增和编辑用户组的\"保存\"按钮', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('34', '授权', '27', '0', 'AuthManager/group', '0', '\"后台 \\ 用户 \\ 用户信息\"列表页的\"授权\"操作按钮,用于设置用户所属用户组', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('35', '访问授权', '27', '0', 'AuthManager/access', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"访问授权\"操作按钮', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('36', '成员授权', '27', '0', 'AuthManager/user', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"成员授权\"操作按钮', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('37', '解除授权', '27', '0', 'AuthManager/removeFromGroup', '0', '\"成员授权\"列表页内的解除授权操作按钮', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('38', '保存成员授权', '27', '0', 'AuthManager/addToGroup', '0', '\"用户信息\"列表页\"授权\"时的\"保存\"按钮和\"成员授权\"里右上角的\"添加\"按钮)', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('39', '分类授权', '27', '0', 'AuthManager/category', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"分类授权\"操作按钮', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('40', '保存分类授权', '27', '0', 'AuthManager/addToCategory', '0', '\"分类授权\"页面的\"保存\"按钮', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('41', '模型授权', '27', '0', 'AuthManager/modelauth', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"模型授权\"操作按钮', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('42', '保存模型授权', '27', '0', 'AuthManager/addToModel', '0', '\"分类授权\"页面的\"保存\"按钮', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('43', '扩展', '0', '11', 'Addons/index', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('44', '插件管理', '43', '1', 'Addons/index', '0', '', '扩展', '0','1');
INSERT INTO `onethink_menu` VALUES ('45', '创建', '44', '0', 'Addons/create', '0', '服务器上创建插件结构向导', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('46', '检测创建', '44', '0', 'Addons/checkForm', '0', '检测插件是否可以创建', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('47', '预览', '44', '0', 'Addons/preview', '0', '预览插件定义类文件', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('48', '快速生成插件', '44', '0', 'Addons/build', '0', '开始生成插件结构', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('49', '设置', '44', '0', 'Addons/config', '0', '设置插件配置', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('50', '禁用', '44', '0', 'Addons/disable', '0', '禁用插件', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('51', '启用', '44', '0', 'Addons/enable', '0', '启用插件', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('52', '安装', '44', '0', 'Addons/install', '0', '安装插件', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('53', '卸载', '44', '0', 'Addons/uninstall', '0', '卸载插件', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('54', '更新配置', '44', '0', 'Addons/saveconfig', '0', '更新插件配置处理', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('55', '插件后台列表', '44', '0', 'Addons/adminList', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('56', 'URL方式访问插件', '44', '0', 'Addons/execute', '0', '控制是否有权限通过url访问插件控制器方法', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('57', '钩子管理', '43', '2', 'Addons/hooks', '0', '', '扩展', '0','1');
INSERT INTO `onethink_menu` VALUES ('58', '模型管理', '68', '3', 'Model/index', '0', '', '系统设置', '0','1');
INSERT INTO `onethink_menu` VALUES ('59', '新增', '58', '0', 'model/add', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('60', '编辑', '58', '0', 'model/edit', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('61', '改变状态', '58', '0', 'model/setStatus', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('62', '保存数据', '58', '0', 'model/update', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('63', '属性管理', '68', '0', 'Attribute/index', '1', '网站属性配置。', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('64', '新增', '63', '0', 'Attribute/add', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('65', '编辑', '63', '0', 'Attribute/edit', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('66', '改变状态', '63', '0', 'Attribute/setStatus', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('67', '保存数据', '63', '0', 'Attribute/update', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('68', '系统', '0', '2', 'Config/group', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('69', '网站设置', '68', '1', 'Config/group', '0', '', '系统设置', '0','1');
INSERT INTO `onethink_menu` VALUES ('70', '配置管理', '68', '4', 'Config/index', '0', '', '系统设置', '0','1');
INSERT INTO `onethink_menu` VALUES ('71', '编辑', '70', '0', 'Config/edit', '0', '新增编辑和保存配置', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('72', '删除', '70', '0', 'Config/del', '0', '删除配置', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('73', '新增', '70', '0', 'Config/add', '0', '新增配置', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('74', '保存', '70', '0', 'Config/save', '0', '保存配置', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('75', '菜单管理', '68', '5', 'Menu/index', '0', '', '系统设置', '0','1');
INSERT INTO `onethink_menu` VALUES ('76', '导航管理', '68', '6', 'Channel/index', '0', '', '系统设置', '0','1');
INSERT INTO `onethink_menu` VALUES ('77', '新增', '76', '0', 'Channel/add', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('78', '编辑', '76', '0', 'Channel/edit', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('79', '删除', '76', '0', 'Channel/del', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('80', '商品分类', '68', '2', 'Category/index', '0', '', '系统设置', '0','1');
INSERT INTO `onethink_menu` VALUES ('81', '编辑', '80', '0', 'Category/edit', '0', '编辑和保存栏目分类', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('82', '新增', '80', '0', 'Category/add', '0', '新增栏目分类', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('83', '删除', '80', '0', 'Category/remove', '0', '删除栏目分类', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('84', '移动', '80', '0', 'Category/operate/type/move', '0', '移动栏目分类', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('85', '合并', '80', '0', 'Category/operate/type/merge', '0', '合并栏目分类', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('86', '备份数据库', '68', '0', 'Database/index?type=export', '0', '', '数据备份', '0','1');
INSERT INTO `onethink_menu` VALUES ('87', '备份', '86', '0', 'Database/export', '0', '备份数据库', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('88', '优化表', '86', '0', 'Database/optimize', '0', '优化数据表', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('89', '修复表', '86', '0', 'Database/repair', '0', '修复数据表', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('90', '还原数据库', '68', '0', 'Database/index?type=import', '0', '', '数据备份', '0','1');
INSERT INTO `onethink_menu` VALUES ('91', '恢复', '90', '0', 'Database/import', '0', '数据库恢复', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('92', '删除', '90', '0', 'Database/del', '0', '删除备份文件', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('93', '其他', '0', '13', 'other', '1', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('96', '新增', '75', '0', 'Menu/add', '0', '', '系统设置', '0','1');
INSERT INTO `onethink_menu` VALUES ('98', '编辑', '75', '0', 'Menu/edit', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('106', '行为日志', '16', '0', 'Action/actionlog', '0', '', '行为管理', '0','1');
INSERT INTO `onethink_menu` VALUES ('108', '修改密码', '16', '0', 'User/updatePassword', '1', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('109', '修改昵称', '16', '0', 'User/updateNickname', '1', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('110', '查看行为日志', '106', '0', 'action/edit', '1', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('112', '新增数据', '58', '0', 'think/add', '1', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('113', '编辑数据', '58', '0', 'think/edit', '1', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('114', '导入', '75', '0', 'Menu/import', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('115', '生成', '58', '0', 'Model/generate', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('116', '新增钩子', '57', '0', 'Addons/addHook', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('117', '编辑钩子', '57', '0', 'Addons/edithook', '0', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('118', '文档排序', '3', '0', 'Article/sort', '1', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('119', '排序', '70', '0', 'Config/sort', '1', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('120', '排序', '75', '0', 'Menu/sort', '1', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('121', '排序', '76', '0', 'Channel/sort', '1', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('122', '数据列表', '58', '0', 'think/lists', '1', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES ('123', '审核列表', '3', '0', 'Article/examine', '1', '', '', '0','1');
INSERT INTO `onethink_menu` VALUES(135, '已发货订单', 131, 2, 'Ordertransport/index', 0, '', '订单管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(134, '优惠券', 158, 4, 'Fcoupon/index', 0, '', '优惠券管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(131, '订单', 0, 6, 'Order/index', 0, '', '', 0, 1);
INSERT INTO `onethink_menu` VALUES(132, '已提交订单', 131, 1, 'Order/index', 0, '', '订单管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(133, '已签收订单', 131, 3, 'Ordercomplete/index', 0, '', '订单管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(137, '正退货订单', 173, 4, 'Back/index', 0, '', '退货管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(141, '同意换货商品', 131, 10, 'Changeagree/index', 0, '', '换货管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(138, '同意退货订单', 173, 7, 'Backagree/index', 0, '', '退货管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(139, '已退货订单', 173, 8, 'Backover/index', 0, '', '退货管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(140, '正换货商品', 131, 9, 'Change/index', 0, '', '换货管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(142, '已换货商品', 131, 12, 'Changeover/index', 0, '', '换货管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(143, '今日销量统计', 146, 13, 'Statistics/index', 0, '', '数据统计', 0, 1);
INSERT INTO `onethink_menu` VALUES(144, '本周销量统计', 146, 14, 'Statistics/week', 0, '', '数据统计', 0, 1);
INSERT INTO `onethink_menu` VALUES(145, '本月销量统计', 146, 15, 'Statistics/month', 0, '', '数据统计', 0, 1);
INSERT INTO `onethink_menu` VALUES(146, '数据', 0, 7, 'Statistics/index', 0, '', '数据统计', 0, 1);
INSERT INTO `onethink_menu` VALUES(147, '每日数据', 146, 16, 'Report/index', 0, '', '报表统计', 0, 1);
INSERT INTO `onethink_menu` VALUES(148, '每周数据', 146, 17, 'Report/week', 0, '', '报表统计', 0, 1);
INSERT INTO `onethink_menu` VALUES(149, '每月统计', 146, 18, 'Report/month', 0, '', '报表统计', 0, 1);
INSERT INTO `onethink_menu` VALUES(150, '首页统计', 146, 20, 'Lookup/index', 0, '', '访问统计', 0, 1);
INSERT INTO `onethink_menu` VALUES(151, '栏目页统计', 146, 23, 'Lookup/category', 0, '', '访问统计', 0, 1);
INSERT INTO `onethink_menu` VALUES(152, '内容页统计', 146, 24, 'Lookup/article', 0, '', '访问统计', 0, 1);
INSERT INTO `onethink_menu` VALUES(153, '申请取消的订单', 131, 0, 'Cancel/index', 0, '', '取消管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(154, '拒绝的订单', 131, 0, 'Cancelrefuse/index', 0, '', '取消管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(155, '同意取消的订单', 131, 0, 'Cancelagree/index', 0, '', '取消管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(156, '财务管理', 16, 4, 'Pay/index', 0, '', '支付管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(157, '品牌管理', 158, 0, 'Brand/index', 0, '', '广告管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(158, '广告', 0, 9, 'Slide/index', 0, '', '', 0, 1);
INSERT INTO `onethink_menu` VALUES(160, '幻灯片', 158, 0, 'Slide/index', 0, '', '广告管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(159, '广告', 158, 0, 'Ad/index', 0, '', '广告管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(161, '团购管理', 158, 0, 'Tuan/index', 0, '团购分类，添加团购商品', '活动管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(162, '拒绝退货订单', 173, 5, 'Backrefuse/index', 0, '', '退货管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(163, '退货中订单', 173, 6, 'Backon/index', 0, '', '退货管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(164, '拒绝换货订单', 131, 11, 'Changerefuse/index', 0, '', '换货管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(165, '换货中订单', 131, 11, 'Changeon/index', 0, '', '换货管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(166, '商品', 0, 4, 'Goods/index', 0, '', '', 0, 1);
INSERT INTO `onethink_menu` VALUES(168, '邮件管理', 16, 6, 'Email/index', 0, '', '信息管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(169, '短信管理', 16, 7, 'Sms/index', 0, '', '信息管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(170, '站内信管理', 16, 8, 'Envelope/index', 0, '', '信息管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(171, '留言管理', 16, 9, 'Message/index', 0, '', '信息管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(172, '回复管理', 16, 10, 'Reply/index', 0, '', '信息管理', 0, 1);
INSERT INTO `onethink_menu` VALUES(173, '售后', 0, 10, 'Back/index', 0, '', '', 0, 1);
INSERT INTO `onethink_menu` VALUES(174, '文章分类', '68', '2', 'Catearticle/index', '0', '', '系统设置', '0','1');

-- -----------------------------
-- Table structure for `onethink_model`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_model`;
CREATE TABLE `onethink_model` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '模型标识',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '模型名称',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '继承的模型',
  `relation` varchar(30) NOT NULL DEFAULT '' COMMENT '继承与被继承模型的关联字段',
  `need_pk` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '新建表时是否需要主键字段',
  `field_sort` text NULL  COMMENT '表单字段排序',
  `field_group` varchar(255) NOT NULL DEFAULT '1:基础' COMMENT '字段分组',
  `attribute_list` text NULL  COMMENT '属性列表（表的字段）',
  `attribute_alias` varchar(255) NOT NULL DEFAULT '' COMMENT '属性别名定义',
  `template_list` varchar(100) NOT NULL DEFAULT '' COMMENT '列表模板',
  `template_add` varchar(100) NOT NULL DEFAULT '' COMMENT '新增模板',
  `template_edit` varchar(100) NOT NULL DEFAULT '' COMMENT '编辑模板',
  `list_grid` text NULL  COMMENT '列表定义',
  `list_row` smallint(2) unsigned NOT NULL DEFAULT '10' COMMENT '列表数据长度',
  `search_key` varchar(50) NOT NULL DEFAULT '' COMMENT '默认搜索字段',
  `search_list` varchar(255) NOT NULL DEFAULT '' COMMENT '高级搜索的字段',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `engine_type` varchar(25) NOT NULL DEFAULT 'MyISAM' COMMENT '数据库引擎',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='文档模型表';

-- -----------------------------
-- Records of `onethink_model`
-- -----------------------------
INSERT INTO `onethink_model` VALUES ('1', 'document', '基础文档', '0', '', '1', '{\"1\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"12\",\"13\",\"14\",\"15\",\"16\",\"17\",\"18\",\"19\",\"20\",\"21\",\"22\",\"51\"]}', '1:基础', '', '','', '', '', 'id:编号\r\ntitle:标题:[EDIT]\r\ntype:类型\r\nupdate_time:最后更新\r\nstatus:状态\r\nview:浏览\r\nid:操作:[EDIT]|编辑,[DELETE]|删除', '0', '', '', '1383891233', '1384507827', '1', 'MyISAM');
INSERT INTO `onethink_model` VALUES ('2', 'article', '文章', '1', '', '1', '{\"1\":[\"3\",\"24\",\"2\",\"5\"],\"2\":[\"9\",\"13\",\"19\",\"10\",\"12\",\"16\",\"17\",\"26\",\"20\",\"14\",\"11\",\"25\"]}', '1:基础,2:扩展', '','', '', '', '', 'id:编号\r\ntitle:标题:[EDIT]\r\ntype:类型\r\nupdate_time:最后更新\r\nstatus:状态\r\nview:浏览\r\nid:操作:[EDIT]|编辑,[DELETE]|删除', '0', '', '', '1383891243', '1387260622', '1', 'MyISAM');
INSERT INTO `onethink_model` VALUES ('3', 'download', '下载', '1', '', '1', '{\"1\":[\"3\",\"28\",\"30\",\"32\",\"2\",\"5\",\"31\"],\"2\":[\"13\",\"10\",\"27\",\"9\",\"12\",\"16\",\"17\",\"19\",\"11\",\"20\",\"14\",\"29\"]}', '1:基础,2:扩展', '', '','', '', '', '', '0', '', '', '1383891252', '1387260449', '1', 'MyISAM');
INSERT INTO `onethink_model` VALUES ('5', 'product', '商品', '1', '', '1', '{\"1\":[\"3\",\"36\",\"51\",\"12\",\"55\",\"46\",\"39\"],\"2\":[\"37\",\"102\",\"42\",\"53\",\"10\",\"56\",\"47\",\"50\",\"5\",\"49\",\"52\",\"53\",\"54\",\"14\",\"44\",\"58\",\"9\",\"20\",\"11\",\"2\",\"13\",\"17\",\"35\",\"16\",\"19\",\"43\"]}', '1:基础,2:扩展', '', '','', '', '', 'id:编号\r\ntitle:标题:[EDIT]\r\ntype:类型\r\nupdate_time:最后更新\r\nstatus:状态\r\nview:浏览\r\nid:操作:[EDIT]|编辑,[DELETE]|删除', '0', '', '', '1383891252', '1387260449', '1', 'MyISAM');
INSERT INTO `onethink_model` VALUES ('6', 'phone', '手机', '1', '', '1', '{\"1\":[\"3\",\"60\",\"12\",\"55\",\"51\",\"62\",\"80\",\"68\",\"66\",\"64\",\"63\",\"61\",\"59\"],\"2\":[\"103\",\"104\",\"105\",\"5\",\"56\",\"52\",\"53\",\"54\",\"10\",\"65\",\"81\",\"70\",\"71\",\"67\",\"72\",\"69\",\"73\",\"74\",\"75\",\"76\",\"78\",\"77\",\"79\",\"49\",\"14\",\"9\",\"20\",\"11\",\"2\",\"13\",\"17\",\"16\",\"19\"]}', '1:基础,2:扩展', '', '','', '', '', 'id:编号\r\ntitle:标题:[EDIT]\r\ntype:类型\r\nupdate_time:最后更新\r\nstatus:状态\r\nview:浏览\r\nid:操作:[EDIT]|编辑,[DELETE]|删除', '0', '', '', '1383891252', '1387260449', '1', 'MyISAM');
INSERT INTO `onethink_model` VALUES ('7', 'book', '图书', '1', '', '1', '{\"1\":[\"3\",\"93\",\"12\",\"51\",\"82\",\"101\",\"83\",\"92\",\"84\",\"5\"],\"2\":[\"106\",\"107\",\"108\",\"91\",\"90\",\"89\",\"52\",\"53\",\"54\",\"88\",\"87\",\"86\",\"85\",\"10\",\"49\",\"14\",\"57\",\"9\",\"20\",\"55\",\"56\",\"11\",\"2\",\"13\",\"17\",\"16\",\"19\"]}', '1:基础,2:扩展', '', '','', '', '', 'id:编号\r\ntitle:标题:[EDIT]\r\ntype:类型\r\nupdate_time:最后更新\r\nstatus:状态\r\nview:浏览\r\nid:操作:[EDIT]|编辑,[DELETE]|删除', '0', '', '', '1383891252', '1387260449', '1', 'MyISAM');
INSERT INTO `onethink_model` VALUES ('8', 'clothe', '服装鞋包', '1', '', '1', '{\"1\":[\"3\",\"96\",\"12\",\"55\",\"51\",\"56\",\"94\",\"95\",\"99\",\"97\"],\"2\":[\"109\",\"110\",\"111\",\"49\",\"98\",\"10\",\"100\",\"14\",\"5\",\"9\",\"52\",\"53\",\"54\",\"20\",\"11\",\"2\",\"13\",\"17\",\"16\",\"19\"]}', '1:基础,2:扩展', '', '','', '', '', 'id:编号\r\ntitle:标题:[EDIT]\r\ntype:类型\r\nupdate_time:最后更新\r\nstatus:状态\r\nview:浏览\r\nid:操作:[EDIT]|编辑,[DELETE]|删除', '0', '', '', '1383891252', '1387260449', '1', 'MyISAM');

-- -----------------------------
-- Table structure for `onethink_picture`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_picture`;
CREATE TABLE `onethink_picture` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路径',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片链接',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- -----------------------------
-- Records of `onethink_picture`
-- -----------------------------
INSERT INTO `onethink_picture` VALUES(1, '/Uploads/Picture/2014-09-02/5405e0f3b1705.png', '', '36d077267c76901835c07eb98f43647f', '0f7ce26261cb7a81dcfb14e057982ec60fa3a6e0', 1, 1409671411);
INSERT INTO `onethink_picture` VALUES(2, '/Uploads/Picture/2014-09-18/5419eb4fec0c7.jpg', '', '5435a1dae36fafc2e544f2f78854fb29', 'd93a6e9869e7bf2fc17a533d3060ade8c88c40a9', 1, 1410984783);
INSERT INTO `onethink_picture` VALUES(3, '/Uploads/Picture/2014-09-22/541f3d86103d3.jpg', '', '8e77701a8b49232f17d7f13d91d40693', '4dd3a9e9938d8890db37452b3abe6ff91ead531a', 1, 1411333508);
INSERT INTO `onethink_picture` VALUES(4, '/Uploads/Picture/2014-09-22/541ff48c48dcf.jpg', '', 'e23489fd7e4dcc3dffaecbdef316bc97', '212c69983a3aaae6e379c68521523f847f5065fc', 1, 1411380364);
INSERT INTO `onethink_picture` VALUES(5, '/Uploads/Picture/2014-09-27/5426973d68594.jpg', '', 'b1cc728f0903646228442f12afec0559', '2dbeabe21876fe2e489eeaf8e71f9de9c6465886', 1, 1411815228);
INSERT INTO `onethink_picture` VALUES(6, '/Uploads/Picture/2014-09-28/54282d125f21a.jpg', '', 'da9f27eee154037434fbad74dc73430a', 'd3299248c9946cb94e7f5eeaaa7818fe750ad9de', 1, 1411919121);
INSERT INTO `onethink_picture` VALUES(7, '/Uploads/Picture/2014-09-28/54282f255e437.jpg', '', '2e1205543c59f21e6317c2adf56a64ae', '1ad27e3a47c074ab9b7ed3b2d0aff5f8f848a17f', 1, 1411919653);
INSERT INTO `onethink_picture` VALUES(8, '/Uploads/Picture/2014-09-29/54284e0bb791c.jpg', '', '314edb167e8e67abe5fadb9ecb56a5bb', 'b7a1cf4f226334a39db5fa7351e3c696d3d562b3', 1, 1411927563);
INSERT INTO `onethink_picture` VALUES(9, '/Uploads/Picture/2014-09-29/5428505721fe3.jpg', '', '3a9cfc025a0b8ae90939d080b6b0b3da', 'f0e1654339c40d42da7037cae6b26cef1336570b', 1, 1411928151);
INSERT INTO `onethink_picture` VALUES(10, '/Uploads/Picture/2014-09-29/542851809c5fe.jpg', '', 'b7e3396d129e2501f393c5fbb59080d5', '1961d4b5d20e1ac3d50000570535ca41b5fa8c44', 1, 1411928448);
INSERT INTO `onethink_picture` VALUES(11, '/Uploads/Picture/2014-10-22/5447bf1b8a10a.jpg', '', '4182ad0929a3a535f11273c31a7fd16b', 'b36f727aada45dd67f8206b978c46afc4b1254e6', 1, 1413988123);
INSERT INTO `onethink_picture` VALUES(12, '/Uploads/Picture/2014-10-23/54481f89ef4dc.gif', '', '40e797c3661da89e463bf739b819a4fd', 'bba0f04434413fb63c3e6d82fe74d0ece7b647bf', 1, 1414012809);
INSERT INTO `onethink_picture` VALUES(13, '/Uploads/Picture/2014-10-25/544a986712125.jpg', '', '5332d06200bc87cbeddefea48859eb87', 'e2207e6f2b7f0d7c6f9392ab70eb99b6a14f473b', 1, 1414174821);
INSERT INTO `onethink_picture` VALUES(14, '/Uploads/Picture/2014-10-25/544a994e1e338.jpg', '', 'ad1a25faa262cf395b42b4aa4aead8cf', 'e08dc9cbab906cbeea1e036deaf3b791d6db4f9e', 1, 1414175054);
INSERT INTO `onethink_picture` VALUES(15, '/Uploads/Picture/2014-10-26/544cff452d8fa.jpg', '', 'c1b04f3754108967f1edd5c94657095e', 'd1726508f25b1ef354d48586797a82da18503726', 1, 1414332229);
INSERT INTO `onethink_picture` VALUES(16, '/Uploads/Picture/2014-10-26/544cffc5540ee.jpg', '', 'aac9bafdb67dc58312b65e001ea84540', '068acddf258436463eee6915e919a13f5e3877fe', 1, 1414332357);
INSERT INTO `onethink_picture` VALUES(17, '/Uploads/Picture/2014-10-26/544d19999e40b.png', '', '20887db6ea7f9b810bd6d3ec5e91695b', 'f37a6e21817dd2a4163b3a5bdd05380c8a88efe1', 1, 1414338969);
INSERT INTO `onethink_picture` VALUES(18, '/Uploads/Picture/2014-10-26/544d19be81949.jpg', '', 'da5fdeaed09a782168e78b6907b45a44', 'd8bb619b09799c52eb8b08ca292fd53ef405aea3', 1, 1414339006);
INSERT INTO `onethink_picture` VALUES(19, '/Uploads/Picture/2014-10-27/544d1abbbd6b0.jpg', '', 'db8ea2928ce128693663d2252698bd05', '4dd01d2d86525d61ec12e44779959eb4cc074d9d', 1, 1414339259);
INSERT INTO `onethink_picture` VALUES(20, '/Uploads/Picture/2014-10-27/544d2707616a5.png', '', '31f9e56579f958ff1a9eac6e040c4c20', '608746815de21abbfbee5f646bcb9b747a996c1f', 1, 1414342406);
INSERT INTO `onethink_picture` VALUES(21, '/Uploads/Picture/2014-10-27/544d2792b3e05.png', '', '8a6d4676b58e25f538dc037337b28a6c', 'ef346ce444e1f5a117e388aa5fc018df4d623673', 1, 1414342546);
INSERT INTO `onethink_picture` VALUES(22, '/Uploads/Picture/2014-10-27/544d27e160e6b.png', '', '0b2fdd0c3a198bc9b4034567e0bb112c', '05b9f8b88fff5b614b3d55fd8e617722d1bc7d93', 1, 1414342625);
INSERT INTO `onethink_picture` VALUES(23, '/Uploads/Picture/2014-10-27/544d283099170.png', '', 'b7a5ed3253065b3e2540e779487d5767', 'a06b5bfe54272aedd2d645c560a1d836cd853bcc', 1, 1414342704);
INSERT INTO `onethink_picture` VALUES(24, '/Uploads/Picture/2014-10-27/544d2b43ddf15.png', '', 'ff85333e81966a8cb8f012e59eeb749f', 'b430506b7467ff4842d396d5602a2ac511aea4b6', 1, 1414343491);
INSERT INTO `onethink_picture` VALUES(25, '/Uploads/Picture/2014-10-29/5450091034207.png', '', 'f7aec314e1916bf12a46caf55ea947ac', '0b5fe01203ea843d9ce57ec076deba6686b972fc', 1, 1414531343);
INSERT INTO `onethink_picture` VALUES(27, '/Uploads/Picture/2014-11-11/546215b4b6e52.jpg', '', '6d5df175cf29abedfc8f0e53dce5e67f', '062053c9b9b7f50d318256e3097703c673677c3b', 1, 1415714228);
INSERT INTO `onethink_picture` VALUES(28, '/Uploads/Picture/2014-11-14/546589a1c7307.jpg', '', 'ed01c74e75defefd23adadae4196d072', 'e1cc9e73a601a38f24df7764f7bd3c0b5564b4c3', 1, 1415940508);
INSERT INTO `onethink_picture` VALUES(29, '/Uploads/Picture/2014-11-14/546589bc2eedd.jpg', '', '5fa189f582f2b4765d088b027ca91fff', '71a9c92226ea62c783db412152e749339f708efc', 1, 1415940534);
INSERT INTO `onethink_picture` VALUES(30, '/Uploads/Picture/2014-11-19/546c698c56d1b.jpg', '', '6b089282ea53101d7f783027daa77eff', 'ed0bda3434ac7951cfa576cf7ae98f3c877a64fd', 1, 1416391052);
INSERT INTO `onethink_picture` VALUES(31, '/Uploads/Picture/2014-11-19/546c6af47eaac.gif', '', '79c79ce53b7ebc92059438f36aeec565', 'acd669ce9b6d309cad08b71972e8c093ee40238b', 1, 1416391412);
INSERT INTO `onethink_picture` VALUES(32, '/Uploads/Picture/2014-12-11/548954c9e88fd.png', '', 'eae5fa6c1d7e5fc04d03f7d2210c1caf', '8eec63249735814e90f04448c7eb8236b377afb2', 1, 1418286281);
INSERT INTO `onethink_picture` VALUES(33, '/Uploads/Picture/2015-01-13/54b4be107a909.jpg', '', '4f1dc467c583d89e6e5a6342d0d2c575', '4079777aeae1d874c5c6af299752f0ecd2cd3e2e', 1, 1421131279);
INSERT INTO `onethink_picture` VALUES(34, '/Uploads/Picture/2015-01-13/54b4c2a55097d.jpg', '', '13467d9159d9a4f3e7e1428150c8e038', '5a366a06a358029355fc264453bc424c177062f9', 1, 1421132453);
INSERT INTO `onethink_picture` VALUES(35, '/Uploads/Picture/2015-01-13/54b4c82d6ce82.jpg', '', '5e507c7b9f98789e3da9f1c30591dead', '2d5ee85fa5999bf188b2f9bc6835b9dc9b2582f8', 1, 1421133869);
INSERT INTO `onethink_picture` VALUES(36, '/Uploads/Picture/2015-01-13/54b4d99370fa7.jpg', '', '4aed3d40f223ee7282b6a25362706552', '6b6fa14ac7b822bde4ddb8918a6cb3f6d39bb947', 1, 1421138323);
INSERT INTO `onethink_picture` VALUES(37, '/Uploads/Picture/2015-01-13/54b4e5fd4a1d4.jpg', '', '79b8e026da3e9305cf053f4c67847383', 'b1902c912f84a3fa50736e8e772ee2fdfbd9e778', 1, 1421141500);
INSERT INTO `onethink_picture` VALUES(38, '/Uploads/Picture/2015-01-13/54b4f38766a1c.jpg', '', '8344b79471a49874961f7bacfc0ebff0', '763ea118453c7142d3ca7728d164de06299f9c7a', 1, 1421144966);
INSERT INTO `onethink_picture` VALUES(39, '/Uploads/Picture/2015-01-13/54b4ff7458068.jpg', '', 'c7b49ecc3beb01cc257d529636731adc', '4d108c216f2d12f08d4141acd776756c90af5d5b', 1, 1421148020);
INSERT INTO `onethink_picture` VALUES(40, '/Uploads/Picture/2015-01-13/54b50f1cece1c.jpg', '', 'f9038e593b7d211e942676668bf7ee0a', '22e3b7b1759fba15108c689edfae276e5db048b0', 1, 1421152028);
INSERT INTO `onethink_picture` VALUES(41, '/Uploads/Picture/2015-01-13/54b51e59e212b.jpg', '', '61d2c2e7b20e6e11d37c757466d78336', 'c8f5b405d82103f13c2af44113fffd9b06cc70f5', 1, 1421155929);
INSERT INTO `onethink_picture` VALUES(42, '/Uploads/Picture/2015-01-13/54b51e820573d.jpg', '', '93be5c427935a0deef1f39db5e38e280', '95f9aa79c54165400c19bf20bfdbf0935f9d1a8a', 1, 1421155969);
INSERT INTO `onethink_picture` VALUES(43, '/Uploads/Picture/2015-01-13/54b51ed0c4fb0.jpg', '', '9ebc6c765eb96d8c5d265247ba800195', 'fe0d1977e5f0aa17038349026dc7c8426c30b996', 1, 1421156048);
INSERT INTO `onethink_picture` VALUES(44, '/Uploads/Picture/2015-01-13/54b51fdb585e3.jpg', '', 'db8585cf7faf56c12cc8ba42724bb0c7', '85747087ad68234679ed4f54474a029442a060ee', 1, 1421156315);
INSERT INTO `onethink_picture` VALUES(45, '/Uploads/Picture/2015-01-13/54b521162bc8e.jpg', '', 'd8991eb8728e24d10afbb7d53bd271b8', 'c936375d3aeb018bb41a22b5e249f24d954a5e9a', 1, 1421156630);
INSERT INTO `onethink_picture` VALUES(46, '/Uploads/Picture/2015-01-13/54b5212a8e4b0.jpg', '', '8d81382d4cb87728c079b31896a12530', 'd86824d872d76d2caadd7d5f3bbc2e54ebf50567', 1, 1421156650);
INSERT INTO `onethink_picture` VALUES(47, '/Uploads/Picture/2015-01-13/54b5215927817.jpg', '', 'c37deb2b29cdc4bc9f88446fe4d4671b', '6910092082bc43e0c49087153fe8501bab58056b', 1, 1421156697);
INSERT INTO `onethink_picture` VALUES(48, '/Uploads/Picture/2015-01-13/54b525eb02811.jpg', '', '98f358bc82f961315b55e5e6751b00f0', '34f4dfb7d1db78a316a90ce4ca7c9f2c22700c65', 1, 1421157866);
INSERT INTO `onethink_picture` VALUES(49, '/Uploads/Picture/2015-01-13/54b5268ab8cdb.jpg', '', '40ff32e20a184d64696b68ba4ab766eb', '63ac4ec5c6bcf04f9d173e1a15fccb25adf91711', 1, 1421158026);
INSERT INTO `onethink_picture` VALUES(50, '/Uploads/Picture/2015-01-13/54b526dd8bfa8.jpg', '', '2d99963c567de0d314fc0933c9026945', '81c4a321554aa5e624e04ea5023f8da696f1948c', 1, 1421158108);
INSERT INTO `onethink_picture` VALUES(51, '/Uploads/Picture/2015-01-13/54b53234efd57.jpg', '', '72e49d3daad7e64460bfd70b4965f2ed', '9ddde71e90f6a24d7172cd08c01bf3d7459f283d', 1, 1421161012);
INSERT INTO `onethink_picture` VALUES(52, '/Uploads/Picture/2015-01-13/54b532434e821.jpg', '', 'ddf360f93cce844277f9ea9b6d3f199e', '48203957d6eeb1ae703863225a198de7f7917c49', 1, 1421161027);
INSERT INTO `onethink_picture` VALUES(53, '/Uploads/Picture/2015-01-14/54b6011980614.png', '', '9547507bf8e1337740e23198fc1a002b', '6bb198392531782907600820afbf901da705f51c', 1, 1421213977);
INSERT INTO `onethink_picture` VALUES(54, '/Uploads/Picture/2015-01-16/54b8a92a3928d.jpg', '', '2b9555848288b11c6abddc2ef30d7c02', 'a9be35e83640630e1415538160d0f023cecd40d9', 1, 1421388073);
INSERT INTO `onethink_picture` VALUES(56, '/Uploads/Picture/2015-01-16/54b8a9c6c9231.jpg', '', 'ced3bb1c980e258fbe7802af44c72e6d', '5dc332586535cf6cdd4c7365071eb8162c1deed8', 1, 1421388230);
INSERT INTO `onethink_picture` VALUES(57, '/Uploads/Picture/2015-01-16/54b8a9ea0eb89.jpg', '', '4bc9ae5483e80cae3b442accca669801', 'af59fdbb47f0a14f50d3271ae4a93c3c0e6cf6dc', 1, 1421388265);
INSERT INTO `onethink_picture` VALUES(58, '/Uploads/Picture/2015-01-16/54b8aa06e86dd.jpg', '', 'd07c82a1f31a1827a85df3c2647c502f', '4f9ae10835fd41e71b543ca7ccd257dedfd225ba', 1, 1421388294);
INSERT INTO `onethink_picture` VALUES(59, '/Uploads/Picture/2015-01-16/54b8aa41968db.jpg', '', 'ed39cc1c818866725ce2af8c86330bb0', 'd78b45b8f6e3ec8498e2e47729fe1d584081cfba', 1, 1421388353);
INSERT INTO `onethink_picture` VALUES(60, '/Uploads/Picture/2015-01-16/54b8b814bbc1d.jpg', '', 'd0c48300df72a1aebc8c7107c110c2b5', '2bcee7e5a0ca199fd51dcd7cd314937ca500fc68', 1, 1421391892);
INSERT INTO `onethink_picture` VALUES(62, '/Uploads/Picture/2015-01-16/54b8faf9057ec.jpg', '', '78cc6b8e3a5b5b3ca88592c46201a5e6', '2d01650ce9e6ceef5ca15275c28a2facf0bca071', 1, 1421409016);
INSERT INTO `onethink_picture` VALUES(63, '/Uploads/Picture/2015-01-17/54ba6dd86b7f6.png', '', '32d62534d0bdca11e52f497d4521de4f', '20952d59f0872d287c326c593b7c7106c5a8313a', 1, 1421503959);
INSERT INTO `onethink_picture` VALUES(64, '/Uploads/Picture/2015-01-17/54ba6f0fd2e6e.jpg', '', '37a3108bfd3a190aa5ffb86fcc2669a4', 'c7df8683963c486e84e1fb13487092d1274dfe81', 1, 1421504271);
INSERT INTO `onethink_picture` VALUES(65, '/Uploads/Picture/2015-01-17/54ba6fef11267.jpg', '', 'bb34caff6f4980ddb5ce14099405c8a8', '4118731b563cc928d66198d3b2b052a1b16a3c2b', 1, 1421504494);
INSERT INTO `onethink_picture` VALUES(66, '/Uploads/Picture/2015-01-17/54ba71227fe48.png', '', 'cf29142c91442b346081e8ba552e7c8f', 'b5e21188f144541321904995805ac62353637c78', 1, 1421504802);
INSERT INTO `onethink_picture` VALUES(67, '/Uploads/Picture/2015-01-17/54ba72711673e.png', '', 'd695af9dcb860211b01c4074b33e553f', '25dad847b4a7ba4606e1974642727eb03f287485', 1, 1421505136);
INSERT INTO `onethink_picture` VALUES(68, '/Uploads/Picture/2015-01-17/54ba734b52ed7.jpg', '', '10f51f401227db216b2edc6aff2c7526', 'cbcfc84ce9abc823f8cf136b90d895eb91403197', 1, 1421505355);
INSERT INTO `onethink_picture` VALUES(69, '/Uploads/Picture/2015-02-02/54cf72354728f.png', '', 'c7e4d1a1e20e8b8aaf06a3b9c36c6ee4', '2a98aaa5f2addb4dc5b3a0f91c081b3dfb749434', 1, 1422881332);
INSERT INTO `onethink_picture` VALUES(70, '/Uploads/Picture/2015-02-02/54cf72bedda19.png', '', '8b0fbcbf45b1d1d644497d1cd297a966', '5ab4f924e942405d80bb3b78495f14142ed5160d', 1, 1422881470);
INSERT INTO `onethink_picture` VALUES(71, '/Uploads/Picture/2015-02-02/54cf732806f5c.jpg', '', '9fcdf136e8c8ecb5474feb55be350b19', '045973b1a1adb13024a527d2ce20f66452afd5e1', 1, 1422881575);
INSERT INTO `onethink_picture` VALUES(72, '/Uploads/Picture/2015-02-02/54cf732eb78b2.jpg', '', 'a776e4dde58b4c05a0dc58328936f59c', '78236fb8d76a9bdb5d52aa1d62f08c2f6f8eb883', 1, 1422881582);
INSERT INTO `onethink_picture` VALUES(73, '/Uploads/Picture/2015-02-02/54cf75ac91fbf.jpg', '', '981d7e1b22ffefddf4d1f869f46722d6', '1f28d80d3cd1c14e148b4f50cebef35e28c95c44', 1, 1422882220);
INSERT INTO `onethink_picture` VALUES(74, '/Uploads/Picture/2015-02-02/54cf77fe05588.jpg', '', '9baf244e0b0463f1fad243bc31517f35', 'ba3e0a5bdf0aa0b1691b3307aa5a13cfb5863a61', 1, 1422882813);
INSERT INTO `onethink_picture` VALUES(75, '/Uploads/Picture/2015-02-02/54cf78aed5675.jpg', '', '6b60fcfb3127c84f13781d8dd7a05cca', '8f2e3660a7264405096c798ed259865d3435c817', 1, 1422882990);
INSERT INTO `onethink_picture` VALUES(76, '/Uploads/Picture/2015-02-02/54cf78f6e4958.jpg', '', '28670c955115c19deac649e3834525b1', 'd1afd3ee798183fce3184777da988b64498a1503', 1, 1422883062);
INSERT INTO `onethink_picture` VALUES(77, '/Uploads/Picture/2015-02-02/54cf79b6a29d4.jpg', '', 'c89e3d67600e5d293e603bef2830637a', '9a02e8e4e70b528e44bcf9b80fcfb068da4c51ea', 1, 1422883253);
INSERT INTO `onethink_picture` VALUES(78, '/Uploads/Picture/2015-02-02/54cf7a9688bc7.jpg', '', '09134a7d63c4a5d6c12569d6cbd8e50d', 'bb20d71938795bb2a60707646f4344214e0bc974', 1, 1422883478);
INSERT INTO `onethink_picture` VALUES(79, '/Uploads/Picture/2015-02-02/54cf7a9a798b2.jpg', '', '3ca8af1b66fb6b6af8ad5271a509ee95', '6e847640f9a5354ed836278b267cc7f177ff541a', 1, 1422883482);
INSERT INTO `onethink_picture` VALUES(85, '/Uploads/Picture/2015-03-22/550e50360c452.jpg', '', '8911ed312eb1f294249279a45f243c56', 'd7fa425aa4a47bdce6c78068c33d826d41bc3dfb', 1, 1427001397);
INSERT INTO `onethink_picture` VALUES(86, '/Uploads/Picture/2015-03-22/550e5099e214b.jpg', '', 'f46f9cafebf0455b71445d9b3816129f', '20781f4980f008edb3b4d99b111df99a35db9b57', 1, 1427001497);
INSERT INTO `onethink_picture` VALUES(87, '/Uploads/Picture/2015-04-09/55269aabe2c22.jpg', '', 'b9ac440cffe584d4b42afd3e5b46164e', '80efeb3ec9f9b370317308c39668bceb2156f3c1', 1, 1428593323);
INSERT INTO `onethink_picture` VALUES(88, '/Uploads/Picture/2015-04-09/55269c49e8122.jpg', '', '49c0e046afebe35b80b5d3af7f6d2db6', '0470b35332d559f2b5262f3287d029e6a814d83c', 1, 1428593737);
INSERT INTO `onethink_picture` VALUES(89, '/Uploads/Picture/2015-04-10/5527d68115da9.jpg', '', '3793a9f51dc253dcb9f7c4e8db02cd2e', 'dfb02188c1d0d8d4b98ca51e15ec7166cef3b670', 1, 1428674175);
INSERT INTO `onethink_picture` VALUES(90, '/Uploads/Picture/2015-04-10/5527db52187cf.jpg', '', '90d78f3df758242fe166f3da9225cd66', '56520b70805d39f89ddd78de5dd34e608b3e59e5', 1, 1428675409);
INSERT INTO `onethink_picture` VALUES(91, '/Uploads/Picture/2015-04-10/5527dc490d4ac.jpg', '', '822ed85af6678e2734a165d754063ac7', '2e33680d745c7e183adb56abe001d1e25b6fd00d', 1, 1428675656);
INSERT INTO `onethink_picture` VALUES(92, '/Uploads/Picture/2015-04-10/5527ee792ea89.jpg', '', '246e2d15d771743f5166a3623a36dabb', '6832aad682678e2369eae6a6b9d35a2255553644', 1, 1428680312);
INSERT INTO `onethink_picture` VALUES(93, '/Uploads/Picture/2015-04-10/5527f30991c46.jpg', '', '7445c8217e61c4ab9a6c3892fab823b8', '66acb2251ec28687fd87f88dea16aeb8abcb077d', 1, 1428681481);
INSERT INTO `onethink_picture` VALUES(94, '/Uploads/Picture/2015-04-11/55280a206b637.jpg', '', 'b7d79e066665100302643177a75d8c01', 'c2ffd9ec9a544453468e86f64defa80439e9c0bf', 1, 1428687392);
INSERT INTO `onethink_picture` VALUES(95, '/Uploads/Picture/2015-04-11/552836be64be2.png', '', 'b1c2965b23fc2bcb316f41384438c47d', 'c48e297f88c41d828d23387f7f8c5f8d239f24d0', 1, 1428698813);
INSERT INTO `onethink_picture` VALUES(96, '/Uploads/Picture/2015-04-11/552838b5a0cdc.png', '', '054662115c58fc4b0256e8f08b124a97', '64877c58b93f82123bb37652c56c28d3af9bd36c', 1, 1428699317);
INSERT INTO `onethink_picture` VALUES(97, '/Uploads/Picture/2015-04-11/55283a2291874.jpg', '', '06ac839c2ace588adad083ce167a1a28', 'b4c04ee19d17f3d59196f96674aa0492a900d4f0', 1, 1428699682);
INSERT INTO `onethink_picture` VALUES(98, '/Uploads/Picture/2015-04-11/55283cde0ce3a.png', '', 'e580684c9273fe9e40aebd26a24012ea', 'a44c1c483105bf51aa1d8567db3a668fbe3e76d4', 1, 1428700381);
INSERT INTO `onethink_picture` VALUES(99, '/Uploads/Picture/2015-04-11/55283e42b0bca.jpg', '', '9df82f543248e67f8ae8d56f6776ffae', '628295fea8946c2a607260c8bb1795756031e711', 1, 1428700738);
INSERT INTO `onethink_picture` VALUES(100, '/Uploads/Picture/2015-04-11/55283f37d7a9d.png', '', '6ce1b6a3cf2a19699398bf85addfe778', '51adc087979d9575b68df3733459a63d15ee5cbc', 1, 1428700983);
INSERT INTO `onethink_picture` VALUES(101, '/Uploads/Picture/2015-04-11/55283fbe4255c.png', '', 'fe96c1ded9564d83fd08c1aaec9a39e8', 'bf3500bc330f8924fc8021cef0b9af57b5b3188d', 1, 1428701118);
INSERT INTO `onethink_picture` VALUES(102, '/Uploads/Picture/2015-04-11/55283feb3ea33.png', '', '515c2a1f4ac9081e658535182c0757af', 'c91c8fe91196a8579d744c3aca16f4757b1c12b2', 1, 1428701163);
INSERT INTO `onethink_picture` VALUES(103, '/Uploads/Picture/2015-04-11/55284132b0ca4.png', '', 'c98e6acef9bdc46a17a34963ae33e46b', '24db363f4e6ead88a17f81b512e20c2d7e305192', 1, 1428701490);
INSERT INTO `onethink_picture` VALUES(104, '/Uploads/Picture/2015-04-11/552844aec508a.png', '', '7050c0f2772127fbd703b8e8f9a55567', 'fc2637c6f5bd9d9c9f61ade1409206be5ae0e9ea', 1, 1428702382);
INSERT INTO `onethink_picture` VALUES(105, '/Uploads/Picture/2015-04-12/5529609351746.jpg', '', '9252251518c003c0449de8255a29008a', '27e9a440efbf3b3a3d66e449f8c7f6d5c4946a32', 1, 1428775058);
INSERT INTO `onethink_picture` VALUES(106, '/Uploads/Picture/2015-04-12/55296117aaa5a.jpg', '', 'b32954da1b63eed29df9cb297e901f3c', '122292da64ba3800f9c9578e398ccc1b3825a85f', 1, 1428775191);
INSERT INTO `onethink_picture` VALUES(107, '/Uploads/Picture/2015-04-12/552963b88f304.png', '', '532b5d8f55d217ae091c2aaea8952434', 'dcb961e4fd0a94d97b7ed7e3bcaa389eb683f288', 1, 1428775864);
INSERT INTO `onethink_picture` VALUES(108, '/Uploads/Picture/2015-04-12/5529676d374b2.jpg', '', '476164225841ee11090cad1087737c6d', 'ababb25797337de27b2f55a1c8b8d308750b21ba', 1, 1428776813);
INSERT INTO `onethink_picture` VALUES(109, '/Uploads/Picture/2015-04-12/552970f38f8ce.jpg', '', '10e4b0aa28a3e83a9da810e5c4fd7be8', '2b6f31bf2acc08d8b563a5c276eef41414b6d8e4', 1, 1428779251);
INSERT INTO `onethink_picture` VALUES(110, '/Uploads/Picture/2015-04-12/55297549e52e5.jpg', '', '5dc0f04a2ecaebc9f94f3ec2e92e9ef7', '254fc303c8f33956246c8e96eeb905f525ea43ef', 1, 1428780361);
INSERT INTO `onethink_picture` VALUES(111, '/Uploads/Picture/2015-04-12/5529f7b65062e.png', '', 'c1e607e3bf0b32bb419c001df23d30c6', 'b16eb57d68a25de2f79c4e487e0a867d2df87150', 1, 1428813750);
INSERT INTO `onethink_picture` VALUES(112, '/Uploads/Picture/2015-04-12/5529f8e521a55.png', '', '4fd98d871331a1b30c8780e2cd783a59', 'ca9d562081c9166fcea14f5de1ece6cab2170150', 1, 1428814053);
INSERT INTO `onethink_picture` VALUES(113, '/Uploads/Picture/2015-04-12/5529f913c1868.png', '', '4f50fbbee1c22e34e6d022e122ad67ad', '230d40ab050289a79c75c56f2832e7ef74551117', 1, 1428814099);
INSERT INTO `onethink_picture` VALUES(114, '/Uploads/Picture/2015-04-13/552b6aca5f9ca.jpg', '', '40d3e4144df99d864a2ea853ae59f0a1', '0276d4148e923134344851c99c7e5934cce6be70', 1, 1428908746);



-- -----------------------------
-- Table structure for `onethink_ucenter_admin`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_ucenter_admin`;
CREATE TABLE `onethink_ucenter_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `member_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员用户ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '管理员状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='管理员表';


-- -----------------------------
-- Table structure for `onethink_ucenter_app`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_ucenter_app`;
CREATE TABLE `onethink_ucenter_app` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '应用ID',
  `title` varchar(30) NOT NULL COMMENT '应用名称',
  `url` varchar(100) NOT NULL COMMENT '应用URL',
  `ip` char(15) NOT NULL DEFAULT '' COMMENT '应用IP',
  `auth_key` varchar(100) NOT NULL DEFAULT '' COMMENT '加密KEY',
  `sys_login` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '同步登陆',
  `allow_ip` varchar(255) NOT NULL DEFAULT '' COMMENT '允许访问的IP',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '应用状态',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='应用表';


-- -----------------------------
-- Table structure for `onethink_ucenter_member`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_ucenter_member`;
CREATE TABLE `onethink_ucenter_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` char(16) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `email` char(32) NOT NULL COMMENT '用户邮箱',
  `mobile` char(15) NOT NULL DEFAULT '' COMMENT '用户手机',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) DEFAULT '0' COMMENT '用户状态',
 `face` int(10) unsigned NOT NULL DEFAULT '0'  COMMENT '头像',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- -----------------------------
-- Table structure for `onethink_ucenter_setting`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_ucenter_setting`;
CREATE TABLE `onethink_ucenter_setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '设置ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型（1-用户配置）',
  `value` text NOT NULL COMMENT '配置数据',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='设置表';



-- -----------------------------
-- Table structure for `onethink_url`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_url`;
CREATE TABLE `onethink_url` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '链接唯一标识',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `short` char(100) NOT NULL DEFAULT '' COMMENT '短网址',
  `status` tinyint(2) NOT NULL DEFAULT '2' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_url` (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='链接表';


-- -----------------------------
-- Table structure for `onethink_shoplist`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_shoplist`;
CREATE TABLE `onethink_shoplist` (
   `id` int(10) NOT NULL AUTO_INCREMENT,
  `goodid` int(10) unsigned NOT NULL DEFAULT '0',
  `num` int(10) unsigned NOT NULL DEFAULT '0',
  `orderid` varchar(225) CHARACTER SET utf8 DEFAULT NULL COMMENT '订单号',
  `uid` int(10) unsigned NOT NULL DEFAULT '0',
   `status` tinyint(2) NOT NULL DEFAULT '0'  COMMENT '未提交订单1-表示已提交订单或已支付2-已完成3-退货4-换货',
   `create_time` int(10)  unsigned NOT NULL DEFAULT '0',
   `price` decimal(50,2) NOT NULL DEFAULT '0',
   `parameters` varchar(225) NOT NULL DEFAULT '' COMMENT '参数',
    `sort` varchar(225) NOT NULL DEFAULT '' COMMENT '序号',
  `iscomment` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `total` decimal(50,2) NOT NULL DEFAULT '0',
  `tag` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '支付标识号',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- -----------------------------
-- Table structure for `onethink_message`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_message`;
CREATE TABLE `onethink_message` (
   `id` int(10) NOT NULL AUTO_INCREMENT,
   `uid` int(10) unsigned NOT NULL DEFAULT '0',
   `goodid` int(10) unsigned NOT NULL DEFAULT '0',
   `title` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '标题',
   `content` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '留言内容',
    `status` tinyint(2) NOT NULL DEFAULT '0'  COMMENT '默认0-未提交订单1-未读2-已读',
   `create_time` int(10) unsigned NOT NULL DEFAULT '0',
    `update_time` int(10) unsigned NOT NULL DEFAULT '0',
   `group` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '分组',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='留言表';


-- -----------------------------
-- Table structure for `onethink_reply`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_reply`;
CREATE TABLE `onethink_reply` (
   `id` int(10) NOT NULL AUTO_INCREMENT,
   `uid`  int(10) unsigned NOT NULL DEFAULT '0',
   `messageid` int(10) unsigned NOT NULL DEFAULT '0',
   `content` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '回复内容',
    `status` tinyint(2) NOT NULL  COMMENT '默认0-未提交订单1-未读2-已读',
   `create_time` int(10) unsigned NOT NULL DEFAULT '0',
    `update_time` int(10)  unsigned NOT NULL DEFAULT '0',
   `group` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '分组',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='回复表';

-- -----------------------------
-- Table structure for `onethink_envelope`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_envelope`;
CREATE TABLE `onethink_envelope` (
     `id` int(10) NOT NULL AUTO_INCREMENT,
     `username` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '用户名',
     `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
    `sendname` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '发件人',
      `title` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '标题', 
    `content` text NOT NULL COMMENT  '发送内容',
       `status` tinyint(2) NOT NULL DEFAULT '0'  COMMENT '1-未读2-已读',
     `view` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '阅读数量',
    `create_time` int(10) unsigned NOT NULL DEFAULT '0',
      `update_time` int(10)unsigned NOT NULL DEFAULT '0',
    `group` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '分组',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='站内信表';

-- -----------------------------
-- Table structure for `onethink_personenvelope`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_personenvelope`;
CREATE TABLE `onethink_personenvelope` (
     `id` int(10) NOT NULL AUTO_INCREMENT,
      `sendname` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '发件人',
     `title` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '标题', 
     `content` text NOT NULL COMMENT  '发送内容',
      `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '1-未读2-已读',
       `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
     `view` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
     `create_time` int(10) unsigned NOT NULL DEFAULT '0',
     `update_time` int(10)unsigned NOT NULL DEFAULT '0',
     `group` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '分组',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='个人站内信表';


-- -----------------------------
-- Table structure for `onethink_email`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_email`;
CREATE TABLE `onethink_email` (
   `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
     `title` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '标题', 
      `domain` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '链接',
      `account` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '邮箱',
    `username` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '用户名',
    `sendname` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '发件人',
    `content` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '回复内容',
      `msg` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '备注',
          `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
      `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '1已发送 -1禁用',
    `create_time` int(10) unsigned NOT NULL DEFAULT '0',
      `update_time` int(10)  unsigned NOT NULL DEFAULT '0',
    `group` varchar(225) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '分组',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='发送邮件记录表';

-- -----------------------------
-- Table structure for `onethink_sms`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_sms`;
CREATE TABLE `onethink_sms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mobile` varchar(50) NOT NULL DEFAULT '' COMMENT '手机号码',
  `content` varchar(225) NOT NULL DEFAULT '' COMMENT '短信内容',
  `extcode` varchar(50) NOT NULL DEFAULT '' COMMENT '扩展子号',
  `signtag` varchar(225) NOT NULL DEFAULT '' COMMENT '签名',
  `uid` varchar(225) NOT NULL DEFAULT '' COMMENT '用户id',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发送时间',
    `update_time` int(10)  unsigned NOT NULL DEFAULT '0',
  `tempid` varchar(255) NOT NULL DEFAULT '' COMMENT '模板编号',
  `group` tinyint(2) NOT NULL DEFAULT '0' COMMENT '分组1-验证2-通知' ,
  `other` tinyint(2) NOT NULL DEFAULT '0' COMMENT '备用' ,
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态1-有效2-过期3-验证' ,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='短信记录表';

-- -----------------------------
-- Table structure for `onethink_verification`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_verification`;
CREATE TABLE `onethink_verification` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mobile` varchar(50) NOT NULL DEFAULT '' COMMENT '手机号码',
  `email` varchar(50) NOT NULL DEFAULT '' COMMENT '邮箱',
  `paycode` varchar(50) NOT NULL DEFAULT '' COMMENT '支付密码',
  `uid` varchar(225) NOT NULL DEFAULT '' COMMENT '用户id',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发送时间',
    `update_time` int(10) unsigned NOT NULL DEFAULT '0',
  `tempid` varchar(255) NOT NULL DEFAULT '' COMMENT '模板编号',
  `tag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '验证分组1-邮箱2-手机3-其他' ,
 `msg` varchar(50) NOT NULL DEFAULT '' COMMENT '手机验证码',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态1-有效2-过期3-验证' ,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='安全验证表';



-- -----------------------------
-- Table structure for `onethink_userdata`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_userdata`;
CREATE TABLE `onethink_userdata` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `type` tinyint(3) unsigned NOT NULL COMMENT '类型标识',
  `target_id` int(10) unsigned NOT NULL COMMENT '目标id',
  UNIQUE KEY `uid` (`uid`,`type`,`target_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
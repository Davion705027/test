-- phpMyAdmin SQL Dump
-- version 4.4.15.10
-- https://www.phpmyadmin.net
--
-- Host: 127.0.0.1:3306
-- Generation Time: 2020-04-22 17:42:23
-- 服务器版本： 5.7.27
-- PHP Version: 5.4.45

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `egg-wechat2`
--

-- --------------------------------------------------------

--
-- 表的结构 `apply`
--

CREATE TABLE IF NOT EXISTS `apply` (
  `id` int(20) unsigned NOT NULL,
  `user_id` int(20) unsigned NOT NULL COMMENT '申请人id',
  `friend_id` int(20) unsigned NOT NULL COMMENT '好友id',
  `nickname` varchar(30) NOT NULL DEFAULT '' COMMENT '备注',
  `lookme` int(1) NOT NULL DEFAULT '1' COMMENT '看我',
  `lookhim` int(1) NOT NULL DEFAULT '1' COMMENT '看他',
  `status` enum('pending','refuse','agree','ignore') NOT NULL DEFAULT 'pending' COMMENT '申请状态',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `apply`
--

INSERT INTO `apply` (`id`, `user_id`, `friend_id`, `nickname`, `lookme`, `lookhim`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 'ceshi1', 1, 1, 'agree', '2020-02-26 22:37:26', '2020-02-26 22:39:20'),
(2, 3, 2, 'ceshi1', 1, 1, 'agree', '2020-02-26 22:37:26', '2020-02-26 22:58:22'),
(3, 1, 3, 'ceshi3', 1, 1, 'agree', '2020-03-14 17:35:00', '2020-03-14 17:53:20'),
(7, 2, 1, 'ceshi2', 1, 1, 'agree', '2020-04-06 03:01:56', '2020-04-06 03:02:07');

-- --------------------------------------------------------

--
-- 表的结构 `fava`
--

CREATE TABLE IF NOT EXISTS `fava` (
  `id` int(20) unsigned NOT NULL,
  `data` text NOT NULL COMMENT '内容',
  `type` enum('emoticon','text','image','video','audio','card') NOT NULL DEFAULT 'text' COMMENT '类型',
  `options` text NOT NULL COMMENT '其他参数',
  `user_id` int(20) unsigned NOT NULL COMMENT '用户id',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `fava`
--

INSERT INTO `fava` (`id`, `data`, `type`, `options`, `user_id`, `created_at`, `updated_at`) VALUES
(1, '解开了解开了', 'text', '{}', 1, '2020-03-14 04:57:13', '2020-03-14 04:57:13'),
(2, '哈哈哈', 'text', '{}', 1, '2020-03-14 05:03:46', '2020-03-14 05:03:46'),
(3, 'hahha ', 'text', '{}', 1, '2020-03-14 05:03:49', '2020-03-14 05:03:49'),
(4, 'blob:http://localhost:8080/be3c32c8-db43-4d1d-bb42-ded033ebf1d0', 'image', '{}', 1, '2020-03-14 05:04:34', '2020-03-14 05:04:34'),
(5, '/static/images/emoticon/5497/1.gif', 'emoticon', '{}', 1, '2020-03-14 05:04:38', '2020-03-14 05:04:38'),
(6, 'hahha ', 'text', '{}', 1, '2020-03-14 05:04:44', '2020-03-14 05:04:44'),
(7, 'blob:http://localhost:8080/301508ab-a5c4-4113-b60a-34ebcb1c94ae', 'video', '{"poster":"http://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/egg-oss-demo/7281pil3jeg0000.mp4?x-oss-process=video/snapshot,t_10,m_fast,w_300,f_png"}', 1, '2020-03-14 05:04:58', '2020-03-14 05:04:58'),
(9, 'http://tmp/touristappid.o6zAJsynvdf-LdFdDOg_X6XDszSY.Rd4QvciVedOT5b86a40bb28cbb38cefa0b86cca29e1f.mp4', 'video', '{"poster":"http://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/egg-oss-demo/egpduoarz340000.mp4?x-oss-process=video/snapshot,t_10,m_fast,w_300,f_png"}', 4, '2020-03-14 05:27:29', '2020-03-14 05:27:29');

-- --------------------------------------------------------

--
-- 表的结构 `friend`
--

CREATE TABLE IF NOT EXISTS `friend` (
  `id` int(20) unsigned NOT NULL,
  `user_id` int(20) unsigned NOT NULL COMMENT '用户id',
  `friend_id` int(20) unsigned NOT NULL COMMENT '好友id',
  `nickname` varchar(30) NOT NULL DEFAULT '' COMMENT '备注',
  `lookme` int(1) NOT NULL DEFAULT '1' COMMENT '看我',
  `lookhim` int(1) NOT NULL DEFAULT '1' COMMENT '看他',
  `star` int(1) NOT NULL DEFAULT '0' COMMENT '是否为星标朋友：0否1是',
  `isblack` int(1) NOT NULL DEFAULT '0' COMMENT '是否加入黑名单：0否1是',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `friend`
--

INSERT INTO `friend` (`id`, `user_id`, `friend_id`, `nickname`, `lookme`, `lookhim`, `star`, `isblack`, `created_at`, `updated_at`) VALUES
(3, 3, 2, 'ceshi1', 1, 1, 0, 0, '2020-02-26 22:58:22', '2020-02-26 22:58:22'),
(4, 2, 3, 'ceshi3', 1, 1, 0, 0, '2020-02-26 22:58:22', '2020-03-26 02:49:00'),
(5, 1, 3, 'ceshi3', 1, 1, 0, 0, '2020-03-14 17:53:20', '2020-03-14 17:53:20'),
(6, 3, 1, '', 1, 1, 0, 0, '2020-03-14 17:53:20', '2020-03-14 17:53:20'),
(13, 2, 1, 'ceshi2', 1, 1, 0, 0, '2020-04-06 03:02:07', '2020-04-06 03:02:07'),
(14, 1, 2, '', 1, 1, 0, 0, '2020-04-06 03:02:07', '2020-04-06 03:02:07');

-- --------------------------------------------------------

--
-- 表的结构 `friend_tag`
--

CREATE TABLE IF NOT EXISTS `friend_tag` (
  `id` int(20) unsigned NOT NULL,
  `friend_id` int(20) unsigned NOT NULL COMMENT '好友id',
  `tag_id` int(20) unsigned NOT NULL COMMENT '标签id',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `friend_tag`
--

INSERT INTO `friend_tag` (`id`, `friend_id`, `tag_id`, `created_at`, `updated_at`) VALUES
(1, 4, 1, '2020-03-20 23:10:40', '2020-03-20 23:10:40'),
(2, 4, 2, '2020-03-23 00:16:00', '2020-03-23 00:16:00');

-- --------------------------------------------------------

--
-- 表的结构 `group`
--

CREATE TABLE IF NOT EXISTS `group` (
  `id` int(20) unsigned NOT NULL,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '群组名称',
  `avatar` varchar(200) DEFAULT '',
  `user_id` int(20) unsigned NOT NULL COMMENT '群主id',
  `remark` text COMMENT '群公告',
  `invite_confirm` int(1) NOT NULL DEFAULT '1' COMMENT '邀请确认',
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `group`
--

INSERT INTO `group` (`id`, `name`, `avatar`, `user_id`, `remark`, `invite_confirm`, `status`, `created_at`, `updated_at`) VALUES
(7, 'ceshi2,ceshi3,ceshi1', '', 2, '', 1, 1, '2020-03-14 17:05:35', '2020-03-14 17:05:35'),
(8, 'ceshi3,ceshi2,hahah', '', 2, '', 1, 1, '2020-04-05 22:25:57', '2020-04-05 22:25:57'),
(9, 'ceshi3,ceshi2', '', 1, '', 1, 1, '2020-04-05 22:36:59', '2020-04-05 22:36:59');

-- --------------------------------------------------------

--
-- 表的结构 `group_user`
--

CREATE TABLE IF NOT EXISTS `group_user` (
  `id` int(20) unsigned NOT NULL,
  `user_id` int(20) unsigned NOT NULL COMMENT '用户id',
  `group_id` int(20) unsigned NOT NULL COMMENT '群组id',
  `nickname` varchar(30) NOT NULL DEFAULT '' COMMENT '在群里的昵称',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `group_user`
--

INSERT INTO `group_user` (`id`, `user_id`, `group_id`, `nickname`, `created_at`, `updated_at`) VALUES
(20, 2, 7, '', '2020-03-14 17:05:35', '2020-03-14 17:05:35'),
(23, 3, 7, '', '2020-03-20 22:23:37', '2020-03-20 22:23:37'),
(24, 2, 8, '', '2020-04-05 22:25:57', '2020-04-05 22:25:57'),
(25, 3, 8, '', '2020-04-05 22:25:57', '2020-04-05 22:25:57'),
(26, 1, 8, '', '2020-04-05 22:25:57', '2020-04-05 22:25:57'),
(27, 1, 9, '', '2020-04-05 22:36:59', '2020-04-05 22:36:59'),
(28, 3, 9, '', '2020-04-05 22:36:59', '2020-04-05 22:36:59'),
(29, 2, 9, '', '2020-04-06 02:44:54', '2020-04-06 02:44:54');

-- --------------------------------------------------------

--
-- 表的结构 `moment`
--

CREATE TABLE IF NOT EXISTS `moment` (
  `id` int(20) unsigned NOT NULL,
  `content` text NOT NULL COMMENT '朋友圈内容',
  `image` text NOT NULL COMMENT '朋友圈图片',
  `video` varchar(255) NOT NULL DEFAULT '' COMMENT '朋友圈视频',
  `location` varchar(255) NOT NULL DEFAULT '' COMMENT '位置',
  `remind` varchar(255) NOT NULL DEFAULT '' COMMENT '提醒谁看',
  `see` varchar(255) NOT NULL DEFAULT 'all' COMMENT '谁可以看 all公开 none私密',
  `user_id` int(20) unsigned NOT NULL COMMENT '用户id',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `moment`
--

INSERT INTO `moment` (`id`, `content`, `image`, `video`, `location`, `remind`, `see`, `user_id`, `created_at`, `updated_at`) VALUES
(1, '第一条朋友', '', '', '', '', 'all', 2, '2020-03-14 22:16:41', '2020-03-14 22:16:41'),
(2, '尽自己可见', '', '', '', '', 'none', 2, '2020-03-14 22:19:01', '2020-03-14 22:19:01'),
(3, '尽自己可见', '', '', '', '', 'only:1', 2, '2020-03-14 22:19:53', '2020-03-14 22:19:53'),
(4, '谁不可看', '', '', '', '', 'except:1', 2, '2020-03-14 22:20:33', '2020-03-14 22:20:33'),
(5, '谁不可看', '', '', '', '', 'except:1', 2, '2020-03-15 02:39:16', '2020-03-15 02:39:16'),
(6, '谁不可看', '', '', '', '', 'except:1', 2, '2020-03-15 02:39:18', '2020-03-15 02:39:18'),
(7, '谁不可看', '', '', '', '', 'except:1', 2, '2020-03-15 02:39:19', '2020-03-15 02:39:19'),
(8, '谁不可看', '', '', '', '', 'except:1', 2, '2020-03-15 02:39:21', '2020-03-15 02:39:21'),
(9, '谁不可看', '', '', '', '', 'except:1', 2, '2020-03-15 02:39:23', '2020-03-15 02:39:23'),
(10, '谁不可看', '', '', '', '', 'except:1', 2, '2020-03-15 02:39:24', '2020-03-15 02:39:24'),
(11, '谁不可看', '', '', '', '', 'except:1', 2, '2020-03-15 02:39:25', '2020-03-15 02:39:25'),
(12, '谁不可看', '', '', '', '', 'except:1', 2, '2020-03-15 02:39:26', '2020-03-15 02:39:26'),
(13, '谁不可看', '', '', '', '', 'except:1', 2, '2020-03-15 02:39:27', '2020-03-15 02:39:27'),
(14, '谁不可看', '', '', '', '', 'except:1', 2, '2020-03-15 02:39:28', '2020-03-15 02:39:28'),
(15, '发布文字内容', '', '{"src":"","poster":""}', '', '', 'all', 2, '2020-03-16 05:01:36', '2020-03-16 05:01:36'),
(16, '发送文字', '', '', '', '', 'all', 2, '2020-03-16 05:02:19', '2020-03-16 05:02:19'),
(17, '发送视频', '', '{"src":"http://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/egg-oss-demo/aap12cz2lcs0000.mp4","poster":"http://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/egg-oss-demo/aap12cz2lcs0000.mp4?x-oss-process=video/snapshot,t_10,m_fast,w_300,f_png"}', '', '', 'all', 2, '2020-03-16 05:03:39', '2020-03-16 05:03:39'),
(18, '发送图文', 'http://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/egg-oss-demo/forgmfqy3ko0000.jpg,http://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/egg-oss-demo/8dgnsquglsc0000.png', '', '', '', 'all', 2, '2020-03-16 05:04:01', '2020-03-16 05:04:01'),
(19, 'hahha', '', '', '', '', 'all', 2, '2020-03-16 05:11:04', '2020-03-16 05:11:04'),
(20, '', 'http://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/egg-oss-demo/1b7679055nnk000.jpg', '', '', '', 'all', 2, '2020-03-16 05:11:14', '2020-03-16 05:11:14'),
(21, '12456', 'http://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/egg-oss-demo/58ce3n6xjqg0000.jpg', '', '', '', 'all', 2, '2020-03-16 05:13:49', '2020-03-16 05:13:49'),
(22, 'dsadasd', '', '', '', '', 'all', 2, '2020-03-16 05:14:07', '2020-03-16 05:14:07'),
(23, '123456', '', '', '', '', 'all', 2, '2020-03-16 05:16:49', '2020-03-16 05:16:49'),
(24, '456789', '', '', '', '', 'all', 2, '2020-03-16 05:16:55', '2020-03-16 05:16:55'),
(25, '123465', '', '', '', '', 'all', 3, '2020-03-16 05:17:25', '2020-03-16 05:17:25'),
(26, 'hahah', '', '{"src":"http://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/egg-oss-demo/7jjtenh0al40000.mp4","poster":"http://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/egg-oss-demo/7jjtenh0al40000.mp4?x-oss-process=video/snapshot,t_10,m_fast,w_300,f_png"}', '', '', 'all', 3, '2020-03-16 05:20:20', '2020-03-16 05:20:20'),
(27, '提醒谁看', '', '', '', '3', 'all', 2, '2020-03-19 00:54:06', '2020-03-19 00:54:06'),
(28, '大撒大撒', '', '', '', '3', 'all', 2, '2020-03-19 00:57:02', '2020-03-19 00:57:02'),
(29, '谁可以看', '', '', '', '3', 'none', 2, '2020-03-19 01:46:17', '2020-03-19 01:46:17'),
(30, '你好', '', '', '', '3', 'only:3', 2, '2020-03-19 03:39:59', '2020-03-19 03:39:59'),
(31, '哈哈哈', '', '', '', '3', 'all', 2, '2020-03-19 03:44:34', '2020-03-19 03:44:34'),
(32, '123', 'http://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/egg-oss-demo/9mwlwr4u94c0000.jpg,http://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/egg-oss-demo/bu412k2b3fk0000.png', '', '', '', 'all', 3, '2020-03-26 02:29:12', '2020-03-26 02:29:12');

-- --------------------------------------------------------

--
-- 表的结构 `moment_comment`
--

CREATE TABLE IF NOT EXISTS `moment_comment` (
  `id` int(20) unsigned NOT NULL,
  `user_id` int(20) unsigned NOT NULL COMMENT '评论用户id',
  `moment_id` int(20) unsigned NOT NULL COMMENT '朋友圈消息id',
  `content` text CHARACTER SET utf8mb4 NOT NULL COMMENT '评论内容',
  `reply_id` int(11) NOT NULL DEFAULT '0' COMMENT '回复用户id 0顶级评论',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `moment_comment`
--

INSERT INTO `moment_comment` (`id`, `user_id`, `moment_id`, `content`, `reply_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '第一条回复', 0, '2020-03-14 23:24:37', '2020-03-14 23:24:37'),
(2, 1, 1, '第一条回复', 0, '2020-03-14 23:27:16', '2020-03-14 23:27:16'),
(3, 2, 14, '123', 0, '2020-03-16 02:17:53', '2020-03-16 02:17:53'),
(4, 3, 14, '哈哈哈啊', 2, '2020-03-16 02:25:12', '2020-03-16 02:25:12'),
(5, 2, 14, '哈哈哈', 3, '2020-03-16 02:27:55', '2020-03-16 02:27:55'),
(6, 2, 14, '??哈哈', 0, '2020-03-16 04:40:08', '2020-03-16 04:40:08'),
(7, 2, 14, '发送表情包😀😁😂', 2, '2020-03-16 04:41:59', '2020-03-16 04:41:59'),
(8, 1, 26, '😞123', 0, '2020-03-23 00:22:29', '2020-03-23 00:22:29'),
(9, 2, 32, '哈哈', 0, '2020-03-26 02:55:02', '2020-03-26 02:55:02'),
(10, 2, 32, '😄啦', 0, '2020-03-26 02:55:11', '2020-03-26 02:55:11'),
(11, 2, 32, '😖你好', 0, '2020-03-26 03:51:48', '2020-03-26 03:51:48');

-- --------------------------------------------------------

--
-- 表的结构 `moment_like`
--

CREATE TABLE IF NOT EXISTS `moment_like` (
  `id` int(20) unsigned NOT NULL,
  `user_id` int(20) unsigned NOT NULL COMMENT '点赞用户id',
  `moment_id` int(20) unsigned NOT NULL COMMENT '朋友圈消息id',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `moment_like`
--

INSERT INTO `moment_like` (`id`, `user_id`, `moment_id`, `created_at`, `updated_at`) VALUES
(2, 1, 1, '2020-03-14 22:58:14', '2020-03-14 22:58:14'),
(4, 2, 14, '2020-03-16 00:45:43', '2020-03-16 00:45:43'),
(5, 3, 14, '2020-03-16 00:46:04', '2020-03-16 00:46:04'),
(6, 1, 3, '2020-03-16 00:46:36', '2020-03-16 00:46:36'),
(12, 3, 13, '2020-03-16 01:57:32', '2020-03-16 01:57:32');

-- --------------------------------------------------------

--
-- 表的结构 `moment_timeline`
--

CREATE TABLE IF NOT EXISTS `moment_timeline` (
  `id` int(20) unsigned NOT NULL,
  `user_id` int(20) unsigned NOT NULL COMMENT '用户id',
  `moment_id` int(20) unsigned NOT NULL COMMENT '朋友圈消息id',
  `own` int(1) NOT NULL DEFAULT '0' COMMENT '是否是自己的 0否1是',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `moment_timeline`
--

INSERT INTO `moment_timeline` (`id`, `user_id`, `moment_id`, `own`, `created_at`, `updated_at`) VALUES
(1, 3, 1, 1, '2020-03-14 22:16:41', '2020-03-14 22:16:41'),
(3, 2, 1, 1, '2020-03-14 22:16:41', '2020-03-14 22:16:41'),
(4, 2, 2, 1, '2020-03-14 22:19:02', '2020-03-14 22:19:02'),
(6, 2, 3, 1, '2020-03-14 22:19:53', '2020-03-14 22:19:53'),
(7, 3, 4, 1, '2020-03-14 22:20:33', '2020-03-14 22:20:33'),
(8, 2, 4, 1, '2020-03-14 22:20:33', '2020-03-14 22:20:33'),
(9, 3, 5, 0, '2020-03-15 02:39:16', '2020-03-15 02:39:16'),
(10, 2, 5, 1, '2020-03-15 02:39:16', '2020-03-15 02:39:16'),
(11, 3, 6, 0, '2020-03-15 02:39:18', '2020-03-15 02:39:18'),
(12, 2, 6, 1, '2020-03-15 02:39:18', '2020-03-15 02:39:18'),
(13, 3, 7, 0, '2020-03-15 02:39:20', '2020-03-15 02:39:20'),
(14, 2, 7, 1, '2020-03-15 02:39:20', '2020-03-15 02:39:20'),
(15, 3, 8, 0, '2020-03-15 02:39:22', '2020-03-15 02:39:22'),
(16, 2, 8, 1, '2020-03-15 02:39:22', '2020-03-15 02:39:22'),
(17, 3, 9, 0, '2020-03-15 02:39:23', '2020-03-15 02:39:23'),
(18, 2, 9, 1, '2020-03-15 02:39:23', '2020-03-15 02:39:23'),
(19, 3, 10, 0, '2020-03-15 02:39:24', '2020-03-15 02:39:24'),
(20, 2, 10, 1, '2020-03-15 02:39:24', '2020-03-15 02:39:24'),
(21, 3, 11, 0, '2020-03-15 02:39:25', '2020-03-15 02:39:25'),
(22, 2, 11, 1, '2020-03-15 02:39:25', '2020-03-15 02:39:25'),
(23, 3, 12, 0, '2020-03-15 02:39:26', '2020-03-15 02:39:26'),
(24, 2, 12, 1, '2020-03-15 02:39:26', '2020-03-15 02:39:26'),
(25, 3, 13, 0, '2020-03-15 02:39:27', '2020-03-15 02:39:27'),
(26, 2, 13, 1, '2020-03-15 02:39:27', '2020-03-15 02:39:27'),
(27, 3, 14, 0, '2020-03-15 02:39:28', '2020-03-15 02:39:28'),
(28, 2, 14, 1, '2020-03-15 02:39:28', '2020-03-15 02:39:28'),
(29, 3, 15, 0, '2020-03-16 05:01:36', '2020-03-16 05:01:36'),
(30, 2, 15, 1, '2020-03-16 05:01:36', '2020-03-16 05:01:36'),
(31, 3, 16, 0, '2020-03-16 05:02:19', '2020-03-16 05:02:19'),
(32, 2, 16, 1, '2020-03-16 05:02:19', '2020-03-16 05:02:19'),
(33, 3, 17, 0, '2020-03-16 05:03:39', '2020-03-16 05:03:39'),
(34, 2, 17, 1, '2020-03-16 05:03:39', '2020-03-16 05:03:39'),
(35, 3, 18, 0, '2020-03-16 05:04:01', '2020-03-16 05:04:01'),
(36, 2, 18, 1, '2020-03-16 05:04:01', '2020-03-16 05:04:01'),
(37, 3, 19, 0, '2020-03-16 05:11:04', '2020-03-16 05:11:04'),
(38, 2, 19, 1, '2020-03-16 05:11:04', '2020-03-16 05:11:04'),
(39, 3, 20, 0, '2020-03-16 05:11:14', '2020-03-16 05:11:14'),
(40, 2, 20, 1, '2020-03-16 05:11:14', '2020-03-16 05:11:14'),
(41, 3, 21, 0, '2020-03-16 05:13:49', '2020-03-16 05:13:49'),
(42, 2, 21, 1, '2020-03-16 05:13:49', '2020-03-16 05:13:49'),
(43, 3, 22, 0, '2020-03-16 05:14:07', '2020-03-16 05:14:07'),
(44, 2, 22, 1, '2020-03-16 05:14:07', '2020-03-16 05:14:07'),
(45, 3, 23, 0, '2020-03-16 05:16:49', '2020-03-16 05:16:49'),
(46, 2, 23, 1, '2020-03-16 05:16:49', '2020-03-16 05:16:49'),
(47, 3, 24, 0, '2020-03-16 05:16:55', '2020-03-16 05:16:55'),
(48, 2, 24, 1, '2020-03-16 05:16:55', '2020-03-16 05:16:55'),
(49, 2, 25, 0, '2020-03-16 05:17:25', '2020-03-16 05:17:25'),
(50, 1, 25, 0, '2020-03-16 05:17:25', '2020-03-16 05:17:25'),
(51, 3, 25, 1, '2020-03-16 05:17:25', '2020-03-16 05:17:25'),
(52, 2, 26, 0, '2020-03-16 05:20:20', '2020-03-16 05:20:20'),
(53, 1, 26, 0, '2020-03-16 05:20:20', '2020-03-16 05:20:20'),
(54, 3, 26, 1, '2020-03-16 05:20:20', '2020-03-16 05:20:20'),
(55, 3, 27, 0, '2020-03-19 00:54:07', '2020-03-19 00:54:07'),
(56, 2, 27, 1, '2020-03-19 00:54:07', '2020-03-19 00:54:07'),
(57, 3, 28, 0, '2020-03-19 00:57:03', '2020-03-19 00:57:03'),
(58, 2, 28, 1, '2020-03-19 00:57:03', '2020-03-19 00:57:03'),
(59, 2, 29, 1, '2020-03-19 01:46:17', '2020-03-19 01:46:17'),
(60, 3, 30, 0, '2020-03-19 03:40:00', '2020-03-19 03:40:00'),
(61, 2, 30, 1, '2020-03-19 03:40:00', '2020-03-19 03:40:00'),
(62, 3, 31, 0, '2020-03-19 03:44:34', '2020-03-19 03:44:34'),
(63, 2, 31, 1, '2020-03-19 03:44:34', '2020-03-19 03:44:34'),
(64, 2, 32, 0, '2020-03-26 02:29:13', '2020-03-26 02:29:13'),
(65, 1, 32, 0, '2020-03-26 02:29:13', '2020-03-26 02:29:13'),
(66, 3, 32, 1, '2020-03-26 02:29:13', '2020-03-26 02:29:13');

-- --------------------------------------------------------

--
-- 表的结构 `report`
--

CREATE TABLE IF NOT EXISTS `report` (
  `id` int(20) unsigned NOT NULL,
  `user_id` int(20) unsigned NOT NULL COMMENT '用户id',
  `reported_id` int(20) unsigned NOT NULL COMMENT '被举报人id',
  `reported_type` enum('user','group') NOT NULL DEFAULT 'user' COMMENT '举报类型',
  `content` text COMMENT '举报内容',
  `category` varchar(10) DEFAULT '' COMMENT '举报分类',
  `status` enum('pending','refuse','agree') NOT NULL DEFAULT 'pending' COMMENT '举报状态',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `sequelizemeta`
--

CREATE TABLE IF NOT EXISTS `sequelizemeta` (
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `sequelizemeta`
--

INSERT INTO `sequelizemeta` (`name`) VALUES
('20200213115147-user.js'),
('20200215122707-friend.js'),
('20200215122724-apply.js'),
('20200218125815-report.js'),
('20200218133241-tag.js'),
('20200218133258-friend_tag.js'),
('20200302180102-group.js'),
('20200302180110-group_user.js'),
('20200313203535-fava.js'),
('20200314125012-moment.js'),
('20200314125016-moment_timeline.js'),
('20200314125023-moment_like.js'),
('20200314125028-moment_comment.js');

-- --------------------------------------------------------

--
-- 表的结构 `tag`
--

CREATE TABLE IF NOT EXISTS `tag` (
  `id` int(20) unsigned NOT NULL,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '标签名称',
  `user_id` int(20) unsigned NOT NULL COMMENT '用户id',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `tag`
--

INSERT INTO `tag` (`id`, `name`, `user_id`, `created_at`, `updated_at`) VALUES
(1, '哈哈哈', 2, '2020-03-20 23:10:40', '2020-03-20 23:10:40'),
(2, '家人', 2, '2020-03-23 00:15:59', '2020-03-23 00:15:59');

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(20) unsigned NOT NULL,
  `username` varchar(30) NOT NULL DEFAULT '' COMMENT '用户名称',
  `nickname` varchar(30) NOT NULL DEFAULT '' COMMENT '昵称',
  `email` varchar(160) DEFAULT NULL COMMENT '用户邮箱',
  `password` varchar(200) NOT NULL DEFAULT '',
  `avatar` varchar(200) DEFAULT '',
  `phone` varchar(20) DEFAULT NULL COMMENT '用户手机',
  `sex` enum('男','女','保密') DEFAULT '男' COMMENT '用户性别',
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '状态 0禁用1启用',
  `sign` varchar(200) NOT NULL DEFAULT '' COMMENT '个性签名',
  `area` varchar(200) NOT NULL DEFAULT '' COMMENT '地区',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`id`, `username`, `nickname`, `email`, `password`, `avatar`, `phone`, `sex`, `status`, `sign`, `area`, `created_at`, `updated_at`) VALUES
(1, 'ceshi2', '', NULL, 'f9c14ba4d63f224c02f317943105b0d4d7778628e51394b025994ed06d5c9863', '', NULL, '男', 1, '', '', '2020-02-26 22:32:50', '2020-02-26 22:32:50'),
(2, 'ceshi1', 'hahah', NULL, 'f9c14ba4d63f224c02f317943105b0d4d7778628e51394b025994ed06d5c9863', 'http://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/egg-oss-demo/e7kmvm0tu3c0000.jpg', NULL, '男', 1, '', '', '2020-02-26 22:32:58', '2020-03-14 20:07:15'),
(3, 'ceshi3', '', NULL, 'f9c14ba4d63f224c02f317943105b0d4d7778628e51394b025994ed06d5c9863', '', NULL, '男', 1, '', '', '2020-02-26 22:33:05', '2020-02-26 22:33:05'),
(4, 'ceshi4', '', NULL, 'f9c14ba4d63f224c02f317943105b0d4d7778628e51394b025994ed06d5c9863', '', NULL, '男', 1, '', '', '2020-02-26 22:33:13', '2020-02-26 22:33:13'),
(5, 'cesshi5', '', NULL, 'f9c14ba4d63f224c02f317943105b0d4d7778628e51394b025994ed06d5c9863', '', NULL, '男', 1, '', '', '2020-02-26 22:33:19', '2020-02-26 22:33:19'),
(6, 'ceshi6', '', NULL, 'f9c14ba4d63f224c02f317943105b0d4d7778628e51394b025994ed06d5c9863', '', NULL, '男', 1, '', '', '2020-02-26 22:33:30', '2020-02-26 22:33:30');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `apply`
--
ALTER TABLE `apply`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `friend_id` (`friend_id`);

--
-- Indexes for table `fava`
--
ALTER TABLE `fava`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `friend`
--
ALTER TABLE `friend`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `friend_id` (`friend_id`);

--
-- Indexes for table `friend_tag`
--
ALTER TABLE `friend_tag`
  ADD PRIMARY KEY (`id`),
  ADD KEY `friend_id` (`friend_id`),
  ADD KEY `tag_id` (`tag_id`);

--
-- Indexes for table `group`
--
ALTER TABLE `group`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `group_user`
--
ALTER TABLE `group_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `group_id` (`group_id`);

--
-- Indexes for table `moment`
--
ALTER TABLE `moment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `moment_comment`
--
ALTER TABLE `moment_comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `moment_id` (`moment_id`);

--
-- Indexes for table `moment_like`
--
ALTER TABLE `moment_like`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `moment_id` (`moment_id`);

--
-- Indexes for table `moment_timeline`
--
ALTER TABLE `moment_timeline`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `moment_id` (`moment_id`);

--
-- Indexes for table `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `sequelizemeta`
--
ALTER TABLE `sequelizemeta`
  ADD PRIMARY KEY (`name`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `tag`
--
ALTER TABLE `tag`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `apply`
--
ALTER TABLE `apply`
  MODIFY `id` int(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `fava`
--
ALTER TABLE `fava`
  MODIFY `id` int(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `friend`
--
ALTER TABLE `friend`
  MODIFY `id` int(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `friend_tag`
--
ALTER TABLE `friend_tag`
  MODIFY `id` int(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `group`
--
ALTER TABLE `group`
  MODIFY `id` int(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `group_user`
--
ALTER TABLE `group_user`
  MODIFY `id` int(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT for table `moment`
--
ALTER TABLE `moment`
  MODIFY `id` int(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=33;
--
-- AUTO_INCREMENT for table `moment_comment`
--
ALTER TABLE `moment_comment`
  MODIFY `id` int(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `moment_like`
--
ALTER TABLE `moment_like`
  MODIFY `id` int(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `moment_timeline`
--
ALTER TABLE `moment_timeline`
  MODIFY `id` int(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=67;
--
-- AUTO_INCREMENT for table `report`
--
ALTER TABLE `report`
  MODIFY `id` int(20) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tag`
--
ALTER TABLE `tag`
  MODIFY `id` int(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- 限制导出的表
--

--
-- 限制表 `apply`
--
ALTER TABLE `apply`
  ADD CONSTRAINT `apply_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `apply_ibfk_2` FOREIGN KEY (`friend_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- 限制表 `fava`
--
ALTER TABLE `fava`
  ADD CONSTRAINT `fava_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- 限制表 `friend`
--
ALTER TABLE `friend`
  ADD CONSTRAINT `friend_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `friend_ibfk_2` FOREIGN KEY (`friend_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- 限制表 `friend_tag`
--
ALTER TABLE `friend_tag`
  ADD CONSTRAINT `friend_tag_ibfk_1` FOREIGN KEY (`friend_id`) REFERENCES `friend` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `friend_tag_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`) ON DELETE CASCADE;

--
-- 限制表 `group`
--
ALTER TABLE `group`
  ADD CONSTRAINT `group_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- 限制表 `group_user`
--
ALTER TABLE `group_user`
  ADD CONSTRAINT `group_user_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `group_user_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`) ON DELETE CASCADE;

--
-- 限制表 `moment`
--
ALTER TABLE `moment`
  ADD CONSTRAINT `moment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- 限制表 `moment_comment`
--
ALTER TABLE `moment_comment`
  ADD CONSTRAINT `moment_comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `moment_comment_ibfk_2` FOREIGN KEY (`moment_id`) REFERENCES `moment` (`id`) ON DELETE CASCADE;

--
-- 限制表 `moment_like`
--
ALTER TABLE `moment_like`
  ADD CONSTRAINT `moment_like_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `moment_like_ibfk_2` FOREIGN KEY (`moment_id`) REFERENCES `moment` (`id`) ON DELETE CASCADE;

--
-- 限制表 `moment_timeline`
--
ALTER TABLE `moment_timeline`
  ADD CONSTRAINT `moment_timeline_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `moment_timeline_ibfk_2` FOREIGN KEY (`moment_id`) REFERENCES `moment` (`id`) ON DELETE CASCADE;

--
-- 限制表 `report`
--
ALTER TABLE `report`
  ADD CONSTRAINT `report_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- 限制表 `tag`
--
ALTER TABLE `tag`
  ADD CONSTRAINT `tag_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

/*
 * @Date           : 2022-03-28 14:51:16
 * @LastEditTime: 2023-10-25 14:43:42
 * @Description    :
 */
"use strict";

/**
 * @param {Egg.Application} app - egg application
 */
module.exports = (app) => {
  const { router, controller, middleware } = app;

  // require('./router/backend/user_info')(app);
  //管理员登录
  require("./router/backend/admin")(app);
  // 角色
  require("./router/backend/role")(app);
  // App 资源管理
  require("./router/backend/appAssets")(app);

  //用户管理
  require("./router/backend/user")(app);

  //管理后台操作记录
  require("./router/backend/adminRecord")(app);

  // 用户 模块化 配置 自定义版本号 表
  require("./router/backend/configVersion")(app);
  // 客户端  国际化  可配置表
  require("./router/backend/i18nKey")(app);
  //  DJ CP APP SDK 管理
  require("./router/backend/appSdkVersion")(app);

    // 客户端 CSS 属性 可配置表
    require("./router/backend/cssKey")(app);

  // 客户端 assets 属性 可配置表
  require("./router/backend/assetsKey")(app);
  // 组件 key
  require("./router/backend/componentKey")(app);
  // 组件文档
  require("./router/backend/componentDoc")(app);
  // 布局模板
  require("./router/backend/layoutTemplate")(app);
  //管理后台  键值 更改记录
  require("./router/backend/keyChangeRecord")(app);
  //管理后台  键值 集合模板
  require("./router/backend/versionGroup")(app);
  //   配置键 分组表
  require("./router/backend/keyGroup")(app);
  //客户端 其他  控制布局 可配置表
  require("./router/backend/jsKey")(app);
  //客户端  商户自定义配置
  require("./router/backend/keyConfigRecord")(app);

  //客户端   打包记录表
  require("./router/backend/packingRecord")(app);

  //客户端   图片阐述  描述 表
  require("./router/backend/imgDescription")(app);

  //客户端   打包 进程表
  require("./router/backend/packingProcess")(app);

  //客户端   打包 配置表
  require("./router/backend/packingConfig")(app);


  

  // 主题模板
  require("./router/backend/themeTemplate")(app);

  //语言管理
  require("./router/backend/language")(app);
    // 客户端 语言管理
    require("./router/backend/clientLanguage")(app);

  //常见问题管理

  require("./router/backend/faq")(app);
  //菜单管理
  require("./router/backend/menu")(app);
  //文档资源池
  require("./router/backend/docpool")(app);
  //md 文档资源池
  require("./router/backend/mddocpool")(app);
  
  // b-sdk 菜单管理
  require("./router/backend/b_sdk_menu")(app);
  // b-sdk 文档资源池
  require("./router/backend/b_sdk_docpool")(app);
  // b-sdk md 文档资源池
  require("./router/backend/b_sdk_mddocpool")(app);

  //问题主题
  require("./router/backend/questionTopic")(app);

  //文章管理
  require("./router/backend/article")(app);
  //更新记录
  require("./router/backend/updateRecord")(app);
  //更新记录
  require("./router/common/file")(app);
  // 公共接口 无需token
  // require("./router/common/index")(app);
  //MD文档上传记录
  require("./router/backend/mdHistory")(app);
  // code 标签
  require("./router/backend/codeTag")(app);
  // 中间件接口
  require("./router/backend/middlewareInterface")(app);
  // 賽事管理
  require("./router/backend/competitionManage")(app);
  // 賽事分片管理
  require("./router/backend/competitionSlice")(app);
  // 动画模板
  require("./router/backend/animTemplate")(app);
  // 动画联队
  require("./router/backend/animTeamManage")(app);
  // 动画基础
  require("./router/backend/animBaseManage")(app);

  require("./router/client/all")(app);
  // 客户端菜单和权限
  require("./router/backend/clientRouters")(app);
   // 扫描大赛资源
   require("./router/backend/scan_match")(app);   

  // ----------------- 杯赛历史数据 ---------------
  // 上传文件
  require("./router/backend/matchMaterial/uploadFile")(app);
  // 欧洲杯
  require("./router/backend/matchMaterial/match_ozb")(app);

  // 奥运会
  require("./router/backend/matchMaterial/match_oyh")(app);

  // 历史视频
  require("./router/backend/matchMaterial/historical_videos")(app);
  // 场馆管理
  require("./router/backend/matchMaterial/venueManage")(app);
  // 运动员管理
  require("./router/backend/matchMaterial/athleteManage")(app);
  require("./router/backend/appLogger")(app);


  
  //运维

  require("./router/yunwei/all")(app);

  require("./router/openapi")(app);


};

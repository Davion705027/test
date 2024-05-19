

"use strict";

/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
  const { router, controller, jwt } = app;
  const prefix = app.config.api_prefix.client_prefix;

  /**
   * @api {post} /client/login  客户端接口 客户端用户登录
   *
   * @apiGroup  客户端接口
   *
   */
  router.post(prefix + "/login", controller.user.login);

  /**
   * 客户端, 获取当前登录用户的角色所绑定的菜单
   */
  router.get(prefix + '/user/menus', controller.clientRole.getRoleMenus)

  /**
   * @api {get} /client/faq/all  客户端获取常见问题列表
   *
   * @apiGroup    客户端接口
   *
   */
  router.get(prefix + "/faq/all", controller.faq.index);

  /**
   * @api {get} /client/faq/info  客户端获取常见问题详情
   *
   * @apiGroup    客户端接口
   *
   */
  router.get(prefix + "/faq/info", controller.faq.show);

  /**
   * @api {get} /client/updateRecord/all  客户端获取更新记录列表
   *
   * @apiGroup    客户端接口
   *
   */
  router.get(prefix + "/updateRecord/all", controller.updateRecord.index);

  /**
   * @api {get} /client/updateRecord/info  客户端获取更新记录详情
   *
   * @apiGroup    客户端接口
   *
   */
  router.get(prefix + "/updateRecord/info", controller.updateRecord.show);

  /**
   * @api {get} /client/updateRecord/related  客户端获取相关的更新记录（文档或者常见问题）
   *
   * @apiGroup    客户端接口
   *
   */
  router.get(prefix + "/updateRecord/related", controller.updateRecord.related_record);

  /**
   * 查询所有菜单
   */
  router.get(prefix + "/menu/find-all-menus", controller.menu.findAllMenus);

  /**
 * @api {get} /client/menu/children  客户端获取菜单子节点 树形
 * @apiGroup   客户端接口
 *
 * @apiParam {Number} id  菜单id.
 *

 */
  router.get(prefix + "/menu/childrendeep", controller.menu.find_children_deep);

  /**
 * @api {get} /client/menu/children  客户端获取菜单子节点 平铺
 * @apiGroup   客户端接口
 *
 * @apiParam {Number} id  菜单id.
 *

 */
  router.get(prefix + "/menu/childrenflat", controller.menu.find_children_flat);

  /**
 * @api {get} /client/docpool/info  客户端获取文档详情
 * @apiGroup   客户端接口
 *
 * @apiParam {Number} id  文档id.
 *

 */
  router.get(prefix + "/docpool/info", controller.docpool.show);
  /**
   * @api 问题列表
   */
  router.get(prefix + "/faq/all", controller.faq.index);

  /**
   * @api 文档列表
   */
  router.get(prefix + "/docpool/all", controller.docpool.index);

  /**
   * @api 文档列表 - 查询
   */
  router.get(prefix + "/docpool/search", controller.docpool.searchDoc);

  /**
 * @api {get} /client/detail/info  客户端获取文档详情
 * @apiGroup   客户端接口
 *
 * @apiParam {Number} id  文档id.
 *

 */
  router.get(prefix + "/detail/info", controller.detail.show);

  /**
   * @api 文档详情
   */
  router.get(prefix + "/mddocpool/info", controller.mddocpool.findMdDocInfo);


  /**
  * @api css配置属性分组
  */
  router.get(prefix + "/keyGroup/all", controller.keyGroup.index);



 
  /**
   * 客户端  创建版本
   */
  router.post(prefix + "/configVersion/create", controller.configVersion.create);
  /**
   * 客户端  修改版本状态
   */
  router.post(prefix + '/configVersion/update', controller.configVersion.update);


/**
   * 选择一个版本 copy 为新版本
   */
router.post(prefix + '/configVersion/cloneVersion', controller.configVersion.cloneVersion);




/**
 * 客户端 查询当前用户的版本列表
 */
router.get(prefix + '/configVersion/findAll', controller.configVersion.clientIndex);


 

  /**
  * @api   根据 获取 key 系统预设配置 
  */

  router.get(prefix + "/key/findKey", controller.client.findKey);


/**
 * 客户端 设置单条 保存
 */

  router.post(prefix + '/keyConfigRecord/saveRecord', controller.keyConfigRecord.saveRecord);
/**
 * 客户端  读取 记录 
 */

  router.get(prefix + '/keyConfigRecord/findRecord', controller.keyConfigRecord.findRecord);


 



  /**
   * 获取打包记录
   */
  router.get(prefix + '/packingRecord/all', controller.packingRecord.index);
  /**
   * 一键打包
   */
  router.post(prefix + '/packingRecord/packAllConfig', controller.packingRecord.packAllConfig);

  router.post(prefix + '/packingRecord/create', controller.packingRecord.create);



  /**
   * 客户端点击模块化设置的保存
   */
  router.post(prefix + '/modular/setting/save', controller.modularSettingCache.save);

  /**
   * 获取客户端之前保存过的设置记录
   */
  router.get(prefix + '/modular/setting/list', controller.modularSettingCache.list);

  /**
   * 选择一条记录的版本作为当前版本
   */
  router.get(prefix + '/modular/setting/pick', controller.modularSettingCache.pick);

  

  /**
  * 上传文件
  */
  router.post(prefix + '/file/upload', controller.fileUpload.save);



  router.get(prefix + '/codeTag/all', controller.codeTag.index);

  router.get(prefix + '/middlewareInterface/findByCodeTag', controller.middlewareInterface.findByCodeTag);

  router.get(prefix + '/middlewareInterface/details', controller.middlewareInterface.show);

  router.get(prefix + '/middlewareInterface/findResponseData', controller.middlewareInterface.findResponseData);

  router.get(prefix + '/competitionManage/findAll', controller.competitionManage.findAll);

  router.get(prefix + '/competitionSlice/findByPlayingTime', controller.competitionSlice.findByPlayingTime);
/**
 * 布局 列表 
 */
  router.get(prefix+ '/layoutTemplate/findAll', controller.layoutTemplate.index);
  /**
   * 标准 主题 列表
   */
  router.get(prefix+ '/themeTemplate/findAll', controller.themeTemplate.index);
  /**
   * H5,PC 客户端 语言列表
   */
  router.get(prefix+ '/clientLanguage/findAll', controller.clientLanguage.index);
  /**
   * 对接文档 客户端 系统 语言列表
   */
  router.get(prefix+ '/language/read', controller.language.index);
  router.get(prefix + "/clientLanguage/read", controller.clientLanguage.index);


 

  /**
   * 组合打包 打包配置 列表
   */
  router.get(prefix+ '/packingConfig/read', controller.packingConfig.index);
    /**
   * 组合打包 打包配置 创建
   */
  router.post(prefix+'/packingConfig/create',   controller. packingConfig.create);
    /**
   * 组合打包 打包配置 更新
   */
  router.post(prefix+'/packingConfig/update', controller.packingConfig.update);


    /**
   * 查询 图片描述 配置
   */

  router.post(prefix+'/imgDescription/findImgDescList', controller.imgDescription.findImgDescList);

  
  /**
   * 查询 b-sdk 所有菜单
   */
  router.get(prefix + "/b_sdk/menu/find-all-menus", controller.bSdkMenu.findAllMenus);
  
  /**
   * @api b-sdk 文档列表 - 查询
   */
  router.get(prefix + "/b_sdk/docpool/search", controller.bSdkDocpool.searchDoc);
  
  /**
   * @api b-sdk 文档列表 - 查询
   */
  router.get(prefix + "/b_sdk/docpool/details", controller.bSdkDocpool.show);

  /**
   * @api 文档详情
   */
  router.get(prefix + "/b_sdk/mddocpool/info", controller.bSdkMddocpool.findMdDocInfo);

  /**
   * @api 获取app adk 历史版本
   */
  router.get(prefix + "/appSdkVersion/all", controller.appSdkVersion.index);

};

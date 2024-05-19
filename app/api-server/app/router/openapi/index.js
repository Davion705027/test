"use strict";

/**
 * @param {Egg.Application} app - egg application
 */
module.exports = (app) => {
  const { router, controller } = app;

  /**
   * @api {get} 文档详情
   *
   * @apiGroup  开放接口
   */
  router.get(
    "/openapi/b_sdk/mddocpool/content/:language/:docId",
    controller.bSdkMddocpool.findMdDocContent
  );

  /**
   * @api {post} 上传 组件文档 文件
   *
   * @apiGroup  开放接口
   */
  router.post("/openapi/componentDoc/upload", controller.componentDoc.upload);

  /**
   * @api {get} 组件文档 菜单
   *
   * @apiGroup  开放接口
   */
  router.get("/openapi/componentKey/menus", controller.componentKey.menus);

  /**
   * @api {get} 组件文档 详情
   *
   * @apiGroup  开放接口
   */
  router.get(
    "/openapi/componentDoc/findDetailsByProjectAndVersion",
    controller.componentDoc.findDetailsByProjectAndVersion
  );

  router.get("/openapi/appSdkVersion/all", controller.appSdkVersion.all);

  /**
   * @api {get} 动画配置
   *
   * @apiGroup  开放接口
   */
  router.get(
    "/openapi/animation/config",
    controller.animTemplate.animTemplateConfig
  );

  /**
   * @api {get} 获取动画模板基础数据
   *
   * @apiGroup  开放接口
   */
  router.get(
    "/openapi/animation/baseData",
    controller.animBaseManage.getAnimBaseData
  );

  /**
   * @api {get} 获取动画模板 logo 数据
   *
   * @apiGroup  开放接口
   */
  router.get(
    "/openapi/animation/logoData",
    controller.animTeamManage.getLogoData
  );

  /**
   * @api {get} 获取各布局各环境最新打包记录 布局作为键 ，有隐藏BUG
   *
   * @apiGroup  开放接口
   */
  router.get("/openapi/getRecentPack", controller.packingRecord.getRecentPack);

  /**
   * @api {get} 获取各布局各环境最新打包记录 打包配置 ID 作为键
   *
   * @apiGroup  开放接口
   */
  router.get(
    "/openapi/getRecentPack2",
    controller.packingRecord.getRecentPack2
  );


  // 上传切片
  router.post(
    "/openapi/applogger/upload",
    controller.appLogger.sliceUpload
  );

  // 合并切片
  router.post(
    "/openapi/applogger/merge",
    controller.appLogger.merge
  );

  // app日志列表
  router.get(
    "/openapi/applogger/index",
    controller.appLogger.index
  );
};

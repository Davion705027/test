/*
 * @Date           : 2022-04-05 21:56:33
 * @LastEditTime: 2022-09-21 19:37:27
 * @Description    :
 */

"use strict";

/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
  const { router, controller, jwt } = app;
 

  /**
   * @api {post} /client/login  客户端接口 客户端用户登录
   *
   * @apiGroup  客户端接口
   *
   */
  router.post(  "/yunwei/need_packup", controller.packingProcess.index);

 

};

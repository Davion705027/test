"use strict";
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = (app) => {
  const { router, controller } = app;
  const {mddocpool} = controller
  const prefix = app.config.api_prefix.backend_prefix;
  router.get(prefix + "/mddocpool/all", mddocpool.index);
  router.get(prefix + "/mddocpool/info", mddocpool.show);
  router.post(prefix + "/mddocpool/create", mddocpool.create);
  router.post(prefix + "/mddocpool/update", mddocpool.update);
  router.post(prefix + "/mddocpool/disable", mddocpool.disable);
  /**
   * @api {post} /mddocpool/oneclick_enable   一键启用
  */
  router.post(prefix + "/mddocpool/oneclick_enable",mddocpool.oneclick_enable);
  app.config.open_delete_fn &&
    router.post(prefix + "/mddocpool/delete", mddocpool.destroy);
};

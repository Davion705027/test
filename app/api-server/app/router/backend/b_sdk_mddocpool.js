"use strict";
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = (app) => {
  const { router, controller } = app;
  const {bSdkMddocpool} = controller
  const prefix = app.config.api_prefix.backend_prefix;
  router.get(prefix + "/b_sdk_mddocpool/all", bSdkMddocpool.index);
  router.get(prefix + "/b_sdk_mddocpool/info", bSdkMddocpool.show);
  router.post(prefix + "/b_sdk_mddocpool/create", bSdkMddocpool.create);
  router.post(prefix + "/b_sdk_mddocpool/update", bSdkMddocpool.update);
  router.post(prefix + "/b_sdk_mddocpool/disable", bSdkMddocpool.disable);
  app.config.open_delete_fn &&
    router.post(prefix + "/b_sdk_mddocpool/delete", bSdkMddocpool.destroy);
};

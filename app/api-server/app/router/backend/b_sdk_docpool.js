"use strict";
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = (app) => {
  const { router, controller } = app;
  const {bSdkDocpool} = controller
  const prefix = app.config.api_prefix.backend_prefix;
  router.get(prefix + "/b_sdk_docpool/all", bSdkDocpool.index);
  router.get(prefix + "/b_sdk_docpool/info", bSdkDocpool.show);
  router.post(prefix + "/b_sdk_docpool/create", bSdkDocpool.create);
  router.post(prefix + "/b_sdk_docpool/update", bSdkDocpool.update);
  router.post(prefix + "/b_sdk_docpool/disable", bSdkDocpool.disable);
  app.config.open_delete_fn &&
    router.post(prefix + "/b_sdk_docpool/delete", bSdkDocpool.destroy);
};

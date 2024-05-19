"use strict";
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = (app) => {
  const { router, controller } = app;

  const prefix = app.config.api_prefix.backend_prefix;

  router.get(prefix + "/animBaseManage/all", controller.animBaseManage.index);
  router.get(prefix + "/animBaseManage/info", controller.animBaseManage.show);
  router.post(prefix + "/animBaseManage/create", controller.animBaseManage.create);
  router.post(prefix + "/animBaseManage/update", controller.animBaseManage.update);
  app.config.open_delete_fn &&
    router.post(
      prefix + "/animBaseManage/delete",
      controller.animBaseManage.destroy
    );
};

"use strict";
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = (app) => {
  const { router, controller } = app;

  const prefix = app.config.api_prefix.backend_prefix;

  router.get(prefix + "/animTemplate/all", controller.animTemplate.index);
  router.get(prefix + "/animTemplate/info", controller.animTemplate.show);
  router.get(prefix + "/animTemplate/dict", controller.animTemplate.dict);
  router.post(prefix + "/animTemplate/create", controller.animTemplate.create);
  router.post(prefix + "/animTemplate/update", controller.animTemplate.update);
  app.config.open_delete_fn &&
    router.post(
      prefix + "/animTemplate/delete",
      controller.animTemplate.destroy
    );
};

"use strict";
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = (app) => {
  const { router, controller } = app;
  const {docpool} = controller
  const prefix = app.config.api_prefix.backend_prefix;
  router.get(prefix + "/docpool/all", docpool.index);
  router.get(prefix + "/docpool/info", docpool.show);
  router.post(prefix + "/docpool/create", docpool.create);
  router.post(prefix + "/docpool/update", docpool.update);
  router.post(prefix + "/docpool/disable", docpool.disable);
  app.config.open_delete_fn &&
    router.post(prefix + "/docpool/delete", docpool.destroy);
};

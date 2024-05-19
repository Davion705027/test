"use strict";
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = (app) => {
  const { router, controller } = app;
  const {mdHistory} = controller
  const prefix = app.config.api_prefix.backend_prefix;
  router.get(prefix + "/mdHistory/all", mdHistory.index);
  router.get(prefix + "/mdHistory/info", mdHistory.show);
  router.post(prefix + "/mdHistory/create", mdHistory.create);
  router.post(prefix + "/mdHistory/update", mdHistory.update);
  router.post(prefix + "/mdHistory/disable", mdHistory.disable);
  router.post(prefix + "/mdHistory/delete", mdHistory.destroy);
  app.config.open_delete_fn &&
    router.get(
      prefix + "/mdHistory/related",
      mdHistory.related_record
    );
};

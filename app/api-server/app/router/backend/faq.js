"use strict";
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = (app) => {
  const { router, controller } = app;
  const {faq} = controller
  const prefix = app.config.api_prefix.backend_prefix;
  router.get(prefix + "/faq/all", faq.index);
  router.get(prefix + "/faq/info", faq.show);
  router.post(prefix + "/faq/create", faq.create);
  router.post(prefix + "/faq/update", faq.update);
  router.post(prefix + "/faq/disable", faq.disable);
  app.config.open_delete_fn &&
    router.post(prefix + "/faq/delete", faq.destroy);
};

"use strict";
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = (app) => {
  const { router, controller } = app;
  const {menu} = controller
  const prefix = app.config.api_prefix.backend_prefix;
  router.get(prefix + "/menu/all", menu.index);
  router.get(prefix + "/menu/children", menu.find_children_deep);
  router.get(prefix + "/menu/info", menu.show);
  router.post(prefix + "/menu/create", menu.create);
  router.post(prefix + "/menu/update", menu.update);
  router.post(prefix + "/menu/disable", menu.disable);
   app.config.open_delete_fn && router.post(prefix + "/menu/delete", menu.destroy);
};

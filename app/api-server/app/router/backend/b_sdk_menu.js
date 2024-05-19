"use strict";
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = (app) => {
  const { router, controller } = app;
  const {bSdkMenu} = controller
  const prefix = app.config.api_prefix.backend_prefix;
  router.get(prefix + "/b_sdk_menu/all", bSdkMenu.index);
  router.get(prefix + "/b_sdk_menu/children", bSdkMenu.find_children_deep);
  router.get(prefix + "/b_sdk_menu/info", bSdkMenu.show);
  router.post(prefix + "/b_sdk_menu/create", bSdkMenu.create);
  router.post(prefix + "/b_sdk_menu/update", bSdkMenu.update);
  router.post(prefix + "/b_sdk_menu/disable", bSdkMenu.disable);
   app.config.open_delete_fn && router.post(prefix + "/b_sdk_menu/delete", bSdkMenu.destroy);
};

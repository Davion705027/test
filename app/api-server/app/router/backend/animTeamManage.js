"use strict";
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = (app) => {
  const { router, controller } = app;

  const prefix = app.config.api_prefix.backend_prefix;

  router.get(prefix + "/animTeamManage/all", controller.animTeamManage.index);
  router.get(prefix + "/animTeamManage/info", controller.animTeamManage.show);
  router.post(prefix + "/animTeamManage/create", controller.animTeamManage.create);
  router.post(prefix + "/animTeamManage/update", controller.animTeamManage.update);
  app.config.open_delete_fn &&
    router.post(
      prefix + "/animTeamManage/delete",
      controller.animTeamManage.destroy
    );
};

'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const { versionGroup } = controller
   const prefix = app.config.api_prefix.backend_prefix

   router.get(prefix + '/versionGroup/all', versionGroup.index);
   router.get(prefix + '/versionGroup/info', versionGroup.show);
   router.post(prefix + '/versionGroup/create', versionGroup.create);
   router.post(prefix + '/versionGroup/update', versionGroup.update);
   router.post(prefix + '/versionGroup/updateBatch', versionGroup.update_batch);
   app.config.open_delete_fn && router.post(prefix + '/versionGroup/delete', versionGroup.destroy);
};

'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const {competitionManage} = controller
   const   prefix = app.config.api_prefix.backend_prefix
   router.get(prefix+'/competitionManage/all', competitionManage.index);
   router.get(prefix+'/competitionManage/findOneByCid', competitionManage.findOneByCid);
   router.post(prefix+'/competitionManage/create',    competitionManage.create);
   router.post(prefix+'/competitionManage/update', competitionManage.update);
   app.config.open_delete_fn &&   router.post(prefix+'/competitionManage/delete', competitionManage.destroy);
};

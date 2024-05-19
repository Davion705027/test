'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const athleteManage = controller.matchMaterial.athleteManage
   const prefix = app.config.api_prefix.backend_prefix
   router.get(prefix+'/matchMaterial/athleteManage/all',athleteManage.index);
   router.get(prefix+'/matchMaterial/athleteManage/findOneByCid', athleteManage.findOneByCid);
   router.post(prefix+'/matchMaterial/athleteManage/create',  athleteManage.create);
   router.post(prefix+'/matchMaterial/athleteManage/update', athleteManage.update);
   router.post(prefix+'/matchMaterial/athleteManage/delete', athleteManage.destroy);
};

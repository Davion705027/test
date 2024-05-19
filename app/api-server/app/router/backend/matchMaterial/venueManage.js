'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const venueManage = controller.matchMaterial.venueManage
   const prefix = app.config.api_prefix.backend_prefix
   router.get(prefix+'/matchMaterial/venueManage/all',venueManage.index);
   router.get(prefix+'/matchMaterial/venueManage/findOneByCid', venueManage.findOneByCid);
   router.post(prefix+'/matchMaterial/venueManage/create',  venueManage.create);
   router.post(prefix+'/matchMaterial/venueManage/update', venueManage.update);
   router.post(prefix+'/matchMaterial/venueManage/delete', venueManage.destroy);
};

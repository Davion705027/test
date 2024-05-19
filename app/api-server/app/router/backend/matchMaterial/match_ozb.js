'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const prefix = app.config.api_prefix.backend_prefix
   router.get(prefix+'/matchMaterial/match_ozb/all',controller.matchMaterial.matchOzb.index);
   router.get(prefix+'/matchMaterial/match_ozb/findOneByCid', controller.matchMaterial.matchOzb.findOneByCid);
   router.post(prefix+'/matchMaterial/match_ozb/create',    controller.matchMaterial.matchOzb.create);
   router.post(prefix+'/matchMaterial/match_ozb/update', controller.matchMaterial.matchOzb.update);
   router.post(prefix+'/matchMaterial/match_ozb/delete', controller.matchMaterial.matchOzb.destroy);
};

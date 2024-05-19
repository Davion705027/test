'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const prefix = app.config.api_prefix.backend_prefix
   router.get(prefix+'/matchMaterial/match_oyh/all',controller.matchMaterial.matchOyh.index);
   router.get(prefix+'/matchMaterial/match_oyh/findOneByCid', controller.matchMaterial.matchOyh.findOneByCid);
   router.post(prefix+'/matchMaterial/match_oyh/create',    controller.matchMaterial.matchOyh.create);
   router.post(prefix+'/matchMaterial/match_oyh/update', controller.matchMaterial.matchOyh.update);
   router.post(prefix+'/matchMaterial/match_oyh/delete', controller.matchMaterial.matchOyh.destroy);
};

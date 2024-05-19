'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const {packingConfig} = controller
   const   prefix = app.config.api_prefix.backend_prefix
 
   router.get(prefix+'/packingConfig/all', packingConfig.index);
   router.get(prefix+'/packingConfig/info', packingConfig.show);
   router.post(prefix+'/packingConfig/create',    packingConfig.create);
   router.post(prefix+'/packingConfig/update', packingConfig.update);
   app.config.open_delete_fn &&   router.post(prefix+'/packingConfig/delete', packingConfig.destroy);
};

'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const {packingProcess} = controller
   const   prefix = app.config.api_prefix.backend_prefix
   router.get(prefix+'/packingProcess/all', packingProcess.index);
   router.get(prefix+'/packingProcess/info', packingProcess.show);
   router.post(prefix+'/packingProcess/create',    packingProcess.create);
   router.post(prefix+'/packingProcess/update', packingProcess.update);
  router.post(prefix+'/packingProcess/delete', packingProcess.destroy);
  router.get(prefix+'/packingProcess/refresh', packingProcess.refresh);
};

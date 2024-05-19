'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const {packingRecord} = controller
   const   prefix = app.config.api_prefix.backend_prefix
   router.get(prefix+'/packingRecord/all', packingRecord.index);
   router.get(prefix+'/packingRecord/info', packingRecord.show);
   router.post(prefix+'/packingRecord/create',    packingRecord.create);
   router.post(prefix+'/packingRecord/update', packingRecord.update);
   app.config.open_delete_fn &&  router.post(prefix+'/packingRecord/delete', packingRecord.destroy);
};

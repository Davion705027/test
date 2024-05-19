'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const {jsKey } = controller
   const   prefix = app.config.api_prefix.backend_prefix

   router.get(prefix+'/jsKey/all',jsKey.index);
   router.get(prefix+'/jsKey/info',jsKey.show);
   router.post(prefix+'/jsKey/create',   jsKey.create);
   router.post(prefix+'/jsKey/update',jsKey.update);
   app.config.open_delete_fn &&   router.post(prefix+'/jsKey/delete',jsKey.destroy);
};

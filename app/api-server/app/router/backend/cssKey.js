'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const {cssKey} = controller
   const   prefix = app.config.api_prefix.backend_prefix

   router.get(prefix+'/cssKey/all', cssKey.index);
   router.get(prefix+'/cssKey/info', cssKey.show);
   router.post(prefix+'/cssKey/create',    cssKey.create);
   router.post(prefix+'/cssKey/update', cssKey.update);
   app.config.open_delete_fn &&   router.post(prefix+'/cssKey/delete', cssKey.destroy);
};

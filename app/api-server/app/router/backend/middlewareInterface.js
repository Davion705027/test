'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const {middlewareInterface} = controller
   const   prefix = app.config.api_prefix.backend_prefix
   router.get(prefix+'/middlewareInterface/all', middlewareInterface.index);
   router.get(prefix+'/middlewareInterface/info', middlewareInterface.show);
   router.post(prefix+'/middlewareInterface/create',    middlewareInterface.create);
   router.post(prefix+'/middlewareInterface/update', middlewareInterface.update);
   app.config.open_delete_fn &&   router.post(prefix+'/middlewareInterface/delete', middlewareInterface.destroy);
};

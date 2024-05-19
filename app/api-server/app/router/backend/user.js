'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const {user} = controller
   const   prefix = app.config.api_prefix.backend_prefix
   router.get(prefix+'/user/all', user.index);
   router.get(prefix+'/user/info', user.show);
   router.post(prefix+'/user/create',    user.create);
   router.post(prefix+'/user/update', user.update);
   app.config.open_delete_fn &&   router.post(prefix+'/user/delete', user.destroy);
};

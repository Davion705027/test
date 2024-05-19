'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const {keyGroup} = controller
   const   prefix = app.config.api_prefix.backend_prefix
   router.get(prefix+'/keyGroup/all', keyGroup.index);
   router.get(prefix+'/keyGroup/info', keyGroup.show);
   router.post(prefix+'/keyGroup/create',    keyGroup.create);
   router.post(prefix+'/keyGroup/update', keyGroup.update);
   app.config.open_delete_fn &&   router.post(prefix+'/keyGroup/delete', keyGroup.destroy);
};

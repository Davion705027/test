'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const {configVersion} = controller
   const   prefix = app.config.api_prefix.backend_prefix
   router.get(prefix+'/configVersion/all', configVersion.index);
   router.get(prefix+'/configVersion/info', configVersion.show);
   router.post(prefix+'/configVersion/create',    configVersion.create);
   router.post(prefix+'/configVersion/update', configVersion.update);
   app.config.open_delete_fn &&   router.post(prefix+'/configVersion/delete', configVersion.destroy);
};

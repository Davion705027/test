'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const {appSdkVersion} = controller
   const   prefix = app.config.api_prefix.backend_prefix
   router.get(prefix+'/appSdkVersion/all', appSdkVersion.index);
   router.get(prefix+'/appSdkVersion/info', appSdkVersion.show);
   router.post(prefix+'/appSdkVersion/create', appSdkVersion.create);
   router.post(prefix+'/appSdkVersion/update', appSdkVersion.update);
   app.config.open_delete_fn &&   router.post(prefix+'/appSdkVersion/delete', appSdkVersion.destroy);
};

'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const {adminRecord} = controller
   const   prefix = app.config.api_prefix.backend_prefix
   router.get(prefix+'/adminRecord/all', adminRecord.index);
   router.get(prefix+'/adminRecord/info', adminRecord.show);
   router.post(prefix+'/adminRecord/create',    adminRecord.create);
   router.post(prefix+'/adminRecord/update', adminRecord.update);
   app.config.open_delete_fn &&   router.post(prefix+'/adminRecord/delete', adminRecord.destroy);
};

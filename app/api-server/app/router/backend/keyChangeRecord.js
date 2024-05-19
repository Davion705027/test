'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const {keyChangeRecord} = controller
   const   prefix = app.config.api_prefix.backend_prefix
   router.get(prefix+'/keyChangeRecord/all',keyChangeRecord.index);
   router.get(prefix+'/keyChangeRecord/info',keyChangeRecord.show);
   router.post(prefix+'/keyChangeRecord/create',   keyChangeRecord.create);
   router.post(prefix+'/keyChangeRecord/update',keyChangeRecord.update);
   app.config.open_delete_fn &&   router.post(prefix+'/keyChangeRecord/delete',keyChangeRecord.destroy);
};

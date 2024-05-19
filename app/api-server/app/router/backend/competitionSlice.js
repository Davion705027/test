'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const {competitionSlice} = controller
   const   prefix = app.config.api_prefix.backend_prefix
   router.get(prefix+'/competitionSlice/all', competitionSlice.index);
   router.post(prefix+'/competitionSlice/create',    competitionSlice.create);
   router.post(prefix+'/competitionSlice/update', competitionSlice.update);
   app.config.open_delete_fn &&   router.post(prefix+'/competitionSlice/delete', competitionSlice.destroy);
};

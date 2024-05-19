"use strict";
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = (app) => {
  const { router, controller } = app;
  const {updateRecord} = controller
  const prefix = app.config.api_prefix.backend_prefix;
  router.get(prefix + "/updateRecord/all", updateRecord.index);
  router.get(prefix + "/updateRecord/info", updateRecord.show);
  router.post(prefix + "/updateRecord/create", updateRecord.create);
  router.post(prefix + "/updateRecord/update", updateRecord.update);
  router.post( prefix + "/updateRecord/disable", updateRecord.disable );
  router.post(prefix + "/updateRecord/delete", updateRecord.destroy);
  app.config.open_delete_fn &&
    router.get( prefix + "/updateRecord/related", updateRecord.related_record );
};

'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const {i18nKey} = controller
   const   prefix = app.config.api_prefix.backend_prefix

   router.get(prefix+'/i18nKey/all', i18nKey.index);
   router.get(prefix+'/i18nKey/info', i18nKey.show);
   router.post(prefix+'/i18nKey/create',    i18nKey.create);
   router.post(prefix+'/i18nKey/update', i18nKey.update);
   app.config.open_delete_fn &&   router.post(prefix+'/i18nKey/delete', i18nKey.destroy);
};

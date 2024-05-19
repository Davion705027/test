'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const {themeTemplate} = controller
   const   prefix = app.config.api_prefix.backend_prefix
 
   router.get(prefix+'/themeTemplate/all',themeTemplate.index);
   router.post(prefix+'/themeTemplate/create',   themeTemplate.create);
   router.post(prefix+'/themeTemplate/update',themeTemplate.update);
};

'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const {layoutTemplate} = controller
   const   prefix = app.config.api_prefix.backend_prefix
 
   router.get(prefix+'/layoutTemplate/all',layoutTemplate.index);
   router.post(prefix+'/layoutTemplate/create',   layoutTemplate.create);
   router.post(prefix+'/layoutTemplate/update',layoutTemplate.update);
   router.post(prefix+'/layoutTemplate/mirror',layoutTemplate.mirror);
};

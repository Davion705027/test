'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const prefix = app.config.api_prefix.backend_prefix
   router.post(prefix + '/matchMaterial/upload', controller.matchMaterial.uploadFile.upload);
};

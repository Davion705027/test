'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const {codeTag} = controller
   const prefix = app.config.api_prefix.backend_prefix
   router.get(prefix + '/codeTag/all', codeTag.index);
   router.post(prefix + '/codeTag/create', codeTag.create);
};

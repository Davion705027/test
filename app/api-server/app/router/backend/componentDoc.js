'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const {componentDoc} = controller
   const prefix = app.config.api_prefix.backend_prefix
   router.get(prefix + '/componentDoc/findBy', componentDoc.findBy);
};

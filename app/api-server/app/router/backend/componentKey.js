'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const {componentKey} = controller
   const prefix = app.config.api_prefix.backend_prefix

   router.get(prefix + '/componentKey/all', componentKey.index)

   router.post(prefix + '/componentKey/update', componentKey.update)
};

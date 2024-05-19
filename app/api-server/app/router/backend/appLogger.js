
'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = (app) =>{
    const { router, controller } = app;
    const {appLogger} = controller
    const   prefix = app.config.api_prefix.backend_prefix

    router.post(prefix+'/appLogger/delete', appLogger.delete);
    router.post(prefix+'/appLogger/deleteMany', appLogger.deleteMany);
}
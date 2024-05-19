/*
 * @FilePath: /client-api-doc-server/app/router/backend/role.js
 * @Description:  role
 */
'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = (app) =>{
    const { router, controller } = app;
    const {role} = controller
    const   prefix = app.config.api_prefix.backend_prefix
    router.get(prefix+'/role/index', role.index);
    router.get(prefix+'/role/info', role.info);
    router.post(prefix+'/role/create', role.create);
    router.post(prefix+'/role/update', role.update);
    app.config.open_delete_fn && router.post(prefix+'/role/delete', role.delete);
}
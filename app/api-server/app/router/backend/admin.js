/*
 * @FilePath: /client-api-doc-server/app/router/backend/admin.js
 * @Description:  admin
 */
'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = (app) =>{
    const { router, controller } = app;
    const {admin} = controller
    const   prefix = app.config.api_prefix.backend_prefix
    router.post(prefix+'/admin/login', admin.login);
    router.get(prefix+'/admin/index', admin.index);
    router.post(prefix+'/admin/create', admin.create);
    router.post(prefix+'/admin/update', admin.update);
    app.config.open_delete_fn && router.post(prefix+'/admin/delete', admin.delete);
}
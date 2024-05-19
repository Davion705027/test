/*
 * @FilePath: /client-api-doc-server/app/router/backend/appAssets.js
 * @Description:  appAssets
 */
'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = (app) =>{
    const { router, controller } = app;
    const {appAssets} = app.controller
    const   prefix = app.config.api_prefix.backend_prefix
    router.get(prefix+'/appAssets/index', appAssets.index);
    router.post(prefix+'/appAssets/scan', appAssets.scan); // 扫描
    router.post(prefix+'/appAssets/create', appAssets.create);
    router.post(prefix+'/appAssets/update', appAssets.update);
    router.post(prefix+'/appAssets/delete', appAssets.delete);
    router.get(prefix + "/appAssets/find", appAssets.find);
}

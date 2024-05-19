/*
 * @FilePath: /client-api-doc-server/app/router/backend/scanMatch.js
 * @Description:  scanMatch
 */
'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = (app) =>{
    const { router, controller } = app;
    const { scanMatch } = app.controller
    const   prefix = app.config.api_prefix.backend_prefix
    router.get(prefix+'/scanMatch/index', scanMatch.index);
    router.post(prefix+'/scanMatch/scan', scanMatch.scan); // 扫描
    router.post(prefix+'/scanMatch/create', scanMatch.create);
    router.post(prefix+'/scanMatch/update', scanMatch.update);
    router.post(prefix+'/scanMatch/delete', scanMatch.delete);
}

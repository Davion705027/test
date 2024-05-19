'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = (app) =>{
    const { router, controller } = app;
    const { clientMenu, clientRole } = controller;
    const prefix = app.config.api_prefix.backend_prefix

    router.get(prefix+'/cls/menu/search_read', clientMenu.search_read);
    router.get(prefix+'/cls/menu/read_all', clientMenu.read_all);
    router.post(prefix+'/cls/menu/create', clientMenu.create);
    router.post(prefix+'/cls/menu/unlink', clientMenu.unlink);
    router.post(prefix+'/cls/menu/write', clientMenu.write);

    router.get(prefix+'/cls/role/search_read', clientRole.search_read);
    router.get(prefix+'/cls/role/read_all', clientRole.read_all);
    router.post(prefix+'/cls/role/create', clientRole.create);
    router.post(prefix+'/cls/role/unlink', clientRole.unlink);
    router.post(prefix+'/cls/role/write', clientRole.write);
}
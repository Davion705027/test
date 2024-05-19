'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const {assetsKey} = controller
   const   prefix = app.config.api_prefix.backend_prefix

   router.get(prefix+'/assetsKey/all', assetsKey.index);
   router.get(prefix+'/assetsKey/info', assetsKey.show);
   router.post(prefix+'/assetsKey/create',    assetsKey.create);
   router.post(prefix+'/assetsKey/update', assetsKey.update);
   router.post(prefix+'/assetsKey/handle_flush_imgUrl', assetsKey.flushImgUrl); // 剔除图片地址带域名
   app.config.open_delete_fn &&   router.post(prefix+'/assetsKey/delete', assetsKey.destroy);
};

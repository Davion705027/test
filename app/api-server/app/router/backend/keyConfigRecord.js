/*
 * @FilePath: /client-api-doc-server/app/router/backend/keyConfigRecord.js
 * @Description: 
 */
'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const {keyConfigRecord} = controller
   const   prefix = app.config.api_prefix.backend_prefix
   router.get(prefix+'/keyConfigRecord/all',keyConfigRecord.index);
   router.get(prefix+'/keyConfigRecord/info',keyConfigRecord.show);
   router.post(prefix+'/keyConfigRecord/create',   keyConfigRecord.create);
   router.post(prefix+'/keyConfigRecord/update',keyConfigRecord.update);
   router.post(prefix+'/keyConfigRecord/handle_flush_imgUrl', keyConfigRecord.flushImgUrl); // 剔除图片地址带域名
   app.config.open_delete_fn &&   router.post(prefix+'/keyConfigRecord/delete',keyConfigRecord.destroy);
};

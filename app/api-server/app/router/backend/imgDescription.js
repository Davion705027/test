/*
 * @FilePath: /client-api-doc-server/app/router/backend/imgDescription.js
 * @Description: 
 */
'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
   const { router, controller } = app;
   const {imgDescription} = controller
   const   prefix = app.config.api_prefix.backend_prefix
   router.post(prefix+'/imgDescription/flush', imgDescription.flush_imgdesc);
   router.get(prefix+'/imgDescription/all', imgDescription.index);
   router.get(prefix+'/imgDescription/findListByKey', imgDescription.findListByKey);
   router.get(prefix+'/imgDescription/info', imgDescription.show);
   router.post(prefix+'/imgDescription/create',    imgDescription.create);
   router.post(prefix+'/imgDescription/update', imgDescription.update);
   router.post(prefix+'/imgDescription/updateImgDescs', imgDescription.updateImgDescs);
   app.config.open_delete_fn &&   router.post(prefix+'/imgDescription/delete', imgDescription.destroy);
};

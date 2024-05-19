/**
 * @param {Egg.Application} app - egg application
 */
module.exports = (app) =>{

    const { router, controller } = app;
    const   prefix = app.config.api_prefix.backend_prefix
          /**
 * @api {post}  /file/upload   文件上传
 * @apiGroup     文件模块
 *
 */  
    router.post(prefix+'/file/upload', controller.fileUpload.save);
    
    /**
     * @api {post}  /file_splite_chunk/upload   大文件分片上传
     * @apiGroup     文件模块
     */
    router.post('/file_splite_chunk/upload', controller.fileUploadBySpliteChunk.save);
}
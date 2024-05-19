'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
  const { router, controller } = app;
  const {article} = controller
  const   prefix = app.config.api_prefix.backend_prefix
    router.get(prefix+'/article/all', article.index);
    router.get(prefix+'/article/info', article.show);
    router.post(prefix+'/article/create',    article.create);
    router.post(prefix+'/article/update', article.update);
     app.config.open_delete_fn &&  router.post(prefix+'/article/delete', article.destroy);
};

'use strict';
/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
  const { router, controller } = app;
  const {questionTopic} = controller
  const   prefix = app.config.api_prefix.backend_prefix
   router.get(prefix+'/questionTopic/all', questionTopic.index);
   router.get(prefix+'/questionTopic/info', questionTopic.show);
   router.post(prefix+'/questionTopic/create',    questionTopic.create);
   router.post(prefix+'/questionTopic/update', questionTopic.update);
   router.post(prefix+'/questionTopic/disable', questionTopic.disable);
   app.config.open_delete_fn&& 
   router.post(prefix+'/questionTopic/delete', questionTopic.destroy);
};

/*
 * @Author: eisha
 * @Description:
 * @FilePath: \sports-rules-server\app\router\clientLanguage.js
 */

module.exports = app => {
  const { router, controller, jwt } = app;
  // console.log( 'app.controller--',jwt,app.controller);
 
  const {clientLanguage} = controller
  const prefix = app.config.api_prefix.backend_prefix;
  // 语言管理  添加中间件 jwt
  app.router.get(prefix + "/clientLanguage/read",   clientLanguage.index);
  app.router.post(prefix + "/clientLanguage/create", jwt, clientLanguage.create);
  app.router.post(prefix + "/clientLanguage/update", jwt, clientLanguage.update);
  // app.router.post(prefix + "/clientLanguage/delete", jwt, clientLanguage.destroy);
};

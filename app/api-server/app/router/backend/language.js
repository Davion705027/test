/*
 * @Author: eisha
 * @Description:
 * @FilePath: \sports-rules-server\app\router\language.js
 */

module.exports = app => {
  const { router, controller, jwt } = app;
  // console.log( 'app.controller--',jwt,app.controller);
 
  const {language} = controller
  const prefix = app.config.api_prefix.backend_prefix;
  // 语言管理  添加中间件 jwt
  app.router.get(prefix + "/language/read", jwt, language.index);
  app.router.post(prefix + "/language/create", jwt, language.create);
  app.router.post(prefix + "/language/update", jwt, language.update);
  // app.router.post(prefix + "/language/delete", jwt, language.destroy);
};

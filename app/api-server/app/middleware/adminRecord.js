/*
 * @Date           : 2022-04-06 11:38:56
 * @LastEditTime   : 2022-04-06 14:30:49
 * @Description    :
 */
var UrlParse = require("url-parse");
module.exports = (options, app) => {
  return async function cost(ctx, next) {
    let url = new UrlParse(ctx.request.url);
    // pathname: '/client/faq/all',
    let pathname = url.pathname;
    // console.log("接口请求---------", pathname);
    // 是后台接口
    let is_backend = pathname.includes("/backend/");
    let is_login = pathname.includes("/backend/admin/login");
    if(is_backend&&!is_login){
      // console.log('后台管理接口，非登录接口--记录操作-----------');
        let api_method = ctx.request.method;
        // console.log("接口请求-----is_backend----", is_backend);
        // console.log("接口请求-----api_method----", api_method);
        let { id ,keyid } = ctx.request.body;
        // console.log("接口请求-----id----", id);
        let token = ctx.request.headers.authorization || "";
        // console.log('ctx.request.headers.authorization--',ctx.request.headers.authorization);
      
        let result = await ctx.service.jwt.verifyToken(token);
        // console.log('接口请求-----result----------',result);
        let final_obj = {
          //请求接口路径
          path: pathname,
          //操作人
          operator: result.name,
          //请求方法
          method: api_method,
          //操作对象ID
          target_id: id || keyid,
        };
        await  ctx.model.AdminRecord.create(final_obj);
    }
    await next();
  };
};

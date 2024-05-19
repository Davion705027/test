/*
 * @Date           : 2022-04-06 15:26:50
 * @LastEditTime   : 2022-04-15 20:20:14
 * @Description    :
 */

// https://juejin.cn/post/6993559990610952199#heading-8

// app/middleware/auth.js
var UrlParse = require("url-parse");
const AuthException = require("../exception/auth");
module.exports = (options, app) => {
  // 此处name为 auth(xxx) 的xxx
  return async function auth(ctx, next) {
    // let url=  url: '/client/faq/all?rmdt=1649230438849&currentPage=1&pageSize=1000&lan=zn'
    let url = new UrlParse(ctx.request.url);

    // console.log('url-----------------------',url);

    // slashes: false,
    // protocol: '',
    // hash: '',
    // query: '?currentPage=1&pageSize=1000',
    // pathname: '/client/faq/all',
    // auth: '',
    // host: '',
    // port: '',
    // hostname: '',
    // password: '',
    // username: '',
    // origin: 'null',
    // href: '/client/faq/all?currentPage=1&pageSize=1000'

    // console.log(2);

    // curl -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJmb28iOiJiYXIiLCJpYXQiOjE0OTAwMTU0MTN9.ehQ38YsRlM8hDpUMKYq1rHt-YjBPSU11dFm0NOroPEg" 127.0.0.1:7001/success

    // 判定是否需要鉴权
    let needauth = true;

    if (
      url.pathname.includes("/login") ||
      url.pathname.includes("/public/upload/")||
      url.pathname.includes("/yunwei/need_packup")||
      url.pathname.startsWith("/openapi/") ||
      url.pathname.startsWith("/common/")
 
    ) {
      needauth = false;
    }
    // console.log(url.pathname);
    let api_prefix = ctx.app.config.api_prefix;
    //是否是客户端 接口
    let is_client_api = url.pathname.includes(api_prefix.client_prefix+'/');
    //是否是服务端 接口
    let is_backend_api = url.pathname.includes(api_prefix.backend_prefix+'/');

    // console.log("判定是否需要鉴权----", needauth);
    // 鉴权
    if (needauth) {
      // 获取token
      let token = ctx.request.headers.authorization || "";
      let result = await ctx.service.jwt.verifyToken(token);

      // console.log("token 验证 结果----", result);

      if (result) {
        // id: '624d3ee67b217b63bcb4be48',
        //   is_admin: true,
        //   iat: 1649248794,
        //   exp: 1649259594,
        //   jti: '470dabe8-0625-4e27-915a-d89d5dc07925'
        //用户端账户访问 后台接口 返回权限异常
        if (result.is_user) {
          if (is_backend_api) {
            throw new AuthException("权限异常", "100004");
          }
        }
        // 管理后台账户 访问 客户端接口 返回权限异常
        if (result.is_admin) {
          if (is_client_api) {
            throw new AuthException("权限异常", "100004");
          }
        }

        ctx.token_info = result

        await next();
      } else {
        throw new AuthException("令牌异常，请重新登录", "100003");
      }
    } else {
      await next();
    }
  };
};

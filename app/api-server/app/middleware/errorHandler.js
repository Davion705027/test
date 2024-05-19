/*
 * @Date           : 2022-04-06 16:39:31
 * @LastEditTime   : 2022-04-09 10:53:33
 * @Description    :  
 */
// app/middleware/error_handler.js
const HttpException = require('../exception/http');
module.exports =  (options, app) => {
  return async function errorHandler(ctx, next) {
    const method = ctx.request.method;
    // 当请求方法为OPTIONS，通常为axios做验证请求，直接响应httpStatus204 no content即可

    console.clear('ctx.request---------',ctx.request);
    if (method === 'OPTIONS') {
      ctx.status = 204;
      return;
    }
    try { // 在这里捕获程序中的异常
    //  console.log(1);

      await next();
      // console.log(88);
    } catch (err) {
      console.log("判断异常是不是自定义异常--------");
      console.log(err);
      // 判断异常是不是自定义异常
      if (err instanceof HttpException) {
        ctx.status = err.httpCode;
        ctx.body = {
          code: err.code,
          msg: err.msg,
          data: err.data,
        };
        return;
        // https://github.com/auth0/node-jsonwebtoken#errors--codes
      } 

      // ... 其他异常处理，例如egg参数校验异常，可以在这里处理
      
      // 最后其他异常统一处理
      ctx.status = 200;
      ctx.body = {
        code: '500000',
        msg: err.message || '服务器异常',
        data: null,
      };

    }



   
  };
};

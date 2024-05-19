/*
 * @Date           : 2022-04-06 15:35:13
 * @LastEditTime   : 2022-04-06 22:15:18
 * @Description    :  
 */
// app/exception/http.js
 
class HttpException extends Error {
    constructor(code ="500000", message = '服务器异常', data = null, httpCode = 200) {
      super();
      this.code = code; // 自定义状态码
      this.msg = message; // 自定义返回消息
      this.data = data; // 自定义返回数据
      this.httpCode = httpCode; // http状态码
    }
  }
  module.exports = HttpException;
  
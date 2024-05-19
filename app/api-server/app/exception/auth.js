/*
 * @Date           : 2022-04-06 15:59:31
 * @LastEditTime   : 2022-04-06 22:14:52
 * @Description    :  
 */

const HttpException = require('./http');
class AuthException extends HttpException {
    constructor(message = '令牌无效', errorCode = '100003') {
      super(errorCode, message, null, 200);
    }
  }
  module.exports = AuthException;
  
 
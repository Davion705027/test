// app/exception/not_found.js
const HttpException = require('./http');
class NotFoundException extends HttpException {
  constructor(message = '资源不存在', errCode = 40004) {
    super(errCode, message, null, 404);
  }
}
module.exports = NotFoundException;

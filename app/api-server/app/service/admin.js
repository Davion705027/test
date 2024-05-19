/*
 * @Author         : your name
 * @Date           : 2022-03-11 22:48:41
 * @LastEditTime   : 2022-04-06 13:14:21
 * @LastEditors    : Please set LastEditors
 * @Description    : 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 * @FilePath       : \client-api-doc-server\app\service\admin.js
 */
'use strict';

const Service = require('egg').Service;

class AdminService extends Service {
  async login(query) {
    const { ctx } = this;
    const result  = await   ctx.model.Admin.findOne({
        where: query
      })
      return result;   
     
  }
}

module.exports = AdminService;

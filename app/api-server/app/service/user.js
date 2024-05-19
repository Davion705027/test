/*
 * @Author         : your name
 * @Date           : 2022-03-12 17:01:31
 * @LastEditTime   : 2022-03-13 15:44:26
 * @LastEditors    : Please set LastEditors
 * @Description    : 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 * @FilePath       : \client-api-doc-server\app\service\user.js
 */
'use strict';

const Service = require('egg').Service;

class UserService extends Service {
        /**
   * 查询  全部数据  
   * @returns 
   */
  async findAll(query,options) {
    const ctx = this.ctx;
    const result =    await ctx.model.User.paginate(query,options );

 

    return result
    
  }

  

}

module.exports = UserService;

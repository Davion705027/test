/*
 * @Date           : 2022-04-13 15:37:46
 * @LastEditTime   : 2022-04-15 20:16:37
 * @Description    :
 */

"use strict";
const Controller = require("egg").Controller;

const docpool  = require("./docpool")
class DetailController extends Controller {
  /**
   * 查询  一条数据  的详细信息
   * @returns
   */
  async show() {
    const ctx = this.ctx;
    try {
      const { id, type } = ctx.query;
      const {  controller } = ctx.app;

      if (!id || !type) {
        ctx.api_error_msg("参数不足");
      }
      console.log(ctx);
     let  result=''
      switch (type) {
        case "doc":
         result = await ctx.model.Docpool.findById(id).exec();
          break;
        case "faq":
            result = await ctx.model.Faq.findById(id).exec();
          break;
        case "updateRecord":
            result = await ctx.model.UpdateRecord.findById(id).exec();
          break;

        default:
            result='参数不足'
          break;
      }

      if(ctx.is_client_request(ctx)){
        if(result&&result.status!=1){
       return   ctx.api_error_msg('已下架');
        }
       }

      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
}

module.exports = DetailController;

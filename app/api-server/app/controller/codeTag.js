"use strict";

const Controller = require("egg").Controller;
class ConfigVersionController extends Controller {
  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;
    try {
      // let { username } = ctx.query;
      const result = await ctx.model.CodeTag.find();
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }

  /**
   * 创建  一条数据
   * @returns
   */
  async create() {
    const ctx = this.ctx;
    try {
      const token_info = await ctx.service.jwt.get_token_info()
      if (!token_info) throw Error('登录失效')

      const data = { ...ctx.request.body }
      data.creator = data.updater = token_info.name;
      ctx.remove_false_key(data);
      await ctx.model.CodeTag.create(data);
      ctx.api_success_data(true);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
}
module.exports = ConfigVersionController;

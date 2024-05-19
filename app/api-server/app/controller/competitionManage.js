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
      const regex_list = ['name', 'race']
      const query = ['request_type', 'data_type', 'status', ...regex_list].reduce((origin, key) => {
        if (ctx.query[key] !== undefined) {
          origin[key] = regex_list.includes(key) ? { $regex: ctx.query[key], $options: "i", } : ctx.query[key]
        }
        return origin
      }, {})
      // await ctx.sleep(6000);
      const result = await ctx.model.Competition.paginate(query, {
        page: ctx.toInt(ctx.query.currentPage),
        limit: ctx.toInt(ctx.query.pageSize),
        sort: { updatedAt: -1 },
      });
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }

  /**
   * 查询所有赛事
   */
  async findAll() {
    const ctx = this.ctx;
    try {
      const result = await ctx.model.Competition.find({ status: 1 });
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }

  async findOneByCid() {
    const ctx = this.ctx;
    try {
      const result = await ctx.model.Competition.findById(ctx.query.cid);
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

      const data = {
        ...ctx.request.body,
        creator: token_info.name,
        updater: token_info.name,
      }
      ctx.remove_false_key(data);
      await ctx.model.Competition.create(data);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }

  /**
   * 更新 一条数据
   * @returns
   */
  async update() {
    const ctx = this.ctx;
    try {
      const token_info = await ctx.service.jwt.get_token_info()
      if (!token_info) throw Error('登录失效')

      const { id, ...data } = ctx.request.body
      data.updater = token_info.name
      ctx.remove_false_key(data);
      await ctx.model.Competition.findByIdAndUpdate(id, data);
      ctx.api_success_data(true);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }

  /**
   * 删除  一条数据
   * @returns
   */
  async destroy() {
    const ctx = this.ctx;
    try {
      const id = ctx.request.body.id;
      const result = await ctx.model.Competition.findByIdAndDelete(id);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
}
module.exports = ConfigVersionController;

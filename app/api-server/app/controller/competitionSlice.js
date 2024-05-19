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
      const cid = ctx.query.cid
      if (!cid) throw Error('赛事ID不能为空')

      const regex_list = []
      const query = ['status', ...regex_list].reduce((origin, key) => {
        if (ctx.query[key] !== undefined) {
          origin[key] = regex_list.includes(key) ? { $regex: ctx.query[key], $options: "i", } : ctx.query[key]
        }
        return origin
      }, {})
      const result = await ctx.model['competition_slice_' + cid].paginate(query, {
        page: ctx.toInt(ctx.query.currentPage),
        limit: ctx.toInt(ctx.query.pageSize),
        sort: { 'response_data.ts': -1 },
      });
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }

  async findByPlayingTime() {
    const ctx = this.ctx;
    try {
      const cid = ctx.query.cid
      if (!cid) throw Error('赛事ID不能为空')
      const time = ctx.query.time * 1

      const result = await ctx.model['competition_slice_' + cid].find({ 'response_data.ts': { $lte: time } }, null, { limit: 2, sort: { 'response_data.ts': -1 } })
      const next = await ctx.model['competition_slice_' + cid].findOne({ 'response_data.ts': { $gt: time } }, null, { sort: { 'response_data.ts': 1 } })

      ctx.api_success_data({ pre: result[1], current: result[0], next });
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
      const cid = ctx.request.body.cid
      if (!cid) throw Error('赛事ID不能为空')

      const token_info = await ctx.service.jwt.get_token_info()
      if (!token_info) throw Error('登录失效')

        ;['send_start_time', 'send_end_time', 'response_time'].forEach(key => ctx.request.body[key] = new Date(ctx.request.body[key]))

      const data = { ...ctx.request.body, creator: token_info.name, updater: token_info.name, }
      ctx.remove_false_key(data);
      await ctx.model['competition_slice_' + cid].create(data);
      ctx.api_success_data(true);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }

  /**
   * 更新 一条数据
   * @returns
   */
  async update() {
    const ctx = this.ctx
    try {
      const { id, cid, ...data } = ctx.request.body
      if (!cid) throw Error('赛事ID不能为空')

      const token_info = await ctx.service.jwt.get_token_info()
      if (!token_info) throw Error('登录失效')

      data.updater = token_info.name
      ctx.remove_false_key(data);
      await ctx.model['competition_slice_' + cid].findByIdAndUpdate(id, data);
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
      const cid = ctx.request.body.cid
      if (!cid) throw Error('赛事ID不能为空')

      const id = ctx.request.body.id;
      const result = await ctx.model['competition_slice_' + cid].findByIdAndDelete(id);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
}
module.exports = ConfigVersionController;

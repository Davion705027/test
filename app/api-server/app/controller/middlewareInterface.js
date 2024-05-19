"use strict";

const { Controller } = require("egg");
class ConfigVersionController extends Controller {
  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;
    try {
      const regex_list = ['url']
      const query = ['code_tag_id', 'status', ...regex_list].reduce((origin, key) => {
        if (ctx.query[key] !== undefined) {
          origin[key] = regex_list.includes(key) ? { $regex: ctx.query[key], $options: "i", } : ctx.query[key]
        }
        return origin
      }, {})
      // await ctx.sleep(6000);
      const result = await ctx.model.MiddlewareInterface.paginate(query, {
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
   * 查询  一条数据  的详细信息
   * @returns
   */
  async show() {
    const ctx = this.ctx;
    try {
      const id = ctx.query.id;
      const result = await ctx.model.MiddlewareInterface.findById(id).exec();
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }

  async findByCodeTag() {
    const ctx = this.ctx;
    try {
      const { code_tag_id } = ctx.query
      const result = await ctx.model.MiddlewareInterface.find({ code_tag_id, status: 1 });
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }

  /**
   * 查询  一条数据  的详细信息
   * @returns
   */
  async show() {
    const ctx = this.ctx;
    try {
      const id = ctx.query.id;
      const result = await ctx.model.MiddlewareInterface.findById(id).exec();
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }

  /**
   * 获取赛事响应数据
   */
  async findResponseData() {
    const ctx = this.ctx;
    try {
      const competition = await ctx.model.Competition.findOne({ interface_id: ctx.query.interfaceId });
      let responseData
      if (competition) {
        responseData = await ctx.model['competition_slice_' + competition.id].findOne({ 'response_data.code': ctx.query.code })
      }

      ctx.api_success_data(responseData);
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
      await ctx.model.MiddlewareInterface.create(data);
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
      await ctx.model.MiddlewareInterface.findByIdAndUpdate(id, data);
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
      const result = await ctx.model.MiddlewareInterface.findByIdAndDelete(id);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
}
module.exports = ConfigVersionController;

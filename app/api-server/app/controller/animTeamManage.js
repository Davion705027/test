"use strict";

const { Controller } = require("egg");

/**
 * 动画模板
 */
class AnimTeamManageController extends Controller {
  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;
    try {
      const { anim_template_id, name } = ctx.query;

      const query = {};

      if (anim_template_id) {
        query.anim_template_id = anim_template_id;
      }

      if (name) {
        query.name = {
          $regex: name,
          $options: "i",
        };
      }

      const result = await ctx.model.AnimTeamData.paginate(query, {
        page: ctx.toInt(ctx.query.currentPage),
        limit: ctx.toInt(ctx.query.pageSize),
        sort: { createdAt: -1 },
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
      const result = await ctx.model.AnimTeamData.findById(id).exec();
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
      const currentUsername = ctx.token_info.name;

      const data = {
        ...ctx.request.body,
        create_by: currentUsername,
        update_by: currentUsername,
      };
      ctx.remove_false_key(data);
      await ctx.model.AnimTeamData.create(data);
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
    const ctx = this.ctx;

    try {
      const currentUsername = ctx.token_info.name;

      const { id, ...data } = ctx.request.body;
      data.update_by = currentUsername;
      ctx.remove_false_key(data);
      await ctx.model.AnimTeamData.findByIdAndUpdate(id, data);
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
      const result = await ctx.model.AnimTeamData.findByIdAndDelete(id);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }

  /**
   * 获取 logo 模板数据
   * @returns
   */
  async getLogoData() {
    const ctx = this.ctx;
    try {
      let { templateId } = ctx.query;
      if (!templateId) {
        const animTemplate = await ctx.model.AnimTemplate.findOne()
          .sort({ createdAt: 1 })
          .exec();
        templateId = animTemplate.id;
      }

      const result = await ctx.model.AnimTeamData.findOne({
        anim_template_id: templateId,
      })
        .sort({ createdAt: -1 })
        .exec();

      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
}
module.exports = AnimTeamManageController;

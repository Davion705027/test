/*
 * @Date           : 2022-03-11 10:59:48
 * @FilePath: \client-api-doc-server\app\controller\faq.js
 * @Description    :
 */
"use strict";
const Controller = require("egg").Controller;
class FaqController extends Controller {
  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;

    try {
      let query = {};
      let name = ctx.query.name;
      let stateandname = ctx.query.stateandname;

      if (stateandname) {
        name = stateandname;
      }
      if (name) {
        query = {
          $or: [
            {
              name_zh: {
                $regex: name,
                $options: "i",
              },
            },
            {
              name_en: {
                $regex: name,
                $options: "i",
              },
            },
          ],
          $and: [
            stateandname
              ? {
                  status: true,
                }
              : {},
          ],
        };
      }
      if (ctx.is_client_request(ctx)) {
        query["status"] = { $eq: 1 };
      }

      const options = {
        page: ctx.toInt(ctx.query.currentPage),
        limit: ctx.toInt(ctx.query.pageSize),
        sort: { is_top: -1, updatedAt: -1 },
        select: {
          content_zh: 0,
          content_en: 0,
        },
      };
      // await ctx.sleep(6000);
      const result = await ctx.model.Faq.paginate(query, options);
      ctx.api_success_data(result);
    } catch (error) {
      console.log(error);
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

      const result = await ctx.model.Faq.findById(id).exec();
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   * 创建或者更新数据通用内部方法
   * @returns
   */
  compute_final_obj_when_create_or_update() {
    const ctx = this.ctx;

    let { id, name_zh, name_en, content_zh, content_en, status, is_top, topic } =
      ctx.request.body;

    let final_obj = {
      id,
      name_zh,
      name_en,
      content_zh,
      content_en,
      status,
      is_top,
      topic,
    };

    ctx.remove_false_key(final_obj);

    return final_obj;
  }
  /**
   * 创建  一条数据
   * @returns
   */
  async create() {
    const ctx = this.ctx;
    try {
      let final_obj = this.compute_final_obj_when_create_or_update();
      const result = await ctx.model.Faq.create(final_obj);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   * 更新  一条数据
   * @returns
   */
  async update() {
    const ctx = this.ctx;
    try {
      let final_obj = this.compute_final_obj_when_create_or_update();
      let id = final_obj.id;
      delete final_obj.id;
      const result = await ctx.model.Faq.findByIdAndUpdate(id, final_obj);

      ctx.api_success_data(result);
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
      const result = await ctx.model.Faq.findByIdAndDelete(id);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   * 禁用 一条数据
   */
  async disable() {
    const ctx = this.ctx;
    try {
      const id = ctx.request.body.id;
      const update = { status: -2 };
      const result = await ctx.model.Faq.findByIdAndUpdate(id, update);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
}
module.exports = FaqController;

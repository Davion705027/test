"use strict";

const Controller = require("egg").Controller;
class ThemeTemplateController extends Controller {
  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;
    try {
      const regex_list = ['name']
      const query = ['id', ...regex_list].reduce((origin, key) => {
        if (ctx.query[key] !== undefined) {
          origin[key] = regex_list.includes(key) ? { $regex: ctx.query[key], $options: "i", } : ctx.query[key]
        }
        return origin
      }, {})
      // await ctx.sleep(6000);
      const result = await ctx.model.ThemeTemplate.paginate(query, {
        page: ctx.toInt(ctx.query.currentPage ||1),
        limit: ctx.toInt(ctx.query.pageSize ||20),
        sort: { updatedAt: -1 },
      });
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }

  /**
   * 查询所有 
   */
  async findAll() {
    const ctx = this.ctx;
    try {
      const result = await ctx.model.ThemeTemplate.find(null, { name: 1, project: 1 }, { sort: { createAt: -1 } });
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   * 创建或者更新数据通用内部方法
   * @returns
   */
  async compute_final_obj_when_create_or_update(htype) {
    const ctx = this.ctx;
    let { id, name,   descriptions, status,project,version } = ctx.request.body;
    let final_obj = { id, name,   descriptions, status,project,version };

    if(htype=='update'){
      delete  final_obj.value
    }
    await this.service.jwt.add_operator(final_obj);

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
          let final_obj = await this.compute_final_obj_when_create_or_update( "create" );
  
      let all = await ctx.model.ThemeTemplate.find({})

final_obj.value = all.length+1
      const result = await ctx.model.ThemeTemplate.create(final_obj);
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
      let final_obj = await this.compute_final_obj_when_create_or_update(
        "update"
      );
      let id = final_obj.id;
      delete final_obj.id;
      const result = await ctx.model.ThemeTemplate.findByIdAndUpdate(id, final_obj);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
}
module.exports = ThemeTemplateController;

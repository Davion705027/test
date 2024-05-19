/*
 * @Date           : 2022-03-11 10:59:48
 * @FilePath       : /jinnian-cms-server/app/controller/doc.js
 * @Description    :
 */
"use strict";
const Controller = require("egg").Controller;
class QuestionTopicController extends Controller {
  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;
    try {
      let query = {};
      const options = {
        page: ctx.toInt(ctx.query.currentPage),
        limit: ctx.toInt(ctx.query.pageSize),
        sort:     {order: -1, updatedAt: -1 },
      };
      // await ctx.sleep(6000);
      const result = await ctx.model.QuestionTopic.paginate(query, options);
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
      const result = await ctx.model.QuestionTopic.findById(id).exec();
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
      let {
        id,
        names={},
        status,
        order
      } = ctx.request.body;
      let final_obj = {
        id,
        names, 
        status,
        order
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
      //当前最大的sid 
      //当前最大的sid 
      const arr= await   ctx.model.QuestionTopic.find({ },['sid'],{sort:{sid:-1}}).exec();
      final_obj.sid = arr[0]?arr[0]['sid']+1 :1;
      const result = await ctx.model.QuestionTopic.create(final_obj);
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
      const result = await ctx.model.QuestionTopic.findByIdAndUpdate(id,final_obj) ;
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
      const result = await ctx.model.QuestionTopic.findByIdAndDelete(id);
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
        const update=  {   status :-2 }
        const result = await ctx.model.QuestionTopic.findByIdAndUpdate(id,update) ;
        ctx.api_success_data(result);
      } catch (error) {
        ctx.api_error_msg(error);
      }
    }
}
module.exports = QuestionTopicController;

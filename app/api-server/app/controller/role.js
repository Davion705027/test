/*
 * @Date           : 2022-04-06 15:17:14
 * @LastEditTime: 2023-10-22 14:18:22
 * @Description    : 角色操作
 */
"use strict";

const Controller = require("egg").Controller;

class RoleController extends Controller {
  /**
   * 角色列表
   */
  async index(){
    const { ctx } = this;
    const query = {};
    let {name} = ctx.request.query;
    if (name) {
      query.name =  {
        $regex: name,
        $options: "i",
      }
    }
    const options = {
      page: ctx.toInt(ctx.query.currentPage) || 1,
      limit: ctx.toInt(ctx.query.pageSize) || 10,
      sort: { updatedAt: -1 },
    };
    try{
      const result = await ctx.model.Role.paginate(query,options);
      ctx.api_success_data(result);
    } 
    catch(error){
      ctx.api_error_msg(error);
    }
  }
  async info(){
    const { ctx } = this;
    const { name, id } = ctx.request.query;
    const query = {};
    name && (query.name = name);
    id && (query._id = id);
    try{
      const result = await ctx.model.Role.findOne(query).exec() || {};
      console.log(result);
      ctx.api_success_data(result.menus);
    } 
    catch(error){
      ctx.api_error_msg(error);
    }
  }
  /**
   *  新增角色
   * @returns
   */
  async create() {
    const ctx = this.ctx;
    try {
      let final_obj = ctx.request.body;
      ctx.remove_false_key(final_obj);
      let result  = await ctx.model.Role.create(final_obj);

      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   *  修改角色
   * @returns
   */
  async update() {
    const ctx = this.ctx;
    try {
      let final_obj = ctx.request.body;
      ctx.remove_false_key(final_obj);
      let result  = await ctx.model.Role.findByIdAndUpdate(final_obj.id, final_obj);

      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   * 删除  一条数据
   * @returns
   */
  async delete() {
    const ctx = this.ctx;
    try {
      const id = ctx.request.body.id;
      const result = await ctx.model.Role.findByIdAndDelete(id);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
}

module.exports = RoleController;

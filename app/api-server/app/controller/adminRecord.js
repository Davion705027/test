/*
 * @Date           : 2022-03-11 10:59:48
 * @FilePath       : /client-api-doc-server/app/controller/doc.js
 * @Description    :
 */
"use strict";
const moment = require("moment");
const Controller = require("egg").Controller;
class AdminRecordController extends Controller {
  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;
    const {
      currentPage,
      pageSize,
      id,
      method,
      operator,
      path,
      target_id,
      time_start,
      time_end,
    } = ctx.query;
    try {
      let query = {};
      if (id) {
        query = { _id: id };
      } else {
        method ? (query["method"] = method) : "";
        operator ? (query["username"] = operator) : "";
        target_id ? (query["target_id"] = target_id) : "";
        path ? (query["path"] = { $regex: path, $options: "i" }) : "";
      let  f_time_start = new Date(time_start).getTime();
      let  f_time_end = new Date(time_end).getTime();
        let query_createdAt = {};
        if (f_time_start) {
          query_createdAt['$gt'] =f_time_start;
        }
        if (f_time_end) {
          query_createdAt['$lt'] = f_time_end;
        }
        if (f_time_start || f_time_end) {
          query["createdAt"] = query_createdAt;
        }
      }
      const options = {
        page: ctx.toInt(currentPage),
        limit: ctx.toInt(pageSize),
        sort: { updatedAt: -1 },
      };
      // await ctx.sleep(6000);
      const result = await ctx.model.AdminRecord.paginate(query, options);
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
      const result = await ctx.model.AdminRecord.findById(id, {
        password: -1,
      }).exec();
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
    let { id, method, operator, target_id,path } = ctx.request.body;
    let final_obj = {
      id,
      method,
      operator,
      target_id,
      path
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
      const result = await ctx.model.AdminRecord.create(final_obj);
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
      const result = await ctx.model.AdminRecord.findByIdAndUpdate(
        id,
        final_obj
      );
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
      const result = await ctx.model.AdminRecord.findByIdAndDelete(id);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
}
module.exports = AdminRecordController;

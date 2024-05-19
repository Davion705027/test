/*
 * @Date           : 2022-03-11 10:59:48
 * @FilePath       : /client-api-doc-server/app/controller/doc.js
 * @Description    :
 */
"use strict";
const Controller = require("egg").Controller;
class KeyGroupController extends Controller {
  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;
    try {
      const { currentPage, pageSize, id, key,  project, status, key_type, operator } = ctx.query;
      let query = {};


      if (id) {
        query = { _id: id }
      } else {

        project ? (query['project'] = Number(project)) : "";
    
        status ? (query['status'] = Number(status)) : "";
        operator ? (query['operator'] = operator) : "";
        key_type ? (query['key_type'] = key_type) : "";


        key ? (query['key'] = { $regex: key, $options: "i", }) : "";


      }





      const options = {
        page: ctx.toInt(currentPage),
        limit: ctx.toInt(pageSize),
        sort: { updatedAt: -1 },
      };
      // await ctx.sleep(6000);
      const result = await ctx.model.KeyGroup.paginate(query, options);
      if (!ctx.is_client_request(ctx)) await this.handleStatistics(result.docs)
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }

  async handleStatistics(KeyGroupList) {
    const mapper = KeyGroupList.reduce((o, v) => {
      v.statistics = { total: 0, disabled: 0, enable: 0, abandoned: 0 }
      o[v.id] = v
      return o
    }, {})

    const keyGroupIds = Object.keys(mapper)

    const [cssKeyList, jsKeyList] = await Promise.all([
      this.ctx.model.CssKey.find({ group_id: { $in: keyGroupIds } }),
      this.ctx.model.JsKey.find({ group_id: { $in: keyGroupIds } }),
    ])

    for (const item of cssKeyList) {
      if (!mapper[item.group_id]) continue

      mapper[item.group_id].statistics.total++
      // -1 禁用  ， 1 启用 ，-2  已废弃
      if (item.status === -1) mapper[item.group_id].statistics.disabled++
      if (item.status === 1) mapper[item.group_id].statistics.enable++
      if (item.status === -2) mapper[item.group_id].statistics.abandoned++
    }

    for (const item of jsKeyList) {
      if (!mapper[item.group_id]) continue

      mapper[item.group_id].statistics.total++
      // -1 禁用  ， 1 启用 ，-2  已废弃
      if (item.status === -1) mapper[item.group_id].statistics.disabled++
      if (item.status === 1) mapper[item.group_id].statistics.enable++
      if (item.status === -2) mapper[item.group_id].statistics.abandoned++
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
      const result = await ctx.model.KeyGroup.findById(id, {
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
  async compute_final_obj_when_create_or_update(htype) {
    const ctx = this.ctx;
    let { id, names, key, mark, project, key_type, descriptions, status ,level   } =
      ctx.request.body;

 

    let final_obj = {
      id,
      names,
      key,
      mark,
      project,
      key_type,
      descriptions,
      status,
      
      level
    };

    if (htype == 'create') {
      delete final_obj.id
    } else {
      delete final_obj.key
   
    }
    await this.service.jwt.add_operator(final_obj)
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
      let final_obj = await this.compute_final_obj_when_create_or_update('create');

      const result = await ctx.model.KeyGroup.create(final_obj);
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
      let final_obj = await this.compute_final_obj_when_create_or_update('update');
      let id = final_obj.id;
      delete final_obj.id;
      const result = await ctx.model.KeyGroup.findByIdAndUpdate(id, final_obj);
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
      const result = await ctx.model.KeyGroup.findByIdAndDelete(id);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
 
}
module.exports = KeyGroupController;

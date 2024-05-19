/*
 * @Date           : 2022-03-11 10:59:48
 * @FilePath       : /client-api-doc-server/app/controller/doc.js
 * @Description    :
 */
"use strict";
const Controller = require("egg").Controller;
class VersionGroupController extends Controller {
  
  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;
    try {
      const { currentPage, pageSize, id, version_group_name} = ctx.query;
      let query = {};


      if (id) {
        query = { _id: id }
      }

      const options = {
        page: ctx.toInt(currentPage),
        limit: ctx.toInt(pageSize),
        sort: { updatedAt: -1 },
      };
      const result = await ctx.model.VersionGroup.paginate(query, options);
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
      const result = await ctx.model.KeyGroup.findById(id).exec();
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
    let {id, user_ids, version_ids,version_group_name } = ctx.request.body;
    


    let final_obj = {
      id, user_ids, version_ids,version_group_name
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
      const result = await ctx.model.VersionGroup.create(final_obj);
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
      const result = await ctx.model.VersionGroup.findByIdAndUpdate(id, final_obj);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
    /**
   * 更新  批量数据
   * @returns
   */
    async update_batch() {
      const ctx = this.ctx;

      let final_obj = ctx.request.body
      let option = {};
      let ids = []
      final_obj.forEach(e => {
        ids.push({
          id: e.id
        })
      });
      option = {$or:ids}

      
      try {
        final_obj.forEach(async e => {
         await ctx.model.VersionGroup.findByIdAndUpdate({_id:e.id}, {$set: {version_ids: e.version_ids,user_ids:e.user_ids,version_group_name:e.version_group_name}});
        })

        // const result = await ctx.model.VersionGroup.updateMany(option,{$set: final_obj});
        await this.service.jwt.add_operator(final_obj)
        ctx.api_success_data();
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
      const result = await ctx.model.KeyGroupCollection.findByIdAndDelete(id);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }

}
module.exports = VersionGroupController;

/*
 * @Date           : 2022-03-11 10:59:48
 * @FilePath       : /client-api-doc-server/app/controller/doc.js
 * @Description    :
 */
"use strict";
const Controller = require("egg").Controller;
class PackingConfigController extends Controller {
  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;

    try {
      const { currentPage, pageSize, id,   project,operator,operatorid ,name } = ctx.query;
     

        let query={}
        if(id){
          query= { _id: id }
        }else{
          project?query['project']=project :""
          operator?query['operator']=operator :""
          operatorid?query['operatorid']=operatorid :""

          name?  query['name']= { $regex:name, $options: "i" }:''
        }

 

      const result = await ctx.model.PackingConfig.paginate(query, {
        page: ctx.toInt(currentPage),
        limit: ctx.toInt(pageSize),
        sort: { updatedAt: -1 },
      })
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
      const result = await ctx.model.PackingConfig.findById(id).exec();
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
    let {
      id,
      name,
      project,component,js,i18n, theme,mark, job_label

    } = ctx.request.body;


 
    let final_obj = {
      id,
      name,
      project,component,js,i18n,  theme,mark, job_label
    };

    await this.service.jwt.add_operator(final_obj)
    if(htype=='create'){
      final_obj.creatorid =   final_obj.operatorid
    }
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

      const result = await ctx.model.PackingConfig.create(final_obj);
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
      const result = await ctx.model.PackingConfig.findByIdAndUpdate(id, final_obj);
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
      const result = await ctx.model.PackingConfig.findByIdAndDelete(id);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
 
}
module.exports = PackingConfigController;

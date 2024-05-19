/*
 * @Date           : 2022-03-11 10:59:48
 * @FilePath       : /client-api-doc-server/app/controller/doc.js
 * @Description    :   后台管理系统内   默认配置的 更改记录 
 */
"use strict";
const Controller = require("egg").Controller;
class KeyChangeRecordController extends Controller {
  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;

    try {
       
      let {  currentPage, pageSize ,id,key, keyid, key_type,  project  ,operator  ,exact_query=false } = ctx.query;
      let query={}

      if(id){
        query={_id:id}
       }else{
        project?(query['project']=Number(project) ):"";
        key_type?(query['key_type']=Number(key_type) ):"";
        keyid?(query['keyid']= keyid ):"";
        
        operator?(query['operator']=operator):"";
        if(exact_query){
          key?(query['key']=key):"";
         }else{
          key?(query['key']= { $regex: key, $options: "i", }):"";
         }

       }
 
      const options = {
        page: ctx.toInt( currentPage),
        limit: ctx.toInt( pageSize),
        sort: { updatedAt: -1 },
      };
      // await ctx.sleep(6000);
      const result = await ctx.model.KeyChangeRecord.paginate(query, options);
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
      const result = await ctx.model.KeyChangeRecord.findById(id, {
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
    let { id, keyid, key,  project, key_type, mark, change  } =
      ctx.request.body;

   
      
     
 
    let final_obj = { id, keyid, key, project, key_type, mark, change   };

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

      const result = await ctx.model.KeyChangeRecord.create(final_obj);
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
      const result = await ctx.model.KeyChangeRecord.findByIdAndUpdate(
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
      const result = await ctx.model.KeyChangeRecord.findByIdAndDelete(id);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
}
module.exports = KeyChangeRecordController;

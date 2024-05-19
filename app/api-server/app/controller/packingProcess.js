/*
 * @Date           : 2022-03-11 10:59:48
 * @FilePath       : /client-api-doc-server/app/controller/doc.js
 * @Description    :
 */
"use strict";
const Controller = require("egg").Controller;
class PackingProcessController extends Controller {
  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;

    try {
      let query = {};

        let {puck_up_record_id} =ctx.request.body
        if(puck_up_record_id){ query['puck_up_record_id']=puck_up_record_id }
   
   
  
      // await ctx.sleep(6000);
      const result = await ctx.model.PackingProcess.find(query);
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
      const result = await ctx.model.PackingProcess.findById(id).exec();
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
    let { id,   mark, project  } = ctx.request.body;
    let final_obj = {
      id,
     
      mark,
      project,
      
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

      const result = await ctx.model.PackingProcess.create(final_obj);
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
      const result = await ctx.model.PackingProcess.findByIdAndUpdate(id, final_obj);
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
      const result = await ctx.model.PackingProcess.findByIdAndDelete(id);
       await  this.service.packingUp.delete_PackingProcess( result.puck_up_record_id);
      ctx.api_success_data( result);
    } catch (error) {
      // console.error(error);
      // ctx.api_success_data(  JSON.stringify(error)); 
      ctx.api_error_msg(error);
    }
  }

   /**
   * 刷新
   * @returns
   */
   async refresh() {
    const ctx = this.ctx;
    try {
      await  this.service.packingUp.pack_up_compute_need_packup()
      ctx.api_success_data(1);
    
  
    } catch (error) {
      // console.error(error);
      // ctx.api_success_data(error);
      ctx.api_error_msg(error);
    }
  }

 
}
module.exports = PackingProcessController;

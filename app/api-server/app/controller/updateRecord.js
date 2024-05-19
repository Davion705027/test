/*
 * @Date           : 2022-03-11 10:59:48
 * @FilePath       : /client-api-doc-server/app/controller/doc.js
 * @Description    :
 */
"use strict";
const Controller = require("egg").Controller;
class UpdateRecordController extends Controller {
  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;
    try {
      // const query = {};
      // const name = ctx.query.name;
      // const doc = ctx.query.doc;
      // const faq = ctx.query.faq;
      let query = {};
      let {name,doc,faq} = ctx.query
      if (name) {
        query = {
          $or:[
              {
                "name_zh":{
                  $regex: name,
                  $options: "i",
                }
              },
              {
                "name_en":{
                  $regex: name,
                  $options: "i",
                }
              }, 
          ]
          
       
        };
      }
      if(ctx.is_client_request(ctx)){
        query['status']={ $eq :1}
       }
      if(doc){
        query.related_doc ={
          $eq:doc
        }
      }else{
        if(faq){
          query.related_faq ={
            $eq: faq
          }
        }
       
      }
      console.log(query);

      const options = {
        page: ctx.toInt(ctx.query.currentPage),
        limit: ctx.toInt(ctx.query.pageSize),
        sort: {  updatedAt: -1 },
        select: {
          content_zh: 0,
          content_en: 0,
        },
      };
      // await ctx.sleep(6000);
      const result = await ctx.model.UpdateRecord.paginate(query, options);
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
      const result = await ctx.model.UpdateRecord.findById(id).exec();
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
      name_zh,
      name_en,
      content_zh,
      content_en,
      status,
      is_top,
      related_staff,
      related_faq,
      related_doc
    } = ctx.request.body;
    let final_obj = {
      id,
      name_zh,
      name_en,
      content_zh,
      content_en,
      status,
      is_top,
      related_staff,
      related_faq,
      related_doc
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
      const result = await ctx.model.UpdateRecord.create(final_obj);
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
      const result = await ctx.model.UpdateRecord.findByIdAndUpdate(
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
      const result = await ctx.model.UpdateRecord.findByIdAndDelete(id);
      ctx.api_success_data(result);
    } catch (error) {
      console.log("error----", error);
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
      const result = await ctx.model.UpdateRecord.findByIdAndUpdate(id, update);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }

  /**
   * 通过 关联文档 或者 关联常见问题 查询更新记录 
   */
   async related_record() {
    const ctx = this.ctx;
    try {
    
      const doc = ctx.query.doc;
      const faq = ctx.query.faq;


      if(!doc&&!faq){
        ctx.api_error_msg('必须传相关关联文档 或者 关联常见问题 ID');
        return 
      }
 
      let query={     }
      if(doc){
        query.related_doc =doc
      }else{
        query.related_faq =faq
      }
      if(ctx.is_client_request(ctx)){
        query['status']={ $eq :1}
       }

      let options={
      sort:{
        updatedAt:-1
        }
      }
      const result = await ctx.model.UpdateRecord.find( query,'',options ).exec();
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
}
module.exports = UpdateRecordController;

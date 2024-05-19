"use strict";

const Controller = require("egg").Controller;
class LayoutTemplateController extends Controller {
  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;
    try {
      const regex_list = ["name"];
      const query = ["id", ...regex_list].reduce((origin, key) => {
        if (ctx.query[key] !== undefined) {
          origin[key] = regex_list.includes(key)
            ? { $regex: ctx.query[key], $options: "i" }
            : ctx.query[key];
        }
        return origin;
      }, {});
      // await ctx.sleep(6000);
      const result = await ctx.model.LayoutTemplate.paginate(query, {
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
      const result = await ctx.model.LayoutTemplate.find(
        null,
        { name: 1, project: 1 },
        { sort: { createAt: -1 } }
      );
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
    let { id, name,   descriptions, status, folder } = ctx.request.body;
    let final_obj = { id, name,   descriptions, status,folder };
    delete  final_obj.mirror
    if(htype=='update'){
       delete  final_obj.folder
    
      
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
      let final_obj = await this.compute_final_obj_when_create_or_update(
        "create"
      );

      const list = await ctx.model.LayoutTemplate.find({},null,
        { sort: { value: -1 } }).exec()
      let value = 1
      if(list && list.length){
        value = list[0].value + 1
      }
      final_obj.value = value

      const result = await ctx.model.LayoutTemplate.create(final_obj);

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
      await this.check_name()
      let id = final_obj.id;
      delete final_obj.id;
      const result = await ctx.model.LayoutTemplate.findByIdAndUpdate(id, final_obj);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }

  /**
   * 镜像其他布局
   */
  async mirror(){
    const ctx = this.ctx;
    try {
      const {target ,mirror} = ctx.request.body
     
 
      const target_results = await ctx.model.LayoutTemplate.find({value: target})
       if(!target_results.length){
        ctx.api_error_msg('镜像布局不存在');  
        return 
       }
      const target_result = target_results[0]
      if(target_result.mirror){
        ctx.api_error_msg('已经镜像过');
        return 
      } 

      const mirror_results = await ctx.model.LayoutTemplate.find({value: mirror})
      if(!mirror_results.length){
        ctx.api_error_msg('镜像布局不存在');  
        return 
      }
      //镜像 css js component i18n assets 
      await  ctx.service.layoutTemplate.mirror_layout({
        target,
        mirror
        })
    const result = await ctx.model.LayoutTemplate.findByIdAndUpdate(target_result._id, {mirror});
    
    ctx.api_success_data(result)


    } catch (error) {
      console.error(error);
      ctx.api_error_msg(error);
    }

  }
}
module.exports = LayoutTemplateController;

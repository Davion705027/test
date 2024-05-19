/*
 * @Date           : 2022-03-11 10:59:48
 * @FilePath: /client-api-doc-server/app/controller/appSdkVersion.js
 * @Description    :
 */
"use strict";
const Controller = require("egg").Controller;
const uuid = require("uuid").v1;
class AppSdkVersionController extends Controller {
  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;
    try {
      let query = {};
      let { name,version,showWeb } = ctx.query;
      // 版本号
      if (version) {
        query.version = {
            $regex: version,
            $options: "i",
          }
      }
      // 版本名字
      if (name) {
        query.name = {
            $regex: name,
            $options: "i",
          }
      }
     
      const options = {
        page: ctx.toInt(ctx.query.currentPage),
        limit: ctx.toInt(ctx.query.pageSize),
        sort: { updatedAt: -1 },
      };

      // 显示在web端的版本历史列表  
      if(+showWeb){
        query.showWeb = +showWeb
        options.sort = { createdAt: -1} // 历史版本 按创建时间倒序排
      }
      // await ctx.sleep(6000);
      const result = await ctx.model.AppSdkVersion.paginate(query, options);
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
      const result = await ctx.model.AppSdkVersion.findById(id).exec();
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   * 创建或者更新数据通用内部方法
   * @returns
   */
  async compute_final_obj_when_create_or_update() {
    const ctx = this.ctx;
    let {
      id,
      name,
      mark,
      version,
      status = -1,
      filename,
      env,
      type,
      path,
      size,
      showWeb,
      demoPath,
      demoFilename,
      demoSize
    } = ctx.request.body;
    let final_obj = {
      id,
      name,
      mark,
      version,
      filename,
      env,
      type,
      path,
      status,
      size,
      showWeb,
      demoPath,
      demoFilename,
      demoSize
    };
    await this.service.jwt.add_operator(final_obj);
    ctx.remove_false_key(final_obj,['showWeb']);
    return final_obj;
  }
  /**
   * 创建  一条数据
   * @returns
   */
  async create() {
    const ctx = this.ctx;
    try {
      let final_obj = await this.compute_final_obj_when_create_or_update();

     
    
      const result = await ctx.model.AppSdkVersion.create(final_obj);
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
      let final_obj = await this.compute_final_obj_when_create_or_update();
      let id = final_obj.id;
      delete final_obj.id;

      const result = await ctx.model.AppSdkVersion.findByIdAndUpdate(
        id,
        final_obj
      );
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
      const result = await ctx.model.AppSdkVersion.findByIdAndDelete(id);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   * 所有 
   */
  async all(){
    const ctx = this.ctx;
    try {
      const options = {
        page: 1,
        limit: 20,
        sort: { createdAt: -1 },
      };
   
      const result = await ctx.model.AppSdkVersion.paginate({}, options);
   
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
}
module.exports = AppSdkVersionController;

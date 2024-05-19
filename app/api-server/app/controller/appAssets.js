/*
 * @Date           : 2022-04-06 15:17:14
 * @LastEditTime: 2023-11-04 13:00:22
 * @Description    : AppAssets app资源管理
 */
"use strict";

const Controller = require("egg").Controller;

const fs = require('fs');
const fsPromises = fs.promises
const path = require('path');
class AppAssetsController extends Controller {
  // 扫描
  async scan(){
    try{
      const res = await this.service.appAssets.scan()
      this.ctx.api_success_data(res);
    }catch(error){
      this.ctx.api_error_msg(error);
    }
  }  
  /**
   * APP素材列表
   */
  async index(){
    const { ctx } = this;
    const query = {};
    let {project,path,url} = ctx.request.query;
    if (project) {
      query.project =  {
        $regex: project,
        $options: "i",
      }
    }
    if (path) {
      query.path =  {
        $regex: path,
        $options: "i",
      }
    }
    if (url) {
      query.url =  {
        $regex: url,
        $options: "i",
      }
    }
    const options = {
      page: ctx.toInt(ctx.query.currentPage) || 1,
      limit: ctx.toInt(ctx.query.pageSize) || 10,
      sort: { updatedAt: -1 },
    };
    try{
      const result = await ctx.model.AppAssets.paginate(query,options);
      ctx.api_success_data(result);
    } 
    catch(error){
      ctx.api_error_msg(error);
    }
  }
  /**
   *  新增AppAssets
   * @returns
   */
  async create() {
    try{
      await this.service.appAssets.create()
      this.ctx.api_success_data();
    }catch(error){
      this.ctx.api_error_msg(error);
    }
  }
  /**
   *  修改AppAssets
   * @returns
   */
  async update() {
    const ctx = this.ctx;
    try {
      let final_obj = ctx.request.body;
      ctx.remove_false_key(final_obj);
      let result  = await ctx.model.AppAssets.findByIdAndUpdate(final_obj.id, final_obj);

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
      console.log(id);
      const find = await ctx.model.AppAssets.findById(id);
      console.log(find);
      if(!find)return
      await ctx.model.AppAssets.deleteOne({_id:id});

      await fsPromises.rm(path.join('static',find.url),{force: true})
      ctx.api_success_data();
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  async find() {
    const ctx = this.ctx;
    try {
      let { project } = ctx.request.query;
      const res = await this.service.appAssets.get_two_target_path(project);
      ctx.api_success_data(res);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
}

module.exports = AppAssetsController;

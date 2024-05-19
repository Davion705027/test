/*
 * @Date           : 2022-04-06 15:17:14
 * @LastEditTime: 2023-11-04 13:00:22
 * @Description    : ScanMatch 大赛素材
 *  */
"use strict";

const Controller = require("egg").Controller;

const fs = require('fs');
const fsPromises = fs.promises
const path = require('path');
class ScanMatchController extends Controller {
  // 扫描
  async scan(){
    try{
      const res = await this.service.scanMatch.scan()
      this.ctx.api_success_data(res);
    }catch(error){
      this.ctx.api_error_msg(error.message);
    }
  }  
  getQuearyObj(key,value){
    return {
      key,
      value
    }
  }
  /**
   * 列表
   */
  async index(){
    const { ctx } = this;
    const query = {};
    let {source,project,path,url} = ctx.request.query;

    // let query_list = [
    //   this.getQuearyObj('source',source),
    //   this.getQuearyObj('project',project),
    //   this.getQuearyObj('path',path),
    //   this.getQuearyObj('url',url)
    // ].filter(i=>Boolean(i.value))
    // query_list.forEach(item=>{
    //   query[item.key] = {
    //     $regex: item.value,
    //     $options: "i",
    //   }
    // })
    if (source) {
      query.source = source
    }
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
      const result = await ctx.model.ScanMatch.paginate(query,options);
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
      await this.service.scanMatch.create()
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
      let result  = await ctx.model.ScanMatch.findByIdAndUpdate(final_obj.id, final_obj);

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
      const find = await ctx.model.ScanMatch.findById(id);
      console.log(find);
      if(!find)return
      await ctx.model.ScanMatch.deleteOne({_id:id});

      await fsPromises.rm(path.join('static',find.url),{force: true})
      ctx.api_success_data();
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
}

module.exports = ScanMatchController;

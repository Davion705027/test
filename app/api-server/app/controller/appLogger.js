/*
 * @Date           : 2022-03-11 10:59:48
 * @FilePath: /client-api-doc-server/app/controller/AppLoggerController.js
 * @Description    app 日志收集:
 */
"use strict";

const Controller = require("egg").Controller;
const fs = require('fs');
const fsPromises = fs.promises
const path = require('path');
class AppLoggerController extends Controller {
  // 切片上传
  async sliceUpload() {
    const ctx = this.ctx;
    try{
      const res = await ctx.service.appLogger.upload();
      ctx.api_success_data(res);
    }catch(error){
      ctx.api_error_msg(error);
    }
  }
  
  // 合并切片
  async merge(){
    const ctx = this.ctx;
    try{
      const res = await ctx.service.appLogger.merge();
      ctx.api_success_data(res);
    }catch(error){
      ctx.api_error_msg(error);
    }
  }

  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;
    try {
      let query = {};
      let { name,project } = ctx.query;
      // 项目
      if (project) {
        query.project = {
            $regex: project,
            $options: "i",
          }
      }
      // 文件名字 txt
      if (name) {
        query.name = {
            $regex: name,
            $options: "i",
          }
      }
     
      const options = {
        page: ctx.toInt(ctx.query.currentPage) || 1,
        limit: ctx.toInt(ctx.query.pageSize) || 10,
        sort: { updatedAt: -1 },
      };

      // await ctx.sleep(6000);
      const result = await ctx.model.AppLogger.paginate(query, options);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }

    // 删除单个
  async delete(){
      const ctx = this.ctx;
      try{
        const { id,filePath } = ctx.request.body;
        // const findone = await ctx.model.AppLogger.findById(id);
        let finalFile = 'static' + filePath;

        if(fs.existsSync(finalFile)){
          fs.unlinkSync(finalFile);  
        }
        const result = await ctx.model.AppLogger.deleteOne({
          _id:id
        });

        ctx.api_success_data(result);
      }catch(error){
        ctx.api_error_msg(error);
      }
    }
  
  // 按日期批量删除
  async deleteMany(){
    const ctx = this.ctx;
    try{
      const { start,end,project='ty' } = ctx.request.body;
      let projectPath = `static/public/upload/appLogger/${project}` // 项目路径
      this.deleteFoldersInRange(projectPath,start.toString().replaceAll('-',''),end.toString().replaceAll('-',''));

      // 删除数据库数据
      const result = await ctx.model.AppLogger.deleteMany({
        createdAt: {
          $gte: new Date(start),
          $lte: new Date(end),
        },
      });
      ctx.api_success_data(result);
    }catch(error){
      ctx.api_error_msg(error);
    }
  }
  /*
    删除时间范围内的文件夹
    @param {string} directory 文件夹路径
    @param {string} startDate 开始日期 20240511
    @param {string} endDate 结束日期 20240518
  */ 
  deleteFoldersInRange(directory,startDate,endDate){
    startDate = parseInt(startDate, 10);
    endDate = parseInt(endDate, 10);

    if(!fs.existsSync(directory)){
      return '不存在:' + directory;
    }
    // 读取指定目录下的文件夹
    const files = fs.readdirSync(directory);

    files.forEach(file => {
        const filePath = path.join(directory, file);

        // 检查是否是文件夹，并且文件夹名称符合日期格式 
        if (fs.statSync(filePath).isDirectory() && /^\d{8}$/.test(file)) {
            const fileDate = parseInt(file, 10);

            // 检查文件夹日期是否在指定范围内
            if (fileDate >= startDate && fileDate <= endDate) {
                try {
                    // 删除文件夹及其内容
                    fs.rmdirSync(filePath, { recursive: true });
                    console.log(`删除文件夹: ${filePath}`);
                } catch (err) {
                    console.error(`无法删除文件夹 ${filePath}: ${err}`);
                }
            }
        }
    });


  }


  /**
   * 删除  一条数据
   * @returns
   */
  // async destroy() {
  //   const ctx = this.ctx;
  //   try {
  //     const id = ctx.request.body.id;
  //     const result = await ctx.model.AppSdkVersion.findByIdAndDelete(id);
  //     ctx.api_success_data(result);
  //   } catch (error) {
  //     ctx.api_error_msg(error);
  //   }
  // }

}
module.exports = AppLoggerController;

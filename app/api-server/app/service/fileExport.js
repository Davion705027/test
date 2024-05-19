/*
 * @Date           : 2022-04-03 13:35:21
 * @LastEditTime: 2022-09-09 19:08:00
 * @Description    :
 */
"use strict";
const Service = require("egg").Service;
const fsPromises = require("fs").promises;
const fs = require("fs");
const { mkdir } = fsPromises;
const moment = require("moment");
const path = require("path");
const uuid = require("uuid").v1;
const json2xls = require('json2xls');

const NodeXlsx = require('node-xlsx').default
class FileExportService extends Service {

     ensure_write_folder_exist  (write_folder) {
    let is_exist = fs.existsSync(write_folder);
    if (is_exist) {
      // console.log( colors.red(`${write_folder}-----文件夹已存在----  `) );
    } else {
      try {
        // 创建文件夹
        fs.mkdirSync(write_folder, { recursive: true });
        // console.log(colors.green(`创建文件夹   ${write_folder} 完成`));
      } catch (err) {
        // console.log(`创建文件夹   ${write_folder}  出错`, err);
      }
    }
  };
  /**
   *  获取文件 上传目录
   * @returns
   */
  async computeExportFile(config) {

    let {type = "other", extname = ".txt",filename='' ,needday=1} = config
    //获取当前日期
    let day = moment().format("YYYYMMDD");
    console.log(day);
    // console.log('this.config-------',this.config);
    // console.log('this.config.upload_dir-------',this.config.upload_dir);
    // 基础配置
    //  let basedir =   this.config.Export_dir+type;
    let basedir = this.config.upload_dir + type;
    //创建 文件的保存路径
    let dir=basedir 
    //如果不需要日期 目录
     if(needday==1){ dir =   path.join(basedir, day);}
   
    //不存在就创建目录
    await mkdir(dir, { recursive: true });
    //生成uuid 文件名字
    let uid = uuid().replace(/-/gi, "");
    //新文件名字
    let new_file_name =  filename ||( uid + extname) ;
    //完整路径
    let filepath = path.join(dir, new_file_name);
    // 保存目录
   let  save_dir =  filepath.replace(/\\/g, "/");

   if(save_dir.startsWith('static/')){
    save_dir =save_dir  .substring(7)
   }
    return {
      //day 
      day,
      //type
      file_type:type,
      //完整路径
      filepath,
      // 保存目录  : this.ctx.origin + ExportDir.slice(3).replace(/\\/g, '/')
      save_dir ,
      //文件名字
      filename: new_file_name,
    };
  }
  /**
   * 写入文件内容   json
   *
   */
  async write_file_json(data = "") {
    let result = await this.service.fileExport.write_file({
      data: JSON.stringify(data),
      type: "json",
      extname: ".json",
    });
    return result;
  }
  /**
   *
   * 写入文件内容 大部分 场景下  ， json ,text ,md  文本类型的
   *
   * excel ，word ,pdf 这种 不走这里
   */
  async write_file(config = {}) {
    let { data = "", type = "json",   } = config;
    
 
    data = JSON.stringify(data)
    // console.log("写入文件内容---------", data);
    delete config.data
    let file_info = await this.service.fileExport.computeExportFile(
      config
    );
    console.log("写入文件内容---------", file_info);
    let encoding = ['xlsx'].includes(type) ? 'binary':'utf8'
    let ss = await fs.writeFile(file_info.filepath, data || "",  encoding   ,  (err) => {
      if (err) throw err;
      console.log("The file has been saved!");
    });
    
    return file_info;
  }
  /**
   * @description 删除文件
   * @param
   * @return
   */
  async deletefile(filepath) {
    const ctx = this.ctx;
    let path_ = filepath.split("/").join("\\");
    // 基础配置
    //创建 文件的保存路径
    try {
      let success = true;
      fs.unlink(path_, function (error) {
        if (error) {
          success = false;
        }
      });
      if (success) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }

 
  async export_file_json(data) {
    // 转变客户端 json 对象
    let obj = {};
    data.map((x) => {
      obj[x.key] = x;
    });
    //写入 文件 ， 返回文件地址  ， 前端下载文件
    let result = await this.service.fileExport.write_file_json(obj);
    return result;
  }
  async export_file_excel(data) {
    // fs.writeFileSync( file_export, xls, 'binary');
    

    // console.error( 'datadatadatadatadata--' ,data?.length);
    // console.error( 'datadatadatadatadata--1' ,data[0]);

      let data2= []
      data.map(x=>{
        data2.push(x.dataValues)
      })

      // console.error( 'datadatadatadatadata--2' ,data2[0]);
    // let result = await  this.service.fileExport.write_file({
    //   data: json2xls(data2 ),
    //   type: "xlsx",
    //   extname: ".xlsx",
    // })

    let file_info = await this.service.fileExport.computeExportFile(
      "xlsx",
      ".xlsx"
    );
    //  fs.writeFileSync( file_info.filepath, json2xls(data2 ), 'binary');

     await fs.writeFile(file_info.filepath, json2xls(data2 ),  'binary'  ,  (err) => {
      if (err) throw err;
      console.log("The file has been saved!");
    });
      
    return  file_info
  }


 
}
module.exports = FileExportService;

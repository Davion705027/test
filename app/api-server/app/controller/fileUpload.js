/*
 * @Date           : 2022-03-29 21:41:11
 * @LastEditTime   : 2022-04-11 10:53:20
 * @Description    :
 */
"use strict";
const pump = require("pump");
const Controller = require("egg").Controller;

const fsPromises = require("fs").promises;
class FileUploadController extends Controller {
  // https://github.com/eggjs/egg-multipart#upload-multiple-files
  /**
   * 保存图片
   */
  // async save() {
  //     const ctx = this.ctx;
  //     try {
  //         console.log('保存图片-----',ctx.request);
  //         console.log('保存图片-----1', 666);
  //         console.log('保存图片----files-', );
  //         console.log('got %d files', ctx.request.files.length);
  //         const parts = ctx.multipart({ autoFields: true });
  //         let files ={};
  //         let part ;
  //         while ((part  = await parts()) != null) {
  //             console.log('field: ' + part[0]);
  //             console.log('value: ' + part[1]);
  //             console.log('valueTruncated: ' + part[2]);
  //             console.log('fieldnameTruncated: ' + part[3]);
  //             console.log('field: ' + part.fieldname);
  //             console.log('filename: ' + part.filename);
  //             console.log('encoding: ' + part.encoding);
  //             console.log('mime: ' + part.mime);
  //             if(!part .filename){
  //                 continue;
  //             }
  //             const fieldname = part .fieldname; // file表单的名字
  //             // 上传图片的目录
  //             const dir = await this.service.fileUpload.getUploadFile(part .filename,'image');
  //             const target = dir.filepath;
  //             const writeStream = fs.createWriteStream(target);
  //             await pump(part , writeStream);
  //             writeStream.destroy();
  //             files = Object.assign(files, {
  //               [fieldname]: dir.save_filepath
  //             });
  //             // if (part.length) {
  //             //     // arrays are busboy fields
  //             //     console.log('field: ' + part[0]);
  //             //     console.log('value: ' + part[1]);
  //             //     console.log('valueTruncated: ' + part[2]);
  //             //     console.log('fieldnameTruncated: ' + part[3]);
  //             //   } else {
  //             //     if (!part.filename) {
  //             //       // user click `upload` before choose a file,
  //             //       // `part` will be file stream, but `part.filename` is empty
  //             //       // must handler this, such as log error.
  //             //       continue;
  //             //     }
  //             //     // otherwise, it's a stream
  //             //     console.log('field: ' + part.fieldname);
  //             //     console.log('filename: ' + part.filename);
  //             //     console.log('encoding: ' + part.encoding);
  //             //     console.log('mime: ' + part.mime);
  //             //     const result = await ctx.oss.put('egg-multipart-test/' + part.filename, part);
  //             //     console.log(result);
  //             //   }
  //           }
  //           if(Object.keys(files).length > 0){
  //             ctx.api_success_data(files);
  //           }else{
  //             ctx.api_error_msg(error);
  //           }
  //       ctx.api_success_data(result);
  //     } catch (error) {
  //       ctx.api_error_msg(error);
  //     }
  //   }
  // https://github.com/eggjs/egg-multipart#upload-multiple-files
  /**
   * 保存 文件
   */
  async save() {
    const ctx = this.ctx;
    const result = await this.service.fileUpload.save_file(
      ctx.request.files,
      ctx.request.body.b_sdk
    );
    if (result.success) {
      ctx.api_success_data(result.data);
    } else {
      ctx.api_error_msg(result.msg);
    }
  }


   /**
  * 
  * 上传文档内容 直接生成md 文件并且返回 md 文档 的路径地址
  */

   async   writerandcreate(){
    const ctx = this.ctx;
   try {
    const doc = ctx.query.body;
    let {
      content
    } = ctx.request.body;
    




    
   } catch (error) {
    
   }

  }


}
module.exports = FileUploadController;

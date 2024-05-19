/*
 * @Date           : 2022-04-03 13:35:21
 * @LastEditTime   : 2022-04-15 19:39:50
 * @Description    :  
 */
'use strict';

const Service = require('egg').Service;
const fsPromises = require('fs').promises
const { mkdir } = fsPromises
const moment = require("moment");
const path = require('path');

const uuid = require("uuid").v1

class FileUploadService extends Service {

    /**
     *
     * 转化 文件类型到 自定义的  type
     *
     */
    compute_type_by_file(file = {}) {
        let { mimeType = "", filename = "" } = file;
        mimeType =mimeType .toLowerCase()
 

        if (mimeType.includes("image")) return "image";

        if (mimeType.includes("video")) return "video";

        if (filename.endsWith(".md")) return "md";

        if (filename.endsWith(".json")) return "json";
        if (filename.endsWith(".apk")) return "apk";
        if (filename.endsWith(".ipa")) return "ipa";

        return "other"
    }

    /**
     * 获取文件 上传目录
     * 
     * @param {string} filename 
     * @param {string} type 
     * @param {boolean} is_b_sdk 
     * @returns 
     */
    async getUploadFile(filename, type = 'other', is_b_sdk) {
        //获取当前日期
        let day = moment().format("YYYYMMDD");
        // console.log(day);
        // 基础配置
        let basedir = this.config.upload_dir + (is_b_sdk ? 'b_sdk/' : '') + type;

        //创建 文件的保存路径 
        let dir = path.join(basedir, day);
        //不存在就创建目录
        await mkdir(dir, { recursive: true });
        //生成uuid 文件名字
        let uid = uuid().replace(/-/ig, '');
        //生成的文件名字
        let save_name = uid + path.extname(filename)
        //完整路径
        let filepath = path.join(dir, save_name);
        //文件后缀名字
        let suffix_name =   ( save_name .substring(save_name.lastIndexOf('.')+1) +'').toLowerCase()

        return {
            //完整路径
            filepath,
            //生成的文件名字
            save_name,
            // 保存目录  : this.ctx.origin + uploadDir.slice(3).replace(/\\/g, '/')
            save_filepath: filepath.slice(6).replace(/\\/g, '/'),
            //文件后缀名字
            suffix_name
        }

    }

    /**
     * 追加文件上传日志
     * 
     * @param {import('egg-multipart').EggFile} file 
     * @param {*} info 
     */
    async pushUploadFileLog(file, info) {
      const { name } = this.ctx.token_info

      const fileStat = await fsPromises.stat(file.filepath)
      
      const data = {
        name: file.filename,
        mime_type: file.mimeType,
        filepath: info.filepath,
        filesize: fileStat.size,
        save_name: info.save_name,
        save_filepath: info.save_filepath,
        suffix_name: info.suffix_name,
        create_by: name,
        update_by: name,
      }
  
      console.log(data);
      await this.ctx.model.FileUploadLog.create(data)
    }


    /**
     * 上传文件内部方法
     * 
     * @param {Array} files 
     * @param {boolean} is_b_sdk 
     * @returns 
     */
    async save_file(files, is_b_sdk) {
        const ctx = this.ctx;
        let result = { success: "", data: {}, };
        try {
            for (let i = 0; i < files.length; i++) {
                const file = files[i];
                // console.log("file-----", file);
                // console.log("field: " + file.fieldname);
                // console.log("filename: " + file.filename);
                // console.log("encoding: " + file.encoding);
                // console.log("mime: " + file.mime);
                // console.log("tmp filepath: " + file.filepath);
                // field: 'files',
                // filename: '11111111111111.png',
                // encoding: '7bit',
                // mime: 'image/png',
                // fieldname: 'files',
                // transferEncoding: '7bit',
                // mimeType: 'image/png',
                // filepath: 'C:\\Users\\admin\\AppData\\Local\\Temp\\egg-multipart-tmp\\client-api-doc-server\\2022\\04\\03\\12\\d5002e4c-d71a-4332-aa30-b030940505e7.png'
                try {
                    // process file or upload to cloud storage
                    // 文件名字
                    const filename = file.filename;
                    // 转换类型
                    const type = this.compute_type_by_file(file);
                    // 上传图片的目录
                    const save_target = await this.getUploadFile(filename, type, is_b_sdk);
                    // console.log("计算后的存放路径---- ", save_target);
                    const oldPath = file.filepath;
                    const newPath = save_target.filepath;
                    await this.pushUploadFileLog(file, save_target)
                    await fsPromises.copyFile(oldPath, newPath);

                    result["data"][filename] = save_target;
                } finally {
                    // remove tmp files and don't block the request's response
                    // cleanupRequestFiles won't throw error even remove file io error happen
                    ctx.cleanupRequestFiles([file]);
                }
            }
            result.success = true;
        } catch (error) {
            result.success = false;
            result.msg = error;
        }
        return result;
    }



}

module.exports = FileUploadService;

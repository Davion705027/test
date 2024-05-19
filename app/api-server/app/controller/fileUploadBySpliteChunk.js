/*
 * @Date           : 2022-03-29 21:41:11
 * @LastEditTime   : 2022-04-11 10:53:20
 * @Description    :
 */
"use strict";
const Controller = require("egg").Controller;

const fs = require("fs");
const fsPromises = require("fs").promises;
const { pipeline } = require("stream");
const sendToWormhole = require("stream-wormhole");
const moment = require("moment");
const path = require("path");

class FileUploadBySpliteChunkController extends Controller {
  /**
   *
   * 转化 文件类型到 自定义的  type
   *
   */
  compute_type_by_file({ mimeType = "", filename = "" }) {
    let str = "";
    if (mimeType.includes("image")) {
      str = "image";
    } else if (mimeType.includes("video")) {
      str = "video";
    } else {
      if (filename.endsWith(".md")) {
        str = "md";
      } else {
        str = "other";
      }
    }
    return str;
  }

  /**
   * 追加文件上传日志
   *
   * @param {Object} fileinfo
   * @param {string} fileinfo.name
   * @param {string} fileinfo.mime_type
   * @param {string} fileinfo.size
   * @param {string} fileinfo.filepath
   * @param {Object} info
   */
  async pushUploadFileLog(fileinfo, info) {
    const username = this.ctx.token_info.name;

    const data = {
      name: fileinfo.name,
      mime_type: fileinfo.mime_type,
      filesize: fileinfo.size,
      filepath: info.filepath,
      save_name: info.save_name,
      save_filepath: info.save_filepath,
      suffix_name: info.suffix_name,
      create_by: username,
      update_by: username,
    };

    console.log(data);
    await this.ctx.model.FileUploadLog.create(data);
  }

  /**
   * 获取文件 上传目录
   *
   * @param {*} fileid
   * @param {*} filename
   * @param {*} type
   * @returns
   */
  async getUploadInfo(fileid, filename, type = "other") {
    //获取当前日期
    let day = moment().format("YYYYMMDD");
    // console.log('------this.config.upload_dir-', this.config.upload_dir, day);

    //创建 文件的保存路径
    let dir = path.join(this.config.upload_dir, type, day);
    //不存在就创建目录
    await fsPromises.mkdir(dir, { recursive: true });
    //生成uuid 文件名字
    let uid = fileid;
    //生成的文件名字
    let save_name = uid + path.extname(filename);
    //完整路径
    let filepath = path.join(dir, save_name);
    //文件后缀名字
    let suffix_name = (
      save_name.substring(save_name.lastIndexOf(".") + 1) + ""
    ).toLowerCase();

    return {
      //完整路径
      filepath,
      //生成的文件名字
      save_name,
      // 保存目录  : this.ctx.origin + uploadDir.slice(3).replace(/\\/g, '/')
      save_filepath: filepath.slice(6).replace(/\\/g, "/"),
      //文件后缀名字
      suffix_name,
    };
  }

  async save() {
    const stream = await this.ctx.getFileStream();
    try {
      // 转换类型
      const type = this.compute_type_by_file({
        mimeType: stream.fields.mime_type,
        filename: stream.fields.name,
      });

      const save_target = await this.getUploadInfo(
        stream.fields.file_id,
        stream.filename,
        type
      );

      const is_exists = fs.existsSync(save_target.filepath);
      if (!is_exists) {
        await this.pushUploadFileLog(stream.fields, save_target);
      }

      const writeStream = fs.createWriteStream(save_target.filepath, {
        flags: "a",
      });
      stream.pipe(writeStream);

      await new Promise((resolve) => stream.on("end", resolve));
      writeStream.close();
      stream.destroy();

      this.ctx.api_success_data({
        [stream.filename]: save_target,
      });
    } catch (err) {
      await sendToWormhole(stream);
      this.ctx.api_error_msg(err);
    }
  }
}
module.exports = FileUploadBySpliteChunkController;

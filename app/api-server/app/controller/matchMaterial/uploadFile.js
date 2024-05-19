/*
 * @Description    : 杯赛素材上传文件
 * 目录： /static/public/upload/matchMaterial
 * 
 *  */
"use strict";

const Controller = require("egg").Controller;

const fs = require('fs');
const fsPromises = fs.promises
const path = require('path');
class MatchMaterialUploadController extends Controller {
  async upload() {
    const ctx = this.ctx;
    let urlList = await this.service.matchMaterial.create()
    console.log(2, urlList)
    ctx.api_success_data(urlList)
  }
}

module.exports = MatchMaterialUploadController;

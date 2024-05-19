

'use strict';

const Service = require('egg').Service;
const fs = require('fs');
const path = require('path');
const fsPromises = fs.promises
const { mkdir } = fsPromises
const moment = require("moment");
const uuid = require("uuid").v1;
const utils = require("../utils/index.js")
class MatchMaterialService extends Service {
  // 获取对应项目的路径  这里可以动态修改扫描路径 例如：'static/assets/'
  get_project_path(){
    const project = this.project;
    const upload_dir = this.config.upload_dir; // static/public/upload/
    const project_path = `${upload_dir}${project}/`;  // static/public/upload/ozb 欧洲杯
    return project_path;
  }  
  async scan() {
    const { ctx } = this;
    const params = ctx.request.body;
    const project = params.project // 项目
    if(!project)return; 
    this.project = project

    // 删除操作
    await this.delete_old_assets()

    // 目标目录 需要读取的目录 /static/public/upload/app/cp
    let target_path = this.get_project_path()
    if(!fs.existsSync(target_path)){
      throw Error('扫描目录不存在');
    }

    let folder = path.resolve(target_path)    
    // 递归读取目标文件夹
    await this.readDirectoryContents(folder,target_path)
  }
  // 用户上传
  async create(){
    const { ctx } = this;
    const files = ctx.request.files;
    let backData = []
    for (let i = 0; i < files.length; i++) {
      const file = files[i];
      let url = await this.create2(file)
      backData.push(url)
    }
    return backData
  }
  async create2(file){
    const { ctx } = this;
    let request_obj = ctx.request.body;
    const { project } = request_obj
    this.project = project
    
    // 用户不传路径默认丢到 other文件夹下
    request_obj.path = request_obj.path || ('other/' +moment().format( "YYYYMMDD" ));
    
    const oldPath = file.filepath
    let file_name =  utils.rebuild_file_name(file.filename) 
   
    // 检查要写入的newPath文件是否存在文件夹
    // 创建文件夹
    const file_path = path.resolve(this.get_project_path(),path.join(request_obj.path,file_name))
    const dir_path = path.dirname(file_path)
    // console.log(dir_path);
    await mkdir(dir_path, { recursive: true });
    // static/public/upload/...
    const newPath = path.join(dir_path, file_name)

    // 服务器存储路径 /public/upload/...
    const url = newPath.split('static')[1]
    // 复制文件
    await fsPromises.copyFile(oldPath, newPath);
    return ctx.format_path(url)
  }
  
  /**
   * 递归读取文件夹
   * @param {String} directoryPath 文件路径
   * @param {String} father_path 父级相对文件路径 
   */
  async readDirectoryContents(directoryPath,father_path) {
    const paths = fs.readdirSync(directoryPath);
    for (const _path of paths) {
    //   console.log(father_path + _path);  // 绝对路径 /static/cp/xx

      const filePath = path.join(directoryPath, _path);
      const stat = fs.statSync(filePath);
      if (stat.isFile()) {  

        // console.log(filePath); // Users/admin/Desktop/code/full-stack/client-api-doc-server/static/cp/xx/10004.png
        const oldPath = filePath; // /Users/.../static/cp/xx/10004.png
    

        // 获取项目的原路径  xx/10004.png
        const origin_path = oldPath.split(this.project + '/')[1]
        // static/public/upload/...
        const newPath = path.resolve(this.get_project_path(),origin_path)
        // 服务器存储路径 /public/upload/...
        const url = newPath.split('static')[1]

        // 检查要写入的newPath文件是否存在文件夹
        // 创建文件夹
        const dir_path = path.dirname(newPath)
        await mkdir(dir_path, { recursive: true });


        console.log(origin_path);
        let final_obj = {
            project:this.project,
            name: path.basename(origin_path),
            path: origin_path, // 原路径
            url, // 服务器存储路径
            // uid: save_target.uid // uid
            size: ''+ (  Math.ceil( 100* (stat.size/(1024*1024)) ) /100) +'MB',
            birthtimeMs: stat.birthtimeMs
        }
        

        await this.service.jwt.add_operator(final_obj)
        await this.ctx.model.ScanMatch.create(final_obj)

      } else if (stat.isDirectory()) {
        // 如果是子目录，递归调用
        await this.readDirectoryContents(filePath,father_path + _path);
      }
    }
    }
    // 获取文件类型
    get_file_type(filePath){
        const fileType = path.extname(filePath).toLowerCase();
        if (fileType === '.jpg' || fileType === '.jpeg' || fileType === '.png' || fileType === '.gif') {
            return 'image'
        } else if (fileType === '.mp3') {
            return 'map3'
        } else {
            return 'other'
        }
    }
   
    /**
     * 删除数据库存储的数据
     * static/public/upload/app/cp
     */
    async delete_old_assets(){
        const project = this.project
        const res = await this.ctx.model.ScanMatch.deleteMany({project})
        console.log('删除了',res.deletedCount);
    }
}

module.exports = MatchMaterialService;

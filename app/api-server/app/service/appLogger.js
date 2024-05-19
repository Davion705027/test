
'use strict';

const fs = require('fs');
const path = require('path');
const fsPromises = fs.promises
const { mkdir } = fsPromises
const moment = require("moment");
const uuid = require("uuid").v1

const Service = require('egg').Service;
class AppLoggerService extends Service {
  checkPath(path){
    if (!fs.existsSync(path)) {
      // 如果不存在，则创建目录
      fs.mkdirSync(path, { recursive: true });
    }
  }
  /**
   * 获取项目分片路径
   *  */
  getProjectChunkPath(project){
    let root = process.cwd();
    // static/chunks/ty 
    let chunksPath = path.join(root, 'static/chunks/'+project);
    // 检查 chunks目录是否存在
    this.checkPath(chunksPath)
    return chunksPath;
  }
  async upload() {
    const { ctx } = this;
    
    let { index, totalChunks, project, fileChunk } = ctx.request.body;
    let chunksPath = this.getProjectChunkPath(project)

    await fs.promises.writeFile(path.join(chunksPath, `chunk_${index}`), Buffer.from(fileChunk, 'base64'), 'binary');

    return 'upload success';   
     
  }

  // 合并后的文件 存储路径
  // extname 文件后缀
  getSvaePath(project,extname){
    // 按项目存储日志
    project = project.toLowerCase();
    let day = moment().format("YYYYMMDD");
    let basedir = this.config.upload_dir + `appLogger/${project}`; // static/public/upload/appLogger/ty
    let dir = path.join(basedir, day);
    //不存在就创建目录  
    // await mkdir(dir, { recursive: true });
    this.checkPath(dir)
    let uid = uuid().replace(/-/ig, '');
      //生成的文件名字
    let save_name = uid + extname;
    let savePath = path.join(dir, save_name);
    return savePath;
  }
  
  /**
   * 合并切片 可主动合并也可以接口调用
   * project 合并的项目
   * extname 合并后的文件名
   */
  async merge(){
      const {ctx} = this
      let { extname='.txt',  project } = ctx.request.body;
      if(!project)return '缺少参数：project';
      let chunksPath = this.getProjectChunkPath(project)

      let chunksList = []
      // 读取当前项目的所有chunks
      chunksList = fs.readdirSync(chunksPath);
      if(!chunksList.length){
        return '暂无切片可合并';
      }
      // chunksList = ['chunk_8','chunk_1','chunk_6']
      chunksList.sort((a, b) => {
        const numA = parseInt(a.split('_')[1]); 
        const numB = parseInt(b.split('_')[1]);
        return numA - numB; // 按切片索引大小排序
      });

      let savePath = this.getSvaePath(project,extname)
      const writeStream = fs.createWriteStream(savePath, { flags: 'a' });

      let totalSize = 0
      for (let i = 0; i < chunksList.length; i++) {
        try{
          const chunkFilePath = path.join(chunksPath, chunksList[i]);
          const readStream = fs.createReadStream(chunkFilePath);
          readStream.pipe(writeStream, { end: false });

          // 当前切片大小
          const stats = fs.statSync(chunkFilePath);
          totalSize += stats.size;

          await new Promise((resolve) => {
            readStream.on('end', () => {
              resolve();
              // 删除已合并的分片
              fs.unlink(chunkFilePath, (err) => {
                if (err) console.error('Error deleting chunk:', err);
                resolve();
              });
            });
          });
        }catch(e){
          console.log('读取切片失败');
        }
      }

      writeStream.on('finish', () => {
        console.log('File merged successfully');
        let obj = {
          project,
          filePath:savePath.split('static')[1],
          name: extname,
          size: totalSize
        }
        totalSize = 0;
        ctx.model.AppLogger.create(obj)
      });

      writeStream.end();

  }
}

module.exports = AppLoggerService;

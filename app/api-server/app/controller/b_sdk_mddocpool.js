/*
 * @Date           : 2022-03-11 10:59:48
 * @FilePath: /client-api-doc-server/app/controller/mddocpool.js
 * @Description    :
 */
"use strict";
const path = require('path')
const fs = require('fs/promises')
const Controller = require("egg").Controller;
const utils = require("../utils/index.js");
class MddocpoolController extends Controller {
  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;
    try {
      let query = {};
      let {name,language,document, currentPage,pageSize,status} = ctx.query
        name &&(query[ "name"]={ $eq :name} )
        language &&(query[ "language"]={ $eq :language} )
        document &&(query[ "document"]={ $eq :document} )
        status &&(query[ "status"]={ $eq :status} )
      if(ctx.is_client_request(ctx)){
        query['status']={ $eq :1}
       }
      console.log(query);
      const options = {
        page: ctx.toInt( currentPage),
        limit: ctx.toInt( pageSize),
        sort: {   updatedAt: -1 },
     
      };
      // await ctx.sleep(6000);
      let result = await ctx.model.BSdkMddocpool.paginate(query, options);
      // const result = await ctx.model.BSdkMddocpool.find(query,null, { field: 'updatedAt', test: -1 }).exec();
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   * 查询  一条数据  的详细信息
   * @returns
   */
  async show() {
    const ctx = this.ctx;
    try {
      const id = ctx.query.id;
      const result = await ctx.model.BSdkMddocpool.findById(id).exec();
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  async findMdDocInfo() {
    try {
      const {docId,language} = this.ctx.query;
      const list = await this.ctx.model.BSdkMddocpool.find({document:docId,status:1},'',{sort:{updatedAt:-1}}).exec();
      const map = list.reduce((o,v) => (o[v.language] = v, o), {})
      const result = map[language] || map.zh_cn
      let content = 'not found'
      if (result?.path) {
        const buf = await fs.readFile(path.join('static',result.path))
        content = buf.toString()
      }
      this.ctx.api_success_data(content);
    } catch (error) {
      this.ctx.api_error_msg(error);
    }
  }
  /**
   * 创建或者更新数据通用内部方法
   * @returns
   */
  async compute_final_obj_when_create_or_update(type) {
    const ctx = this.ctx;
    let {
      id,language,name,path,author,document,status=-1,mark
 
    } = ctx.request.body;
    let final_obj = {
      id,language,name,path,author,document,status,mark
    };

    if(type=='create'){
      //创建的时候需要 提取 创建人 名字
      //  放入 author  字段 
      let token = ctx.request.headers.authorization || "";
      let   result= await  this.service.jwt.verifyToken(token)

        
      
      let author_create=''
      if(result){  author_create = result.name}

      console.error('创建的时候需要 提取 创建人 名字,,,,',result);

      final_obj.author=author_create
     }
 
     console.log('创建或者更新数据通用内部方法---mddocpool----', JSON.stringify(final_obj) );
    ctx.remove_false_key(final_obj);
    return final_obj;
  }
  /**
   * 创建  一条数据
   * @returns
   */
  async create() {
    const ctx = this.ctx;
    try {
      let final_obj = await this.compute_final_obj_when_create_or_update('create');
      if(final_obj.author){
        const result = await ctx.model.BSdkMddocpool.create(final_obj);
        ctx.api_success_data(result);
      }else{
        ctx.api_error_msg('作者未知')
      }
    
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   * 更新  一条数据
   * @returns
   */
  async update() {
    const ctx = this.ctx;
    try {
      let {id,...final_obj} = await this.compute_final_obj_when_create_or_update('update');
      await ctx.model.BSdkMddocpool.findByIdAndUpdate(
        id,
        final_obj
      );
      const result = await ctx.model.BSdkMddocpool.findById(id)
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   * 删除  一条数据
   * @returns
   */
  async destroy() {
    const ctx = this.ctx;
    try {
      const id = ctx.request.body.id;
      const result = await ctx.model.BSdkMddocpool.findByIdAndDelete(id);
      ctx.api_success_data(result);
    } catch (error) {
      console.log("error----", error);
      ctx.api_error_msg(error);
    }
  }
  /**
   * 禁用 一条数据
   */
  async disable() {
    const ctx = this.ctx;
    try {
      const id = ctx.request.body.id;
      const update = { status: -2 };
      const result = await ctx.model.BSdkMddocpool.findByIdAndUpdate(id, update);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   * 通过 关联文档 或者 关联常见问题 查询更新记录 
   */
   async related_record() {
    const ctx = this.ctx;
    try {
      const doc = ctx.query.doc;
      const faq = ctx.query.faq;
      if(!doc&&!faq){
        ctx.api_error_msg('必须传相关关联文档 或者 关联常见问题 ID');
        return 
      }
      let query={     }
      if(ctx.is_client_request(ctx)){
        query['status']={ $eq :1}
       }
      let options={
      sort:{
        updatedAt:-1
        }
      }
      const result = await ctx.model.BSdkMddocpool.find( query,'',options ).exec();
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }


  async findMdDocContent() {
    try {
      const { docId, language } = this.ctx.params;
      console.log(docId, language);
      const result = await this.ctx.model.BSdkMddocpool.findOne({
        document: docId,
        language,
        status: 1,
      }).exec();
      let { path, name } = result;
      console.log("result------------------path-----", result);
      if (name.endsWith('.md')) {
        //md 文档编译显示
        let content = await utils.render_markdown_file({
          file_path: path,
          docId,
        });

        this.ctx.set("content-type", "text/html");
        this.ctx.body = content;
        // this.ctx.body = {
        //   path,
        //   full_path :  node_path.join( __dirname ,"../../static/",path),
        //   content
        // }
      } else {
        const SERVER_API_DOMAIN = this.app.config.SERVER_API_DOMAIN;
        // 其他文件类型直接下载
        this.ctx.redirect(SERVER_API_DOMAIN + path);
      }
    } catch (error) {
      this.ctx.api_error_msg(error);
    }
  }
}
module.exports = MddocpoolController;

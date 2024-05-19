/*
 * @Date           : 2022-03-11 10:59:48
 * @FilePath       : /client-api-doc-server/app/controller/doc.js
 * @Description    :
 */
"use strict";
const Controller = require("egg").Controller;
class ArticleController extends Controller {
  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;
    try {
      const query = {};
      const name = ctx.query.name;
      if (name) {
        query["name"] = {
          $regex: name,
          $options: "i",
        };
      }
      const options = {
        page: ctx.toInt(ctx.query.currentPage),
        limit: ctx.toInt(ctx.query.pageSize),
        sort:     { updatedAt: -1 },
      };
      // await ctx.sleep(6000);
      const result = await ctx.model.Article.paginate(query, options);
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
      const result = await ctx.model.Article.findById(id).exec();
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   * 创建  一条数据
   * @returns
   */
  async create() {
    const ctx = this.ctx;
    try {
      const { 
        type,
        updateRecord,
        topic,
        status,
        is_top,
        is_best



       } = ctx.request.body;
     
       //校正 type 
       if(![1,2,3].includes(1*type) ){
         type =3
       }

      let final_obj={
        author:'admin',
        type,
        updateRecord,
        topic,
        status,
        is_top,
        is_best
      }

     //类型   1 momentArticle  时刻文章  2 videoArticle   视频文章  3   commonArticle 常规文章
      if(type==1){
        final_obj['moment_content'] = ctx.request.body.moment_content||''
        final_obj['moment_images'] = ctx.request.body.moment_images||[] 

      }else if( type ==2){
        final_obj['video_src'] = ctx.request.body.video_src ||''
        final_obj['video_content'] = ctx.request.body.video_content ||''
      }else{
        final_obj['common_content'] = ctx.request.body.common_content ||[] 
      } 

      const result = await ctx.model.Article.create(final_obj);
      ctx.api_success_data(result);
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
      const id = ctx.request.body.id;
      const { name, age } = ctx.request.body;
      const update=  { name,age }
      const result = await ctx.model.Article.findByIdAndUpdate(id,update) ;
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
      const result = await ctx.model.Article.findByIdAndDelete(id);
      ctx.api_success_data(result);
   
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
}
module.exports = ArticleController;

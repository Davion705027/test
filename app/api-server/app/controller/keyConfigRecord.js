/*
 * @Date           : 2022-03-11 10:59:48
 * @FilePath: /client-api-doc-server/app/controller/keyConfigRecord.js
 * @Description    :  客户端对接文档内   商户配置    
 */
"use strict";
const Controller = require("egg").Controller;
class KeyConfigRecordController extends Controller {
  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;

    try {
       
      let {
        currentPage,
        pageSize ,
        key,
        keyid,
        key_type,
        project,
        operator,
        version,
        create_time_from,
        create_time_to,
      } = ctx.query;
      let query={}

      project?(query['project']=Number(project) ):"";
      key_type?(query['key_type']=Number(key_type) ):"";
      keyid?(query['keyid']= keyid ):"";
      version?(query['version']=version ):"";
      
      operator?(query['operator']={ $regex: operator, $options: "i", }):"";
      key?(query['key']= { $regex: key, $options: "i", }):"";

        if (create_time_from && create_time_to) {
        query.createdAt = {
          $gte: new Date(create_time_from).getTime(),
          $lt: new Date(create_time_to).getTime(),
        };
      }

      console.log(query);

       if(ctx.is_client_request(ctx)){
        await this.service.jwt.add_operator(query)
       }

      const options = {
        page: ctx.toInt( currentPage),
        limit: ctx.toInt( pageSize),
        sort: { updatedAt: -1 },
      };
      // await ctx.sleep(6000);
      const result = await ctx.model.KeyConfigRecord.paginate(query, options);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg( JSON.stringify(error) );
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
      const result = await ctx.model.KeyConfigRecord.findById(id, {
        password: -1,
      }).exec();
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   * 创建或者更新数据通用内部方法
   * @returns
   */
  async compute_final_obj_when_create_or_update(htype) {
    const ctx = this.ctx;
    let { id, keyid, key,  project, key_type, mark,  version,value  } =
      ctx.request.body;
 
      
 
    let final_obj = { id, keyid, key, project, key_type, mark, version,value     };
    await this.service.jwt.add_operator(final_obj)
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

      const result = await ctx.model.KeyConfigRecord.create(final_obj);
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
      let final_obj = await this.compute_final_obj_when_create_or_update('update');
      let id = final_obj.id;
      delete final_obj.id;
      const result = await ctx.model.KeyConfigRecord.findByIdAndUpdate(
        id,
        final_obj
      );
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
      const result = await ctx.model.KeyConfigRecord.findByIdAndDelete(id);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }

 /**
  * 商户设置单条数据 记录
  */
  async saveRecord(){

    const ctx = this.ctx;
    try {
      let { id   } =
      ctx.request.body;

      if(id){
        await this.update()
      }else{
        await this.create()
      }
 
    } catch (error) {
      ctx.api_error_msg(error);
    }



  }


 /**
  * 商户 设置 记录
  */
 async findRecord(){

  const ctx = this.ctx;
  try {
    let { version ,project   } =
    ctx.request.query;
    if(!version|| !project){
      ctx.api_error_msg( 'version ,project  必须指定'); 
    }else{

      await  this.index()
    }

  

  } catch (error) {
    ctx.api_error_msg( JSON.stringify(error) );
  }

 }
  /**
     * 刷新图片地址  剔除域名
     * @returns
     */
  async flushImgUrl() {
    const ctx = this.ctx;
    try {

      const result = await ctx.model.KeyConfigRecord.find( { value: /^http/i } ).exec()
      for (let i = 0; i < result.length; i++) {
        const item = JSON.parse(JSON.stringify(result[i]));
        item.value = item.value.replace(/.+(\/public.+)$/, '$1');
        await ctx.model.KeyConfigRecord.findByIdAndUpdate(item.id, item);
      }
      
      const count = result.length
      const message = count ? `共计刷新${count}条数据` : '暂无可刷新数据'
      ctx.api_success_data({
        message,
        count
      });
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }



}
module.exports = KeyConfigRecordController;

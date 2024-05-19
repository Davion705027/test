/*
 * @Date           : 2022-03-11 10:59:48
 * @FilePath: /client-api-doc-server/app/controller/imgDescription.js
 * @Description    :
 */
"use strict";
const Controller = require("egg").Controller;
class ImgDescriptionController extends Controller {
  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;

    try {
      let query = {};
      let { name } = ctx.query;
      if (name) {
        query = {
          name: {
            $regex: name,
            $options: "i",
          },
        };
      }
      const options = {
        page: ctx.toInt(ctx.query.currentPage),
        limit: ctx.toInt(ctx.query.pageSize),
        sort: { updatedAt: -1 },
      };
      // await ctx.sleep(6000);
      const result = await ctx.model.ImgDescription.paginate(query, options);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }

  /**
   * 通过 Keyid 查找
   */
  async findListByKey() {
    const ctx = this.ctx;
    try {
      let query = {};
      let { keyid = '',project='',key_type='' } = ctx.query;
      keyid && (query.keyid = keyid);
      project && (query.project = project);
      key_type && (query.key_type = key_type);
      const result = await ctx.model.ImgDescription.find(
        query,
        null,
        { sort: { order: 1 } }
      );
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
      const result = await ctx.model.ImgDescription.findById(id, {
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
  async compute_final_obj_when_create_or_update() {
    const ctx = this.ctx;
    let {
      id,
      titles,
      path,
      project,
      key_type,
      keyid,
      descriptions,
      order,
      status,
      mark,
    } = ctx.request.body;
    let final_obj = {
      id,
      titles,
      path,
      project,
      key_type,
      keyid,
      descriptions,
      order,
      status,
      mark,
    };
    // 更新相应model的图片描述所需要的对象
    let other_obj = {
      project,
      key_type,
      keyid,
    }
   
    // 修改的时候 下列字段不动
    if(id){
       delete final_obj.keyid
       delete final_obj.key_type
       delete final_obj.project
    }

     
    await this.service.jwt.add_operator(final_obj);
    ctx.remove_false_key(final_obj);

    Object.assign(other_obj,final_obj);
    return {final_obj,other_obj};
  }
  /**
   * 创建  一条数据
   * @returns
   */
  async create() {
    const ctx = this.ctx;
    try {
      let final_obj =  await this.compute_final_obj_when_create_or_update('create');

      const result = await ctx.model.ImgDescription.create(final_obj);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   * 添加/更新编辑图片描述信息
   */
  async updateImgDescs() {
    const ctx = this.ctx;
    try {

      let {final_obj,other_obj} = await this.compute_final_obj_when_create_or_update();

      let result = null
      if (final_obj.id) {
        result = await ctx.model.ImgDescription.findByIdAndUpdate(final_obj.id, final_obj);
      } else {
        result = await ctx.model.ImgDescription.create(final_obj);
      }


      await ctx.service.imgDescription.update_model(other_obj)
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
      let final_obj = await  this.compute_final_obj_when_create_or_update('update');
      let id = final_obj.id;
      delete final_obj.id;
      const new_obj = await ctx.model.ImgDescription.findById(id, {
        password: -1,
      }).exec();

      ctx.api_success_data(new_obj);
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
      const result = await ctx.model.ImgDescription.findByIdAndDelete(id);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   * 刷新图片描述统计
   */
  async  flush_imgdesc(){
    const ctx = this.ctx;
    try {
      
     await ctx.service.imgDescription.flush_imgdesc();
      ctx.api_success_data( 'ok');
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   *  客户端 查询 图片描述 配置
   */
  async  findImgDescList(){
    const ctx = this.ctx;
    try {
      
      //  const result = await ctx.service.imgDescription.findImgDescList();
      let { project, key_type } = ctx.request.body;
      let query = {};
      project && (query.project = project);
      key_type && (query.key_type = key_type);
      const result = await ctx.model.ImgDescription.find(query, null, {
        sort: { order: 1 },
      });
      console.log(result)
      ctx.api_success_data( result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }



 

}
module.exports = ImgDescriptionController;

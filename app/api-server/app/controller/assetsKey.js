/*
 * @Date           : 2022-03-11 10:59:48
 * @FilePath: /client-api-doc-server/app/controller/assetsKey.js
 * @Description    :
 */
"use strict";
const Controller = require("egg").Controller;
class AssetsKeyController extends Controller {
  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;

    try {
      const { currentPage, pageSize, id, exact_query = false, no_upload_image = false } = ctx.query;
      const query = id
        ? { _id: id }
        : ['key', 'group_id', 'project', 'status',   'operator'].reduce((o, k) => {
          if (ctx.query[k]) {
            o[k] = ['group_id', 'project', 'status'].includes(k)
              ? ctx.query[k]
              : { $regex: ctx.query[k], $options: "i" }
          }
          return o
        }, {})

      if (query.key && exact_query) query.key = ctx.query.key

      // 添加查询条件：图片描述中未上传图片
      if (no_upload_image) {
        query.imgdesc=null
      }

      const result = await ctx.model.AssetsKey.paginate(query, {
        page: ctx.toInt(currentPage),
        limit: ctx.toInt(pageSize),
        sort: { updatedAt: -1 },
      })
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
      const result = await ctx.model.AssetsKey.findById(id).exec();
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
      key,
      group,
      group_id,
      project,
      level,
      root,
      descriptions,
      status,
      mark,
     value,
    } = ctx.request.body;


  

    let final_obj = {
      id,
      key,
      group,
      group_id,
      project,
      level,
      root: parseInt(root) || -1,
      descriptions,
      status,
      mark,
     value,
       
    };
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
      let final_obj = await this.compute_final_obj_when_create_or_update();

      const result = await ctx.model.AssetsKey.create(final_obj);
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
      let final_obj = await this.compute_final_obj_when_create_or_update();
      let id = final_obj.id;
      delete final_obj.id;
      const old_obj = await ctx.model.AssetsKey.findByIdAndUpdate(id, final_obj);
      const new_obj = await ctx.model.AssetsKey.findById(id).exec();
      await this.service.keyChangeRecord.key_change({
        old_obj:  old_obj.toJSON(), 
        new_obj:new_obj.toJSON(), 
        key_type:ctx.assistant.key_type.assets
      });
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
      const result = await ctx.model.AssetsKey.findByIdAndDelete(id);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   * 刷新图片地址  剔除域名
   * @returns
   */
  async flushImgUrl() {
    const ctx = this.ctx;
    try {

      const result = await ctx.model.AssetsKey.find( { value: /^http/i } ).exec()
      for (let i = 0; i < result.length; i++) {
        const item = JSON.parse(JSON.stringify(result[i]));
        item.value = item.value.replace(/.+(\/public.+)$/, '$1');
        await ctx.model.AssetsKey.findByIdAndUpdate(item.id, item);
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
module.exports = AssetsKeyController;

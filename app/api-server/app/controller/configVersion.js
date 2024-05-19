/*
 * @Date           : 2022-03-11 10:59:48
 * @FilePath       : /client-api-doc-server/app/controller/doc.js
 * @Description    :
 */
"use strict";
const Controller = require("egg").Controller;
const uuid = require("uuid").v1;

class ConfigVersionController extends Controller {
  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;
    try {
      let query = {};
      let { operator, version_group_ids } = ctx.query;
      if (operator) {
        query = {
          operator: {
            $regex: operator,
            $options: "i",
          },
        };
      }
      if (version_group_ids && version_group_ids.length > 0) {
        query.version_group_ids = {
          version_group_ids
        }
      }
      const options = {
        page: ctx.toInt(ctx.query.currentPage),
        limit: ctx.toInt(ctx.query.pageSize),
        sort: { updatedAt: -1 },
      };
      // await ctx.sleep(6000);
      // const aggregateQuery = ctx.model.ConfigVersion.aggregate(
      //   [(
      //     {
      //       $lookup: {
      //         from: "versiongroups",
      //         localField: "_id",
      //         foreignField: "version_ids",
      //         as: "version_group"
      //       }
      //     }
      //   )]
      // );

      const result = await ctx.model.ConfigVersion.paginate(query, options);
      result.docs.forEach(e => {
        e.id = e._id;
      });
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
      const result = await ctx.model.ConfigVersion.findById(id  ).exec();
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
    let { id, name, mark, version, status=1 ,targetProject ,themeRefer,version_group_ids,version_group_names } = ctx.request.body;
    let final_obj = {
      id,
      name,
      mark,
      version,
      targetProject,
       themeRefer,
      status,
      version_group_ids,
      version_group_names
    };
    await this.service.jwt.add_operator(final_obj);
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
  
     
      final_obj.status = 1;
      //生成uuid 文件名字
      let uid = uuid().replace(/-/gi, "");
      final_obj.version = uid;
      const result = await ctx.model.ConfigVersion.create(final_obj);
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
      const result = await ctx.model.ConfigVersion.findByIdAndUpdate(
        {_id: id},
        {$set: final_obj}
      );
      // return
      ctx.api_success_data(result);
      // return;
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
      const result = await ctx.model.ConfigVersion.findByIdAndDelete(id);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
 

  /**
   * 复制蓝本创建新版本号
   */
  async cloneVersion() {
    const ctx = this.ctx;
    try {
      const { clone_version } = ctx.request.body;
      /**
       * 创建新版本
       */
      let final_obj = await this.compute_final_obj_when_create_or_update();
      
  
      let uid = uuid().replace(/-/gi, "");
      final_obj.version = uid;
      const result = await ctx.model.ConfigVersion.create(final_obj);

      const newVersion = result._doc.version;

      await this.service.configVersion.cloneVersion({
        oldVersion :clone_version ,newVersion:newVersion
      })

   
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
/**
 * 客户端 查询当前用户的版本列表
 */
 async clientIndex() {
    const ctx = this.ctx;
    try {
      let query = {};
      // const token_info = await ctx.service.jwt.get_token_info()
      // let  operatorid = token_info['id']
      // if (operatorid) {
      //   query = {
      //     operatorid
      //   };
      // }else{
      //   ctx.api_error_msg('');
      // }
      let { version_group_ids } = ctx.query;
      if (version_group_ids && version_group_ids.length > 0) {
        query.version_group_ids = {
          $all: version_group_ids.split(",")
        }
      }
      const options = {
        page: ctx.toInt(ctx.query.currentPage ||1),
        limit: ctx.toInt(ctx.query.pageSize ||1000),
        sort: { updatedAt: -1 },
      };
      // await ctx.sleep(6000);
      const result = await ctx.model.ConfigVersion.paginate(query, options);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }


}
module.exports = ConfigVersionController;

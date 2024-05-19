"use strict";
const Controller = require("egg").Controller;
class UserController extends Controller {
  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;

    try {
      let query = {};
      let { name, group } = ctx.query;
      if (name) {
        query = {
          name: {
            $regex: name,
            $options: "i",
          },
        };
      }
      if (group) {
        query.group = group
      }
      const options = {
        page: ctx.toInt(ctx.query.currentPage),
        limit: ctx.toInt(ctx.query.pageSize),
        sort: { updatedAt: -1 },
      };

      // const aggregateQuery = ctx.model.ConfigVersion.aggregate(
      //   [(
      //     {
      //       $lookup: {
      //         from: "versiongroups",
      //         localField: "_id",
      //         foreignField: "user_ids",
      //         as: "version_group"
      //       }
      //     }
      //   )
      // ]
      // );
      // const result = await ctx.model.User.aggregatePaginate(aggregateQuery,query, options);
      const result = await ctx.model.User.paginate(query, options);
      result.docs.forEach(e => {
        e.id = e._id;
        let version_group_names_temp = [];
        e.version_group_names.forEach(i => {
          version_group_names_temp.push(i)
        })
        e.version_group_name = version_group_names_temp.join(",")
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
      const result = await ctx.model.User.findById(id, { password: -1 }).exec();
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   * 创建或者更新数据通用内部方法
   * @returns
   */
  compute_final_obj_when_create_or_update() {
    const ctx = this.ctx;
    let { id, name, password, mark, sdk, app, modulize, group, roleId, version_group_ids, version_group_names } = ctx.request.body;
    let final_obj = {
      id,
      name,
      password,
      mark,
      sdk,
      app,
      modulize,
      group,
      roleId,
      version_group_ids,
      version_group_names
    };
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
      let final_obj = this.compute_final_obj_when_create_or_update();

      const result = await ctx.model.User.create(final_obj);
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
      let final_obj = this.compute_final_obj_when_create_or_update();
      let id = final_obj.id;
      delete final_obj.id;
      const result = await ctx.model.User.findByIdAndUpdate(id, final_obj);
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
      const result = await ctx.model.User.findByIdAndDelete(id);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }

  /**
   * 登录  客户端登录
   *
   */
  async login() {
    const ctx = this.ctx;
    const app = this.app;
    try {
      const { name, password } = ctx.request.body;

      const result = await ctx.model.User.findOne({
        name,
        password,
      }).exec();

      console.log("登录  客户端登录");
      // return
      if (result) {
        //生成 token 的方式
        const token = await this.service.jwt.createToken(
          {
            id: result.id,
            is_user: true,
            name: result.name,
            roleId: result.roleId
          },
          app.config.jwt.secret
        );
        console.log("token---", token);

        ctx.api_success_data({
          id: result.id,
          token,
          roleId: result.roleId,
          version_group_ids:result.version_group_ids
        });
      } else {
        ctx.api_error_msg("用户不存在");
      }
    } catch (error) {
      console.log(error);
      ctx.api_error_msg(error);
    }
  }
}
module.exports = UserController;

/*
 * @Date           : 2022-04-06 15:17:14
 * @LastEditTime: 2023-10-22 14:54:05
 * @Description    :
 */
"use strict";

const Controller = require("egg").Controller;

class AdminController extends Controller {
  /**
   * 管理员登录
   */
  async login() {
    const { ctx } = this;

    try {
      const { name, password } = ctx.request.body;
      const result = await ctx.model.Admin.findOne({
        name: name,
        password: password,
      }).exec();
      if (result) {
        // console.log(result);
        //生成 token 的方式
        const token = await this.service.jwt.createToken({
          id: result.id,
          is_admin: true,
          name: result.name,
        });
        // 获取权限信息
        const role_res = await ctx.model.Role.findById(result.roleId).exec();
        ctx.api_success_data({token,name,roleId:result.roleId,menus:role_res?.menus});
      } else {
        ctx.api_error_msg("用户 不存在");
      }
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   * 管理员列表
   */
  async index(){
    const { ctx } = this;
    // const _id1 = new mongoose.Types.ObjectId('6534a4cf1a0bb2a79028dd7a');
    // const _id2 = new mongoose.Types.ObjectId('6534a4cf1a0bb2a79028dd7a');
    // console.log(_id1 === _id2) // false
    // console.log(ctx.model.Admin == ctx.app.mongoose.Collection('admin'));
    const query = {};
    let {name} = ctx.request.query;
    if (name) {
      query.name =  {
        $regex: name,
        $options: "i",
      }
    }
    const options = {
      page: ctx.toInt(ctx.query.currentPage) || 1,
      limit: ctx.toInt(ctx.query.pageSize) || 10,
      sort: { updatedAt: -1 },
    };
    try{
      const result = await ctx.model.Admin.paginate(query,options);
      // todo
      // .aggregate([{
      //   $lookup:{
      //     localField:'roleId',
      //     from:'role',
      //     foreignField:'id',
      //     as:'role'
      // }
      // }]).exec()
      // console.log(result);

      let docs = JSON.parse(JSON.stringify(result.docs)) || [];
      let final_data = [];
      for(let item of docs){
        const res = await ctx.model.Role.findById(item.roleId);
        if(res){
          item.roleName = res.name
          item.menus = res.menus;
        }
        final_data.push(item)
      }
      result.docs = final_data;
      ctx.api_success_data(result);
    } 
    catch(error){
      ctx.api_error_msg(error);
    }
  }
  /**
   *  新增管理员
   * @returns
   */
  async create() {
    const ctx = this.ctx;
    try {
      let final_obj = ctx.request.body;
      ctx.remove_false_key(final_obj);
      let result  = await ctx.model.Admin.create(final_obj);

      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   *  修改管理员
   * @returns
   */
  async update() {
    const ctx = this.ctx;
    try {
      let final_obj = ctx.request.body;
      ctx.remove_false_key(final_obj);
      let result  = await ctx.model.Admin.findByIdAndUpdate(final_obj.id, final_obj);

      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   * 删除  一条数据
   * @returns
   */
  async delete() {
    const ctx = this.ctx;
    try {
      const id = ctx.request.body.id;
      const result = await ctx.model.Admin.findByIdAndDelete(id);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
}

module.exports = AdminController;

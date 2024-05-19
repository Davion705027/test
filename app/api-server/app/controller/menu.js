/*
 * @Date           : 2022-03-11 10:59:48
 * @FilePath: \client-api-doc-server\app\controller\menu.js
 * @Description    :
 */
"use strict";
const Controller = require("egg").Controller;
class MenuController extends Controller {
  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;
    try {
      let query = {};
      
      const options = {
        page: 1,
        limit: 10000,
        sort: { order: 1, updatedAt: -1 },
        
      };
      // await ctx.sleep(6000);
      const result = await ctx.model.Menu.paginate(query, options);
      ctx.api_success_data(result);
    } catch (error) {
      console.log(error);
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
      const result = await ctx.model.Menu.findById(id).exec();
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
    let { id, names, fatherId, mark, status, type, order, related_doc, group } =
      ctx.request.body;
    let final_obj = {
      id,
      names,
      fatherId,
      mark,
      status,
      type,
      order: Number(order),
      related_doc,
      group
    };

    ctx.remove_false_key(final_obj);
    // console.log("final_obj--",final_obj);

    return final_obj;
  }
  /**
   * 创建或者更新 内部方法
   *
   */
  async create_or_update_inner_function_update_father(final_obj) {
    console.log("final_obj--", final_obj);
    const ctx = this.ctx;
    const resultfather = await ctx.model.Menu.findById(final_obj.fatherId).exec();
    let resultfather_children = resultfather.children || [];
    resultfather_children.push({ type: "menu", id: final_obj.id, show: false });
  }
  /**
   * 创建  一条数据
   * @returns
   */
  async create() {
    const ctx = this.ctx;
    try {
      let final_obj = this.compute_final_obj_when_create_or_update();
      const result = await ctx.model.Menu.create(final_obj);
      final_obj.id = result.id;

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
      //旧的父级ID
      // let old_father_obj = await  ctx.model.Menu.findById(id, final_obj)
      let final_obj = this.compute_final_obj_when_create_or_update();
      let id = final_obj.id;
      let options = {
        returnDocument: "after",
      };
      const result = await ctx.model.Menu.findByIdAndUpdate(id, final_obj);

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
      const resultdoc = await ctx.model.Menu.findById(id).exec();
      if (resultdoc.fatherId == -1) {
        ctx.api_error_msg("根节点不能更改");
      } else {
        const result = await ctx.model.Menu.findByIdAndDelete(id);
        ctx.api_success_data(result);
      }
    } catch (error) {
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
      const resultdoc = await ctx.model.Menu.findById(id).exec();
      if (resultdoc.fatherId == -1) {
        ctx.api_error_msg("根节点不能更改");
      } else {
        const update = { status: -2 };
        const result = await ctx.model.Menu.findByIdAndUpdate(id, update);
        ctx.api_success_data(result);
      }
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  async findAllMenus() {
    let query = {};
    if (this.ctx.is_client_request(this.ctx)) query["status"] = { $eq: 1 };
    const result = await this.ctx.model.Menu.find(query, "", {
      sort: { order: 1, updatedAt: -1, },
    }).exec();
    this.ctx.api_success_data(result);
  }
  /**
   * 查询  子节点
   * @returns
   */
  async find_children_deep() {
    const ctx = this.ctx;

    // console.log("ctx.is_client_request(ctx)----",ctx.is_client_request(ctx));
    try {
      const id = ctx.query.id;
      const deep = ctx.query.deep || false;

      let {group} = ctx.query;
      let query = { fatherId: id };
      if (group) {
        query.group = group
      }

      if (ctx.is_client_request(ctx)) {
        query["status"] = { $eq: 1 };
      }
      let options = {
        sort: {
          order: 1,
          updatedAt: -1,
        },
      };
      let result = await ctx.model.Menu.find(query, "", options).exec();

      //如果递归 文件夹
      if (deep && id != -1) {
        let arr = [];

        for (let i = 0; i < result.length; i++) {
          let obj = await this.find_children_deep_inner(result[i]);
          arr.push(obj);
        }

        console.log( 'arr---------',arr);
        ctx.api_success_data(arr);
      } else {
        ctx.api_success_data(result);
      }
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   * 内部递归方法
   * @param {*} params
   * @param {*} obj
   * @returns
   */
  async find_children_deep_inner(fatherobj) {
    // console.log('内部递归方法');
    const ctx = this.ctx;

    if (fatherobj.type == 1 && fatherobj.id != -1) {
      fatherobj["children"] = [];
      let query = { fatherId: fatherobj.id };

      if (ctx.is_client_request(ctx)) {
        //  console.log(1);
        query["status"] = { $eq: 1 };
      }
      let options = {
        sort: {
          order: 1,
          updatedAt: -1,
        },
      };
      let result = await ctx.model.Menu.find(query, "", options).exec();
      let arr = [];

      for (let i = 0; i < result.length; i++) {
        let obj = await this.find_children_deep_inner(result[i]);
        arr.push(obj);
      }

      // console.log( 'fatherobj[children]-------',arr);
      fatherobj["children"] = arr;

      // console.log( 'fatherobj--------',fatherobj);
      return {
        ...fatherobj.toJSON(),
        children: arr,
      };
    } else {
      return fatherobj;
    }
  }

  /**
   * 内部递归方法
   * @param {*} params
   * @param {*} obj
   * @returns
   */
  async find_children_flat_inner(fatherobj, alldoc) {
    // console.log('内部递归方法');
    const ctx = this.ctx;

    if (fatherobj.type == 1 && fatherobj.id != -1) {
      alldoc = [];
      let query = { fatherId: fatherobj.id };
      if (ctx.is_client_request(ctx)) {
        query["status"] = { $eq: 1 };
      }
      let options = {
        sort: {
          type: -1,
        },
      };
      let result = await ctx.model.Menu.find(query, "", options).exec();
      let arr = [];

      for (let i = 0; i < result.length; i++) {
        await this.find_children_flat_inner(result[i], alldoc);
      }
    } else {
      alldoc.push(fatherobj);
    }
  }

  /**
   * 查询某一个菜单ID 下所有文件名字
   *
   */

  async find_children_flat() {
    const ctx = this.ctx;
    try {
      const id = ctx.query.id;
      const name = ctx.query.name;

      let query = { fatherId: id };
      if (ctx.is_client_request(ctx)) {
        query["status"] = { $eq: 1 };
      }
      let options = {
        sort: {
          type: -1,
        },
      };
      let alldoc = [];
      let result = await ctx.model.Menu.find(query, "", options).exec();

      //如果递归 文件夹
      if (id != -1) {
        for (let i = 0; i < result.length; i++) {
          await this.find_children_flat_inner(result[i], alldoc);
        }
      } else {
        alldoc = result.filter(x => x.type == 2);
      }

      if (name) {
        alldoc = alldoc.filter(x => (  Object.values(x.names ||{}).join(",")   ).includes(name));
      }

      ctx.api_success_data(alldoc);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
}
module.exports = MenuController;

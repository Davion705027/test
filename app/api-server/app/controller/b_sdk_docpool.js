/*
 * @Date           : 2022-03-11 10:59:48
 * @FilePath: \client-api-doc-server\app\controller\docpool.js
 * @Description    :
 */
"use strict";
const Controller = require("egg").Controller;
class BSDKDocpoolController extends Controller {
  async searchDoc() {
    try{
    const { keyword } = this.ctx.query
    const search = { $regex: RegExp(keyword), $options: 'i' }
    const result = await this.ctx.model.BSdkDocpool.paginate(
      { $or: [{name_zh: search}, {name_en: search}, {url: search}] }, 
      { sort: { updatedAt: -1 } }
    );
      this.ctx.api_success_data(result);
    } catch (error) {
      this.ctx.api_error_msg(error);
    }
  }
 /**
  *  查询  全部数据
  */
  async index(){

    const ctx = this.ctx;

    try {
      let { name, url, currentPage,pageSize,id,type } = ctx.query;
      let query = {
        type,
        $or: [
          name ? { name_zh: { $regex: new RegExp(name), $options: "i" } } : {},
          name ? { name_en: { $regex: new RegExp(name), $options: "i" } } : {},
        ],
        $and: [
          url
            ? {
                url: {
                  $regex: url,
                  $options: "i",
                },
              }
            : {},
        ],
      };
  
  


      let options = {
        page: ctx.toInt( currentPage),
        limit: ctx.toInt( pageSize),
        sort: {   updatedAt: -1 },
     
      };

      if(id){
        query={
          "_id":{
            $eq :id
          }
        }
        options = {
          page: ctx.toInt( 1),
          limit: ctx.toInt( pageSize),
          sort: {   updatedAt: -1 },
       
        };

    
      }


      // await ctx.sleep(6000);
      let result = await ctx.model.BSdkDocpool.paginate(query, options);

    
      ctx.api_success_data(result);
   
    } catch (error) {
    
      ctx.api_error_msg(error);
      
    }


  }
  /**
   * 查询  全部数据
   * @returns
   */
  async index2() {
    const ctx = this.ctx;
    try {
      let query = {};
      let { name, url, nameandurl } = ctx.query;
      if (nameandurl) {
        query = {
          $or: [
            nameandurl ? { name_zh: { $regex: new RegExp(nameandurl), $options: "i" } } : {},
            nameandurl ? { name_en: { $regex: new RegExp(nameandurl), $options: "i" } } : {},
            nameandurl ? { url: { $regex: new RegExp(nameandurl), $options: "i" } } : {},
          ],
          $and: [
            {
              status: true,
            },
          ],
        };
      } else {
        query = {
          $or: [
            name ? { name_zh: { $regex: new RegExp(name), $options: "i" } } : {},
            name ? { name_en: { $regex: new RegExp(name), $options: "i" } } : {},
          ],
          $and: [
            url
              ? {
                  url: {
                    $regex: url,
                    $options: "i",
                  },
                }
              : {},
          ],
        };
      }
      const options = {
        page: ctx.toInt(ctx.query.currentPage),
        limit: ctx.toInt(ctx.query.pageSize),
        sort: {   updatedAt: -1 },
     
      };
      // await ctx.sleep(6000);
      let result = await ctx.model.BSdkDocpool.paginate(query, options);
      if (nameandurl && result.total != 0) {
        let doc = [];
        //对外-组装
        for (let i = 0; i < result.docs.length; i++) {
          let menu_list = await ctx.model.Menu.find({
            related_doc: result.docs[i].id,
            status: true,
          }).exec();
          let menu;
          let father_menu;
          let parent_menu;
          for (let index = 0; index < menu_list.length; index++) {
            const element = menu_list[index];
            let element_menu = await ctx.model.Menu.findById(element.fatherId).exec();
            if (element_menu.status == 1) {
              if (element_menu.fatherId != -1) {
                let element_father_menu = await ctx.model.Menu.findById(
                  element_menu.fatherId
                ).exec();
                if (element_father_menu.status == 1) {
                  menu = menu_list[index];
                }
              } else {
                menu = menu_list[index];
              }
            }
          }
          father_menu = menu;
          if (menu && menu.fatherId != -1) {
            let menu_1 = await ctx.model.Menu.findById(menu.fatherId).exec();
            father_menu = menu_1;
            if (menu_1 && menu_1.fatherId != -1) {
              let menu_2 = await ctx.model.Menu.findById(menu_1.fatherId).exec();
              father_menu = menu_2;
              if (menu_2 && menu_2.fatherId != -1) {
                let menu_3 = await ctx.model.Menu.findById(menu_2.fatherId).exec();
                father_menu = menu_3;
                if (menu_3 && menu_3.fatherId != -1) {
                  let menu_4 = await ctx.model.Menu.findById(menu_3.fatherId).exec();
                  father_menu = menu_4;
                  if (menu_4 && menu_4.fatherId != -1) {
                  } else if (menu_4.fatherId == -1) {
                    father_menu = menu_3;
                    parent_menu = menu_4;
                  }
                } else if (menu_3.fatherId == -1) {
                  father_menu = menu_2;
                  parent_menu = menu_3;
                }
              } else if (menu_2.fatherId == -1) {
                father_menu = menu_1;
                parent_menu = menu_2;
              }
            } else if (menu_1.fatherId == -1) {
              father_menu = menu;
              parent_menu = menu_1;
            }
          }
          let {
            use_md,
            status,
            related_faq,
            _id,
            name_zh,
            name_en,
            createdAt,
            updatedAt,
            url,
            topic,
            mulit_language
          } = result.docs[i];
          let item = {
            use_md,
            status,
            related_faq,
            _id,
            name_zh,
            name_en,
            createdAt,
            updatedAt,
            url,
            menu,
            father_menu,
            parent_menu,
            topic,
            mulit_language
          };
          if (father_menu) {
            doc.push(item);
          }
        }
        result.docs = doc;
        result.total = doc.length;
        ctx.api_success_data(result);
      } else {
        ctx.api_success_data(result);
      }
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
      const result = await ctx.model.BSdkDocpool.findById(id).exec();
      if (ctx.is_client_request(ctx)) {
        if (result && result.status != 1) {
          return ctx.api_error_msg("已下架");
        } else {

        }
      }else{


      }

      //


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
      name_zh,
      name_en,
      
      sdk_version,
      sdk_environment,
      sdk_type,
      sdk_internal_external,
      sdk_file_url,
      sdk_file_name,
      sdk_file_size,

      status,
      use_md =true,
      topic,
      related_faq,
      mulit_language,
      mark,
      type,
    } = ctx.request.body;
    let final_obj = {
      id,
      name_zh,
      name_en,

      sdk_version,
      sdk_environment,
      sdk_type,
      sdk_internal_external,
      sdk_file_url,
      sdk_file_name,
      sdk_file_size,

      status,
      use_md: !!use_md,
      topic,
      related_faq,
      mulit_language,
      mark,
      type,
      update_by: ctx.token_info.name
    };
    if (!id) {
      final_obj.create_by = ctx.token_info.name
    }
    ctx.remove_false_key(final_obj, ["use_md"]);
    final_obj.status = final_obj.status || 1
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
      const result = await ctx.model.BSdkDocpool.create(final_obj);
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
      const result = await ctx.model.BSdkDocpool.findByIdAndUpdate(id, final_obj);
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
      const result = await ctx.model.BSdkDocpool.findByIdAndDelete(id);
      ctx.api_success_data(result);
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
      const update = { status: -2 };
      const result = await ctx.model.BSdkDocpool.findByIdAndUpdate(id, update);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
}
module.exports = BSDKDocpoolController;

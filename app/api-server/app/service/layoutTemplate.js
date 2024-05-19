"use strict";
const Service = require("egg").Service;
class LayoutTemplateService extends Service {
  /**
   * 镜像 imgDescription
   */
  async mirror_imgDescription(params) {
    const { ctx } = this;
    const { mirror, target } = params;
    const mirror_arr = await ctx.model.ImgDescription.find({ ...mirror });
    let len = mirror_arr.length;
    for (let i = 0; i < len; i++) {
      let mirror_item = mirror_arr[i].toJSON();
      let target_obj = {
        ...mirror_item,
        ...target,
      };
      delete target_obj._id;
      delete target_obj.id;
      const is_exit = await ctx.model.ImgDescription.exists({
        keyid: target_obj.keyid,
        project: target_obj.project,
      });
      if (!is_exit) {
        await ctx.model.ImgDescription.create(target_obj);
      }else{
        // console.log('存在');
      }
    }
  }
  /**
   * 镜像  通过  key_type 镜像
   */
  async mirror_by_key_type(params, key_type) {
    // // console.log('mirror_by_key_type---------------', params, key_type);
    const { ctx } = this;
    const { mirror, target } = params;
    let model_name =
      this.ctx.assistant.key_type_val_to_model_map[`key_${key_type}`];
    const mirror_arr = await ctx.model[model_name].find({ ...mirror });
    let len = mirror_arr.length;
    for (let i = 0; i < len; i++) {
      let mirror_item = mirror_arr[i].toJSON();
      let target_obj = {
        ...mirror_item,
        ...target,
      };
      delete target_obj._id;
      delete target_obj.id;
      const is_exit = await ctx.model[model_name].exists({
        key: target_obj.key,
        project: target_obj.project,
      });
      if (!is_exit) {
        const target_item = await ctx.model[model_name].create(target_obj);
        //镜像参数
        let mirror_param = {
          mirror: {
            keyid: mirror_item.id,
            key_type,
            project: mirror_item.project,
          },
          target: {
            keyid: target_item._id,
            key_type,
            project: target_item.project,
          },
        };
        //镜像 imgDescription
        await ctx.service.layoutTemplate.mirror_imgDescription(mirror_param);
      }else{
        // // console.log('存在');
      }
    }
  }
  /**
   * 镜像 i18n
   */
  async mirror_i18n(params) {
    // console.log('mirror_i18n--------------------');
    const { ctx } = this;
    const { target, mirror } = params;
    const key_type = 6;
    //镜像参数
    let mirror_param = {
      mirror: {
        project: mirror,
      },
      target: {
        project: target,
      },
    };
    await ctx.service.layoutTemplate.mirror_by_key_type(mirror_param, key_type);
  }
  /**
   * 镜像 group
   * @param {*} params
   */
  async mirror_group(params) {
    // console.log('mirror_group--------------------');
    const { ctx } = this;
    const { target, mirror } = params;
    const mirror_arr = await ctx.model.KeyGroup.find({ project: mirror });
    let len = mirror_arr.length;
    for (let i = 0; i < len; i++) {
      let mirror_item = mirror_arr[i].toJSON();
      let target_obj = {
        ...mirror_item,
        project: target,
      };
      delete target_obj._id;
      delete target_obj.id;

      
      const target_item = await ctx.model.KeyGroup.create(target_obj);


      const { key_type } = mirror_item;
      //镜像参数
      let mirror_param = {
        mirror: {
          group_id: mirror_item.id,
          group: mirror_item.key,
          project: mirror_item.project,
        },
        target: {
          group_id: target_item._id,
          group: target_item.key,
          project: target_item.project,
        },
      };
      //镜像 带分组 信息的 ：css js assets
      await ctx.service.layoutTemplate.mirror_by_key_type(
        mirror_param,
        key_type
      );
    }
  }
  /**
   * 镜像 布局
   * @param {*} params
   */
  async mirror_layout(params) {
    const { ctx } = this;
    const { target, mirror } = params;
    //镜像 需要分组的
    //镜像 group
    await ctx.service.layoutTemplate.mirror_group(params);
    // 镜像 不需要分组的
    //镜像 i18n
    await ctx.service.layoutTemplate.mirror_i18n(params);
   
  }
}
module.exports = LayoutTemplateService;

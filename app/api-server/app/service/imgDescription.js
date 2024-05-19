"use strict";
const Service = require("egg").Service;
class ImgDescriptionService extends Service {
  async update_model(imgDescription_Obj) {
    const ctx = this.ctx;
    let { key_type, keyid, operator, operatorid } = imgDescription_Obj;
    let id = keyid;
    //所有这个 ID 相关的 图片描述
    let all_imgdesc = await ctx.model.ImgDescription.find({
      keyid,
    });
    let statistics = {
      total: 0,
      status_f1: 0,
      status_1: 0,
      status_f2: 0,
    };
    all_imgdesc.map((x) => {
      statistics.total = statistics.total + 1;
      if (x.status == -1) {
        statistics.status_f1 = statistics.status_f1 + 1;
      } else if (x.status == 1) {
        statistics.status_1 = statistics.status_1 + 1;
      } else {
        statistics.status_f2 = statistics.status_f2 + 1;
      }
    });
   if( !statistics.total){
    statistics =null
   }

    let model_name = ctx.assistant.key_type_val_to_model_map[`key_${key_type}`];
    await ctx.model[model_name].findByIdAndUpdate(keyid, {
      operator,
      operatorid,
      imgdesc: statistics,
    });
  }
  /**
   * 刷新图片描述统计
   */
  async flush_imgdesc() {
    const ctx = this.ctx;
    const { key_type } = ctx.request.body;
    let model_name =
      this.ctx.assistant.key_type_val_to_model_map[`key_${key_type}`];
    await ctx.model[model_name].updateMany(
      { imgdesc: { $ne: null } },
      { $set: { imgdesc: null } }
    );
    const imgdescList = await ctx.model.ImgDescription.find({ key_type });
    const mapper = imgdescList.reduce((o, v) => {
      if (!o[v.keyid]) {
        o[v.keyid] = { total: 0, status_f1: 0, status_1: 0, status_f2: 0 };
      }
      o[v.keyid].total++;
      if (v.status === -1) o[v.keyid].status_f1++;
      if (v.status === 1) o[v.keyid].status_1++;
      if (v.status === -2) o[v.keyid].status_f2++;
      return o;
    }, {});
    for (const keyid in mapper) {
      await ctx.model[model_name].findByIdAndUpdate(keyid, {
        imgdesc: mapper[keyid],
      });
    }
  }
  /**
   *  查询 普片描述 配置
   */
  async findImgDescList() {
    const ctx = this.ctx;
    let { project, key_type, keyids } = ctx.request.body;
    let model_name = ctx.assistant.key_type_val_to_model_map[`key_${key_type}`];
    let keyids_arr = [];
    let imgDescList = [];
    let query = {};
    if (keyids) {
      keyids_arr = keyids;
      query = { status: 1, key_type, project };
    } else {
      const result_List = await ctx.model[model_name].find({
        project,
        status: 1,
      });
      keyids_arr = result_List.map((v) => v.id);
      query = { status: 1, key_type, project, keyid: { $in: keyids_arr } };
    }
    imgDescList = await ctx.model.ImgDescription.find(query, null, {
      sort: { order: 1 },
    });
    return imgDescList;
  }
}
module.exports = ImgDescriptionService;

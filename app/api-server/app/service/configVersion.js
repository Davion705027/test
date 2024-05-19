"use strict";
const Service = require("egg").Service;
class ConfigVersionService extends Service {
  /**
   * 查询  全部数据
   * @returns
   */
  async cloneVersion(params) {
    const ctx = this.ctx;
    const { oldVersion, newVersion } = params;
    // css:1, js:2, layout:3, component:4, theme:5, i18n:6, assets:7
    const token_info = await ctx.service.jwt.get_token_info();
    //操作人
    let operator = token_info["name"];
    //操作人ID
    let operatorid = token_info["id"];
    // css js
    let arr = [1, 2, 4, 6, 7];
    for (let i = 0; i < arr.length; i++) {
      let model_name =
        ctx.assistant.key_type_val_to_model_map[`key_${key_type}`];
      const Record = await ctx.model.KeyConfigRecord.find({
        version: oldVersion,
        key_type: arr[i],
      });
      let new_Record = [];
      Record.map((x) => {
        new_Record.push({
          keyid: x.keyid,
          key: x.key,
          project: x.project,
          mark: x.mark,
          value: x.value,
          version: newVersion,
          operator,
          operatorid,
        });
      });
      await ctx.model[model_name].insertMany(new_Record);
    }
  }
}
module.exports = ConfigVersionService;

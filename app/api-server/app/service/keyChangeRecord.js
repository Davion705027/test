"use strict";
const Service = require("egg").Service;
class KeyChangeRecordService extends Service {
 
  /**
   * 计算 差异对象
   */
  async compute_diff_obj(params) { 
    let {old_obj, new_obj, key_type} =params
    let diff_obj = {};
    let keys = [...Object.keys(old_obj), ...Object.keys(new_obj)];
    keys = Array.from(new Set(keys));
    let len = keys.length;
    let changed_keys = [];
    for (let i = 0; i < len; i++) {
      let key = keys[i];
      let no_need = ['id','updatedAt'].includes(key)
      let need =['value','status','custom'].includes(key)
      let diff=false
     if(need){
      let old_ = JSON.stringify(old_obj[key])
      let new_ = JSON.stringify(new_obj[key])

      diff = ( old_||new_) && ( old_ != new_)
     }
      
      if (diff) {
        diff_obj[key] = {
          old: old_obj[key],
          new: new_obj[key],
        };
        changed_keys.push(key);
      }
    }
    return {
      diff_obj,
      changed_keys,
      changed: changed_keys.length > 0,
    };
  }
  /**
   *  key 变更真正发放
   * @param {*} old_obj
   * @param {*} new_obj
   * @param {*} key_type
   */
  async key_change(params) {

    let {old_obj, new_obj, key_type} =params
    let { diff_obj, changed_keys, changed } =
      await this.service.keyChangeRecord.compute_diff_obj(params);

      console.log('计算 差异对象--------diff_obj---',diff_obj);
    if (!changed) {
      return "";
    }

 
 
    let final_obj = {
      //  配置 键ID
      keyid: old_obj.id,
      //  键名
      key: old_obj.key,
      //布局  
      project: old_obj.project,
      // key 类型 ctx.assistant.key_type
      key_type,
      //更改内容的 JSON字符串化   
      change: JSON.stringify(diff_obj),
    
    };
    await this.service.jwt.add_operator(final_obj)
    const result = await this.app.model.KeyChangeRecord.create(final_obj);
    return result;
  }
}
module.exports = KeyChangeRecordService;

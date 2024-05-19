/**
 * 客户端 CSS 属性 可配置表
 */
var mongoosePaginate = require("mongoose-paginate");

module.exports = (app) => {
  const mongoose = app.mongoose;
  const Schema = mongoose.Schema;
  const schema_instance = new Schema(
    {
        // 版号
        version: String,
        // 类型,  MODULE_SETTING_CACHE_PC (pc)   MODULE_SETTING_CACHE_PC_JS (pc-js)  MODULE_SETTING_CACHE_H5 (h5)  MODULE_SETTING_CACHE_H5_JS (h5-js)
        type: String,
        // 点保存的时候的数据, 这里因为 css 和 js 里面的字段不一样, 就不用多字段了, 直接给一个字符串存完
        jsonString: String,
        // 当前使用的版本
        used: { type: Boolean, default: false },
        // 用户关联字段
        username: String,
    },
    {
      timestamps: true,
    }
  );
  schema_instance.method("toJSON", function () {
    const { __v, _id, ...object } = this.toObject();
    object.id = _id;
    object.createdAt = Date.parse(object.createdAt);
    object.updatedAt = Date.parse(object.updatedAt);
    return object;
  });
  // 使用monmongoosePaginate分页插件    使用：Model.paginate([查询], [选项], [回调])
  schema_instance.plugin(mongoosePaginate);
  return mongoose.model("ModularSettingCache", schema_instance);
};

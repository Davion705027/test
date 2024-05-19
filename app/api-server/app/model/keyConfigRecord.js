/**
 * 客户端对接文档内   商户配置
 */
var mongoosePaginate = require("mongoose-paginate");
module.exports = (app) => {
  const mongoose = app.mongoose;
  const Schema = mongoose.Schema;
  const schema_instance = new Schema(
    {
      //  配置 键ID
      keyid: String,
      // 配置 键
      key: String,
      //布局
      project: {
        type: Number,
        require: true,
      }, 
      // key 类型 ctx.assistant.key_type
      key_type: {
        type: Number,
        require: true,
      },
      //备注
      mark: { type: String },

      //用户自定义版本号 ，一个UUID，商户自定义的一个版本号，输出的配置都走这个版本号可以新建
      version: String,
      //设置值
      value: Object,
      //操作人
      operator: String,
      //操作人ID
      operatorid: String,
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
  return mongoose.model("keyConfigRecord", schema_instance);
};

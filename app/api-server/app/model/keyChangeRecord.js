/**
 *  后台管理系统内   默认配置的 更改记录
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
      //更改内容的 JSON字符串化   
      change: String,
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

  return mongoose.model("KeyChangeRecord", schema_instance);
};

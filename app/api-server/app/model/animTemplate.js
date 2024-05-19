/**
 * 中间件接口表
 */
var mongoosePaginate = require("mongoose-paginate");
module.exports = (app) => {
  const mongoose = app.mongoose;
  const Schema = mongoose.Schema;
  const schema_instance = new Schema(
    {
      // 模板名称
      name: {
        type: String,
        required: [true, "模板名称不能为空"],
      },

      // 备注
      mark: {
        type: String,
      },

      // 创建人
      create_by: {
        type: String,
        required: [true, "创建人不能为空"],
      },

      // 更新人
      update_by: {
        type: String,
        required: [true, "更新人不能为空"],
      },
    },
    { timestamps: true }
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
  return mongoose.model("AnimTemplate", schema_instance);
};


/*
 * @Date           : 2022-04-08 18:50:10
 * @FilePath: /client-api-doc-server/app/model/key_group_collection.js
 * @Description    : 版本的分组
 */
var mongoosePaginate = require("mongoose-paginate");
module.exports = (app) => {
  const mongoose = app.mongoose;
  const Schema = mongoose.Schema;

  const version_group_schema = new Schema({
    version_group_name: { type: String, required: true },
    version_ids: { type: Array, default: [] }, // 
    user_ids: { type: Array, default: [] }, // 用户ID列表

  }, {
    timestamps: true,
  });

  version_group_schema.method("toJSON", function () {
    const { __v, _id, ...object } = this.toObject();
    object.id = _id;
    object.createdAt = Date.parse(object.createdAt);
    object.updatedAt = Date.parse(object.updatedAt);
    return object;
  });
  // 使用monmongoosePaginate分页插件    使用：Model.paginate([查询], [选项], [回调])
  version_group_schema.plugin(mongoosePaginate);
  return mongoose.model("VersionGroup", version_group_schema);
};

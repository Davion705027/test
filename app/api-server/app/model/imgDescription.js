/**
 * CSS 或者 JS 控制键 的 阐述图片
 */
var mongoosePaginate = require("mongoose-paginate");
module.exports = (app) => {
  const mongoose = app.mongoose;
  const Schema = mongoose.Schema;
  const schema_instance = new Schema(
    {
      //标题  多语言的
      titles: {},
      // 布局
      project: {
        type: Number,
        require: true,
      },
      //描述  多语言的
      descriptions: {},
      // 图片地址
      path: { type: String },
      //状态 -1 禁用  ， 1 启用 ，-2  已废弃
      status: { type: Number, default: -1 },
      // key 类型 ctx.assistant.key_type
      key_type: {
        type: Number,
        require: true,
      },
      //关联的 key    的  id
      keyid: String,
      // 排序 ，在单个关联key 内生效 ,排序越小越靠前
      order: Number,
      //备注
      mark: { type: String },
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
  schema_instance.plugin(mongoosePaginate);
  return mongoose.model("ImgDescription", schema_instance);
};

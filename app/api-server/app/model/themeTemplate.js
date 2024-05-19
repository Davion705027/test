/**
 * 客户端  主题   
 */


const mongoosePaginate = require("mongoose-paginate");

module.exports = (app) => {
  const mongoose = app.mongoose;
  const Schema = mongoose.Schema;
  const schema_instance = new Schema(
    {
      // 主题模板名称 国际化
      name: Object,
      //  布局类型
      project: { type: Number, required: true },
 
      //商户版本 
      version: { type: String, required: true },

      // 主题类型 值
      value: { type: String, required: true },
      //描述 多语言的
      descriptions: {},
      //状态
      status: {
        type: Number,
        // -1 禁用  ， 1 启用 ，-2  已废弃
        default: 1,
      },
      //图片描述 数量统计
      imgdesc: Object,
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

    ["createdAt", "updatedAt"].forEach((key) => {
      object[key] = Date.parse(object[key]);
    });
    return object;
  });
  // 使用monmongoosePaginate分页插件    使用：Model.paginate([查询], [选项], [回调])
  schema_instance.plugin(mongoosePaginate);
  return mongoose.model("ThemeTemplate", schema_instance);
};

 

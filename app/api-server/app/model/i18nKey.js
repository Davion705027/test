/**
 * 客户端 国际化   性 可配置表
 */
var mongoosePaginate = require("mongoose-paginate");
module.exports = (app) => {
  const mongoose = app.mongoose;
  const Schema = mongoose.Schema;
  const schema_instance = new Schema(
    {
      // assets变量 键名
      key: { type: String },
      // 布局
      project: {
        type: Number,
        require: true,
      },
      //描述 多语言的
      descriptions: {},
      // 是否开启可配置
      //状态
      status: {
        type: Number,
        // -1 禁用  ， 1 启用 ，-2  已废弃
        default: 1,
      },
      //图片描述 数量统计
      imgdesc: Object,
       //备注
       mark: String,
      //默认值
      value: Object,  
      // value:{
      //   'zh_cn':1
      // },
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
  return mongoose.model("I18nKey", schema_instance);
};

/*
 * @Date           : 2022-03-11 10:09:10
 * @FilePath: \client-api-doc-server\app\model\docpool.js
 * @Description    :  文档资源池
 */
var mongoosePaginate = require("mongoose-paginate");
module.exports = app => {
  const mongoose = app.mongoose;
  const Schema = mongoose.Schema;

  const schema_instance = new Schema(
    {
      //标题  中文
      name_zh: { type: String },
      //标题  英文
      name_en: { type: String },
      //url 当前文档 单独打开的链接地址
      url: { type: String },
      //内容  中文 
      content_zh: { type: String },
      //内容  英文
      content_en: { type: String },
      //使用 md 文档
      use_md: {
        type: Boolean,
        default: true,
      },
        //状态
        status: {
          type: Number,
          // -1 禁用  ， 1 启用 ，
          default: -1,
        },
      //相关 主题标签
      topic: { type: Array, default: [] },
      // 数据类型，faq为常见问题
      type: { type: String },
      //关联的问题 ,// 问题阐述是单独的 ，文档可以关联多个 问题 ，  文档和问题是交叉关联的
      faq: { type: Array, default: [] },
      //语言开关 // "多语言启用配置 json 字符串 { zh_cn: 1 ,zh_tw:-1 }   ",
      mulit_language:{},
      //备注 
      mark:{type:String}
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

  return mongoose.model("Docpool", schema_instance);
};

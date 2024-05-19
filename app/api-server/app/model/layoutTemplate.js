/*
 * @FilePath: /client-api-doc-server/app/model/layoutTemplate.js
 * @Description: 
 */
/**
 * 客户端  布局   
 */

const mongoosePaginate = require("mongoose-paginate");

module.exports = (app) => {
  const mongoose = app.mongoose;
  const Schema = mongoose.Schema;
  const schema_instance = new Schema(
    {
      // 布局模板名称
      name: { type: Object, required: true },
      // 布局类型 值
      value: { type: Number, required: true },
      // 布局对照客户端目录  
      folder: { type: String, required: true , unique: true},
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
      //镜像同步自其他布局 的布局 value 
      mirror:Number,
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
  return mongoose.model("LayoutTemplate", schema_instance);
};

 

/**
 *    DJ CP APP SDK 管理表
 */
var mongoosePaginate = require("mongoose-paginate");
module.exports = (app) => {
  const mongoose = app.mongoose;
  const Schema = mongoose.Schema;
  const schema_instance = new Schema(
    {
      //版本名字
      name: Object,
      //版本号
      version: String,
      // 状态 正式版本 /测试版本
      status: {
        type: Number,
        // -1 测试版本 对内  ， 1 正式版本对外 ，
        default: -1,
      },
      //类型
      type:{
        type: Number,
        // 1 APP 2 SDK 
        default:  1,
      },
      // 文件大小 MB
      size: Number,
      // 集成demo 大小
      demoSize: Number,
      // 环境
      env:String,
     
      //上传的源文件名
      filename:String,
      //上传的集成demo源文件名
      demoFilename:String,
      //apk  /sdk 地址 

      // 是否显示在对接文档上
      showWeb: {
        type: Number,
        default: 0
      },
      // 上传的SDK路径 
      path: String,
      // 集成demo的路径
      demoPath: String,
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
  // 使用monmongoosePaginate分页插件    使用：Model.paginate([查询], [选项], [回调])
  schema_instance.plugin(mongoosePaginate);
  return mongoose.model("AppSdkVersion", schema_instance);
};

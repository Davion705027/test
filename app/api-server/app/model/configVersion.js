
/**
 * 用户 模块化 配置 自定义版本号 表
 */
var mongoosePaginate = require("mongoose-paginate");
// const mongoosePaginate = require('mongoose-aggregate-paginate-v2');
module.exports = (app) => {
  const mongoose = app.mongoose;
  const Schema = mongoose.Schema;

  const schema_instance = new Schema(
    { 
       
     
       //版本名字 用户自定义的 版本名字
       name:String,
       //用户自定义版本号 ，一个UUID，商户自定义的一个版本号，输出的配置都走这个版本号可以新建
       version:String,
       //目标布局
       targetProject:Number,
       // 主题蓝本
       themeRefer: String,
       // 所属的版本组
       version_group_ids: {type: Array},
       version_group_names: {type: Array},
         //状态
       status: {
        type: Number,
        // -1 禁用  ， 1 启用 ， 
        default: -1,
       },
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

  return mongoose.model("ConfigVersion", schema_instance);
};

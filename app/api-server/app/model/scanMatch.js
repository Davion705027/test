
/*
 * @Date           : 2022-03-11 10:09:10
 * @FilePath: /client-api-doc-server/app/model/scanMatch.js
 * @Description    : scanMatch 模型
 */
var mongoosePaginate = require("mongoose-paginate");
module.exports = (app) => {
  const mongoose = app.mongoose;
  const Schema = mongoose.Schema;

  const schema_instance = new Schema({
    // 项目: 1 2 3 代表欧洲杯 世界杯 等 
    project: { type: String ,required:true }, 
    // uid: { type: String ,required:true }, 
    // 服务器地址 'public/upload/app...'
    url: { type: String ,required:true },
    // 素材名字  
    name: { type: String },
    // 素材原路径 'a/b/c.png'
    path: {   
      type: String,
    },
 
    // 来源 扫描 用户手动上传
    source:{
      type:Number,
       // 1 扫描  ，  2 用户手动上传 
      default: 1
    } ,
    //操作人
    operator: String,
    //操作人ID
    operatorid: String,
  }, {
      timestamps: true,
    })  ;
  schema_instance.method("toJSON", function () {
    const { __v, _id, ...object } = this.toObject();
    object.id = _id;
    object.createdAt = Date.parse(object.createdAt);
    object.updatedAt = Date.parse(object.updatedAt);
    return object;
  });
  schema_instance.plugin(mongoosePaginate);
  return mongoose.model("ScanMatch", schema_instance);
};
  
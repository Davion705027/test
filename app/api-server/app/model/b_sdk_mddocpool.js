/*
 * @Date           : 2022-04-08 20:58:04
 * @LastEditTime   : 2022-04-15 19:25:05
 * @Description    :
 */
var mongoosePaginate = require("mongoose-paginate");
module.exports = (app) => {
  const mongoose = app.mongoose;
  const Schema = mongoose.Schema;
  // 设计思路
  const schema_instance = new Schema(
    {
      // "md文档语言 value "
      language: { type: String, required: true },
      //md文档 文件 名字 
      name: { type: String },
      // md文档 文件 路径  
      path: { type: String },
      //md文档作者  名字
      author: { type: String },
      //所属的的文档 id 
      document: { type: String },
      // -1 禁用  ， 1 启用 ， 
      status: { type: Number, default: -1 },
      //备注 
      mark: { type: String, default: '' }
    },
    { timestamps: true, }
  );

  schema_instance.method("toJSON", function () {
    const { __v, _id, ...object } = this.toObject();
    object.id = _id;
    object.createdAt = Date.parse(object.createdAt);
    object.updatedAt = Date.parse(object.updatedAt);
    return object;
  });

  schema_instance.plugin(mongoosePaginate);


  return mongoose.model("B_SDK_Mddocpool", schema_instance);
};

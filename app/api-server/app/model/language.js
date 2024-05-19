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
      //标题  中文
      name_zh: { type: String, required: true },
      //标题  英文
      name_en: { type: String },
      // 语言的key 例如：zh_cn",
      value: { type: String },
      status:{
        type:Number,
         // -1 禁用  ， 1 启用 ， 
        default:-1
      } ,
      //"默认回落语言,只会有一个值,例如：1"
      default_language:{
        type :String
      },
      // "语言排序，越小越靠前"
      order:{
        type :Number
      }


    
 
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

  return mongoose.model("Language", schema_instance);
};

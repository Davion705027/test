/*
 * @Date           : 2022-03-11 10:09:10
 * @FilePath       : /client-api-doc-server/app/model/user.js
 * @Description    : 用户 模型
 */
var mongoosePaginate = require("mongoose-paginate");
module.exports = (app) => {
  const mongoose = app.mongoose;
  const Schema = mongoose.Schema;

  const schema_instance = new Schema(
  
    {
      //标题  中文
      name_zh: { type: String,  required: true},
      //标题  英文
      name_en: { type: String, },
      //内容  中文
      content_zh:{ type: String, required: true },
      //内容  英文
      content_en:{ type: String, },
      //状态
      status:{
        type:Number,
        // -1 禁用  ， 1 启用 ，  
        default:-1
      } ,


      //置顶
      is_top:{
        type:Boolean,
        default:false
      },
       //相关主题
       topic:{
         type:Array,
         default:()=>[]
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

  return mongoose.model("Faq", schema_instance);
};

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
       //关联的常见问题 
         related_faq:{ type: String,default: '', },
         //关联的文档 
         related_doc:{ type: String, default: '',},

      //置顶
      is_top:{
        type:Boolean,
        default:false
      },
      //相关人员, 这次更新和谁有关 ， 找谁咨询 
      related_staff:{
        type: String,
      }
 
 
       
    },
    {
      timestamps: true,
    }
  );

  schema_instance.method("toJSON", function () {
    const { __v, _id, ...object } = this.toObject();
    object.id= _id;
    object.createdAt = Date.parse(object.createdAt);
    object.updatedAt = Date.parse(object.updatedAt);
    return object;
  });

  schema_instance.plugin(mongoosePaginate);

  return mongoose.model("UpdateRecord", schema_instance);
};

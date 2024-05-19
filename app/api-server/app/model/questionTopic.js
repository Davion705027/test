/*
 * @Date           : 2022-04-05 17:09:34
 * @LastEditTime   : 2022-04-05 17:09:34
 * @Description    :  
 */
var mongoosePaginate = require("mongoose-paginate");
module.exports = (app) => {
  const mongoose = app.mongoose;
  const Schema = mongoose.Schema;

  const schema_instance = new Schema(
  
    {
      //短id 
      sid:{type: Number, required: true},
      status:{
        type:Number,
         // -1 禁用  ， 1 启用 ， 
        default:-1
      } ,
      // 主题 各个 语言的名字
      names:{},
      order:{
        type:Number,
        // 0   越大越靠前
        default:0
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

  return mongoose.model("QuestionTopic", schema_instance);
};

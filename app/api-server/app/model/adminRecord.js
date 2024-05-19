
/*
 * @Date           : 2022-03-11 10:09:10
 * @FilePath       : /client-api-doc-server/app/AdminRecord/user.js
 * @Description    : 管理员 模型
 */

var mongoosePaginate = require("mongoose-paginate");
module.exports = (app) => {
    const mongoose = app.mongoose;
    const Schema = mongoose.Schema;
  
    const schema_instance = new Schema({
        //请求接口路径
         path: String,
        //操作人
        operator:String,    
        //请求方法
        method:   String,   

        //操作对象ID 
        target_id:  String,   
     
    }, {
        timestamps: true,
      });
    schema_instance.method("toJSON", function () {
      const { __v, _id, ...object } = this.toObject();
      object.id = _id;
      object.createdAt = Date.parse(object.createdAt);
      object.updatedAt = Date.parse(object.updatedAt);
      return object;
    });
      // 使用monmongoosePaginate分页插件    使用：Model.paginate([查询], [选项], [回调])
  schema_instance.plugin(mongoosePaginate);
    return mongoose.model("AdminRecord", schema_instance);
  };
  
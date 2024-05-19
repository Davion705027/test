
/*
 * @Date           : 2022-03-11 10:09:10
 * @FilePath: /client-api-doc-server/app/model/admin.js
 * @Description    : 管理员 模型
 */
var mongoosePaginate = require("mongoose-paginate");
module.exports = (app) => {
    const mongoose = app.mongoose;
    const Schema = mongoose.Schema;
  
    const schema_instance = new Schema({
      name: { type: String, required:true },
      password: { type: String ,required:true},
      roleId: { type: mongoose.Types.ObjectId, required:true ,ref:"Role"}, // 角色 1,2
      last_sign_in_at: {
        type: Date,
      },
    
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
    return mongoose.model("Admin", schema_instance);
  };
  
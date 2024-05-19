
/*
 * @Date           : 2022-03-11 10:09:10
 * @FilePath: /client-api-doc-server/app/model/role.js
 * @Description    : 角色 模型
 */
var mongoosePaginate = require("mongoose-paginate");
module.exports = (app) => {
    const mongoose = app.mongoose;
    const Schema = mongoose.Schema;
  
    const schema_instance = new Schema({
      name: { type: String, required:true },
      menus: { type: Array, default: [] }, // 菜单列表
      mark: { type: String, default: '' }, // 描述
  
    }, {
        timestamps: true,
      })  ;
    schema_instance.method("toJSON", function () {
      const { __v, _id, ...object } = this.toObject();
      object.id = _id.toString();
      object.createdAt = Date.parse(object.createdAt);
      object.updatedAt = Date.parse(object.updatedAt);
      return object;
    });
    schema_instance.plugin(mongoosePaginate);
    const Role = mongoose.model("Role", schema_instance);

    return Role
  };
  
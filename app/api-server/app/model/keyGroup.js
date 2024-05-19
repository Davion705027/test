/**
 * 客户端  配置键 分组表
 */
var mongoosePaginate = require("mongoose-paginate");
module.exports = (app) => {
  const mongoose = app.mongoose;
  const Schema = mongoose.Schema;
  const schema_instance = new Schema(
    {
      //标题  多语言的
      names: {},
      //  属性组   键
      key: { type: String },
      //布局
      project: {
        type: Number,
        require: true,
      },
      // key 类型 ctx.assistant.key_type
      key_type: {
        type: Number,
        require: true,
      },
      // 级别 类型  
      // css :      1 component  ， 2 global，
      // js :       1 component  ， 2 global，
      // assets :    1 other  2 sprite
      level: {
        type: Number,
 
        default: 1,
      },
      // 统计
      statistics: {},
      //描述  多语言的
      descriptions: {},
      // 是否开启可配置
      //状态
      status: {
        type: Number,
        // -1 禁用  ， 1 启用 ，-2  已废弃
        default: -1,
      },
  
      //备注
      mark: String,
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
  return mongoose.model("KeyGroup", schema_instance);
};

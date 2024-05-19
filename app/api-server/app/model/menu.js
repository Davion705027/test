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
      //标题  多语言的 
      names: {   },
    
      //备注
      mark: { type: String },
      //父级菜单
      fatherId: { type: String, required: true },
      // 菜单类型
      type:{
      type:Number,default:1
      },

      //排序
      order:{
        type:Number, 
      },
      /**
     *  { label: '基础版', value: 'base' },
        { label: '进阶版', value: 'advanced' },
        { label: '完整版', value: 'integrated' }
      */
      group: { type: String, default: () => 'integrated' },
   
      // 映射文档id  只有 文件类型才有意义
      related_doc:{
        type: String,
        default: '',
      },
      //状态
      status: {
        type: Number,
        // -1 禁用  ， 1 启用 ，
        default: -1,
      },
 
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

  return mongoose.model("Menu", schema_instance);
};

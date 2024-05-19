var mongoosePaginate = require("mongoose-paginate");
// const mongoosePaginate = require('mongoose-aggregate-paginate-v2');
module.exports = (app) => {
  const mongoose = app.mongoose;
  const Schema = mongoose.Schema;

  const schema_instance = new Schema(
    {
      // 名字
      name: { type: String },
      //密码
      password: { type: String ,select: true},
      //备注
      mark: { type: String },
      //最后一次登录时间
      last_sign_in_at: {
        type: Date,
      },
      //用户角色id
      // roleId: { type: mongoose.Types.ObjectId, required:true },
      // sdk 对接
      sdk: { type: Boolean },
      // app 对接
      app: { type: Boolean },
      // 模块化对接
      modulize: {type: Boolean, default: () => false},
      /**
       *  { label: '基础版', value: 'base' },
          { label: '进阶版', value: 'advanced' },
          { label: '完整版', value: 'integrated' }
       */
      group: { type: String, default: () => 'integrated' },
      version_group_ids:{type:Array, default: ()=> []}, //所属版本组id
      version_group_names:{type:Array, default: ()=> []} //所属版本组名字
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

  return mongoose.model("User", schema_instance);
};

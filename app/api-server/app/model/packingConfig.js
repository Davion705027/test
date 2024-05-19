/**
 * 打包记录  记录表
 */
var mongoosePaginate = require("mongoose-paginate");
module.exports = (app) => {
  const mongoose = app.mongoose;
  const Schema = mongoose.Schema;
  const schema_instance = new Schema(
    {
      //自定义名字
      name: String,
      // 项目标识
      job_label: String,
      //布局
      project: {
        type: Number,
        require: true,
      },
      //组件配置 选用的商户版本号
      component: String,
      //JS配置 选用的商户版本号
      js: String,
      //国际化配置 选用的商户版本号
      i18n: String,
   
      //自定义主题 ，组合数组
      theme: Array,
      // theme: [
        // {
        //   version:"商户版本号",
        //   i18n:{
        //     //生成 主题的名字
        //   },
        //   key:'theme-1'
        //   is_default: 1,  //1 设置为默认主题
        //   is_standard:1, // 1代表是系统内置的成套的主题 0代表用户自己创建的
        //   order:1,  //排序
        //   themeRefer:'基础主题版本号',  //也可以是空 ，空代表不和 默认主题色合并
        //   css_detail:{},// CSS配置信息
        //   assets_detail:{},// 资源配置信息
        // },
      // ],

      //备注
      mark: { type: String },
      //创建人 打包配置的创建人
      creatorid:String,
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
  return mongoose.model("PackingConfig", schema_instance);
};

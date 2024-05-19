/**
 * 打包记录  记录表
 */
var mongoosePaginate = require("mongoose-paginate");
module.exports = (app) => {
  const mongoose = app.mongoose;
  const Schema = mongoose.Schema;
  const schema_instance = new Schema(
    {
       
      //备注
      mark: { type: String },
      //布局
      project: {
        type: Number,
        require: true,
      },
      //打包配置 id  
      packingConfigId: String,
      //基础名字 /版本号，
      base_name: String,
    
      //打包目标环境   shiwan 试玩 ,  online 生产
      env: {
        type:String,
        default:"shiwan"
      },
      // 发起构建的时间 时间戳
      puck_up_time: Number,
        //day  日期  20230424 格式
      day:String,
      //打包类型  1 全量配置文件 2 用户差异化配置文件， 3.前端代码打包zip 下载  4 js sdk
      //'1,2,3,4'
      type: String,
      //打包类型  1 全量配置文件
      type1_info: {},
      //打包类型  2 用户差异化配置文件
      type2_info: {},
      //打包类型  3.前端代码打包zip 下载
      type3_info: {},
      //打包类型  4  js sdk
      type4_info: {},
      // //打包类型   数据模板
      // type_info: {
        //  // 基础名字
        //  base_name: String,
        //  // 文件全名 ，无 格式 
        //  full_name: String,
        // //打包类型 
      //   type: "4",
          //day 
          // day:String,
      //   //文件地址
      //   path: String,
      //   //文件名字
      //   name: String,
      //   //文件类型
      //   type: String,
      //   //打包完成   -1 未完成 1 已完成 -2未完成强制取消  -3 未完成手动取消
      //   finish: {
      //     type: Number,
      //     default: -1,
      //   },
      // },
      // file_name :  "h5-fbe47440e01d11eda86273c53f4dfa34-1682065515506.json"
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
  return mongoose.model("PackingRecord", schema_instance);
};

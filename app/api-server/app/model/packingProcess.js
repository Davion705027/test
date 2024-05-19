/**
 * 打包记录  记录表
 */

module.exports = (app) => {
  const mongoose = app.mongoose;
  const Schema = mongoose.Schema;
  const schema_instance = new Schema(
    {
      //打包请求的 数据库ID
      puck_up_record_id: String,

      //打包配置 id
      packingConfigId: String,
      //时间戳
      timestamp: Date,
      //打包配置 id
      packingConfigId: String,
      //基础名字 /版本号，
      base_name: String,
      //备注
      mark: { type: String },

      //布局
      project: {
        type: Number,
        require: true,
      },
      //打包类型  1 全量配置文件 2 用户差异化配置文件， 3.前端代码打包zip 下载  4 js sdk
      puck_up_type: Number,
      // 打包时间
      puck_up_time: Date,
      //打包事项 任务名字
      puck_up_name: String,

      // 运维Jenkins 构建 后打包的 文件名字  不含 .zip
      zip_file_name: String,
      //zip 文件全名
      zip_file_full_name: String,
      //前端文件 最后保存路径
      zip_file_full_path: String,
      // 运维Jenkins 构建参数
      jenkins_param_version: String,
      //运维 上传 服务器回传目录
      upload_folder: String,
      //构建布局名字
      jenkins_project_name: String,
      // day
      day: String,
      //打包目标环境   shiwan 试玩 ,  online 生产
      env: {
        type: String,
        default: "shiwan",
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
  // 使用monmongoosePaginate分页插件    使用：Model.paginate([查询], [选项], [回调])

  return mongoose.model("PackingProcess", schema_instance);
};

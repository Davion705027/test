const mongoosePaginate = require("mongoose-paginate");

/**
 * 培训记录
 *
 * @param {Egg.Application} app
 * @returns
 */
module.exports = (app) => {
  const mongoose = app.mongoose;

  const Schema = new mongoose.Schema(
    {
      /**
       * 文件名
       */
      name: {
        type: String,
        required: [true, "文件名不能为空"],
      },

      /**
       * mime 类型
       */
      mime_type: {
        type: String,
        required: [true, "mime 类型不能为空"],
      },
      
      /**
       * 完整路径
       */
      filepath: {
        type: String,
        required: [true, "完整路径不能为空"],
      },
      
      /**
       * 文件大小
       */
      filesize: {
        type: Number,
        required: [true, "文件大小不能为空"],
      },
      
      /**
       * 生成的文件名字
       */
      save_name: {
        type: String,
        required: [true, "生成的文件名字不能为空"],
      },
      
      /**
       * 保存目录
       */
      save_filepath: {
        type: String,
        required: [true, "生成的文件名字不能为空"],
      },
      
      /**
       * 文件后缀名字
       */
      suffix_name: {
        type: String,
        required: [true, "文件后缀名字不能为空"],
      },

      /**
       * 创建时间
       */
      create_time: {
        type: Date,
        default: Date.now,
        required: [true, "创建时间不能为空"],
      },

      /**
       * 创建人
       */
      create_by: {
        type: String,
        required: [true, "创建人不能为空"],
      },

      /**
       * 更新时间
       */
      update_time: {
        type: Date,
        default: Date.now,
        required: [true, "更新时间不能为空"],
      },

      /**
       * 更新人
       */
      update_by: {
        type: String,
        required: [true, "更新人不能为空"],
      },

    },
    {
      // 自动管理创建修改时间
      timestamps: {
        createdAt: "create_time",
        updatedAt: "update_time",
      },

      // 去除__v 版本默认version_key
      versionKey: false,

      toJSON: {
        transform(doc, ret) {
          ret.id = ret._id;
          delete ret._id;
        },
      },
    }
  );
  Schema.plugin(mongoosePaginate);
  return mongoose.model("FileUploadLog", Schema);
};
// Followup

/**
 * code 码标签表
 */
var mongoosePaginate = require("mongoose-paginate");
module.exports = (app) => {
    const mongoose = app.mongoose;
    const Schema = mongoose.Schema;
    const schema_instance = new Schema(
        {
            // 标签名
            name: { type: String, required: true },

            // 标签描述
            desc: { type: String, required: true },

            // 更新人
            updater: { type: String, required: true },

            // 创建人
            creator: { type: String, required: true },
        },
        { timestamps: true, }
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
    return mongoose.model("CodeTag", schema_instance);
};

/**
 * 中间件接口表
 */
var mongoosePaginate = require("mongoose-paginate");
module.exports = (app) => {
    const mongoose = app.mongoose;
    const Schema = mongoose.Schema;
    const schema_instance = new Schema(
        {
            // 请求地址
            url: { type: String, required: true },

            // 描述
            desc: { type: String, required: true },

            // 响应数据
            response: { type: String },

            // code 标签
            code_tag_id: { type: String, required: true },

            // { Array<{ code: String, desc: String, order: Number }> } 有哪些状态
            code_state_list: { type: Array },

            // 状态： -1 禁用   1 启用
            status: { type: Number, required: true },

            // 备注
            mark: { type: String },

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
    return mongoose.model("MiddlewareInterface", schema_instance);
};

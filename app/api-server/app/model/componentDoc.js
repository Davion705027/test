/**
 * 中间件接口表
 */
const mongoosePaginate = require("mongoose-paginate");

const component_doc = (app) => {
    const mongoose = app.mongoose;
    const Schema = mongoose.Schema;
    const schema_instance = new Schema({
        // 组件名称
        name: { type: String, required: true },

        // 布局类型
        project: { type: Number, required: true },

        // 文件存储路径
        path: { type: String, required: true },

        // 版本
        version: { type: String, required: true },

    }, {
        timestamps: true,
    });
    schema_instance.method("toJSON", function () {
        const { __v, _id, ...object } = this.toObject();
        object.id = _id;
        
        ;[ 'createdAt', 'updatedAt', ].forEach((key) => {
            object[key] = Date.parse(object[key])
        })
        return object;
    });
    // 使用monmongoosePaginate分页插件    使用：Model.paginate([查询], [选项], [回调])
    schema_instance.plugin(mongoosePaginate);
    return mongoose.model("ComponentDoc", schema_instance);
}


module.exports = component_doc
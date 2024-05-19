/**
 *   
 */
const mongoosePaginate = require("mongoose-paginate");

const component_doc = (app) => {
    const mongoose = app.mongoose;
    const Schema = mongoose.Schema;
    const schema_instance = new Schema({
        // 组件名称
        name: { type: String },

        // 组件名称
        component_name: { type: String, required: true },

        // 布局类型
        project: { type: Number, required: true },

        // 启用版本
        enable_version: { type: String, required: true },

        // 描述 多语言的
        descriptions: { type: Object },
            //图片描述 数量统计
         imgdesc:{}, 
    }, {
        timestamps: true,
    });
    schema_instance.method("toJSON", function () {
        const { __v, _id, ...object } = this.toObject();
        object.id = _id;

        ;['createdAt', 'updatedAt',].forEach((key) => {
            object[key] = Date.parse(object[key])
        })
        return object;
    });
    // 使用monmongoosePaginate分页插件    使用：Model.paginate([查询], [选项], [回调])
    schema_instance.plugin(mongoosePaginate);
    return mongoose.model("ComponentKey", schema_instance);
}


module.exports = component_doc
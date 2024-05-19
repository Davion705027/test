/*
 * @Date           : 2024-03-01 13:58:04
 * @LastEditTime   : 2024-03-01 14:25:05
 * @Description    : 客户端web菜单管理
 */
var mongoosePaginate = require("mongoose-paginate");
module.exports = (app) => {
    const mongoose = app.mongoose;
    const Schema = mongoose.Schema;
    const ClientMenu = new Schema(
        {
            //名称  中文
            zh_cn: { type: String, required: true },
            //名称  英文
            en_gb: { type: String },
            // 标识,
            key: { type: String },
            // 描述
            description: { type: String }
        },
        {
            timestamps: true,
        }
    );

    ClientMenu.method("toJSON", function () {
        const { __v, _id, ...object } = this.toObject();
        object.id = _id;
        object.createdAt = Date.parse(object.createdAt);
        object.updatedAt = Date.parse(object.updatedAt);
        return object;
    });

    ClientMenu.plugin(mongoosePaginate);
    return mongoose.model("ClientMenu", ClientMenu);
};

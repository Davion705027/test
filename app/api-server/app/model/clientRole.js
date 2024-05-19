/*
 * @Date           : 2022-04-08 20:58:04
 * @LastEditTime   : 2022-04-15 19:25:05
 * @Description    :
 */
var mongoosePaginate = require("mongoose-paginate");
module.exports = (app) => {
    const mongoose = app.mongoose;
    const Schema = mongoose.Schema;
    const ClientRole = new Schema(
        {
            //名称  中文
            name: { type: String, required: true },
            // 描述
            description: { type: String },
            // 关联的菜单 id
            menus: { type: Array }
        },
        {
            timestamps: true,
        }
    );

    ClientRole.method("toJSON", function () {
        const { __v, _id, ...object } = this.toObject();
        object.id = _id;
        object.createdAt = Date.parse(object.createdAt);
        object.updatedAt = Date.parse(object.updatedAt);
        return object;
    });

    ClientRole.plugin(mongoosePaginate);
    return mongoose.model("ClientRole", ClientRole);
};

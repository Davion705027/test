// 场馆列表
const mongoosePaginate = require("mongoose-paginate");
const venueManage = (app) => {
    const mongoose = app.mongoose;
    const Schema = mongoose.Schema;
    const schema_instance = new Schema({

        //名称  中文
        name_zh: { type: String, required: true},

        //名称  英文
        name_en: { type: String, },

        // 图片 多张 
        images: { type: Array },

        // 所属城市
        city: { type: String },

        // 关联赛事
        matchID: { type: Array },

        // // 场馆tag（决赛，揭幕式）
        // tag_zh: { type: Array },

        // // 场馆tag  英文
        // tag_en: { type: Array },

        // 描述，文章 中文
        mark_zh: { type: String },
        // 描述 英文
        mark_en: { type: String },

        // 状态： -1 禁用   1 启用
        status: { type: Number, required: true },
    }, {
        timestamps: true,
    });
    schema_instance.method("toJSON", function () {
        const { __v, _id, ...object } = this.toObject();
        object.id = _id;
    
        return object;
      });
    // 使用monmongoosePaginate分页插件    使用：Model.paginate([查询], [选项], [回调])
    schema_instance.plugin(mongoosePaginate);
 
    return mongoose.model("VenueManage", schema_instance);
}



module.exports = venueManage
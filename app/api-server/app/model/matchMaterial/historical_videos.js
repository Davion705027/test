// 欧洲杯历届赛事列表
const mongoosePaginate = require("mongoose-paginate");
const historicalVideos = (app) => {
    const mongoose = app.mongoose;
    const Schema = mongoose.Schema;
    const schema_instance = new Schema({

        //标题  中文
        title_zh: { type: String, required: true},

        //标题  英文
        title_en: { type: String, },

        // 视频地址 
        video: { type: String },

        // 视频封面 
        cover: { type: String },

        // 参赛者or队伍 中文
        participants_zh: { type: Array },

        // 参赛者or队伍 英文
        participants_en: { type: Array },

        // 关联赛事
        matchID: { type: String },

        // 赛事类型（欧洲杯，奥运会...）
        matchType: { type: String },

        // 状态： -1 禁用   1 启用
        status: { type: Number, required: true },

        // 描述 中文
        mark_zh: { type: String },
        // 描述 英文
        mark_en: { type: String },
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
 
    return mongoose.model("HistoricalVideos", schema_instance);
}



module.exports = historicalVideos
// 欧洲杯历届赛事列表
const mongoosePaginate = require("mongoose-paginate");
const matchOzb = (app) => {
    const mongoose = app.mongoose;
    const Schema = mongoose.Schema;
    const schema_instance = new Schema({
        // 赛事名称
        name: { type: String, required: true },

        // logo 
        logo: { type: String },

        // 举办地点 
        venue: { type: String },

        // 开始时间
        start_time: { type: Date },

        // 结束时间
        end_time: { type: Date },

        // 状态： -1 禁用   1 启用
        status: { type: Number, required: true },

        // 描述
        mark: { type: String },
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
 
    return mongoose.model("MatchOzb", schema_instance);
}



module.exports = matchOzb
// 运动员列表
const mongoosePaginate = require("mongoose-paginate");
const athleteManage = (app) => {
    const mongoose = app.mongoose;
    const Schema = mongoose.Schema;
    const schema_instance = new Schema({

        //姓名  中文
        name_zh: { type: String, required: true},
        //姓名  英文
        name_en: { type: String, },

        // 照片 
        image: { type: String },
        // 国家
        nation: { type: String },
        // 队伍
        team: { type: String },
        // 所属体育项目
        sports: { type: String },
        // 所属赛事 多个
        match: { type: Array },
        // 描述 中文
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
 
    return mongoose.model("AthleteManage", schema_instance);
}



module.exports = athleteManage
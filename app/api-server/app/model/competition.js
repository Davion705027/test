/**
 * 中间件接口表
 */
const mongoosePaginate = require("mongoose-paginate");
const competitionSliceSchema = require("./competition_slice_schema");

const competition = (app) => {
    const mongoose = app.mongoose;
    const Schema = mongoose.Schema;
    const schema_instance = new Schema({
        // 赛事名称
        name: { type: String, required: true },

        // 赛种
        race: { type: String, required: true },

        // 接口 ID
        interface_id: { type: String, required: true },

        // 请求类型: ws | http
        request_type: { type: String, required: true },

        // 数据类型: list | details
        data_type: { type: String, required: true },

        // 列表类型: 6列 | 13列
        column_type: { type: String, required: true },

        // 赛事 ID
        mid: { type: String },

        // 开始时间
        start_time: { type: Date },

        // 结束时间
        end_time: { type: Date },

        // 状态： -1 禁用   1 启用
        status: { type: Number, required: true },

        // 备注
        mark: { type: String },
    }, {
        timestamps: true,
    });
    schema_instance.method("toJSON", function () {
        const { __v, _id, ...object } = this.toObject();
        object.id = _id;
        
        ;[ 'start_time', 'end_time', 'createdAt', 'updatedAt', ].forEach((key) => {
            object[key] = Date.parse(object[key])
        })
        return object;
    });
    // 使用monmongoosePaginate分页插件    使用：Model.paginate([查询], [选项], [回调])
    schema_instance.plugin(mongoosePaginate);
    const CompetitionModel = mongoose.model("Competition", schema_instance);
    initCompetitionSliceTable(app, CompetitionModel)
    return CompetitionModel
}

async function initCompetitionSliceTable(app, CompetitionModel) {
    const competitionList = await CompetitionModel.find()
    const schema_instance = competitionSliceSchema(app)

    for (let i = 0, item; (item = competitionList[i]); i++) {
        const modelName = 'competition_slice_' + item.id
        app.model[modelName] = app.mongoose.model(modelName, schema_instance);
    }
}

module.exports = competition
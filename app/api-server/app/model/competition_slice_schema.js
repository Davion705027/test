const mongoosePaginate = require("mongoose-paginate");

module.exports = (app) => {
    const schema_instance = new app.mongoose.Schema({
        // 发送开始时间
        send_start_time: { type: Date, required: true },

        // 请求响应时间
        // response_time: { type: Date, required: true },

        // 发送结束时间
        send_end_time: { type: Date, required: true },

        // 响应数据
        response_data: { type: Object },

        // 备注
        mark: { type: String },
    }, { timestamps: true });

    schema_instance.method("toJSON", function () {
        const { __v, _id, ...object } = this.toObject();
        object.id = _id;
        ;[ 'send_start_time', 'send_end_time', 'createdAt', 'updatedAt', ].forEach((key) => {
            object[key] = Date.parse(object[key])
        })
        return object;
    });
    schema_instance.plugin(mongoosePaginate);

    return schema_instance
}
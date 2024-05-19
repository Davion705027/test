const mongoose = require("mongoose");
const randomstring = require("randomstring");
const mongodb_connect_fn = require("../mongodb.config");
const model_competition_fn = require("../../app/model/competition");
const competition_slice_schema = require("../../app/model/competition_slice_schema");

const competition = { id: '648714bee44284446c0db345' }

async function main() {
    await mongodb_connect_fn();
    const model_competition_slice = mongoose.model('competition_slice_' + competition.id, competition_slice_schema({ mongoose }))
    const currentTime = new Date('2023-06-12T19:49:30+08:00').getTime()
    const competition_slice_list = []
    for (let i = 0, len = 2899; i < len; i++) {
        const ts = currentTime + i * 4000
        competition_slice_list.push({
            send_start_time: new Date(ts - 1000),
            send_end_time: new Date(ts + 1000),
            response_data: { code: '000000', data: randomstring.generate(18), msg: '成功', ts }
        })
    }

    await model_competition_slice.create(competition_slice_list)
}

main()
    .catch((err) => console.log(err))
    .finally(() => process.exit(0))

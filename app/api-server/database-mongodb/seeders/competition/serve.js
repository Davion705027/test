const Koa = require('koa')
const bodyParser = require('koa-bodyparser')
const { URL } = require('url')

const mongoose = require("mongoose");
const mongodb_connect_fn = require("../../mongodb.config");
const model_middlewareInterface_fn = require("../../../app/model/middlewareInterface");
const model_competition_fn = require("../../../app/model/competition");
const competition_slice_schema = require("../../../app/model/competition_slice_schema");

const app = new Koa();
app.use(bodyParser());

const models = {}

/**
 * 通过URL查找接口
 * 
 * @param {string} url 
 * @returns 
 */
async function findInterfaceByURL(url) {
    return models.middlewareInterface.findOne({ url })
}

/**
 * 通过接口ID查找赛事
 * 
 * @param {string} interface_id 
 * @returns 
 */
async function findCompetitionByInterfaceId(interface_id) {
    return models.competition.findOne({ interface_id })
}

/**
 * 创建赛事切片
 */
function createCompetitionSliceByCompetitionId(competition_id, response) {
    const sliceModelName = 'competition_slice_' + competition_id

    if (!models[sliceModelName]) {
        const schema_instance = competitionSliceSchema(app)
        models[sliceModelName] = mongoose.model(sliceModelName, schema_instance)
    }

    models[sliceModelName].crete(response)
}

app.use(async ctx => {
    // if (data.url.includes('matchDetail/getMatchDetail?mid=3499082'))
    const { url, response } = ctx.request.body
    const _url = new URL(url)
    console.log('--请求进入--', url);

    if (_url.pathname.includes('matchDetail/getMatchDetail')) {
        // console.log('🍎🍎🍎🍎🍎🍎 获取到赛事数据,  mid:', _url.searchParams.get('mid'));
        const interface = await findInterfaceByURL(_url.pathname + '?' + _url.searchParams.get('mid'))
        const competition = await findCompetitionByInterfaceId(interface.id)
        createCompetitionSliceByCompetitionId(competition.id, response)
    }

    ctx.accepts('application/json');
    ctx.body = { code: '000000', data: true, msg: 'success' }
});

async function main() {
    await mongodb_connect_fn()
    models.middlewareInterface = model_middlewareInterface_fn({ mongoose })
    models.competition = model_competition_fn({ mongoose })
}

main().then(() => {
    app.listen(3000);
})
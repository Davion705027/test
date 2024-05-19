const Koa = require('koa')
const bodyParser = require('koa-bodyparser')
// const { URL } = require('url')
const fs = require('fs');

const app = new Koa();
app.use(bodyParser());

app.use(async ctx => {
    // const _url = new URL(ctx.request.body.url)
    console.log('--请求进入--', ctx.request.body.url);

    fs.appendFile('datas/' + ctx.request.body.name.replace(/\//g, '-'), JSON.stringify(ctx.request.body) + '\r\n', (err) => {
        if (err) console.log('数据记录错误', err);
    });

    ctx.accepts('application/json');
    ctx.body = { code: '000000', data: true, msg: 'success' }
});

app.listen(3000);
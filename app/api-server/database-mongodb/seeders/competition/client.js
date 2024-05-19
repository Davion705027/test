; ((config) => {
    const originalOpen = XMLHttpRequest.prototype.open;
    const originalSend = XMLHttpRequest.prototype.send;

    let _method, _url

    XMLHttpRequest.prototype.open = function () {
        _method = arguments[0];
        _url = arguments[1];
        return originalOpen.apply(this, arguments);
    }

    XMLHttpRequest.prototype.send = function (data) {
        const send_start_time = new Date().getTime()

        this.addEventListener('load', function () {
            let response = { send_start_time, send_end_time: new Date().getTime() };
            try {
                response.response_data = JSON.parse(this.responseText);
            } catch (error) {
                response.response_data = this.responseText;
            }

            config.send({ name: config.name, method: _method, url: _url, response })
        })

        return originalSend.apply(this, arguments);
    }

})({
    send(data) {
        this.ajax('http://127.0.0.1:3000', data)
    },

    ajax(url, data) {
        return new Promise((resolve, reject) => {
            fetch(url, {
                body: JSON.stringify(data),
                headers: { 'Content-Type': 'application/json' },
                method: 'POST'
            }).then(res => {
                res.json().then(resolve)
            }).catch(reject)
        })
    },

    name: '【足球】让球&大小',
    // name: '【足球】波胆',
    // name: '【足球】15分钟',
    // name: '【足球】独赢/让球胜平负/双重机会',
    // name: '【足球】半/全场',
    // name: '【足球】进球单/双',
    // name: '【足球】下一/最后进球',
    // name: '【足球】进球区间',
    // name: '【足球】净胜分',
    // name: '【足球】角球',
    // name: '【足球】冠军',

    // name: '【篮球】',
    // name: '【电子竞技】',
    // name: '【网球】',
    // name: '【斯诺克】',
    // name: '【羽毛球】',
    // name: '【乒乓球】',
    // name: '【棒球】',
    // name: '【拳击/格斗】',
    // name: '【沙滩排球】',
    // name: '【水球】',
    // name: '【曲棍球】',
    // name: '【橄榄球】',
    // name: '【冠军】',
})

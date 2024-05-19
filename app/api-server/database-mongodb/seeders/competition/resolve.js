const events = require('events');
const fs = require('fs');
const readline = require('readline');

async function main() {
    try {
        const rl = readline.createInterface({
            input: fs.createReadStream('data.txt'),
            crlfDelay: Infinity
        });

        rl.on('line', (line) => {
            console.log(`Line from file: ${line}`);
        });

        await events.once(rl, 'close');

        console.log('文件读取完成！！！');
        const used = process.memoryUsage().heapUsed / 1024 / 1024;
        console.log(`该文件大小为： ${Math.round(used * 100) / 100} MB`);
    } catch (err) {
        console.error(err);
    }
}

main()
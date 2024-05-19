
"use strict";
const Controller = require("egg").Controller;
class ModularSettingCache extends Controller {
    async save() {
        const { body } = this.ctx.request;
        let token = this.ctx.request.headers.authorization || "";
        let info = await this.service.jwt.verifyToken(token)

        const {
            version,
            type,
            jsonString,
        } = body;

        let data;

         /**
         * 查找版本号是否存在, 如果存在就更新, 没有则新增
         */
        try {
            const result = await this.ctx.model.ModularSettingCache.findOne({ version: version, type: type, username: info?.name })

            if (result) {
                data = await this.ctx.model.ModularSettingCache.updateOne({ version: version }, {
                    type,
                    jsonString,
                    username: info?.name
                })
            } else {
                data = await this.ctx.model.ModularSettingCache.create({
                    version,
                    type,
                    jsonString,
                    username: info?.name
                })
            }
            this.ctx.api_success_data(data);
        } catch (error) {
            this.ctx.api_error_msg(error);
        }
    }

    async list() {
        let token = this.ctx.request.headers.authorization || "";
        let info = await this.service.jwt.verifyToken(token)
        
        const result = await this.ctx.model.ModularSettingCache.find({ username: info?.name });
        this.ctx.api_success_data(result);
    }

    async pick() {
        const { version } = this.ctx.query;
        /**
         * 先把所有的记录都设置为 false, 再把当前选中的设置为 true
         */
        await this.ctx.model.ModularSettingCache.updateMany({}, {$set: { used: false }});

        const row = await this.ctx.model.ModularSettingCache.updateMany({ version: version }, { used: true });

        this.ctx.api_success_data(row);
    }
}
module.exports = ModularSettingCache;

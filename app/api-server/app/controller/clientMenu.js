const Controller = require("egg").Controller;

class ClientMenuController extends Controller {

    /**
     * 新增
     */
    async create() {
        const ctx = this.ctx;
        try {
            const { zh_cn, en_gb, key, description } = ctx.request.body;
            const result = await ctx.model.ClientMenu.create({ zh_cn, en_gb, key, description })
            ctx.api_success_data(result);
        } catch (error) {
            ctx.api_error_msg(error);
        }
    }

    /**
     * 删除
     */
    async unlink() {
        const ctx = this.ctx;
        try {
            const { id } = ctx.request.body;
            const result = await ctx.model.ClientMenu.findByIdAndDelete(id)
            ctx.api_success_data(result);
        } catch (error) {
            ctx.api_error_msg(error);
        }
    }

    /**
     * 修改
     */
    async write() {
        const ctx = this.ctx;
        try {
            const { id, zh_cn, en_gb, key, description } = ctx.request.body;
            const result = await ctx.model.ClientMenu.findByIdAndUpdate(id, { zh_cn, en_gb, key, description })
            ctx.api_success_data(result);
        } catch (error) {
            ctx.api_error_msg(error);
        }
    }

    /**
     * 查询
     */
    async search_read() {
        const ctx = this.ctx;
        try {
            let query = {};
            let { name, currentPage = 1, pageSize = 10 } = ctx.query;
            if (name) {
                query = {
                    zh_cn: {
                        $regex: name,
                        $options: "i",
                    },
                };
            }
            const options = {
                page: ctx.toInt(currentPage),
                limit: ctx.toInt(pageSize),
                sort: { updatedAt: -1 },
            };
            const result = await ctx.model.ClientMenu.paginate(query, options);
            ctx.api_success_data(result);
        } catch (error) {
            ctx.api_error_msg(error);
        }
    }

    /**
     * 不带分页, 获取所有的 menus
     */
    async read_all() {
        const ctx = this.ctx;
        try {
            const result = await ctx.model.ClientMenu.find({});
            ctx.api_success_data(result);
        } catch (error) {
            ctx.api_error_msg(error);
        }
    }
}

module.exports = ClientMenuController;
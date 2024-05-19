const Controller = require("egg").Controller;

class ClientRoleController extends Controller {

    /**
     * 新增
     */
    async create() {
        const ctx = this.ctx;
        try {
            const { name, description, menus } = ctx.request.body;
            const result = await ctx.model.ClientRole.create({ name, description, menus })
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
            const result = await ctx.model.ClientRole.findByIdAndDelete(id)
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
            const { id, name, description, menus } = ctx.request.body;
            const result = await ctx.model.ClientRole.findByIdAndUpdate(id, { name, description, menus })
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
                    name: {
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
            const result = await ctx.model.ClientRole.paginate(query, options);
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
            const result = await ctx.model.ClientRole.find({});
            ctx.api_success_data(result);
        } catch (error) {
            ctx.api_error_msg(error);
        }
    }


    /**
     * 通过角色的 id 获取当前角色所绑定的菜单
     */
    async getRoleMenus() {
        const ctx = this.ctx;
        try {
            const roleid = ctx.request.headers['roleid']
            if (!roleid) return ctx.api_fail({ msg: "角色缺失, 请联系管理员添加角色!" })
            const result = await ctx.model.ClientRole.findById(roleid);
            if (!result.menus) return ctx.api_fail({ msg: "菜单缺失, 请联系管理员配置菜单!" })
            const menus = await ctx.model.ClientMenu.find({ _id: { $in:  result.menus } });
            ctx.api_success_data(menus);
        } catch (error) {
            ctx.api_error_msg(error);
        }
    }
}

module.exports = ClientRoleController;
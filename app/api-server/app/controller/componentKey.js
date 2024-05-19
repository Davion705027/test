"use strict";

const Controller = require("egg").Controller;
class ConfigVersionController extends Controller {
  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;
    try {
      const regex_list = ['name', 'component_name']
      const query = ['project', ...regex_list].reduce((origin, key) => {
        if (ctx.query[key] !== undefined) {
          origin[key] = regex_list.includes(key) ? { $regex: ctx.query[key], $options: "i", } : ctx.query[key]
        }
        return origin
      }, {})

      const result = await ctx.model.ComponentKey.paginate(query, {
        page: ctx.toInt(ctx.query.currentPage),
        limit: ctx.toInt(ctx.query.pageSize),
        sort: { createdAt: -1 },
      });
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }

  /**
   * 更新 一条数据
   * @returns
   */
  async update() {
    const ctx = this.ctx;
    try {
      const { id, ...data } = ctx.request.body
      await ctx.model.ComponentKey.findByIdAndUpdate(id, data);
      ctx.api_success_data(true);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }



  /**
   * 组件文档 菜单
   */
  async menus() {
    const ctx = this.ctx;
    try {
      const project_list = await ctx.model.LayoutTemplate.find(null, { name: 1, project: 1 })

      const componentKeyFilter = { project: { $in: [] } }
      const project_map = project_list.reduce((o, v) => {
        componentKeyFilter.project.$in.push(v.project)
        o[v.project] = { name: v.name, project: v.project, childs: [] }
        return o
      }, {})

      const componentKey_list = await ctx.model.ComponentKey.find(
        componentKeyFilter,
        { name: 1, component_name: 1, project: 1, enable_version: 1, },
        { sort: { createAt: -1 } }
      )

      for (let i = 0, item; (item = componentKey_list[i]); i++) {
        if (project_map[item.project]) project_map[item.project].childs.push(item)
      }

      ctx.api_success_data(Object.values(project_map));
    } catch (error) {
      ctx.api_error_msg(error)
    }
  }

}
module.exports = ConfigVersionController;

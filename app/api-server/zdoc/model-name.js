/*
 * @Date           : 2022-03-11 10:59:12
 * @FilePath       : /client-api-doc-server/zdoc/model-name.js
 * @Description    : 
 */

// app/model/model-name.js


module.exports= app =>{
    const {  STRING, INTEGER, DATE} = app.Sequelize;
    
    const ModelName = app.model.define('ModelName',{
        login: STRING,
        name: STRING(30),
        password:STRING(32),
        age:INTEGER,
        last_sign_in_at:DATE,
        created_at:DATE,
        updated_at:DATE,
    });

    ModelName.findByLogin = async function(login){
        return await this.findOne({
            where:{
                login:login
            }
        })
    }

    // 不能使用箭头函数 
    ModelName.prototype.logSignin= async function(){
        return await this.update({
            last_sign_in_at: new Date()
        })
    }

    return ModelName

}





// app/controller/model-name.js
const { Controller } = require('egg');

class ModelNameController extends Controller {
  /**
   * GET /api/model-name
   */
  async index() {
    const { ctx } = this;

    const response = {};
    try {
      // 分页
      const result = await ctx.service.modelName.getList(ctx.query, ctx.query.offset, ctx.query.limit);
      response.data = result.data;
      result.paging && (response.paging = result.paging);
      response.success = true;
    } catch(err) {
      response.error = {
        message: err,
      };
      response.success = false;
    }

    ctx.body = response;
  }

  /**
   * GET /api/model-name/:id
   */
  async show() {
    const { ctx } = this;
    const { id } = ctx.params;

    const response = {};
    try {
      const result = await ctx.service.modelName.get(id);
      response.data = result;
      response.success = true;
    } catch (err) {
      response.error = {
        message: err,
      };
      response.success = false;
    }
    ctx.body = response;
  }

  /**
   * GET /api/model-name/:id/edit
   */
  async edit() {
    const { ctx } = this;
    const { id } = ctx.params;

    const response = {};
    try {
      await ctx.service.modelName.edit(ctx.query, id);
      response.success = true;
    } catch (err) {
      response.error = {
        message: err,
      };
      response.success = false;
    }
    ctx.body = response;
  }

  /**
   * POST /api/model-name
   */
  async create() {
    const { ctx } = this;

    const response = {};
    try {
      const res = await ctx.service.modelName.create(ctx.request.body);
      response.data = res;
      response.success = true;
    } catch (err) {
      response.error = {
        message: err,
      };
      response.success = false;
    }
    ctx.body = response;
  }

  /**
   * PUT /api/model-name/:id
   */
  async update() {
    const { ctx } = this;
    const { id } = ctx.params;

    const response = {};
    try {
      await ctx.service.modelName.update(ctx.request.body, id);
      response.success = true;
    } catch (err) {
      response.error = {
        message: err,
      };
      response.success = false;
    }
    ctx.body = response;
  }

  /**
   * DELETE /api/model-name/:id
   */
  async destroy() {
    const { ctx } = this;
    const { id } = ctx.params;

    const response = {};
    try {
      await ctx.service.modelName.destroy(id);
      response.success = true;
    } catch (err) {
      response.error = {
        message: err,
      };
      response.success = false;
    }
    ctx.body = response;
  }
}

module.exports = ModelNameController;


// app/service/model-name.js
const { Service } = require('egg');

class ModelNameService extends Service {
  async getList(query, offset, limit) {
    const { ctx } = this;

    const queryOption = {};
    const paging = {};
    const result = {};

    const hasPaging = offset !== undefined || limit !== undefined;
      if (hasPaging) {
        queryOption.offset = Number(offset) || 0;
        queryOption.limit = Number(limit) || 10;
        paging.offset = queryOption.offset;
        paging.limit = queryOption.limit;

        // 这个名字可配置 待定
        delete query.offset;
        delete query.limit;
      }

      const where = {
        ...query,
        // 自定义查询参数参数
      };

      queryOption.where = where;

      // 其他参数
      // queryOption.order = [['createdAt', 'desc']];

      const res = await ctx.model.ModelName.findAll(queryOption);
      result.data = res;

      if (hasPaging) {
        // 获取总数
        const total = await ctx.model.ModelName.findAndCountAll({
          where
        });
        if (total) {
          paging.total = total ? total.count : 0;
        }
        result.paging = paging;
      }
      return result;
  }

  async get(id) {
    const { ctx } = this;
    const result = await ctx.model.ModelName.findOne({
      where: {
        id,
      }
    });
    return result;
  }

  async edit(data={}, id) {
    const { ctx } = this;
    ctx.model.ModelName.update({
      ...data
    }, {
      where: {
        id,
      }
    });
  }

  async create(data={}) {
    const { ctx } = this;
    const result = {};
    const res = await ctx.model.ModelName.create({
      ...data
    });
    if (res) {
      result.id = res.id;
    }
    return result;
  }

  async update(data={}, id) {
    const { ctx } = this;
    ctx.model.ModelName.update({
      ...data
    }, {
      where: {
        id,
      }
    });
  }

  async destroy(id) {
    const { ctx } = this;
    ctx.model.ModelName.destroy({
      where: {
        id,
      }
    });
  }
}

module.exports = ModelNameService;

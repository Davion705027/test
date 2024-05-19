'use strict';

const Service = require('egg').Service;
class CommodityService extends Service{
  // create 添加数据
  async addCommodity(query) {
    const result = await this.ctx.model.CommodityInfo.create(query); // 插入一条
    return result
  }
  // 查询
  async queryCommodity(query) {
    let { price } = query
    let params = { price }
    console.log('---------------')
    console.log(params)
    const result = await this.ctx.model.CommodityInfo.find(params).exec(); // 插入一条
    return result
  }
  
}
module.exports = CommodityService;
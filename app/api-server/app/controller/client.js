"use strict";
const Controller = require("egg").Controller;
class ClientController extends Controller {
  async findKey() {
    const { ctx } = this;
    try {
      const result = await ctx.service.client.findKey();
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
}


module.exports = ClientController;

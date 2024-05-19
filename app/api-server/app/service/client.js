"use strict";

const Service = require("egg").Service;

class ClientService extends Service {
  async findKey() {
    let { project, key_type } =this.ctx.query;

    let model_name =
      this.ctx.assistant.key_type_val_to_model_map[`key_${key_type}`];

    let query = { project };

    let result = await this.ctx.model[model_name].find(query);
    return result;
  }
}

module.exports = ClientService;

/*
 * @Date           : 2022-03-13 23:48:39
 * @LastEditTime   : 2022-04-06 15:18:25
 * @Description    :
 */

const mongoose = require("mongoose");
var randomstring = require("randomstring");
var mongodb_connect_fn = require("../mongodb.config");
var model_builder_fn_admin = require("../../app/model/admin");
var model_builder_fn_role = require("../../app/model/role");
async function main() {
  await mongodb_connect_fn();

  //生成角色数据
  const role_Model = model_builder_fn_role({ mongoose });

  let role_data = {
    name: "超级管理员",
    menus: ["admin", "user", "clientRoleManager", "clientMenuManager", "role"],
    mark: "超级管理员",
  };

  let role_doc = await role_Model.create(role_data);

  // 生产管理员数据
  if (role_doc) {
    let roleId = role_doc._id;

    const admin_Model = model_builder_fn_admin({ mongoose });

    let admin_data = {
      name: "admin",
      password: "123456",
      roleId: new mongoose.Types.ObjectId(roleId),
    };

    await admin_Model.create(admin_data);
  }

  console.log("执行完毕");
  process.exit(0);
}
main().catch((err) => console.log(err));

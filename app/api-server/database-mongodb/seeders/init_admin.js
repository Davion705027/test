/*
 * @Date           : 2022-03-13 23:48:39
 * @LastEditTime   : 2022-04-06 15:18:25
 * @Description    :
 */

const mongoose = require("mongoose");
const mongodb_connect_fn = require("../mongodb.config");
const model_role = require("../../app/model/role");
const model_admin = require("../../app/model/admin");

async function main() {
  await mongodb_connect_fn();
  const RoleModel = model_role({ mongoose });
  const role = await RoleModel.create({
    name: "管理员",
    menus: [
      "user",
      "admin",
      "role",
      "appAssets",
      "language",
      "clientLanguage",
      "questionTopic",
      "docpool",
      "menu",
      "appSdkVersion",
      "configVersion",
      "layoutTemplate",
      "themeTemplate",
      "cssKey",
      "jsKey",
      "assetsKey",
      "componentKey",
      "i18nKey",
      "keyGroup",
      "keyChangeRecord",
      "keyConfigRecord",
      "packingConfig",
      "packingRecord",
      "packingProcess",
      "competitionManage",
      "mddocpool",
      "adminRecord",
      "tool",
      "matchList",
    ],
  });

  const AdminModel = model_admin({ mongoose });
  AdminModel.create({
    name: 'admin',
    password: '123456',
    roleId: role.id
  })

  console.log("执行完毕");
  process.exit(0);
}
main().catch((err) => console.log(err));

/*
 * @Date           : 2022-03-13 23:48:39
 * @LastEditTime   : 2022-04-06 15:18:25
 * @Description    :  
 */



const mongoose = require("mongoose");
var randomstring = require("randomstring");
var mongodb_connect_fn = require("../mongodb.config");
var model_builder_fn = require("../../app/model/admin");
async function main() {
  await mongodb_connect_fn();
  const  Model = model_builder_fn({ mongoose });
  let data = [
    {
      name:"admin",
      password:'123456',
      roleId: '662618fa80be38f2843ce5af'
    }
  ];
 
  await  Model.create(data);
  console.log("执行完毕");
  process.exit(0);
}
main().catch((err) => console.log(err));

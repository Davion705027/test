/*
 * @Date           : 2022-03-13 23:48:39
 * @LastEditTime   : 2022-03-28 14:42:38
 * @Description    :  
 */



const mongoose = require("mongoose");
var randomstring = require("randomstring");
var mongodb_connect_fn = require("../mongodb.config");
var model_builder_fn = require("../../app/model/user");
async function main() {
  await mongodb_connect_fn();
  const  Model = model_builder_fn({ mongoose });
  let data = [];
  for (let index = 0; index < 50; index++) {
    data.push({
      name: randomstring.generate(15),
      password: randomstring.generate(15),
      age: parseInt(Math.random() * 100),
    });
  }
  await  Model.create(data);
  console.log("执行完毕");
  process.exit(0);
}
main().catch((err) => console.log(err));

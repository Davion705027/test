/*
 * @Date           : 2022-04-03 20:56:47
 * @LastEditTime   : 2022-04-03 20:56:47
 * @Description    :  
 */

const mongoose = require("mongoose");
var randomstring = require("randomstring");
var mongodb_connect_fn = require("../mongodb.config");
var model_builder_fn = require("../../app/model/article");
async function main() {
  await mongodb_connect_fn();
  const  Model = model_builder_fn({ mongoose });
  let data = [];
  for (let index = 0; index < 50; index++) {
    data.push({
        author:'admin',
      type:1,
      updateRecord:[1],
      topic:[1],
      status:-1,
      is_top:false,
      is_best:false,
      moment_content: randomstring.generate(120),
      moment_images:["public/1.png"]



    });
  }
  await  Model.create(data);
  console.log("执行完毕");
  process.exit(0);
}
main().catch((err) => console.log(err));

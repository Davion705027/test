/*
 * @Date           : 2022-03-13 23:48:39
 * @LastEditTime   : 2022-04-08 20:32:15
 * @Description    :  
 */



const mongoose = require("mongoose");
var randomstring = require("randomstring");
var mongodb_connect_fn = require("../mongodb.config");
var model_builder_fn = require("../../app/model/docpool");
async function main() {
  await mongodb_connect_fn();
  const  Model = model_builder_fn({ mongoose });
  let data = [];
  for (let index = 0; index < 50; index++) {
    data.push({
      title_zn: randomstring.generate(15),
      title_en: randomstring.generate(15),
      content_zn: randomstring.generate(415),
      content_en: randomstring.generate(415),
     
    });
  }
  await  Model.create(data);
  console.log("执行完毕");
  process.exit(0);
}
main().catch((err) => console.log(err));

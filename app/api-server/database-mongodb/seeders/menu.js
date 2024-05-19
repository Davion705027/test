/*
 * @Date           : 2022-04-08 20:46:32
 * @LastEditTime   : 2022-04-09 10:45:04
 * @Description    :  
 */

const mongoose = require("mongoose");
var randomstring = require("randomstring");
var mongodb_connect_fn = require("../mongodb.config");
var model_builder_fn = require("../../app/model/menu");
async function main() {
  await mongodb_connect_fn();
  const  Model = model_builder_fn({ mongoose });
  let data = [];
 
  
    data.push({
      title_zn: "所有菜单",
      title_en: "all",
      fatherId:"-1",
      mark:'所有菜单的根节点，不能删除',
      type:1,
      status:1
    });
 
  await  Model.create(data);
 


//   await  Model.findOneAndUpdate({
//     title_zn: "所有菜单",
//       title_en: "all",   
//   }, { _id: "100000000000" },  )
console.log("执行完毕");
  process.exit(0);

}
main().catch((err) => console.log(err));



 
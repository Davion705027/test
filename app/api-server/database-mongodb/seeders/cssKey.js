/*
 * @Date           : 2022-03-13 23:48:39
 * @LastEditTime: 2023-10-10 11:57:07
 * @Description    :  
 */



const mongoose = require("mongoose");
var randomstring = require("randomstring");
var mongodb_connect_fn = require("../mongodb.config");
var model_builder_fn = require("../../app/model/cssKey");

var data_h5 = require("../data/css根变量-H5.json");
var data_pc = require("../data/css根变量-PC.json");

async function main() {
  await mongodb_connect_fn();
  const  Model = model_builder_fn({ mongoose });
  let data = [
    // ...data_h5,
    // ...data_pc,
    {
      "key": "border-color-1",
      "group": "border_color",
      "group_id": "6524c0056cb1af16a9773e76",
      "project": 1,
      "root": -1,
      "description": "",
      "mark": "",
      "value": "#393939",
    },
    {
      "key": "color-1",
      "group": "color",
      "group_id": "6524c0056cb1af16a9773e78",
      "project": 1,
      "root": -1,
      "description": "",
      "mark": "",
      "value": "#393939",
    },
  ];
  await  Model.create(data);
  console.log("执行完毕");
  process.exit(0);
}
main().catch((err) => console.log(err));

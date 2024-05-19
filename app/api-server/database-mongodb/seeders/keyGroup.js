/*
 * @Date           : 2022-03-13 23:48:39
 * @LastEditTime: 2023-10-10 11:07:45
 * @Description    :  
 */



const mongoose = require("mongoose");
var randomstring = require("randomstring");
var mongodb_connect_fn = require("../mongodb.config");
var model_builder_fn = require("../../app/model/keyGroup");


let group=[
  "border",
"color",
"page_bg",
"background",
"linear_gradient",
"img_bg",
"skeleton_bg",
"fs_color",
"border_color",
"box_shadow" 
]

let data=[]


group.map(x=>{
  data.push( { names:{
    'zh_cn':x
  }  ,key:x, project: 1,  key_type: 1, descriptions:{
    'zh_cn':x
  }, status:1, })
  data.push( { names: {
    'zh_cn':x
  } , key:x,project: 2,  key_type: 1, descriptions:{
    'zh_cn':x
  }, status:1, })
})
 

async function main() {
  await mongodb_connect_fn();
  const  Model = model_builder_fn({ mongoose });
 
 
  await  Model.create(data);
  console.log("执行完毕");
  process.exit(0);
}
main().catch((err) => console.log(err));

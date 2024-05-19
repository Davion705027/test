/*
 * @Date           : 2022-03-13 23:48:39
 * @LastEditTime   : 2022-04-06 15:18:25
 * @Description    :  
 */



const mongoose = require("mongoose");
var randomstring = require("randomstring");
var mongodb_connect_fn = require("../mongodb.config");
var model_builder_fn = require("../../app/model/language");
async function main() {
  await mongodb_connect_fn();
  const  Model = model_builder_fn({ mongoose });
  const t = new Date();
  let data = [
    {
      name_zh: "中文简体",
      name_en: "Chinese",
      value: "zh_cn",
      order: 1,
      created_at: t,
      updated_at: t,
    },
    {
      name_zh: "中文繁体",
      name_en: "Traditional Chinese",
      value: "zh_tw",
      order: 1,
      created_at: t,
      updated_at: t,
    },
    {
      name_zh: "英文",
      name_en: "English",
      value: "en_gb",
      order: 1,
      created_at: t,
      updated_at: t,
    },
    {
      name_zh: "越南语",
      name_en: "Vietnamese",
      value: "vi_vn",
      order: 1,
      created_at: t,
      updated_at: t,
    },
    {
      name_zh: "泰语",
      name_en: "Thai",
      value: "th_th",
      order: 1,
      created_at: t,
      updated_at: t,
    },
    {
      name_zh: "韩语",
      name_en: "Korean",
      value: "ko_kr",
      order: 1,
      created_at: t,
      updated_at: t,
    },
    {
      name_zh: "印度语",
      name_en: "Hindi",
      value: "id_id",
      order: 1,
      created_at: t,
      updated_at: t,
    },
    {
      name_zh: "葡萄牙语",
      name_en: "Portuguese",
      value: "pt_br",
      order: 1,
      created_at: t,
      updated_at: t,
    },
    {
      name_zh: "柬埔寨语",
      name_en: "Cambodian",
      value: "km_kh",
      order: 1,
      created_at: t,
      updated_at: t,
    },
    {
      name_zh: "日本语",
      name_en: "Japanese",
      value: "ja_jp",
      order: 1,
      created_at: t,
      updated_at: t,
    },
  ];
 
  await  Model.create(data);
  console.log("执行完毕");
  process.exit(0);
}
main().catch((err) => console.log(err));

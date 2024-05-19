

const moment  = require("moment");

// const markdownit = require("markdown-it")

const fs = require('fs/promises')

const utils={}
const path = require('node:path');

const markdownit = require("markdown-it")
const md_html_wapper = require("./markdown-html.js")










utils.render_markdown_file = async (params={})=> {
  console.log('==params==', params);
 
  let {file_path ,docId} = params
  if(!file_path){
    return ''
  }
  let  content =''
  let  result =''
try {
 let full_path = path.join( __dirname ,"../../static/",file_path)
 
  content = await  fs.readFile(   full_path   )
  // content = await  fs.readFile(   full_path ,{encoding:'utf8'} )
  content = content.toString('utf8')
  content = content .replace(".sportxxxkd1.com",'.dbsportxxxkd1.com');
  const md = markdownit()
  result =  md_html_wapper( md.render(content) ,{docId})
 
 
} catch (error) {

 
  result =  md_html_wapper(   `<h3>------error--------:读取内容失败</h3>  <div>${ error}</div>`,{}  ) 
   
}
return result
}

utils.rebuild_file_name =(filename)=>{
    let save_name=''
    let arr =filename.split(".").filter(x=>x)
    let extname = arr[arr.length-1]
    arr = arr.slice(0,arr.length-1)
    
  
    save_name =  arr.join("")
  
    save_name = save_name.replace(".",'-')
    save_name = save_name.replace("/",'-')
    save_name = save_name.replace("\\",'-')
  
    save_name = moment().format( "YYYYMMDDhhmmss" ) +'-'+ save_name;
  
    save_name =  save_name+'.'+ extname
   
    return save_name
  } 


  utils.randomstring=(n = 16) => {
    let result = "";
    let str = "abcdefghijk1mnopqrstuvwxyz0123456789";
    for (let i = 0; i < n; i++) {
      let i = Math.floor(Math.random() * str.length);
      result += str[i];
    }

    return result;
  }


module.exports = utils
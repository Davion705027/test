


const md_html_wapper =(str,params={})=>{

    return `
    
    <!DOCTYPE html>
  <html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>体育对接文档</title>

    <style>
     .qianduan-tixing {
        color:#f00;
     }
 
    
    .markdown-github-style {
        font-family: Helvetica, arial, sans-serif;
        font-size: 14px;
        line-height: 1.6;
        padding-top: 10px;
        padding-bottom: 10px;
        background-color: white;
        padding: 30px;
        color: #333;
      }
      
      .markdown-github-style > *:first-child {
        margin-top: 0 !important;
      }
      
      .markdown-github-style > *:last-child {
        margin-bottom: 0 !important;
      }
      
      .markdown-github-style > h2:first-child {
        margin-top: 0;
        padding-top: 0;
      }
      
      .markdown-github-style > h1:first-child {
        margin-top: 0;
        padding-top: 0;
      }
      
      .markdown-github-style > h1:first-child + h2 {
        margin-top: 0;
        padding-top: 0;
      }
      
      .markdown-github-style a {
        color: #4183c4;
        text-decoration: none;
      }
      
      .markdown-github-style a.absent {
        color: #cc0000;
      }
      
      .markdown-github-style a.anchor {
        display: block;
        padding-left: 30px;
        margin-left: -30px;
        cursor: pointer;
        position: absolute;
        top: 0;
        left: 0;
        bottom: 0;
      }
      
      .markdown-github-style h1, .markdown-github-style h2, .markdown-github-style h3, .markdown-github-style h4, .markdown-github-style h5, .markdown-github-style h6 {
        margin: 20px 0 10px;
        padding: 0;
        font-weight: bold;
        -webkit-font-smoothing: antialiased;
        cursor: text;
        position: relative;
      }
      
      .markdown-github-style h2:first-child, .markdown-github-style h1:first-child, .markdown-github-style h1:first-child + h2, .markdown-github-style h3:first-child, .markdown-github-style h4:first-child, .markdown-github-style h5:first-child, .markdown-github-style h6:first-child {
        margin-top: 0;
        padding-top: 0;
      }
      
      .markdown-github-style h1:hover a.anchor, .markdown-github-style h2:hover a.anchor, .markdown-github-style h3:hover a.anchor, .markdown-github-style h4:hover a.anchor, .markdown-github-style h5:hover a.anchor, .markdown-github-style h6:hover a.anchor {
        text-decoration: none;
      }
      
      .markdown-github-style h1 tt, .markdown-github-style h1 code {
        font-size: inherit;
      }
      
      .markdown-github-style h2 tt, .markdown-github-style h2 code {
        font-size: inherit;
      }
      
      .markdown-github-style h3 tt, .markdown-github-style h3 code {
        font-size: inherit;
      }
      
      .markdown-github-style h4 tt, .markdown-github-style h4 code {
        font-size: inherit;
      }
      
      .markdown-github-style h5 tt, .markdown-github-style h5 code {
        font-size: inherit;
      }
      
      .markdown-github-style h6 tt, .markdown-github-style h6 code {
        font-size: inherit;
      }
      
      .markdown-github-style h1 {
        font-size: 28px;
        color: black;
      }
      
      .markdown-github-style h2 {
        font-size: 24px;
        border-bottom: 1px solid #cccccc;
        color: black;
      }
      
      .markdown-github-style h3 {
        font-size: 18px;
      }
      
      .markdown-github-style h4 {
        font-size: 16px;
      }
      
      .markdown-github-style h5 {
        font-size: 14px;
      }
      
      .markdown-github-style h6 {
        color: #777777;
        font-size: 14px;
      }
      
      .markdown-github-style p, .markdown-github-style blockquote, .markdown-github-style ul, .markdown-github-style ol, .markdown-github-style dl, .markdown-github-style li, .markdown-github-style table, .markdown-github-style pre {
        margin: 15px 0;
      }
      
      .markdown-github-style hr {
        border: 0 none;
        color: #cccccc;
        height: 4px;
        padding: 0;
      }
      
      .markdown-github-style body > h3:first-child, .markdown-github-style body > h4:first-child, .markdown-github-style body > h5:first-child, .markdown-github-style body > h6:first-child {
        margin-top: 0;
        padding-top: 0;
      }
      
      .markdown-github-style a:first-child h1, .markdown-github-style a:first-child h2, .markdown-github-style a:first-child h3, .markdown-github-style a:first-child h4, .markdown-github-style a:first-child h5, .markdown-github-style a:first-child h6 {
        margin-top: 0;
        padding-top: 0;
      }
      
      .markdown-github-style h1 p, .markdown-github-style h2 p, .markdown-github-style h3 p, .markdown-github-style h4 p, .markdown-github-style h5 p, .markdown-github-style h6 p {
        margin-top: 0;
      }
      
      .markdown-github-style li p.first {
        display: inline-block;
      }
      
      .markdown-github-style ul, .markdown-github-style ol {
        padding-left: 30px;
      }
      
      .markdown-github-style ul :first-child, .markdown-github-style ol :first-child {
        margin-top: 0;
      }
      
      .markdown-github-style ul :last-child, .markdown-github-style ol :last-child {
        margin-bottom: 0;
      }
      
      .markdown-github-style dl {
        padding: 0;
      }
      
      .markdown-github-style dl dt {
        font-size: 14px;
        font-weight: bold;
        font-style: italic;
        padding: 0;
        margin: 15px 0 5px;
      }
      
      .markdown-github-style dl dt:first-child {
        padding: 0;
      }
      
      .markdown-github-style dl dt > :first-child {
        margin-top: 0;
      }
      
      .markdown-github-style dl dt > :last-child {
        margin-bottom: 0;
      }
      
      .markdown-github-style dl dd {
        margin: 0 0 15px;
        padding: 0 15px;
      }
      
      .markdown-github-style dl dd > :first-child {
        margin-top: 0;
      }
      
      .markdown-github-style dl dd > :last-child {
        margin-bottom: 0;
      }
      
      .markdown-github-style blockquote {
        border-left: 4px solid #dddddd;
        padding: 0 15px;
        color: #777777;
      }
      
      .markdown-github-style blockquote > :first-child {
        margin-top: 0;
      }
      
      .markdown-github-style blockquote > :last-child {
        margin-bottom: 0;
      }
      
      .markdown-github-style table {
        padding: 0;
      }
      
      .markdown-github-style table tr {
        border-top: 1px solid #cccccc;
        background-color: white;
        margin: 0;
        padding: 0;
      }
      
      .markdown-github-style table tr:nth-child(2n) {
        background-color: #f8f8f8;
      }
      
      .markdown-github-style table tr th {
        font-weight: bold;
        border: 1px solid #cccccc;
        text-align: left;
        margin: 0;
        padding: 6px 13px;
      }
      
      .markdown-github-style table tr td {
        border: 1px solid #cccccc;
        text-align: left;
        margin: 0;
        padding: 6px 13px;
      }
      
      .markdown-github-style table tr th :first-child, .markdown-github-style table tr td :first-child {
        margin-top: 0;
      }
      
      .markdown-github-style table tr th :last-child, .markdown-github-style table tr td :last-child {
        margin-bottom: 0;
      }
      
      .markdown-github-style img {
        max-width: 100%;
      }
      
      .markdown-github-style span.frame {
        display: block;
        overflow: hidden;
      }
      
      .markdown-github-style span.frame > span {
        border: 1px solid #dddddd;
        display: block;
        float: left;
        overflow: hidden;
        margin: 13px 0 0;
        padding: 7px;
        width: auto;
      }
      
      .markdown-github-style span.frame span img {
        display: block;
        float: left;
      }
      
      .markdown-github-style span.frame span span {
        clear: both;
        color: #333333;
        display: block;
        padding: 5px 0 0;
      }
      
      .markdown-github-style span.align-center {
        display: block;
        overflow: hidden;
        clear: both;
      }
      
      .markdown-github-style span.align-center > span {
        display: block;
        overflow: hidden;
        margin: 13px auto 0;
        text-align: center;
      }
      
      .markdown-github-style span.align-center span img {
        margin: 0 auto;
        text-align: center;
      }
      
      .markdown-github-style span.align-right {
        display: block;
        overflow: hidden;
        clear: both;
      }
      
      .markdown-github-style span.align-right > span {
        display: block;
        overflow: hidden;
        margin: 13px 0 0;
        text-align: right;
      }
      
      .markdown-github-style span.align-right span img {
        margin: 0;
        text-align: right;
      }
      
      .markdown-github-style span.float-left {
        display: block;
        margin-right: 13px;
        overflow: hidden;
        float: left;
      }
      
      .markdown-github-style span.float-left span {
        margin: 13px 0 0;
      }
      
      .markdown-github-style span.float-right {
        display: block;
        margin-left: 13px;
        overflow: hidden;
        float: right;
      }
      
      .markdown-github-style span.float-right > span {
        display: block;
        overflow: hidden;
        margin: 13px auto 0;
        text-align: right;
      }
      
      .markdown-github-style code, .markdown-github-style tt {
        margin: 0 2px;
        padding: 0 5px;
        white-space: nowrap;
        border: 1px solid #eaeaea;
        background-color: #f8f8f8;
        color:#fff;
        border-radius: 3px;
      }
      
      .markdown-github-style pre {
        background-color: #000;
        color:#fff;
        border: 1px solid #cccccc;
       
        font-size: 13px;
        line-height: 19px;
        overflow: auto;
        padding: 6px 10px;
        border-radius: 3px;
      }
      
      .markdown-github-style pre code {
        color:#fff;
        margin: 0;
        padding: 0;
        white-space: pre;
        border: none;
        background: transparent;
      }
      
      .markdown-github-style .highlight pre {
        background-color: #000;
        color:#fff;
        border: 1px solid #cccccc;
        font-size: 13px;
        line-height: 19px;
        overflow: auto;
        padding: 6px 10px;
        border-radius: 3px;
      }
      
      .markdown-github-style pre code, .markdown-github-style pre tt {
        background-color: transparent;
        border: none;
      }
      
    
    </style>
  </head>
  <body>
  
  <h2 class="qianduan-tixing"> 你当前打开的是体育团队对接文档内容 ，内容仅仅辅助理解，不作为标准解释，如有疑问联系体育前端团队！</h2>
  <h2 class="qianduan-tixing"> 文档ID:    ${params.docId || '未知' }</h2>
  <div class="markdown-github-style">
  ${str}
  </div>
   


  </body>
  </html>
  
    
    `
  }
 
  




module.exports = md_html_wapper
/*
 * @Date           : 2022-03-29 20:57:44
 * @LastEditTime   : 2022-04-15 19:35:18
 * @Description    :
 */
/* eslint valid-jsdoc: "off" */

"use strict";
/**
 * @param {Egg.EggAppInfo} appInfo app info
 */
module.exports = (appInfo) => {
  /**
   * built-in config
   * @type {Egg.EggAppConfig}
   **/
  const config = (exports = {});

  config.SERVER_API_DOMAIN ="https://api-doc-server-new.dbsporxxxw1box.com"

  config.cluster = {
    listen: {
      port: 18101,
      hostname: '0.0.0.0',
      // hostname: '127.0.0.1', // 不建议设置 hostname 为 '0.0.0.0'，它将允许来自外部网络和来源的连接，请在知晓风险的情况下使用
      // path: '/var/run/egg.sock',
    },
  };

  // use for cookie sign key, should change to your own and keep security
  config.keys = appInfo.name + "_1645787157801_459";

  // add your middleware config here
  // config.middleware = ["jwterr"];
  config.jwterr = {
    enable: true,
    match: /^((?!login).)*$/,
  };

  // add your user config here
 
    // myAppName: 'egg',
    // 洋葱模型   中间件  数据 方向：   左边第一个 中间件 流入 到最右边最后一个中间件 执行完 next 执行核心事务，然后从 最右边最后一个中间件 原路返回 到最左边第一个中间件 ，数据流出返回给客户端
    config. middleware= ["errorHandler","jwterr",'cost','auth',"adminRecord"]
 
  config.security = {
    csrf: {
      enable: false,
      ignoreJSON: true,
    },
    // myAppName: 'egg',
    // domainWhiteList: ['http://localhost:8080'],//允许访问接口的白名单
  };

  config.mongoose = {
    client: {
      url: "mongodb://127.0.0.1:27017/api_doc_new", // cms_dev_1是collection(数据库)名称
      options: {}, // 其他配置项
      // mongoose global plugins, expected a function or an array of function and options
      plugins: [],
    },
  };
 
  // https://www.eggjs.org/zh-CN/core/logger

  
  // // 错误日志记录，直接会将错误日志完整堆栈信息记录下来，并且输出到 errorLog 中
  // // 为了保证异常可追踪，必须保证所有抛出的异常都是 Error 类型，因为只有 Error 类型才会带上堆栈信息，定位到问题。
 
  exports.logger = {
    dir: './rizhi-jilu/',
    appLogName: `${appInfo.name}-web.log`,
    coreLogName: 'egg-web.log',
    agentLogName: 'egg-agent.log',
    errorLogName: 'common-error.log',
    // level: 'WARN',  日志分为 NONE，DEBUG，INFO，WARN 和 ERROR 5 个级别。
  };
  config.cors = {
    origin: "*",
    allowMethods: "GET,HEAD,PUT,POST,DELETE,PATCH",
  };
  // https://www.npmjs.com/package/egg-multipart
  config.multipart = {
    // mode: "file",
    // mode: 'stream',
    // let POST /upload
    mode: 'stream',
    fileSize: '500mb', 
    fileModeMatch: /(\/file\/upload)|(\/appAssets\/create)|(\/matchMaterial\/upload)/,
    allowArrayField: true,
    whitelist : [
      // images
      ".jpg",
      ".jpeg", // image/jpeg
      ".png", // image/png, image/x-png
      ".gif", // image/gif
      ".bmp", // image/bmp
      ".wbmp", // image/vnd.wap.wbmp
      ".webp",
      // ".tif",
      // ".psd",
      // text
      ".svg",
      // ".js",
      // ".jsx",
      ".json",
      // ".css",
      // ".less",
      // ".html",
      // ".htm",
      // ".xml",
      // tar
      ".zip",
      // ".gz",
      // ".tgz",
      // ".gzip",
      // video
      ".mp3",
      ".mp4",
      ".avi",
      //other
      ".md",
      ".drawio",
      // ".xlsx",
      // ".doc",
      ".apk",
      ".ipa",
      ".svga",
      ".txt"
    ]
  };

  config.session = {
    maxAge: 24 * 3600 * 1000, // ms
    key: "EGG_SESS",
    httpOnly: true,
    encrypt: true,
    // sameSite: null,
    logValue: true,
  };
  // jwt.sign(payload, secretOrPrivateKey, [options, callback])
  config.jwt = {
    secret: "ddedef668899",
    enable: true,
     match: /^((?!(login|public|yunwei|openapi)).)*$/,
     expiresIn:'12h'
   
    // https://zhuanlan.zhihu.com/p/42930189
  };
  config.api_prefix = {
    backend_prefix: "/backend",
    client_prefix: "/client",
  };

  // 文件上传目录
  config.upload_dir = "static/public/upload/";


  config.static = {
    // maxAge: 31536000,
    // dir: path.join(appInfo.baseDir, 'static/public')
    dir: 'static/public'
  };

   // BodyParser 中间件配置
   config.bodyParser = {
    jsonLimit: '20mb',
    formLimit: '20mb',
  };




config. onerror= {
  all(err, ctx) {
    console.log( 'err-------------------');
    console.log( err);
    // 在此处定义针对所有响应类型的错误处理方法
    // 注意，定义了 config.all 之后，其他错误处理方法不会再生效

 

   if(err.status==401){
     console.log('err.status==401');
     ctx.status = 200;
 
     ctx.set('content-type', "application/json; charset=utf-8") 
     ctx.body = { code:401, msg:"请先登录" }
  
   }else{
    ctx.status = 200;
 
    ctx.set('content-type', "application/json; charset=utf-8") 
    ctx.body = {
      code:500,
      msg: "服务器异常"
    }
   }

  },
  // html(err, ctx) {
  //   // html hander
  //   ctx.body = '<h3>error-ssssssssssssssssssssssss</h3>';
  //   ctx.status = 500;
  // },
  // json(err, ctx) {
  //   // json hander
  //   ctx.body = { message: 'error' };
  //   ctx.status = 500;
  // },
  // jsonp(err, ctx) {
  //   // 一般来说，不需要特殊针对 jsonp 进行错误定义，jsonp 的错误处理会自动调用 json 错误处理，并包装成 jsonp 的响应格式
  // },
};




  //开启 关键 文档 删除功能
  config.open_delete_fn = true



  return {
    ...config,
   
  };
};

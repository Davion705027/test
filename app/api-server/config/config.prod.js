/*
 * @Date           : 2022-03-29 20:57:44
 * @LastEditTime   : 2022-04-12 16:02:10
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


  config.mongoose = {
    client: {
      url: "mongodb://admin:VNJ0t8ej9ZRHeUpt@127.0.0.1:27017/api_doc_test?authSource=admin",  
      // url: "mongodb://admin:VNJ0t8ej9ZRHeUpt@127.0.0.1:27017/api_doc",  
     
      options: {
        useUnifiedTopology: true
      }, // 其他配置项
      // mongoose global plugins, expected a function or an array of function and options
      plugins: [],
    },
  };
    // myAppName: 'egg',
    // 洋葱模型   中间件  数据 方向：   左边第一个 中间件 流入 到最右边最后一个中间件 执行完 next 执行核心事务，然后从 最右边最后一个中间件 原路返回 到最左边第一个中间件 ，数据流出返回给客户端
    config. middleware= ["errorHandler","jwterr",'cost','auth',]


      //开启 关键 文档 删除功能
  config.open_delete_fn = false
  return {
    ...config,
  };
};

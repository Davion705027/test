/*
 * @Date           : 2022-03-29 20:57:44
 * @LastEditTime   : 2022-04-13 15:58:14
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

  config.SERVER_API_DOMAIN ="http://127.0.0.1:18101"

  config.cluster = {
    listen: {
      port: 18101,
      // hostname: '127.0.0.1', // 不建议设置 hostname 为 '0.0.0.0'，它将允许来自外部网络和来源的连接，请在知晓风险的情况下使用
      // path: '/var/run/egg.sock',
    },
  };

  config.mongoose = {
    client: {
      url: "mongodb://localhost:27017/api_doc_new", // cms_dev_1是collection(数据库)名称
      options: {}, // 其他配置项
      // mongoose global plugins, expected a function or an array of function and options
      plugins: [],
    },
  };

  //开启 关键 文档 删除功能
  config.open_delete_fn = false

  return {
    ...config,
  };
};

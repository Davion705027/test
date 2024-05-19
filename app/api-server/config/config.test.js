/*
 * @Date           : 2022-03-29 20:57:44
 * @LastEditTime   : 2022-04-08 18:36:54
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

  config.mongoose = {
    client: {
      url: "mongodb://localhost:27017/api_doc_new", // cms_dev_1是collection(数据库)名称
      options: {}, // 其他配置项
      // mongoose global plugins, expected a function or an array of function and options
      plugins: [],
    },
  };

  return {
    ...config,
  };
};

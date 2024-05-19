'use strict';
// import { EggPlugin } from 'egg';
/** @type Egg.EggPlugin */
module.exports = {
  // had enabled by egg
  // static: {
  //   enable: true,
  // },
  mongoose: {
    enable: true,
    package: 'egg-mongoose',
  },
  validate: {
    enable: true,
    package: 'egg-validate',
  },
  cors:{
    // 是否启用
    enable:true,
    // 插件名称
    package:'egg-cors',
  },
    // // 数据库 mysql  
    // sequelize :{
    //   enable:true,
    //   package:'egg-sequelize'
    //  }
    jwt: {
      enable: true,
      package: 'egg-jwt',
    } ,
    routerGroup :{
      enable: true,
      package: 'egg-router-group',
    } 
};

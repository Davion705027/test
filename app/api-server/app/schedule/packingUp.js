const Subscription = require('egg').Subscription;
const fs = require("fs");
const path = require("path");
class PackingUpCache extends Subscription {
  // 通过 schedule 属性来设置定时任务的执行间隔等配置
  static get schedule() {
    return {
    //   interval: '1m', // 1 分钟间隔
      interval: '30s', // 1 分钟间隔
      type: 'all', // 指定所有的 worker 都需要执行
    };
  }

  // subscribe 是真正定时任务执行时被运行的函数
//   async subscribe() {
//     // const res = await this.ctx.curl('', {
//     //   dataType: 'json',
//     // });
  
//   }



/**
 * 流程： 
 * 
 *  读取    /public/upload/yunwei/need_packup.json
 *  循环每个数据  扫 public/upload/zip/${day} 目录 确保 当前数据的 zip_file_name 在里面 
 *    
 * 
 *    puck_up_record_id
 *    如果在  ， 更新对应的打包记录的数据 type3_info 状态  
 *   否则 比较 puck_up_time  大于一个小时的 全部 状态 变为 2 
 * 
 * 
 * 
 */



    //   // subscribe 是真正定时任务执行时被运行的函数
      async subscribe() {
    
      // console.log('subscribe------------执行',);
    //   console.log('subscribe------------执行',this.ctx);

      await this.service.packingUp.read_packed_file_and_change_finish_status()


         



        // this.ctx.app.cache = res.data;
      }
}

module.exports = PackingUpCache;
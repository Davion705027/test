/*
 * @Date           : 2022-03-11 10:59:48
 * @FilePath       : /client-api-doc-server/app/controller/doc.js
 * @Description    :
 */
"use strict";

const { pack_env_list } = require("../config/assistant");

const Controller = require("egg").Controller;
class PackingRecordController extends Controller {
  /**
   * 查询  全部数据
   * @returns
   */
  async index() {
    const ctx = this.ctx;
    const { currentPage, pageSize, id, project, env } = ctx.query;
    try {
      let query = {};
      if (id) {
        query = { _id: id };
      } else {
        project ? (query["project"] = project) : "";
        env ? (query["env"] = env) : "";
      }
      const options = {
        page: ctx.toInt(currentPage),
        limit: ctx.toInt(pageSize),
        sort: { updatedAt: -1 },
      };
      // await ctx.sleep(6000);
      const result = await ctx.model.PackingRecord.paginate(query, options);
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   * 获取各布局各环境最新打包记录 布局作为键 ，有隐藏BUG
   * @returns
   */
  async getRecentPack() {
    const ctx = this.ctx;
    try {
       // 先查询所有配置
       const creatorid = '65237aac6092343e930b6a81';
       const packingConfigList = await ctx.model.PackingConfig.find({creatorid});
       //打包配置对象 
       const all_packingConfig_obj={}
       const result = packingConfigList.reduce((pre,next)=>{
        const obj = {}
        const project_key = `project_${next.project}`
        pack_env_list.forEach(item=>obj[item.value]=null)
        all_packingConfig_obj[next.id] ={
          packingConfigName:next.name ,packingConfigMark:next.mark
        }
        pre[project_key] = obj;
    
        return pre;
       },{})



       const record_list = await ctx.model.PackingRecord.find({
        type:{ $regex: '2', $options: "i", }
       },null,{ sort:{createdAt: -1 }}).limit(300);

       for(let i=0;i<record_list.length;i++){
        const record_item = record_list[i];
         const {project,env,base_name,createdAt,day,mark,packingConfigId} = record_item;
         const project_key = `project_${project}`
         
         if(!result[project_key]){
          result[project_key]={}
         }
      
         if(!result[project_key][env]){
          result[project_key][env] = {
            ...all_packingConfig_obj[packingConfigId],
            project,env,packingConfigId, base_name,createdAt,day,mark
          }
         }
       }
       ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }

  /**
   * 获取各布局各环境最新打包记录 打包配置 ID 作为键
   * @returns
   */
  async getRecentPack2() {
    const ctx = this.ctx;
    try {
       // 先查询所有配置
       const creatorid = '65237aac6092343e930b6a81';
       //打包配置
       const packingConfigList = await ctx.model.PackingConfig.find({creatorid});
       //打包配置对象 
       const all_packingConfig_obj={}
       const result = packingConfigList.reduce((pre,next)=>{
        const obj = {}
        const { id ,name ,mark, job_label} =next
        console.log('------------', job_label)
        const packingConfigId_key = `packingConfigId_${ id}`
        pack_env_list.forEach(item=>obj[item.value]= null )
        all_packingConfig_obj[ id] ={
          packingConfigName:name ,packingConfigMark:mark,
          packingConfigJobLabel:job_label
        }
        pre[packingConfigId_key] = obj;
        return pre;
       },{})
      //循环打包配置
       for(let pi=0 ;pi<packingConfigList.length;pi++){
      //读取当前打包配置的 打包记录 
      // 循环环境
      for(let ei=0 ;ei<pack_env_list.length;ei++){
        const record_item = await ctx.model.PackingRecord.findOne({
          packingConfigId:packingConfigList[pi]['id'],
          env:pack_env_list[ei]['value'],
          type:/2/i
         },null,{  sort:{createdAt: -1 } }) ;
         if(record_item){
          const {project,env,base_name,createdAt,day,mark ,packingConfigId} = record_item;
          let  packingConfigId_key = `packingConfigId_${packingConfigId}`
          if(!result[packingConfigId_key]){
           result[packingConfigId_key]={}
          }
          if(!result[packingConfigId_key][env]){
           result[packingConfigId_key][env] = {
             ...all_packingConfig_obj[packingConfigId],
             project,env,packingConfigId, base_name,createdAt,day,   mark
           }
          }

         }

     
      }
       } 
       ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }










  /**
   * 一键打包 所有配置的所有环境
   */
  async packAllConfig(){
    const ctx = this.ctx;
 
    const { creatorid='65237aac6092343e930b6a81' } = ctx.query;
    try {
      // 先查询所有配置
      const packingConfigList = await ctx.model.PackingConfig.find({creatorid});
      for(let i=0;i<packingConfigList.length;i++){
        const config = packingConfigList[i];
        
        // 循环打包环境
        for(let i=0;i<pack_env_list.length;i++){
          const pack_env_item = pack_env_list[i];
          
          const params = {
            env: pack_env_item.value,
            packingConfigId: config._id,
            type: '1,2,3,4',
            mark: `${pack_env_item.label}环境：一键打包生成`
          }
          await this.create(params,true);

        }
      }
      ctx.api_success_data();
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   * 查询  一条数据  的详细信息
   * @returns
   */
  async show() {
    const ctx = this.ctx;
    try {
      const id = ctx.query.id;
      const result = await ctx.model.PackingRecord.findById(id).exec();
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   * 创建或者更新数据通用内部方法
   * @returns
   */
  async compute_final_obj_when_create_or_update(params) {
    const ctx = this.ctx;
    let {
      id,
      type = "1,2",
      mark,
      packingConfigId,
      env = "shiwan",
    } = params;
    let final_obj = {
      id,
      type,
      mark,
      packingConfigId,
      env,
    };
    if (!type) {
      type = "2";
    }
    let type_arr = ("" + type).split(",");
    if (!type_arr.includes("1")) {
      type_arr.push("2");
    }
    if (!type_arr.includes("2")) {
      type_arr.push("2");
    }
    type_arr.sort();
    type = type_arr.join(",");
    await this.service.jwt.add_operator(final_obj);
    ctx.remove_false_key(final_obj);
    return final_obj;
  }
  /**
   * 创建  一条数据
   * params: 参数
   * isout: 区分外部调用
   * 控制器 函数里面第一个参数默认值为ctx，用isout区分ctx.request.body和params
   * @returns
   */
  async create(params,isout=false) {
    const ctx = this.ctx;
    if(!isout){
      params = ctx.request.body
    }
    try {
      let final_obj = await this.compute_final_obj_when_create_or_update(
        params
      );
      let { packingConfigId } = final_obj;
      if (!packingConfigId) {
        ctx.api_error_msg("必须指定 ：组合打包配置");
        return;
      }
      let token_info = await ctx.service.jwt.get_token_info();
      let operatorid = token_info["id"];
      const all_records = await ctx.model.PackingRecord.find({
        operatorid
      }, null, {
        sort: { createdAt: -1, }
      }).exec();
      // if (all_records.length > 0) {
      //   let last_one = all_records[0]
      //   let now = Date.now();
      //   let cha = now - new Date(last_one.createdAt).getTime()
      //   if (cha < 2 * 60 * 1000) {
       
  
      //     ctx.api_error_msg({
           
      //       time: 2 * 60 * 1000 - cha,
      //       msg: '2分钟内只能构建一次'
      //     });
      //     return
      //   }
      // }
     

      let result = await this.service.packingUp.pack_up(final_obj);
 
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   * 更新  一条数据
   * @returns
   */
  async update() {
    const ctx = this.ctx;
    try {
      let final_obj = await this.compute_final_obj_when_create_or_update(
        ctx.request.body
      );
      let id = final_obj.id;
      delete final_obj.id;
      const result = await ctx.model.PackingRecord.findByIdAndUpdate(
        id,
        final_obj
      );
      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
  /**
   * 删除  一条数据
   * @returns
   */
  async destroy() {
    const ctx = this.ctx;
    try {
      const id = ctx.request.body.id;
      const result = await ctx.model.PackingRecord.findByIdAndDelete(id);

      ctx.api_success_data(result);
    } catch (error) {
      ctx.api_error_msg(error);
    }
  }
}
module.exports = PackingRecordController;

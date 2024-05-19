const path = require("path");
const fs = require("fs");
const moment = require("moment");
const Service = require("egg").Service;
class PackingUpService extends Service {
  /**
   * 找到   默认 配置
   * @param {*} detail
   * @returns
   */
  async find_KeyDefaultConfig(detail) {
    const { project, key_type } = detail;
    let query = {
      project,
      status: 1,
    };
    let model_name =
      this.ctx.assistant.key_type_val_to_model_map[`key_${key_type}`];
    console.error("model_name------", model_name);
    let Config = await this.ctx.model[model_name].find(query);
    //转对象
    let result = {};
    Config.map((x) => {
      result[`${x["key"]}`] = x.value;
    });
    return result;
  }
  /**
   * 找到  设置记录
   * @param {*} detail
   * @returns
   */
  async find_KeyConfigRecord(detail) {
    const { version, project, key_type } = detail;
    let query = {
      version,
      project,
      key_type,
    };
    let Config = await this.ctx.model.KeyConfigRecord.find(query);
    //转对象
    let result = {};
    Config.map((x) => {
      result[`${x["key"]}`] = x.value;
    });
    return result;
  }
  /**
   * 找到  自定义设置
   * @param {*} detail
   * @returns
   */
  async find_KeyConfig(detail) {
    // console.log('find_KeyConfig(detail)----1---',detail);
    // console.log('find_KeyConfig(detail)----2---', this.ctx.assistant.key_type_val_to_model_map[`key_${detail.key_type}`]);
    // console.log('find_KeyConfig(detail)----3---',   );
    // console.log('find_KeyConfig(detail)----4---',)
    let { pack_up_type, themeRefer } = detail;

    let ConfigRecord = {};
    let DefaultConfig = {};

    // 找到   设置记录

    if (themeRefer) {
   //当前版本自定义设置
     const  version_ConfigRecord = await this.service.packingUp.find_KeyConfigRecord({
        ...detail,
        
      });
     // 基础蓝本 自定义设置
     const   themeRefer_ConfigRecord = await this.service.packingUp.find_KeyConfigRecord({
        ...detail,
        version: themeRefer,
      });
     //最终组合的 自定义配置
      ConfigRecord =   Object.assign({}, themeRefer_ConfigRecord, version_ConfigRecord)


    } else {
      //自定义设置
      ConfigRecord = await this.service.packingUp.find_KeyConfigRecord(detail);
    }

    //全量
    if (pack_up_type == "1") {
      //找到标准 配置
      DefaultConfig = await this.service.packingUp.find_KeyDefaultConfig({
        ...detail,
      });
      // 自定义配置 合并标准配置
      return Object.assign({}, DefaultConfig, ConfigRecord);
    } else {
      //自定义配置
      return ConfigRecord;
    }
  }
  /**
   * 找到 CSS 和  assets  自定义设置 组合出来 theme 配置
   * @param {*} detail
   * @returns
   */
  async find_CssAndAssetsKeyConfig(PackingConfig, pack_up_type) {
    let { project } = PackingConfig;
    let theme_config = PackingConfig.theme || [];
    let result_arr = [];

    for (let i = 0; i < theme_config.length; i++) {
      let item = theme_config[i];

      let result_item = {
        ...item,
        css_detail: await this.service.packingUp.find_KeyConfig({
          version: item.version,
          project,
          key_type: 1,
          pack_up_type,
          themeRefer: item.themeRefer,
        }), // CSS配置信息
        assets_detail: await this.service.packingUp.find_KeyConfig({
          version: item.version,
          project,
          key_type: 7,
          pack_up_type,
          themeRefer: item.themeRefer,
        }), // 资源配置信息
      };
      result_arr.push(result_item);
    }

    return result_arr;
  }

  /**
   * 全量或者  差异化  json 写入 文件
   */
  async pack_up_common_write_json_file({
    PackingRecord_result,
    pack_up_type,
    data,
    PackingConfig,
  }) {
    // 发起构建的时间
    let puck_up_time = PackingRecord_result.puck_up_time;
  
   //基础名字 /版本号
    let base_name =  PackingRecord_result.base_name;
    // 文件全名 ，无 格式
    let full_name = `${base_name}-${pack_up_type}`;
    // 计算文件名字   布局 - 版本号 -
    let filename = `${full_name}.json`;
    // 写入文件
    let write_file_config = {
      data,
      filename,
      type: "json",
      extname: ".json",
    };
    const write_file_result = await this.service.fileExport.write_file(
      write_file_config
    );
    //打包类型  2 用户差异化配置文件
    let info = {
      //发起构建的时间
      puck_up_time,
      // 基础名字
      base_name,
      // 文件全名 ，无 格式
      full_name,
      //打包类型
      type: pack_up_type,
      //day
      day: write_file_result.day,
      // 文件地址   日期202304091045189-uuid版本名字
      path: write_file_result.save_dir,
      //文件名字
      name: write_file_result.filename,
      //type
      type: write_file_result.file_type,
      //打包完成   -1 未完成 1 已完成 -2未完成强制取消
      finish: 1,
    };
    let cur_PackingRecord = await this.ctx.model.PackingRecord.findById(
      PackingRecord_result._id
    ).exec();
    // 更新数据
    if (pack_up_type == "2") {
      cur_PackingRecord.type2_info = info;
    }
    if (pack_up_type == "1") {
      cur_PackingRecord.type1_info = info;
    }
    await cur_PackingRecord.save();
    console.log(
      `记录打包记录---打包  -${
        pack_up_type == 1 ? "全量配置" : "差异化"
      }--json -------`
    );
  }
  /**
   * 打包
   *
   * 生成打包 记录的 基础数据
   */
  async pack_up_common_create_record(detail) {
    //获取当前日期
    let day = moment().format("YYYYMMDD");
    // 发起构建的时间
    let puck_up_time = Date.now();
    //打包配置
    const packingConfig_obj =  await this.ctx.model.PackingConfig.findById(detail.packingConfigId).exec();
    //布局 
    const {project} = packingConfig_obj
    // 基础名字 /版本号
    let base_name = `project_${ project}-${detail.packingConfigId}-${puck_up_time}-${detail.env}`;
    // 记录 打包记录
    let PackingRecord_config = {
      //布局 
      project ,
      packingConfigId: detail.packingConfigId,
      //打包目标环境  1 试玩 ,2 生产
      env: detail.env,
      //操作人
      operator: detail.operator,
      //操作人ID
      operatorid: detail.operatorid,
      //打包类型  1 全量配置文件 2 用户差异化配置文件， 3.前端代码打包zip 下载  4 js sdk
      type: detail.type,
      //基础名字 /版本号，
      base_name,
      //当前日期
      day,
      // 发起构建的时间
      puck_up_time,
      //打包类型  1 全量配置文件
      type1_info: {},
      //打包类型  2 用户差异化配置文件
      type2_info: {},
      //打包类型  3.前端代码打包zip 下载
      type3_info: {},
      //打包类型  4  js sdk
      type4_info: {},
      //备注
      mark: detail.mark,
    };
    //  记录打包记录
    const PackingRecord_result = await this.ctx.model.PackingRecord.create(
      PackingRecord_config
    );
    console.log(
      "记录打包记录----生成打包 记录的 基础数据 -------",
      PackingRecord_result
    );
    return PackingRecord_result;
  }
  /**
   *
   * 打包 json
   *
   *
   * @param {*} detail
   */
  async pack_up_common_json(PackingRecord_result, PackingConfig, pack_up_type) {
    let result_theme, result_js, result_component, result_i18n;
    let { project, js, component, i18n, theme } = PackingConfig;
    // 找到 CSS 和  assets  自定义设置 组合出来 theme 配置
    if (theme) {
      result_theme = await this.service.packingUp.find_CssAndAssetsKeyConfig(
        PackingConfig,
        pack_up_type
      );
    }
    // js
    if (js) {
      result_js = await this.service.packingUp.find_KeyConfig({
        version: js,
        project,
        key_type: 2,
        pack_up_type,
      });
    }
    //component
    if (component) {
      result_component = await this.service.packingUp.find_KeyConfig({
        version: component,
        project,
        key_type: 4,
        pack_up_type,
      });
    }
    //i18n
    if (i18n) {
      result_i18n = await this.service.packingUp.find_KeyConfig({
        version: i18n,
        project,
        key_type: 6,
        pack_up_type,
      });
    }

    const result_layouts = await this.ctx.model.LayoutTemplate.find({value: project})

    const result_layout = result_layouts.length?result_layouts[0]:{}
    //打包详情
    let pack_up_info = {
      project,
      project_info:result_layout,
      packingConfigId: PackingRecord_result.packingConfigId,
      base_name: PackingRecord_result.base_name,
      day: PackingRecord_result.day,
    
      env: PackingRecord_result.env,
    };
    // 语言
   const  clientLanguage = await this.ctx.model.ClientLanguage.find({})

    //文件内容
    let data = {
      pack_up_info,
      clientLanguage,
      component: {
        version: component,
        detail: result_component,
      },
      js: {
        version: js,
        detail: result_js,
      },
      i18n: {
        version: i18n,
        detail: result_i18n,
      },
      theme: result_theme,
    };
    await this.service.packingUp.pack_up_common_write_json_file({
      PackingRecord_result,
      pack_up_type,
      data,
      PackingConfig,
    });
  }
  /**
   * 计算需要打包的 数据 并写入 文件
   */
  async pack_up_compute_need_packup() {
    let un_finished = await this.ctx.model.PackingRecord.find({
      $or: [{ "type3_info.finish": -1 }, { "type3_info.finish": null }],
      $and: [{ type: { $regex: "3" } }],
    });
    let len = un_finished.length;
    console.log(
      "un_finished------------un_finished-------",
      un_finished.length
    );
    // console.log("un_finished------------un_finished-------",un_finished);
    //需要打包的
    let need_packup = [];
    // 打包 发起到现在 一个小时 以上的  强制 设置 -2
    let now = Date.now();
  
    for (let i = 0; i < len; i++) {
      let item = un_finished[i];
      let createdAt = new Date(item.createdAt).getTime();
      //如果时间大于 1小时强制结束
      let gt1 = now - createdAt > 60 * 60 * 1000;
      if (!gt1) {
        let type2_info = item.type2_info || {};
        need_packup.push({
          //打包请求的 数据库ID
          puck_up_record_id: item._id,
          //打包配置 id
          packingConfigId: item.packingConfigId,
          //布局
          project: item.project,
          //备注
          mark: item.mark,
          //时间戳
          timestamp: Date.now(),
          //基础名字 /版本号
          base_name: item.base_name,
          //打包类型
          puck_up_type: 3,
          // 打包时间
          puck_up_time: item.puck_up_time,
          //打包事项 任务名字
          puck_up_name: "前端代码打包zip",
       
        
          // 运维Jenkins 构建 后打包的 文件名字  不含 .zip
          zip_file_name: `${type2_info.base_name}-3`,
          //zip 文件全名
          zip_file_full_name: `${type2_info.base_name}-3.zip`,
          //前端文件 最后保存路径
          zip_file_full_path: `public/upload/zip/${type2_info.day}/${type2_info.base_name}-3.zip`,
          // 运维Jenkins 构建参数
          jenkins_param_version: `${type2_info.base_name}`,
          //运维 上传 服务器回传目录
          upload_folder: `/opt/project/client-api-doc-server-new/static/public/upload/zip/${type2_info.day}/`,
          // day
          day: type2_info.day,
          //打包目标环境  1 试玩 ,2 生产
          env: item.env,
        });
        // 确保文件回写的目录存在 
        let target_dir = `/static/public/upload/zip/${type2_info.day}`;
        let target_dir_full_path = path.join(__dirname, "../../", target_dir);
        await this.service.fileExport.ensure_write_folder_exist(target_dir_full_path );
     
       
      }
    }
    // console.log("need_packup---------------------need_packup---------计算------",need_packup);
    // console.log("need_packup---------------------打包进程超时---------计算------",timeout_process);
    // if (timeout_process.length > 0) {
    //   //删除 超时的  打包进程    timeout_process
    //   await this.ctx.model.PackingProcess.deleteMany({
    //     puck_up_record_id: { $in: timeout_process },
    //   });
    // }
    await this.ctx.model.PackingProcess.deleteMany({});
      
    

    // // http://127.0.0.1:18101/public/upload/yunwei/need_packup.json
    // // http://api-doc-server-new.sportxxxw1box.com/public/upload/yunwei/need_packup.json
    // // /opt/project/client-api-doc-server-new/static/public/upload/yunwei/need_packup.json
    // // 写入文件
    let write_file_config = {
      needday: -1,
      data: need_packup,
      filename: "need_packup.json",
      type: "yunwei",
      extname: ".json",
    };
    // 把 要打包的 信息 写入文件
    const write_file_result = await this.service.fileExport.write_file(
      write_file_config
    );
 
    await this.ctx.model.PackingProcess.insertMany(need_packup)
    return need_packup;
  }



  /**
   * 删除  打包进程 
   * 
   */
  async delete_PackingProcess(puck_up_record_id){

 

 
   await this.ctx.model.PackingRecord.findByIdAndUpdate(
    puck_up_record_id,
    { "type3_info.finish": -3 }
  );
 
  

  await this.service.packingUp.pack_up_compute_need_packup();
 
 
 
  }
  /**
   * 打包
   * 前端代码打包zip
   *
   */
  async pack_up_common_yunwei_zip(PackingRecord_result, PackingConfig) {
    //计算需要打包的 数据 并写入 文件
    let need_packup =
      await this.service.packingUp.pack_up_compute_need_packup();
    // 运维配置的 当前 要打包的数据的详细信息
    let packingProcess_info =
      need_packup.find(
        (x) => x.base_name == PackingRecord_result.base_name
      ) || {};

    let cur_PackingRecord = await this.ctx.model.PackingRecord.findById(
      PackingRecord_result._id
    ).exec();
    //当前打包 的 记录的  基础数据的 差量化 数据 信息
    let detail_type2_info = cur_PackingRecord.type2_info || {};
    // 记录当前  详细信息  更新 打包记录
    //打包类型  2 用户差异化配置文件
    let info = {
      // 基础名字
      base_name: detail_type2_info.base_name,
      // 文件全名 ，无 格式
      full_name: `${detail_type2_info.base_name}-3`,
      //打包类型
      type: "3",
      //day
      day: detail_type2_info.day,
      // 文件地址   日期202304091045189-uuid版本名字
      path: packingProcess_info.zip_file_full_path,
      //文件名字
      name: packingProcess_info.zip_file_full_name,
      //type
      type: "zip",
      //打包完成   -1 未完成 1 已完成 -2未完成强制取消
      finish: -1,
    };
    cur_PackingRecord.type3_info = info;
    await cur_PackingRecord.save();
    // console.log(
    //   `记录打包记录---打包  3 前端代码打包zip 下载  -------`,
    //   detail
    // );
  }
  /**
   * 打包
   * 前端代码打包zip
   *
   */
  async pack_up_common_yunwei_jssdk() {}
  /**
   * 打包
   *
   * 打包需要输出 四个文件
   *
   * //打包类型  1 全量配置文件 2 用户差异化配置文件，      3.前端代码打包zip 下载    4 js sdk
   *
   */
  async pack_up(detail) {
    // version      username
    // 找到 配置记录  根据 去重之后  组合
    let type_arr = ("" + detail.type).split(",");
    console.log("记录打包记录----type_arr ----1--- ", type_arr);
    // 生成一条打包记录
    const PackingRecord_result =
      await this.service.packingUp.pack_up_common_create_record(detail);
    //打包配置
    const PackingConfig = await this.ctx.model.PackingConfig.findById(
      detail.packingConfigId
    );

    console.log("记录打包记录----type_arr ----2--- PackingConfig");
    //打包类型  1 全量配置文件 2 用户差异化配置文件， 3.前端代码打包zip 下载  4 js sdk
    // 打包类型  1 全量配置文件
    if (type_arr.includes("1")) {
      console.log("记录打包记录----1 全量配置文件 -------");
      await this.service.packingUp.pack_up_common_json(
        PackingRecord_result,
        PackingConfig,
        "1"
      );
    }
    if (type_arr.includes("2")) {
      // 打包类型 2 用户差异化配置文件
      console.log("记录打包记录----2 用户差异化配置文件 -------");
      await this.service.packingUp.pack_up_common_json(
        PackingRecord_result,
        PackingConfig,
        "2"
      );
    }
    // 打包类型 3 前端代码打包zip 下载
    if (type_arr.includes("3")) {
      console.log("记录打包记录---- 3 前端代码打包zip 下载 -------");
      await this.service.packingUp.pack_up_common_yunwei_zip(
        PackingRecord_result,
        PackingConfig
      );
    }
    // 打包类型 4 js sdk
    if (type_arr.includes("4")) {
      console.log("记录打包记录---- 4 js sdk-------");
      await this.service.packingUp.pack_up_common_yunwei_jssdk(
        PackingRecord_result,
        PackingConfig
      );
    }
    console.log(
      "记录打包记录----PackingRecord_result._id -------",
      PackingRecord_result._id
    );
    //  记录打包记录
    const result = await this.ctx.model.PackingRecord.findById(
      PackingRecord_result._id
    );
    // console.log("记录打包记录----全部完成 -------", result);
    return result;
  }
  /**
   * 读取运维的 需要打包的文件内容
   * @returns
   */
  async read_need_packup_file() {
    let target_file = "static/public/upload/yunwei/need_packup.json";
    let target_file_full_path = path.join(__dirname, "../../", target_file);
    // console.log('fs.existsSync(__dirname)',target_dir_full_path);
    try {
      // let fie_path='/public/upload/yunwei/need_packup.json'
      let res = await fs.readFileSync(target_file_full_path).toString();
      res = JSON.parse(res);
      // console.log('读取 运维 打包文件 need_packup.json-----res--',res  );
      if (res && res.length) {
        return res;
      }
    } catch (error) {
      // console.log('读取 运维 打包文件 need_packup.json-------error--',error);
      return [];
    }
  }
  /**
   * 流程：
   *
   *  读取    /public/upload/yunwei/need_packup.json
   *  循环每个数据  扫 public/upload/zip/${day} 目录 确保 当前数据的 zip_file_name 在里面
   *
   *
   *    puck_up_record_id
   *     如果在  ， 更新对应的打包记录的数据 type3_info 状态
   *     否则 比较 puck_up_time  大于一个小时的 全部 状态 变为 -2
   *
   *
   *
   */
  async read_packed_file_and_change_finish_status() {
    // 打包进程
    let packingProcess = await this.ctx.model.PackingProcess.find({});
    // console.log('打包进-------packingProcess---',packingProcess.length);
    // 需要删除的打包进程
    let need_remove_process = [];
    let len = packingProcess.length;
    if (!len) {
      return false;
    }
    // "public/upload/zip/20230422
    //日期文件夹内容
    let day_folder = {};
    //所有数据的day
    let all_days = [];
    // 日期目录内的文件名字
    let day_folder_obj = {};
    for (let i = 0; i < len; i++) {
      let item = packingProcess[i];
      let day = item.day;
      let key = `day_${day}`;
      all_days.push(day);
      if (!day_folder[key]) {
        day_folder[key] = [];
      }
      day_folder[key].push(item.zip_file_full_name);
    }
    //所有数据的day
    all_days = Array.from(new Set(all_days));
    for (let i = 0; i < all_days.length; i++) {
      let folder = path.join(
        __dirname,
        "../../",
        `static/public/upload/zip/${all_days[i]}`
      );
      let key = `day_${all_days[i]}`;
      day_folder_obj[key] = [];
      let is_exist = fs.existsSync(folder);
      if (is_exist) {
        day_folder_obj[key] = fs.readdirSync(folder);
      }
    }
    // //
    // console.log("日期文件夹内容----day_folder--------", day_folder);
    // console.log("所有数据的day ----all_days--------", all_days);
    // console.log(
    //   "日期目录内的文件名字 ----day_folder_obj--------",
    //   day_folder_obj
    // );
    // 循环遍历   packingProcess  判断每一个文件是否在  day_folder_obj[key] 内
    // 如果在  ， 更新对应的打包记录的数据 type3_info 状态
    // 如果不在   比较 puck_up_time  大于一个小时的 全部 状态 变为 -2
    for (let i = 0; i < packingProcess.length; i++) {
      let item = packingProcess[i];
      let { zip_file_full_name, day, puck_up_record_id, puck_up_time } = item;
      if (day_folder_obj[`day_${day}`].includes(zip_file_full_name)) {
        // 文件已存在  如果在  ， 更新对应的打包记录的数据 type3_info 状态
        // console.log('// 文件已存在  如果在  ， 更新对应的打包记录的数据 type3_info 状态----------');
        await this.ctx.model.PackingRecord.findByIdAndUpdate(
          puck_up_record_id,
          { "type3_info.finish": 1 }
        );
        // 需要删除的打包进程
        need_remove_process.push(item._id);
      } else {
        // console.log('如果不在   比较 puck_up_time  大于一个小时的 全部 状态 变为 -2----------');
        // 如果不在   比较 puck_up_time  大于一个小时的 全部 状态 变为 -2
        //如果时间大于 1小时强制结束
        let gt1 = Date.now() - puck_up_time > 60 * 60 * 1000;
        if (gt1) {
          //  console.log('如果不在   如果时间大于 1小时强制结束----------');
          await this.ctx.model.PackingRecord.findByIdAndUpdate(
            puck_up_record_id,
            { "type3_info.finish": -2 }
          );
          // 需要删除的打包进程
          need_remove_process.push(item._id);
        }
        // console.log('如果不在   如果时间   不到一个小时--------puck_up_record_id--' ,puck_up_record_id);
      }
    }
    // console.log( '需要删除的 打包进程',need_remove_process);
    if (need_remove_process.length) {
      // 删除 打包进程
      await this.ctx.model.PackingProcess.deleteMany({
        _id: { $in: need_remove_process },
      });
    }
  }
}
module.exports = PackingUpService;

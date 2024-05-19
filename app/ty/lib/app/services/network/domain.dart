// ignore_for_file: non_constant_identifier_names, avoid_print, constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/utils/lodash.dart';
import 'package:flutter_ty_app/app/utils/pb.dart';
import 'package:flutter_ty_app/app/utils/utils.dart';
import 'package:get/get.dart' as GetUtil;
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../generated/locales.g.dart';
import '../../db/app_cache.dart';
import '../../global/user_controller.dart';
import '../../global/ws/ws_app.dart';
import '../models/res/user_info.dart';
import 'app_dio.dart';
import 'response_interceptor.dart';

/// ***  4.10 针对app架构调整 ****
/// 参数域名 拼接 oss/prod.json oss兜底操作（域名能访问，则oss一定能访问得到）app不在访问本地oss目录下资源
/// todo 根据商户标识 merchantLabel 缓存 userinfo接口实体

// https://app-h5.dbsportxxx1zx.com/?token=5deda33ab8cd8b0e198aac566174e11d1c1cb857&tag=01&jz=1&ignore_iframe_pc=1&gr=common&api=F44HJ+atFdYQqXLm85ADtiugr0ZrwutNsM85t6cxNP9Hzf/22TCB/6e++ProM/DCOtWXfg8JnJSNy6Cnjhqp1g==&keep_url=1&pb=1&env=line1&timestamp=1712733101824
// 例url 流程1 URL
const URL1 =
    'https://topic.sportxxx1zx.com/sports-rules/23-app/common/zh_cn?token=a9078f7a06bd879efa3633d3680fd709177409cd&gr=common&theme=theme-1&lang=zh&pb=1&api=F44HJ+atFdYQqXLm85ADttIpMFzIilQuBIFLyvAEXBo=&project=app-h5&topic=https%3A%2F%2Ftopic.sportxxx1zx.com&pb=1&rdm=1708055653519&themeColors=theme02&sty=y0';
// 流程2 URL  无api
const URL2 =
    'https://topic.sportxxx1zx.com/sports-rules/23-app/common/zh_cn?token=a9078f7a06bd879efa3633d3680fd709177409cd&gr=common&theme=theme-1&lang=zh&pb=1&project=app-h5&topic=https%3A%2F%2Ftopic.sportxxx1zx.com&pb=1&rdm=1708055653519&themeColors=theme02&sty=y0';
// 测试
const URL = URL2;
Map BUILDIN_CONFIG = {
  'PROJECT_NAME': 'app-h5',
  'CURRENT_ENV': 'idc_online',
  'DOMAIN_RESULT': null,
  'TOPIC': null,
  'OSS_JSON': null,
  'OSS_FILE_NAME': 'prod.json'
};

//  待抽离
decodeString(String encodedString) {
  String decodedString = utf8.decode(base64.decode(encodedString));
  var decodedList = Uri.decodeComponent(decodedString);
  return decodedList;
}

// 域名计算结果
DamainModel DOMAIN_RESULT = DamainModel();

class AllDomain {
  // 是否使用跳转链接的api参数
  // 当oss文件的域名很慢时 打开此开关
  bool useApi = true;

  // 跳转链接解析参数的map
  UrlModel urlParams = UrlModel();

  // url 是否有参数
  bool hasToken = false;

  // toppic定时器
  var timer_toppic_fast = null;

  /* init方法中初始化字段 */
  // 是否首次加载页面
  bool loaded = false;

  // url 内的api 解析后的 数据
  var url_api = null;

  // 最快的oss url地址返回的数据
  var oss_file_content = null;

  // oss file 文件内的 api 配置
  List oss_file_api = [];

  //  当前计算后的前端本地 api 池子
  var local_api_pool = [];

  Function create_callback = () {};

  // 域名计算  本地存错 挂载键
  // String DOMAIN_API_STORAGE_KEY = DOMAIN_API_STORAGE_KEY;
  // getuserinfo接口 内的 oss  配置 内的 oss
  OssObj GETUSERINFO_OSS = OssObj();

  // 合并 oss 文件内的 api配置 到 最终的 前端 本地 域名池子  开关
  bool MERGE_OSS_FILE_TO_LOCAL_API_POOL = true;

  // 合并 前端本地旧的   api配置 到 最终的 前端 本地 域名池子  开关
  bool MERGE_OLD_LOCAL_API_TO_LOCAL_API_POOL = true;

  //  getuserinfo  内的 oss 下的 api 数组 是强制的 必须 做为最基础数据 依据的  因此不提供开关。
  //  url 内的 api 参数内的数组  正常是  getuserinfo  内的 oss 下的 api 数组 的 子集 ，
  //  但是在用户试用期间， getuserinfo  内的 oss 下的 api 数组 可能 会变更，因此 理论上 每次页面主动或者被动调用 getuserinfo 都需要写入进来，存储到本地
  // 当前的 流程  ： 流程1   use_url_api 或者 流程2   use_oss_file_api
  String current_api_flow = "use_oss_file_api";

  // 最大的 本地域名池子数量上限
  var LOCAL_API_POOL_MAX = 10;

  // 记录到本地域名池子内的api 的过期时间，超过此时间的api 需要 在 再次刷新本地 域名池的时候 清理掉
  var LOCAL_API_EXPIRATION_TIME = 30 * 24 * 60 * 1000;

  // 每次不论是 如何去检测  API 接口的 ，只要那个API 可用 ，就刷新这个 API 的创建时间 到当时的检测通过时间，相当于加长这个域名在域名池的理论存活时间
  // 当 走 url 内 api 流程 出错是否 去掉api 参数并强制刷新页面去 走  oss 文件流程，也可以不刷新，静默切换流程
  bool force_reload_to_use_oss_file_api = false;

  //oss 文件内 视频播放地址
  String live_domains_oss_path_file = 'live_domains.h5';

  //api  内 视频播放地址
  String live_domains_oss_path_api = 'live_h5';

  List oss_urls = [];
  static const DECRYPT_KEY = "panda1234_1234ob";
  static const DECRYPT_KEY_URL_API = "OBTY20220712OBTY";

  late UserInfo? userInfo;

  AllDomain() {
    BUILDIN_CONFIG['DOMAIN_RESULT'] = DOMAIN_RESULT;
  }

  /*
   * @description: 构造函数
   * @return {undefined} callback 回调方法通知   {type:'domain_api',status:0 ,list:[]} status字段:0-初始状态 1-已经发现最快的api域名并已经设置,  2-已经切换到最新的可用域名, 3-切换时发现没有域名可用
   */
  create(url, {Function? callback}) {
    // 解析url
    urlParams = parseUrl(url);
    // urlParams.token = '75237f391973ba00631037e123aaece64215a8e8'; // 测试使用
    hasToken = hasStrValue(urlParams.token ?? StringKV.token.get());

    // 处理环境
    setEnv();
    setGr(urlParams.gr?.toUpperCase());

    //  初始化原始数据
    // init();

    // 获取本地配置的oss url地址
    // oss_urls = get_oss_urls();

    // 解密使用的key
    // DECRYPT_KEY = CryptoJS.enc.Utf8.parse("panda1234_1234ob");
    // DECRYPT_KEY = utf8.encode("panda1234_1234ob");
    // DECRYPT_KEY = "panda1234_1234ob";
    // 解密url 内 api 字段使用的 key
    // DECRYPT_KEY_URL_API = CryptoJS.enc.Utf8.parse("OBTY20220712OBTY");
    // DECRYPT_KEY_URL_API = utf8.encode("OBTY20220712OBTY");
    // DECRYPT_KEY_URL_API = "OBTY20220712OBTY";
    // 回调方法参数: {type:'domain_api',status:0 ,list:[]}
    // status字段:0-初始状态 1-首次进入: 发现最快的api域名并已经设置,  2-切换域名时 :已经切换到最新的可用域名, 3- 切换域名时:切换时发现没有域名可用
    if (callback is Function) {
      create_callback = callback;
    }
  }

  setEnv() {
    // 三方跳转过来的环境参数
    ///不要只根据传进来的url进行判断环境 app用户会选择环境
    String env = StringKV.env.get() ?? "";
    if (env.isEmpty) {
      env = urlParams.env ?? 'prod';
    } else {
      if (env == '生产维护') {
        env = 'prod';
      } else if (env == '开发') {
        env = 'dev';
      } else if (env == '测试') {
        env = 'test';
      } else if (env == '隔离') {
        env = 'geli';
      } else if (env == '试玩') {
        env = 'sandbox';
      } else if (env == 'MINI') {
        env = 'mini';
      }
    }

    if (env == 'prod') {
      // 生产
      BUILDIN_CONFIG['CURRENT_ENV'] = 'idc_online';
      BUILDIN_CONFIG['OSS_FILE_NAME'] = 'prod.json';
    } else if (env == 'dev') {
      // 开发
      BUILDIN_CONFIG['CURRENT_ENV'] = 'local_dev';
      BUILDIN_CONFIG['OSS_FILE_NAME'] = 'dev.json';
    } else if (env == 'test') {
      // 测试
      BUILDIN_CONFIG['CURRENT_ENV'] = 'local_test';
      BUILDIN_CONFIG['OSS_FILE_NAME'] = 'test.json';
    } else if (env == 'geli') {
      // 隔离
      BUILDIN_CONFIG['CURRENT_ENV'] = 'idc_lspre';
      BUILDIN_CONFIG['OSS_FILE_NAME'] = 'lspre.json';
    } else if (env == 'sandbox') {
      // 试玩
      BUILDIN_CONFIG['CURRENT_ENV'] = 'idc_sandbox';
      BUILDIN_CONFIG['OSS_FILE_NAME'] = 'play.json';
    } else if (env == 'mini') {
      // mini
      BUILDIN_CONFIG['CURRENT_ENV'] = 'idc_ylcs';
      BUILDIN_CONFIG['OSS_FILE_NAME'] = 'mini.json';
    }
  }

  /*
   * @description: 设置topic
  * @param {*} topic 域名列表
  * @return {*}
  */
  set_topic(topic) {
    if (topic.isNotEmpty) {
      toppic_fast(topic, (api_obj) {
        // api_obj 格式如下
        // "sports_rules" -> "https://topic.sportxxx1zx.com/sports-rules/23-app/common/"
        // "domain" -> "https://topic.sportxxx1zx.com"
        // "activity" -> "https://topic.sportxxx1zx.com/activity/common/common/"
        BUILDIN_CONFIG['TOPIC'] = api_obj;
        // 缓存
        MapKV.topic.save(api_obj);
        // LocalStorage.set('topic',api_obj);
      });
    }
  }

  setUserInfo(UserInfo? value){
    userInfo = value;
  }

  /*
   * @description: 设置oss文件中的数据到全局配置文件中
   * @param {*} data oss文件数据
   * @return {*}
   */
  set_all_config_from_oss_file_data_2(oss_data) {
    //解密 img
    final img = lodash.get(oss_data, "img");
    //解密 static
    final static_src = lodash.get(oss_data, "static");
    //解密 live_domains
    final live_domains = lodash.get(oss_data, live_domains_oss_path_file);

    // 设置live_domains
    if (hasValue(live_domains)) {
      DOMAIN_RESULT.live_domains = live_domains;
      StringKV.liveUrl.save(DOMAIN_RESULT.live_domains);
    }
    // 设置oss_img_domains
    if (isStrList(img)) {
      check_img_domain(img);
    }
    // 设置topic
    final topic = lodash.get(oss_data, "topic");
    set_topic(topic);
    // 处理 api  逻辑
    set_all_config_from_oss_file_data_2_api(oss_data);
  }

  setGr(String? gr) {
    gr ??= 'COMMON';
    String upGr = gr.toUpperCase();
    StringKV.gr.save(upGr);
    DOMAIN_RESULT.gr = upGr;
  }
  getGr(){
    String gr = StringKV.gr.get() ?? 'COMMON';
    return  gr.toUpperCase();
  }
  isSameGr(String gr1,String gr2){
    return gr1.toUpperCase() == gr2.toUpperCase();
  }

  /*
   * @description: 设置oss文件中的数据到全局配置文件中  的  api  部分
   * @param {*} data oss文件数据
   * @return {*}
   */
  set_all_config_from_oss_file_data_2_api(oss_data) {
    List api = [];
    var api_x = lodash.get(oss_data, "GA${DOMAIN_RESULT.gr}.api");

    // 因为存在 对接接口 历史遗留 ，用户 进入界面可能无 gr 参数  但是  时间戳接口可以混合调用，getuserinfo 也一样能 混合调用
    if (api_x == null) {
      String cgr = "COMMON";
      setGr(cgr);
      api_x = lodash.get(oss_data, "GA$cgr.api") ?? [];
      // console.log(
      //   "分组信息错误,分组强制设置为COMMON组 api_x:" + JSON.stringify(api_x)
      // );
    }
    api = [...api_x];
    // 存到
    oss_file_api = api;
    // 计算当前的 域名池子
    compute_current_local_api_pool();
    // 如果当时 的 流程是 ： 流程 1 走通了 附带 去集成备份oss 文件配置到前端 这里 不需要去 找可用域名
    // 此时已经有可用域名了
    if (current_api_flow == "use_url_api") {
    } else {
      // 如果当时 的 流程是 ： 流程 2  ,此时 是没有可用域名的  ，这里需要去找 可用域名
      //这里开始 找到一个可用域名  ，不做排序  ，使用 时间戳 接口
      compute_api_domain_firstone_by_currentTimeMillis();
    }
  }

  List getMatchApiList(List arr) {
    return arr.where((x) => x['group'] == getGr()).toList();
  }

  /*
   * 找到 第一个可用的 api   去 进行 后续 页面逻辑
   * @param {*} api
   */
  compute_api_domain_firstone_by_currentTimeMillis(
      {check_group = false}) async {
    final api = getMatchApiList(local_api_pool);
    bool check_ok = hasValList(api);
    print(
      "compute_api_domain_firstone_by_currentTimeMillis--",
    );
    print(api);
    if (!check_ok) {
      // todo 补偿逻辑 如果没有api流程走不下去了 没有刷新过 先刷新下尝试解决问题
      //compute_current_local_api_pool 应该是找这个方法的问题 this.local_api_pool没筛选出值 暂时很难找到 862行计算的
      // const reload_num=LocalStorage.get("reload",0)
      // if(reload_num==0){
      //   LocalStorage.set("reload",reload_num+1)
      //   window.location.reload()
      // }
      // console.log('compute_api_domain_firstone_by_currentTimeMillis--检查失败',);
      return false;
    }
    // let api =   JSON.parse(JSON.stringify(this.local_api_pool))
    // api.push( { api:"http://xxx.com"})
    List<Future<Response>> reqs = [];
    if (hasToken) {
      for (var x in api) {
        // 循环对api进行测试访问处理
        int t = DateTime.now().millisecondsSinceEpoch;
        // 请求的地址
        var api = x['api'];
        String url = '$api?t=$t';
        reqs.add(Dio(
          BaseOptions(
            // 设置超时时间为 3 秒
            receiveTimeout: const Duration(seconds: 3),
            connectTimeout: const Duration(seconds: 3)
          )
        ).get(
          url,
        ));
      }
    }
    //最快的域名对象
    Map fastest_api_obj = {};


    //如果  不是检查 域名分组 正确性 并纠错
    try{
      var res = await myAny(reqs);
      // var res = await Future.any(reqs); 
      String c_url = Uri.parse(res.realUri.origin).toString();
      fastest_api_obj = format_api_to_obj(
          c_url,
          group: compute_exact_group_by_str(str: res.data ?? ""));

      if (!check_group) {
        find_use_apis_event_first_one(fastest_api_obj);
      }

    }catch(e){
      print(e);
    }
  

    // 纠错
    try {

      Future allSettled(List<Future> futures) {
        Completer completer = Completer();
        Future future = completer.future;

        int len = 0;
        int reqsLen = reqs.length;
        List res = List.generate(reqsLen, (index) => null);

        reqs.asMap().forEach((index, element) {
          element.then((value) {
            len +=1;
            res[index] =  {'status': 'fulfilled', 'value': api[index],'response':value };
            if(len == reqsLen){
              completer.complete(res);
            }
          }).catchError((error) {
            len +=1;
            res[index] =  {'status': 'rejected', 'value': api[index] };
            if(len == reqsLen){
              completer.complete(res);
            }
          });
        });
        return future;
      }

      List results = await allSettled(reqs);
      // 异步操作成功时
      // {status: 'fulfilled', value: value}
      // 异步操作失败时
      // {status: 'rejected', reason: reason}
      // print(" 域名时间戳检测逻辑结果 results----------", results);
      //失败次数
      int rejected_num = 0;
      int tr = DateTime.now().millisecondsSinceEpoch;

      results.asMap().forEach((i, result) {
        // 'fulfilled' 异步操作成功时
        if (result['status'] == 'fulfilled') {
          // 刷新 域名的创建时间 ，刷新理论存活时间
          api[i]["update_time"] = tr;
          api[i]["group"] = compute_exact_group_by_str(str: result['response'].data ?? "");
        } else {
          // 'rejected'  异步操作失败时
          rejected_num++;
        }
      });
      //保存数据到本地
      set_sava_json_key(local_api_pool);
      // 重新计算本地域名池 并且写入本地存储
      compute_current_local_api_pool();
      //全部错误
      if (rejected_num == api.length) {
        // 失败 页面  没网 之类的 错误页面
      } else {
        //如果 是检查 域名分组 正确性 并纠错
        if (check_group) {
          // 获取当前使用的 api
          var capi = DOMAIN_RESULT.first_one;
          // 当前使用的 api 的 host
          var capi_str = capi.split('://')[1];
          // 当前使用的 api 的分组
          var capi_group = (local_api_pool.firstWhere(
                  (x) => x['api'].contains(capi_str),
                  orElse: () => {}))['group'] ??
              '';

          final gr = DOMAIN_RESULT.gr;
          // 如果当前在用的域名的分组和用户的分组不相同
          if(!isSameGr(capi_group, gr)){
            // 如果新的最快 API 的分组和用户的分组相同
            if ( isSameGr(fastest_api_obj['group'], gr)) {
              // 设置可用的域名
              find_use_apis_event_first_one(fastest_api_obj);
            } else {
              // 如果分组不相同，则利用新的域名池重新排序
              compute_api_domain_firstone_by_currentTimeMillis();
            }
          }
        }
      }
    } catch (e) {
      print("域名检测 出错:");
      print(e);
    }
  }

  /* todo 接口请求失败
   * 找到toppic中最快的域名
   * @param {*} api
   */
  Future<void> toppic_fast(List api, Function callback, {int count = 0}) async {
    count++;
    // 清除计时器
    clean_timer(timer_toppic_fast);

    List<Future<Response>> reqs = [];
    if (hasToken) {
      for (var x in api) {
        // 循环对api进行测试访问处理
        int t = DateTime.now().millisecondsSinceEpoch;
        // 请求的地址
        String url = '$x/check.json?t=$t';

        final dio_options = BaseOptions(
          connectTimeout: const Duration(seconds: 5),
        );
        reqs.add(Dio(dio_options).get(url));
      }
    }

    try {
      // Response res = await Future.any(reqs);
      Response res = await myAny(reqs);
      // 最快toppic的域名
      String cUrl = Uri.parse(res.realUri.origin).toString();
      clean_timer(timer_toppic_fast);
      var obj_ = {'sports_rules': ''};
      // 体育规则配置
      // 布局规则
      // --2021亚洲H5+PC	common
      // --2023亚洲PC	23-as
      // --2023欧洲H5+PC	23-eu
      // --2023KYAPP复刻版	23-app
      // 路径规则：最优域名/sports-rules/布局/内容 （内容字段需要接口下发，默认common）
      // 比如 https://test-topic.sportxxxifbdxm2.com/sports-rules/common/common
      // 获取项目信息
      final PROJECT_NAME = BUILDIN_CONFIG['PROJECT_NAME'];
      obj_['domain'] = cUrl;
      // window.SEARCH_PARAMS.init_param_set({'topic': obj_['domain']});
      obj_['activity'] = '$cUrl/activity/common/common/';

      switch (PROJECT_NAME) {
        case 'yazhou-h5':
        case 'yazhou-pc':
          obj_['sports_rules'] = '$cUrl/sports-rules/23-as/common/';
          break;
        case 'ouzhou-h5':
        case 'ouzhou-pc':
          obj_['sports_rules'] = '$cUrl/sports-rules/23-eu/common/';
          break;
        case 'app-h5':
          obj_['sports_rules'] = '$cUrl/sports-rules/23-app/common/';
          break;
        case 'new-pc':
          obj_['sports_rules'] = '$cUrl/sports-rules/23-as/common/';
          break;
        default:
          obj_['sports_rules'] = '$cUrl/sports-rules/common/common/';
          break;
      }
      if (isFunction(callback)) {
        callback(obj_);
      }
      return;
    } catch (error) {
      // 所有  全部请求失败
      // print(error);
    }

    try {
      List<Response> results = await Future.wait(reqs);
      // 异步操作成功时
      // {status: 'fulfilled', value: value}
      // 异步操作失败时
      // {status: 'rejected', reason: reason}
      // print(" 域名时间戳检测逻辑结果 results----------", results);
      //失败次数
      int rejected_num = 0;

      results.asMap().forEach((i, result) {
        print(result);
        // todo 'fulfilled' 异步操作成功时
        if (result.statusCode! >= 200 && result.statusCode! < 300) {
          // 刷新 域名的创建时间 ，刷新理论存活时间
        } else {
          // 'rejected'  异步操作失败时
          rejected_num++;
        }
      });
      //全部错误
      if (rejected_num == api.length) {
        // 失败 页面  没网 之类的 错误页面
        timer_toppic_fast = Timer(const Duration(seconds: 5), () {
          toppic_fast(api, callback, count: count);
        });
      } else {}
    } catch (e) {
      print(e);
    }
  }

  clean_timer(timer) {
    if (hasValue(timer)) {
      timer.cancel();
    }
  }

  /*
   * @description: 运行检测功能
   */
  run() {
    // 前置 几道工序
    // 当前的 流程  ： 流程1   use_url_api 或者 流程2   use_oss_file_api
 
    compute_current_api_flow();
    if (current_api_flow == "use_url_api") {
      // 流程 1 开始 修改为先从本地缓存竞速获取最优域名进行 后续再拉取oss合并
      // 加入useApi判断 
      begin_process_when_use_url_api();
    } else {
      // 流程 2 开始
      begin_process_when_use_oss_file_api();
    }

    // 初始化topic
    var topic_url = urlParams.topic;
    if (hasValue(topic_url)) {
      topic_url = Uri.decodeComponent(topic_url!);
      set_topic(topic_url.split(','));
    }

    print(BUILDIN_CONFIG);
    // 检查纠正 分组信息
    Timer(const Duration(seconds: 30), () {
      check_and_correct_local_api_pool_group();
    });
  }


  /*
   * 计算当前流程
   *  流程1   use_url_api    首次进入
   *  流程2   use_oss_file_api    首次进入
   */
  compute_current_api_flow() {
    // 当前的 流程  ：
    var unDecrypt = "";
    var url_search = urlParams;
    var api = url_search.api;

    List unDecryptList = [];
    //   console.log('location.href-',location.href);
    //   console.log('api------------',api);
    //  console.log('api------------',  api.replace(/\s/g,'+'));
    //   console.log('url_search----',url_search);
    //   console.log('url_search---2222-', new URL(location));
    if (api == null || !useApi) {
      // 没有从地址获取api返回
      current_api_flow = "use_oss_file_api";
    } else {
      api = api.replaceAll(RegExp(r'\s'), "+");
      // const api = 'vEtkQtmX6wF8fAGV5b4UDx2mPRca2zMHLMj/YELjSwxjyhV5t0ifZDD6I0iwkpzJ'
      unDecrypt = get_oss_decrypt_str(api, key: DECRYPT_KEY_URL_API);
      // console.log("unDecrypt----------1", unDecrypt);

      if (unDecrypt != '') {
        unDecryptList = unDecrypt
            .split(",")
            .map((x) => x.trim())
            .where((x) => x.startsWith("http://") || x.startsWith("https://"))
            .toList();
      }
      if (unDecryptList.isEmpty) {
        current_api_flow = "use_oss_file_api";
      } else {
        current_api_flow = "use_url_api";
      }
      // console.log("unDecrypt----------2", JSON.stringify(unDecrypt));
    }
    // console.log('unDecrypt----------2', JSON.stringify(unDecrypt_f));
    url_api = unDecryptList;
  }

  String get_oss_decrypt_str(word, {key = DECRYPT_KEY}) {
    var ret = "";
    if (word != null && word.isNotEmpty) {
      try {
        // 解密
        ret = jiemiWord(word, key);
        // 转字符串
        // ret = utf8.decode(decrypt);
        // 去除左右空格
        ret = ret.trim();
        // 删除结尾的 /
        if (ret.isNotEmpty && ret.endsWith('/')) {
          ret = ret.substring(0, ret.length - 1);
        }
      } catch (error) {
        print("getOssDecryptStr: $error");
      }
    }
    return ret;
  }

  /*
   * 流程一  url 内 有api 参数 和 分组参数 ，并且api 参数解析后长度不为0   use_url_api
   * 流程一    当 使用url 内 api 参数  计算一个可用的 api
   */
  Future<void> begin_process_when_use_url_api() async {
    // 获取 token
    String? token = urlParams.token;

    // 并发请求
    List<Future<Response>> reqs = [];
    String pb = '';
    try {
      if (hasValue(urlParams.pb)) {
        pb = 'PB';
      }
    } catch (error) {
      print(error);
    }
    for (var item in url_api) {
      // 并发调取 getUserInfo
      Future<Response> response = Dio(
         BaseOptions(
            // 设置超时时间为 3 秒
            receiveTimeout: const Duration(seconds: 3),
            connectTimeout: const Duration(seconds: 3)
          )
      ).get(
        '$item/yewu12/user/getUserInfo$pb',
        queryParameters: {'token': token},
        options: Options(
          headers: {'requestId': token},
          contentType: Headers.jsonContentType,
        ),
      );
      reqs.add(response);
    }

    try {
      Response res = await myAny(reqs);
      // Response res = await Future.any(reqs);
      var resData = res.data;
      // 只要有一个请求成功
      String code = lodash.get(resData, 'code');
      if ( code == '0000000') {
        // 当流程一：当使用 URL 内 API 参数计算一个可用的 API 计算出来之后后置进程
        try {
          var dataTemp = lodash.get(resData, 'data');
          if(pb.isNotEmpty){
            dataTemp = pakoPb.unzipData(dataTemp);
          }
          // Uint8List? dataTemp =
          //     pako.inflate(utf8.encode(get(res,'data')));
          if (hasValue(dataTemp)) {
            resData['data'] = dataTemp;
            // jsonDecode(res.body)['data'] = utf8.decode(dataTemp);
          }
        } catch (error) {
          print(error);
        }
        // 保存用户数据
        UserController.to.userInfo.value = UserInfo.fromJson(resData['data']);
        resData['time_upd'] = DateTime.now().millisecondsSinceEpoch;
        DOMAIN_RESULT.getuserinfo_res = res;
        begin_process_when_use_url_api_after_process(res);
      } else if(code == '0401013'){
        // getUserInfo 都走不通 token过期了
        ResponseInterceptor.tokenExpiredAction();
      } else {
        print('token 失效，走oss文件逻辑');
        // 强制走 OSS 文件逻辑
        force_current_api_flow_to_use_oss_file_api();
      }
    } catch (error) {
      // 所有全部请求失败
      print(error);
      // 需要重定向 URL 页面重新刷新去掉 API 参数
      // 去掉 API 参数 reload
      // 强制走 OSS 文件逻辑
      force_current_api_flow_to_use_oss_file_api();
    }
  }

  /*
   *
   * 当流程一： 当 使用url 内 api 参数  计算一个可用的 api   计算出来之后 后置进程
   *
   */
  begin_process_when_use_url_api_after_process(Response res) {
    var resData = res.data;
    // 确保分组信息 赋值
    String gr = lodash.get(resData, "data.gr") ?? '';
    setGr(gr);

    //OSS 对象
    // var ossobj = get(resData, "data.oss");
    // console.log("ossobj--------", ossobj);
    // 如果 有 api 但是拿不到 ossobj    ， 强制 走 oss 文件逻辑
    if (lodash.get(resData, "data.oss") == null) {
      force_current_api_flow_to_use_oss_file_api();
      return false;
    }
    OssObj ossobj = OssObj.fromJson(lodash.get(resData, "data.oss"));
    // 第一步  拿到 可用api
    // 确保 ossobj .api 字段内  有包含 当前这个可用的  api
    String c_url = Uri.parse(res.realUri.origin).toString();
    // if(c_url.startsWith('http')){
    //   c_url = new URL(res.config.url);
    // } else{
    //   c_url = new URL(res.config.baseURL);
    // }
    // console.log("c_url------", c_url);
    //当前这个可用的 api
    var use_api = Uri.parse(res.realUri.origin).toString();
    // 当前唯一 已知可用的 api
    var objapi = format_api_to_obj(use_api);
    // 确保初始化
    ossobj.api ??= [];
    if (ossobj.api is! List) {
      ossobj.api = [];
    }
    // List<String> apiList = ossobj.api as List<String>;

    // 去空
    ossobj.api = ossobj.api!.where((x) => hasValue(x)).toList();
    // 容错必须包含当前请求通的url
    // if( !ossobj.api.includes(use_api)){
    //   ossobj.api.push(use_api)
    // }
    ossobj.api = [...?ossobj.api, ...url_api];
    // apiList.addAll(url_api);
    // 同步最新域名到  全量API 数组

    DOMAIN_RESULT.full_apis = lodash.uniq([
      ...?ossobj.api,
      ...DOMAIN_RESULT.full_apis,
    ]);

    // // 第二步 设置
    set_getuserinfo_oss(ossobj);
    // 发现可用的域名的逻辑处理
    find_use_apis_event_first_one(objapi);
    // 图片 以及 静态域名 分流处理
    begin_process_when_use_url_api_after_process_handle_other_domain(ossobj);
    // 补充 oss file 进来
    // 空闲时间执行
    begin_process_when_use_oss_file_api();
  }

  void set_getuserinfo_oss(OssObj ossobj) {
    final api = ossobj.api;
    final img = ossobj.img;
    final live_h5 = ossobj.live_h5;
    final live_pc = ossobj.live_pc;
    if (hasValue(api) && api!.isNotEmpty) {
      GETUSERINFO_OSS = ossobj;
      // GETUSERINFO_OSS = {
      //   'api': api,
      //   'img': img,
      //   'live_h5': live_h5,
      //   'live_pc': live_pc
      // };
      // 计算当前的域名池子
      compute_current_local_api_pool();
    }
    if (hasValue(img) && img!.isNotEmpty) {
      // 更新图片域名
      DOMAIN_RESULT.img_domains = img;
    }

    if (hasValue(live_h5) && live_h5!.isNotEmpty) {
      // 更新视频项目域名
      DOMAIN_RESULT.live_domains = live_h5;
      StringKV.liveUrl.save(DOMAIN_RESULT.live_domains);
    }
  }

  /*
   *
   *  根据流程计算本地api域名池子 三种
   *  逻辑 每次都走 有冗余，但是 事实上 调度次数很少 无所谓
   */
  compute_current_local_api_pool() {
    try{


    //  前端本地旧的   api配置
    var old_local_api = get_save_domain_api();
    var getuserinfo_oss_api = GETUSERINFO_OSS.api ?? [];
    // 变形后 放入的数组
    List new_get_api_obj_arr = [];
    for (var x in getuserinfo_oss_api) {
      new_get_api_obj_arr
          .add(format_api_to_obj(x, group: getGr()));
    }
    //  oss 文件 oss_file_api
    for (var x in oss_file_api) {
      new_get_api_obj_arr
          .add(format_api_to_obj(x, group: getGr()));
    }
    new_get_api_obj_arr = lodash.uniqBy(new_get_api_obj_arr, "api");

    //把认为新进来的 里面的  事实上本地已存在的 删除掉，留下真正新增的
    List real_new_api =
        lodash.pullAllBy(new_get_api_obj_arr, old_local_api, "api");

    // 最终的 api 数组
    List final_api_pool = [...real_new_api, ...old_local_api];
    // 删除旧的
    // 当前时间
    final ct = DateTime.now().millisecondsSinceEpoch;
    // 时间差
    final sc = LOCAL_API_EXPIRATION_TIME;
    // 当前计算后的前端本地 api 池子
    List<Map<String, dynamic>> localApiPool = [];
    final_api_pool.forEach((x) {
      if (x['update_time'] == null) {
        x['update_time'] = ct;
      }
      x.remove('type');
      if (ct - x['update_time'] < sc) {
        localApiPool.add(x);
      }
    });

    // 排序，按照更新时间从大到小排列，新的在前，旧的在后
    localApiPool.sort((a, b) => b['update_time'] - a['update_time']);

    final cgr = getGr();
    // 当前分组的 api
    final local_api_pool_cg =
        localApiPool.where((x) => isSameGr(x['group'],cgr) ).toList();
    // 非当前分组的 api
    final local_api_pool_not_cg =
        localApiPool.where((x) => !isSameGr(x['group'],cgr) ).toList();

    // 截取最大的本地域名池子数量上限
    if (local_api_pool_cg.length > LOCAL_API_POOL_MAX) {
      local_api_pool_cg.removeRange(
          LOCAL_API_POOL_MAX, local_api_pool_cg.length);
    }

    // 重新组合本地域名池
    local_api_pool = [...local_api_pool_cg, ...local_api_pool_not_cg];
    local_api_pool = lodash.uniqBy(local_api_pool, "api");

    set_sava_json_key(local_api_pool);
    }catch(e){
      print(e);
    }
  }

  /*
   * 检查 域名池子 内 域名的 域名分组 正确性 并纠错
   */
  check_and_correct_local_api_pool_group() {
    compute_api_domain_firstone_by_currentTimeMillis(check_group: true);
  }

  /*
   *  // 初次进入,发现可用的域名
   */
  find_use_apis_event_first_one(obj) {
    // 首次进入,发现最快的域名
    final api = obj['api'];
    // console.log("首次加载,已经找到最快的域名:", api);
    // 写入可用api
    StringKV.best_api.save(api);
    // 挂载当前 环境能使用的 api 数组
    DOMAIN_RESULT.first_one = api;

    // 执行回调
    create_callback(DOMAIN_RESULT);
  }

  /*
   *
   * 当流程一： 当 使用url 内 api 参数  计算一个可用的 api   计算出来之后 后置进程
   *
   * 处理除了api  之外的域名
   */
  begin_process_when_use_url_api_after_process_handle_other_domain(
      OssObj oss_data) {
    // api: [null]
    // img: ["http://sit-image.sportxxxkd1.com"]
    // live_h5: "http://testliveh5.sportxxx13ky.com"
    // live_pc: "http://testlivepc.sportxxx13ky.com"
    // loginUrl: "http://test-user-pc-bw4.sportxxxifbdxm2.com/?token=5cc56f7830e569fe3a815b6ffa50634cf32af09a&gr=common&tm=1&lg=zh&mk=EU&stm=blue"
    // loginUrlArr: [,…]
    //解密 img
    List img = lodash.get(oss_data.toJson(), "img");
    // //解密 static
    // let static_src = lodash.get(oss_data, "static",[]);
    //解密 live_domains live_h5
    String live_domains = oss_data.live_h5 ?? "";

    // 设置live_domains
    if (hasStrValue(live_domains)) {
      DOMAIN_RESULT.live_domains = live_domains;
      StringKV.liveUrl.save(DOMAIN_RESULT.live_domains);
    }
    // 设置oss_img_domains

    check_img_domain(img);
  }

  /*
   *
   * 流程二： url 内 无 api gr 此类信息  use_oss_file_api
   * 走 oss 逻辑
   *
   */
  begin_process_when_use_oss_file_api() async {
    

    // 加载oss.json
    String oss_file_name = BUILDIN_CONFIG['OSS_FILE_NAME'];

    String u = urlParams.domain!;
    String finalUrl = composeUrl(u, 'oss/$oss_file_name');

    ///要trycatch 下  oss 文件路径变更 需要给本地静态资源
    try {
      Response res = await Dio().get(finalUrl);

      ///获取oss api域名
      Map ossRes = res.data;
      if (lodash.isPlainObject(ossRes)) {
        jiexi_oss_file(ossRes);
      } else {}
    } catch (e) {
      print(e.toString());

      ///  oss 文件获取失败
      // GetUtil.Get.snackbar(
      //   LocaleKeys.app_h5_cathectic_kind_tips.tr,
      //   LocaleKeys.home_login_invalid.tr,
      //   colorText: Colors.white,
      //   snackPosition: SnackPosition.TOP,
      // );
    }

    // String path = 'res/oss/$oss_file_name';
    // final ossJson = await rootBundle.loadString(path);
    // Map ossRes = json.decode(ossJson);
    // print(ossRes);

    // 测试用
    // String ossjsonTest = '{"update_time":"2024-01-14 17:43:41","topic":["VijmdUkIZl454580y0teW5a6L5RigX1Rb1SDcRpHTjAZE5fPL8WdYjBf/9i8SUT3"],"jt_static":["6FbdCIHRX4gkt/R1Pb1/GhNx9Fp7th8HIOHBcX4W+dNaDKqR3GvdECeXRhscoqcd"],"img":["pV9gSBMQ8z3xSR9EYFS38yLmr3+qSebRP0Cad2LynSo="],"static":[],"live_domains":{"pc":"Wgyqkdxr3RAnl0YbHKKnHQ==","h5":"Wgyqkdxr3RAnl0YbHKKnHQ==","end":"Wgyqkdxr3RAnl0YbHKKnHQ=="},"file_name":"play.json","GAS":{"api":["foD/zLIIeO76kcWlq8BdueuRIdc8vSVBdN0GllYmF35aDKqR3GvdECeXRhscoqcd"]},"GAB":{"api":["s7OWtICGLnxK8h7C85vGK8qChrgxrydp+DzFcALrSMI="]},"api":["foD/zLIIeO76kcWlq8BdudP1Hsa6u03+SQMuVOpBPiA=","foD/zLIIeO76kcWlq8Bdudn+Y6IG/YSGOxOystGOGx7MRzXIPOdjmugug2I6HLZZ"],"update_by":"ob","type":"试玩环境","GAY":{"api":["crj9UzMyiV8d+xKktZ8n1i/+ogaqj6l3j0ty2x2m5SV/UkN1QmDi/y0TPBmRgQLF"]},"GACOMMON":{"api":["foD/zLIIeO76kcWlq8BdudP1Hsa6u03+SQMuVOpBPiA=","foD/zLIIeO76kcWlq8Bdudn+Y6IG/YSGOxOystGOGx7MRzXIPOdjmugug2I6HLZZ"]}}';
    // Map ossRes = json.decode(ossjsonTest);
    // jiexi_oss_file(ossRes);
  }

  /*
   * 解析 OSS 文件返回体内容
   * @param {*} res
   */
  jiexi_oss_file(obj) {
    // 获取解密后的明码数据
    get_decrypt_oss_data(obj);
    // oss url地址返回的数据
    oss_file_content = obj;
    // 设置 oss文件中的数据到全局配置文件中
    set_all_config_from_oss_file_data_2(obj);
    // 全局变量可视化设置
    BUILDIN_CONFIG['OSS_JSON'] = obj;
  }

  /*
   * @description: 获取持久化localStorage中的数据
   * @param {string} key localStorage key值
   * @return {object} 返回Json类型数据
   */
  List get_save_domain_api() {
    List domai_api = ListKV.domainApi.get();
    return domai_api;
  }

  /*
   * @description: 设置持久化localStorage中的数据
   * @param {string} key localStorage key值
   */
  set_sava_json_key(val) {
    ListKV.domainApi.save(val);
  }

  // 更换域名
  changeDomain() {
    List localApis = get_save_domain_api();
    String currentApi = StringKV.best_api.get()!; 
    String gr = getGr();

    // 过滤掉失效域名
    localApis = localApis.where((element) => element['api']!=currentApi).toList();
    set_sava_json_key(localApis);
    
    // 当前分组的 api
    List groupList =
        localApis.where((x) => isSameGr(x['group'], gr))
        .toList();
    groupList.sort((a, b) => b['update_time'] - a['update_time']);
    String? url = groupList.safeFirst?['api'];

    if(url == null){
      List notGroupList =
      localApis.where((x) => !isSameGr(x['group'], gr))
          .toList();
      if(notGroupList.isEmpty){
        return null;
      }
      notGroupList.sort((a, b) => b['update_time'] - a['update_time']);
      var url2 = notGroupList.safeFirst?['api'];
      url = url2;
    }

    if(url == null)return null;

    // 设置当前域名
    DOMAIN_RESULT.first_one = url!;
    StringKV.best_api.save(url);
    // 执行回调
    // 通知dio ws 更换 域名

    AppDio.getInstance().setApiDomain();

    AppWebSocket.changWsUrl();
    return url;

  }

  /*
   *    强制 走 oss 文件逻辑
   */
  force_current_api_flow_to_use_oss_file_api() {
    // 强制刷新 去 变更流程 保证流程正确
    if (force_reload_to_use_oss_file_api) {
      // 缺点 ： 页面刷了 ，loading 加长，而且如果页面显示出来之后 ，内部触发刷新 ，这里还是 一样长时间 ，双倍
      // 优点 ： 后面刷新单倍时长 理论不会走到这里
      // force_current_api_flow_use_oss_file_api_reload();
    } else {
      // 缺点：每次刷新 ，都要走一次报错，甚至多次 报错后 才能走到正规 ， 设置的 axios_instance  超时 10 秒
      force_current_api_flow_use_oss_file_api_no_reload();
    }
  }

  /*
   * 虽然 url 有api 字段 ,但是 如果 getuserinfo 接口不返回 oss 字段  强制 走  oss 文件 逻辑
   */
  force_current_api_flow_use_oss_file_api_no_reload() {
    // url 内的api 解析后的 数据
    url_api = [];
    // 当前流程
    current_api_flow = "use_oss_file_api";
    // 流程 2 开始
    begin_process_when_use_oss_file_api();
  }

  /*
   * @description: 解密数组中的加密数据,并进行赋值操作(获取解密后的信息)
   * @param {*} obj
   * @return {*}
   */
  get_oss_decrypt_obj(obj) {
    if (isList(obj)) {
      // for(var item in obj){}
      for (var i = 0; i < obj.length; i++) {
        // 解密数据,重新设置数据
        obj[i] = get_oss_decrypt_str(obj[i]);
      }
    } else if (isMap(obj)) {
      obj.forEach((key, value) {
        if (hasKey(obj, key)) {
          // 解密数据,重新设置数据
          obj[key] = get_oss_decrypt_str(value);
        }
      });
    }
  }

  /*
   * @description: 获取oss文件中的明码数据
   * @param {*} data oss文件加密数据
   * @return {*} oss文件中的明码数据
   */
  get_decrypt_oss_data(data) {
    if (!hasValue(data)) return;

    // 解密img
    final img = lodash.get(data, 'img');
    if (isStrList(img)) {
      get_oss_decrypt_obj(img);
    } else {
      data["img"] = [];
    }
    // 解密 topic
    final topic = lodash.get(data, 'topic');
    if (isStrList(topic)) {
      get_oss_decrypt_obj(topic);
    } else {
      data["topic"] = [];
    }
    // 解密 static
    final static = lodash.get(data, 'static');
    if (isStrList(static)) {
      get_oss_decrypt_obj(static);
    } else {
      data["static"] = [];
    }
    // 解密 live_domains
    final lds = lodash.get(data, 'live_domains');
    if (hasValue(lds) && lodash.isPlainObject(lds)) {
      get_oss_decrypt_obj(lds);
    } else {
      data["live_domains"] = '';
    }

    for (var key in data.keys.toList()) {
      if (hasValue(key) && key.startsWith("GA")) {
        // 解密 GA*.api
        var api = data[key]['api'];
        if (isStrList(api)) {
          get_oss_decrypt_obj(api);
        } else {
          data[key]['api'] = [];
        }
      }
    }
  }

  /*
   * @description: 检测设置oss返回的可以图片域名
   * @param {Array} oss_img_domains oss图片域名数组
   */
  check_img_domain(List oss_img_domains) {
    if (oss_img_domains.isEmpty) {
      return;
    }
    String path = "";
    try {
      switch (BUILDIN_CONFIG['CURRENT_ENV']) {
        case "local_dev": // 开发
          path = "/group1/M00/25/A0/rBKywGEM5heAAqPFAAABDoCvoS8100.png";
          break;
        case "local_test": // 测试
          path = "/group1/M00/13/74/rBKy7GEM5beAQDjYAAABDoCvoS8983.png";
          break;
        case "idc_pre": // 预发布
          path = "/group1/M00/0E/94/CgURt2EM5U2AKAcCAAABDoCvoS8310.png";
          break;
        case "idc_sandbox": // 试玩
          path = "/group1/M00/0E/94/CgURt2EM5U2AKAcCAAABDoCvoS8310.png";
          break;
        case "idc_lspre": // 隔离预发布
          path = "/group1/M00/49/5A/CgUUSWEM5aOAAp0fAAABDoCvoS8190.png";
          break;
        case "idc_online": // 生产
          path = "/group1/M00/0E/94/CgURt2EM5U2AKAcCAAABDoCvoS8310.png";
          break;
        case "idc_ylcs": // 微型测试环境
          path = "/group1/M00/0E/94/CgURt2EM5U2AKAcCAAABDoCvoS8310.png";
          break;
        default:
          break;
      }
    } catch (error) {
      print(error);
    }
    // 循环检测图片域名
    for (var img_domain_item in oss_img_domains) {
      if (hasStrValue(img_domain_item)) {
        // 检测设置oss图片域名
        img_domain_is_ok(img_domain_item, path);
      }
    }
  }

  /*
   * 检测设置oss图片域名
   * @param domain 域名
   * @param path 图片路径
   */
  Future<bool> img_domain_is_ok(String domain, String path) async {
    // 拼接完整的图片域名
    String url = domain + path;
    Completer<bool> completer = Completer<bool>();
    try {
      // HttpClientRequest request = await HttpClient().getUrl(Uri.parse(url));
      // HttpClientResponse response = await request.close();
      // print(response);
      // if (response.statusCode == HttpStatus.ok) {
      //     // todo
      //     // UserCtr.setCommonImgDomain(domain); // 设置用户图片
      //     DOMAIN_RESULT.img_domains = lodash.uniq([
      //       domain,
      //       ...DOMAIN_RESULT.img_domains
      //     ]);
      // }
      Response response = await Dio().get(url);
      if (response.statusCode == HttpStatus.ok) {
        // todo
        // UserCtr.setCommonImgDomain(domain); // 设置用户图片
        DOMAIN_RESULT.img_domains =
            lodash.uniq([domain, ...DOMAIN_RESULT.img_domains]);
        StringKV.imgUrl.save(DOMAIN_RESULT.img_domains.first);

        completer.complete(true);
      }
    } catch (e) {
      // print(url);
      completer.complete(false);
    }
    return completer.future;
  }

  // 解析外部进来的url参数
  UrlModel parseUrl(String url) {
    Uri uri = Uri.parse(url);
    var domain = uri.origin;
    Map params = uri.queryParameters;

    var token = params['token'];
    var gr = params['gr'];
    var api = params['api'];
    var lang = params['lg'] ?? params['lang'];
    var theme = params['theme'];
    var topic = params['topic'];
    var pb = params['pb'];
    var env = params['env'];
    // String rdm = params['rdm'].toString();
    // String project = params['project'].toString();

    UrlModel res = UrlModel();
    res.domain = domain;
    res.api = api;
    res.token = token;
    res.gr = gr;
    res.topic = topic;
    res.theme = theme;
    res.lang = lang;
    res.pb = pb;
    res.env = env;
    // res.rdm = rdm;
    // res.project = project;
    return res;
  }

  /*
   * @description: 获取本地的oss文件路径(增加本域名的oss url地址)
   */
  get_oss_urls() {
    // 获取本地的oss_url_obj路径  json数组
    List domains = ['https://xbnhjktbwggfvyok.ybgjhb.com/prod.json'];
    return domains;
  }
}

// 创建domai 实例
AllDomain domainInstance = AllDomain();

/*
   * 通过 域名返回的字符串 计算 真实分组
   */
String compute_exact_group_by_str({str = ''}) {
  // data : "oky\n"
  str = str.toLowerCase();
  String group = "";

  if (str.isEmpty) {
    group = "";
  } else if (str.contains("oky")) {
    group = "Y";
  } else if (str.contains("okb")) {
    group = "B";
  } else if (str.contains("oks")) {
    group = "S";
  } else if (str.contains("ok") || str.contains("okc")) {
    group = "COMMON";
  }

  return group;
}

/*
   * 把一条API 数据组装当前的 分组数据 等
   *
   */
Map<String, dynamic> format_api_to_obj(String api, {String? group}) {
  return {
    'api': api, // 域名
    'group':
        group ?? DOMAIN_RESULT.gr ?? 'COMMON', // 域名分组信息 "COMMON" "GA" + .gr
    'update_time': DateTime.now().millisecondsSinceEpoch,
  };
}

// todo
class UrlModel {
  String? domain;
  String? token;
  String? api;
  String? gr;
  String? topic;
  String? theme;
  String? lang;
  String? pb;
  String? env;

  UrlModel({
    this.domain,
    this.token,
    this.api,
    this.gr,
    this.topic,
    this.theme,
    this.lang,
    this.pb,
    this.env,
  });

  UrlModel.fromJson(Map<String, dynamic> json) {
    domain = json['domain'];
    token = json['token'];
    api = json['api'];
    gr = json['gr'];
    topic = json['topic'];
    theme = json['theme'];
    lang = json['lang'];
    pb = json['pb'];
    env = json['env'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['domain'] = domain;
    data['token'] = token;
    data['api'] = api;
    data['gr'] = gr;
    data['topic'] = topic;
    data['theme'] = theme;
    data['lang'] = lang;
    data['pb'] = pb;
    data['env'] = env;
    return data;
  }
}

// getUserinfo 接口返回的oss属性model
class OssObj {
  List<String>? api;
  List<String>? chatroomHttpUrl;
  List<String>? chatroomUrl;
  List<String>? img;
  String? live_h5;
  String? live_pc;
  String? loginUrl;
  List<String>? loginUrlArr;

  OssObj(
      {this.api,
      this.chatroomHttpUrl,
      this.chatroomUrl,
      this.img,
      this.live_h5,
      this.live_pc,
      this.loginUrl,
      this.loginUrlArr});

  OssObj.fromJson(Map<String, dynamic> json) {
    api = json['api'].cast<String>();
    chatroomHttpUrl = json['chatroomHttpUrl'].cast<String>();
    chatroomUrl = json['chatroomUrl'].cast<String>();
    img = json['img'].cast<String>();
    live_h5 = json['live_h5'];
    live_pc = json['live_pc'];
    loginUrl = json['loginUrl'];
    loginUrlArr = json['loginUrlArr'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api'] = api;
    data['chatroomHttpUrl'] = chatroomHttpUrl;
    data['chatroomUrl'] = chatroomUrl;
    data['img'] = img;
    data['live_h5'] = live_h5;
    data['live_pc'] = live_pc;
    data['loginUrl'] = loginUrl;
    data['loginUrlArr'] = loginUrlArr;
    return data;
  }
}

class DamainModel {
  //gr
  String gr = "COMMON";

  //最优 API
  String first_one = "";

  //可用 的 api 数组
  List useable_apis = [];

  //全量API 数组
  List full_apis = [];

  // 用户信息接口返回
  late Response getuserinfo_res;

  //live_domains 视频页面地址 vue为数组 这里直接使用字符串 方便取值
  String live_domains = "";

  // 图片域名
  List img_domains = [];
}

Future myAny(List<Future> list){
  Completer completer = Completer();

  for(var u in list){
    u.then((r){
      if (!completer.isCompleted)  completer.complete(u);
    }).catchError((err){
      if (!completer.isCompleted) completer.completeError('all rejected',err);
    });
  }
  return completer.future;
}
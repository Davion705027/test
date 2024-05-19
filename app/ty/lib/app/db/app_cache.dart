import 'package:get_storage/get_storage.dart';

/// @Author swifter
/// @Date 2024/2/4 17:17

const dbName = "com.tyapp.ob";

/// 初始化
Future<bool> dbPreInit() async {
  return GetStorage.init(dbName);
}

final appStorage = GetStorage(dbName);

Future<void> dbClear() async {
  return appStorage.erase();
}

/// 保存字符串
enum StringKV {
  /// token
  token,

  /// baseurl
  baseUrl,

  /// language
  language,

  /// 登录之后保存
  apiUrl,

  /// 登录之后保存
  imgUrl,
  //  视频页面地址 vue为数组
  liveUrl,

  /// 登录之后保存
  wssUrl,

  /// 日间夜间模式
  themeStyle,
  // 最快请求api
  best_api,
  // 域名分组
  gr,

  /// 元数据
  originData,

  /// 接收h5地址
  h5url,
  OldNewId,
  menuInit,
  nameMap,
  req_checkId,

  // 电竞图片域名  末尾带'/'
  eSportsImgDomain,

  ///登录环境
  env,
  tournamentMatchMap,
}

extension StringKVX on StringKV {
  String? get() {
    return appStorage.read(name);
  }

  save(String? value) {
    if (value != null && value.isNotEmpty) {
      appStorage.writeInMemory(name, value);
      appStorage.save();
    }
  }

  remove() {
    appStorage.remove(name);
  }
}

/// 保存整形
enum IntKV {
  /// 语言
  language,

  // 服务器时间与本地时间差值
  diffTime,
}

extension IntKVX on IntKV {
  int? get() {
    return appStorage.read(name);
  }

  save(int value) {
    appStorage.writeInMemory(name, value);
  }

  remove() {
    appStorage.remove(name);
  }
}

/// 保存布尔值
enum BoolKV {
  /// 主题
  theme,
  dailyActivities,

  ///主页 热门-时间
  sort,

  ///主页  专业-新手
  userVersion,
}

extension BoolKVX on BoolKV {
  bool? get() {
    return appStorage.read(name);
  }

  save(bool value) {
    appStorage.writeInMemory(name, value);
  }

  remove() {
    appStorage.remove(name);
  }
}

/// 保存对象
enum MapKV {
  topic,

  // 赛事玩法置顶 {matchHps.mid_matchHps.hpid_matchHps.topKey : 时间戳}
  matchHpsHtons,
  // 子玩法
  playInfo,
}

extension MapKVX on MapKV {
  Map? get() {
    return appStorage.read(name);
  }

  save(Map value) {
    appStorage.writeInMemory(name, value);
  }

  remove() {
    appStorage.remove(name);
  }
}

/// 保存数组
enum ListKV {
  // api 列表
  domainApi,
  playInfo,

}

extension ListKVX on ListKV {
  List get() {
    return appStorage.read(name) ?? [];
  }

  save(List value) {
    appStorage.writeInMemory(name, value);
    appStorage.save();
  }

  remove() {
    appStorage.remove(name);
  }
}

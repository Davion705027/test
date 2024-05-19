import 'package:get/get.dart';

class LeagueManager {
  LeagueManager._privateConstructor();

  static final LeagueManager _instance = LeagueManager._privateConstructor();

  static LeagueManager get instance {
    return _instance;
  }

  static RxList tid = [].obs;

  static String euid = '40203';

  static RxInt type = 3.obs;

  static String md = '';

  // 热门 时间排序
  static RxInt sort = 1.obs;

  // 入口名字 判断是否清空已选择联赛 home result
  // h5 是点赛果就清楚已选择联赛
  static String entryName = 'home';

}

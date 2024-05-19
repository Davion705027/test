import 'dart:convert';

import 'package:flutter_ty_app/generated/json/access_config.g.dart';
import 'package:flutter_ty_app/generated/json/base/json_field.dart';

export 'package:flutter_ty_app/generated/json/access_config.g.dart';

@JsonSerializable()
class AccessConfig {
  // 活动开关
  late bool activitySwitch = true;

  // 收藏开关
  late bool collectSwitch = true;

  // 彩票开关
  late bool cpSwitch = true;

  // 联赛赛选
  late bool filterSwitch = true;

  // 盘口数
  late bool handicapNum = true;

  // 热门赛事数
  late bool hotMatchNum = true;

  // 热门推荐
  late bool hotRecommend = true;

  // pc列表更多玩法
  late bool multiColumn = true;

  // 滚球全部显示
  late bool playAllShow = true;

  // 近期关注
  late bool recentSwitch = true;

  // 搜索开关
  late bool searchSwitch = true;

  // 排序开关
  late bool sortCut = true;

  /// 赛事统计
  late bool statisticsSwitch = true;

  // 真人
  late bool zrSwitch = true;

  // 联赛收起
  late bool tourSwitch = false;

  AccessConfig();

  factory AccessConfig.fromJson(Map<String, dynamic> json) =>
      $AccessConfigFromJson(json);

  Map<String, dynamic> toJson() => $AccessConfigToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

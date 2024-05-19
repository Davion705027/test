import 'package:flutter_ty_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_ty_app/app/services/models/res/access_config.dart';

AccessConfig $AccessConfigFromJson(Map<String, dynamic> json) {
  final AccessConfig accessConfig = AccessConfig();
  final bool? activitySwitch = jsonConvert.convert<bool>(
      json['activitySwitch']);
  if (activitySwitch != null) {
    accessConfig.activitySwitch = activitySwitch;
  }
  final bool? collectSwitch = jsonConvert.convert<bool>(json['collectSwitch']);
  if (collectSwitch != null) {
    accessConfig.collectSwitch = collectSwitch;
  }
  final bool? cpSwitch = jsonConvert.convert<bool>(json['cpSwitch']);
  if (cpSwitch != null) {
    accessConfig.cpSwitch = cpSwitch;
  }
  final bool? filterSwitch = jsonConvert.convert<bool>(json['filterSwitch']);
  if (filterSwitch != null) {
    accessConfig.filterSwitch = filterSwitch;
  }
  final bool? handicapNum = jsonConvert.convert<bool>(json['handicapNum']);
  if (handicapNum != null) {
    accessConfig.handicapNum = handicapNum;
  }
  final bool? hotMatchNum = jsonConvert.convert<bool>(json['hotMatchNum']);
  if (hotMatchNum != null) {
    accessConfig.hotMatchNum = hotMatchNum;
  }
  final bool? hotRecommend = jsonConvert.convert<bool>(json['hotRecommend']);
  if (hotRecommend != null) {
    accessConfig.hotRecommend = hotRecommend;
  }
  final bool? multiColumn = jsonConvert.convert<bool>(json['multiColumn']);
  if (multiColumn != null) {
    accessConfig.multiColumn = multiColumn;
  }
  final bool? playAllShow = jsonConvert.convert<bool>(json['playAllShow']);
  if (playAllShow != null) {
    accessConfig.playAllShow = playAllShow;
  }
  final bool? recentSwitch = jsonConvert.convert<bool>(json['recentSwitch']);
  if (recentSwitch != null) {
    accessConfig.recentSwitch = recentSwitch;
  }
  final bool? searchSwitch = jsonConvert.convert<bool>(json['searchSwitch']);
  if (searchSwitch != null) {
    accessConfig.searchSwitch = searchSwitch;
  }
  final bool? sortCut = jsonConvert.convert<bool>(json['sortCut']);
  if (sortCut != null) {
    accessConfig.sortCut = sortCut;
  }
  final bool? statisticsSwitch = jsonConvert.convert<bool>(
      json['statisticsSwitch']);
  if (statisticsSwitch != null) {
    accessConfig.statisticsSwitch = statisticsSwitch;
  }
  final bool? zrSwitch = jsonConvert.convert<bool>(json['zrSwitch']);
  if (zrSwitch != null) {
    accessConfig.zrSwitch = zrSwitch;
  }
  final bool? tourSwitch = jsonConvert.convert<bool>(json['tourSwitch']);
  if (tourSwitch != null) {
    accessConfig.tourSwitch = tourSwitch;
  }
  return accessConfig;
}

Map<String, dynamic> $AccessConfigToJson(AccessConfig entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['activitySwitch'] = entity.activitySwitch;
  data['collectSwitch'] = entity.collectSwitch;
  data['cpSwitch'] = entity.cpSwitch;
  data['filterSwitch'] = entity.filterSwitch;
  data['handicapNum'] = entity.handicapNum;
  data['hotMatchNum'] = entity.hotMatchNum;
  data['hotRecommend'] = entity.hotRecommend;
  data['multiColumn'] = entity.multiColumn;
  data['playAllShow'] = entity.playAllShow;
  data['recentSwitch'] = entity.recentSwitch;
  data['searchSwitch'] = entity.searchSwitch;
  data['sortCut'] = entity.sortCut;
  data['statisticsSwitch'] = entity.statisticsSwitch;
  data['zrSwitch'] = entity.zrSwitch;
  data['tourSwitch'] = entity.tourSwitch;
  return data;
}

extension AccessConfigExtension on AccessConfig {
  AccessConfig copyWith({
    bool? activitySwitch,
    bool? collectSwitch,
    bool? cpSwitch,
    bool? filterSwitch,
    bool? handicapNum,
    bool? hotMatchNum,
    bool? hotRecommend,
    bool? multiColumn,
    bool? playAllShow,
    bool? recentSwitch,
    bool? searchSwitch,
    bool? sortCut,
    bool? statisticsSwitch,
    bool? zrSwitch,
    bool? tourSwitch,
  }) {
    return AccessConfig()
      ..activitySwitch = activitySwitch ?? this.activitySwitch
      ..collectSwitch = collectSwitch ?? this.collectSwitch
      ..cpSwitch = cpSwitch ?? this.cpSwitch
      ..filterSwitch = filterSwitch ?? this.filterSwitch
      ..handicapNum = handicapNum ?? this.handicapNum
      ..hotMatchNum = hotMatchNum ?? this.hotMatchNum
      ..hotRecommend = hotRecommend ?? this.hotRecommend
      ..multiColumn = multiColumn ?? this.multiColumn
      ..playAllShow = playAllShow ?? this.playAllShow
      ..recentSwitch = recentSwitch ?? this.recentSwitch
      ..searchSwitch = searchSwitch ?? this.searchSwitch
      ..sortCut = sortCut ?? this.sortCut
      ..statisticsSwitch = statisticsSwitch ?? this.statisticsSwitch
      ..zrSwitch = zrSwitch ?? this.zrSwitch
      ..tourSwitch = tourSwitch ?? this.tourSwitch;
  }
}
import 'package:flutter_ty_app/app/modules/home/models/section_group_enum.dart';

/// 折叠展开比赛

class FoldMatchManager {
  static Set<String> _foldTids = {};

  static bool isFoldByTid(String key, SectionGroupEnum section) {
    return _foldTids.contains(key + section.name);
  }

  static void setFoldByTid(String key, SectionGroupEnum section, bool isFold) {
    if (isFold) {
      _foldTids.add(key + section.name);
    } else {
      _foldTids.remove(key + section.name);
    }
  }

  static void clearFoldTids() {
    _foldTids.clear();
  }

  static Map<SectionGroupEnum, bool> groupFold = {};

  static void clearGroupFold() {
    groupFold.clear();
  }

  static bool isGroupFold(SectionGroupEnum group) {
    return groupFold[group] ?? false;
  }

  static void setGroupFold(SectionGroupEnum group, bool isExpand) {
    groupFold[group] = isExpand;
  }
}

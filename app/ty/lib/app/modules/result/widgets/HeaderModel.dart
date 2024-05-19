import '../../../services/models/res/match_entity.dart';

class HeaderModel {
  // 比分
  late String score = '';

  // 比索时间
  late String time = '';

  // 状态 是否已结束
  late String status = '';
}

// 列表渲染model
class TidDataList {
  late List<MatchEntity> list;
  late String tnjc;
  late String tid;
  late String mid;
  late String tn;
  bool isExpand = true;
}
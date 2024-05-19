import 'package:common_utils/common_utils.dart';

class MatchListReq {
  String cuid; // 菜单id
  String euid;
  int type; // 一级菜单 1滚球2即将开赛3今日4早盘11串关100冠军
  int sort; // 排序1:热门 2时间
  String? device; //设备
  int? hpsFlag;
  int? category;
  String? md; // md="" 所有日期 md=“0” 今日 md=“时间戳” 账单日期
  String? tid;

  MatchListReq({
    required this.cuid,
    required this.euid,
    required this.type,
    required this.sort,
    this.device,
    this.hpsFlag,
    this.category,
    this.md,
    this.tid,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchListReq &&
          runtimeType == other.runtimeType &&
          euid == other.euid &&
          type == other.type &&
          sort == other.sort &&
          tid == other.tid;

  @override
  int get hashCode =>
      euid.hashCode ^ type.hashCode ^ sort.hashCode ^ tid.hashCode;

  String getRequestSessionKey(bool collection) {
    return '$cuid$euid$type$sort$device$hpsFlag$category$md$tid${collection ? 'collection' : ''}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cuid'] = cuid;
    data['euid'] = euid;
    data['type'] = type;
    data['sort'] = sort;
    data['device'] = device;
    data['hpsFlag'] = hpsFlag;
    data['category'] = category;
    data['md'] = md;
    data['tid'] = tid;
    data.removeWhere((key, value) => ObjectUtil.isEmpty(value));
    return data;
  }

  MatchListReq.fromJson(Map<String, dynamic> json)
      : cuid = json['cuid'],
        euid = json['euid'],
        type = json['type'],
        sort = json['sort'],
        device = json['device'],
        hpsFlag = json['hpsFlag'],
        category = json['category'],
        md = json['md'],
        tid = json['tid'];
}

void main() {
  MatchListReq req = MatchListReq(
    cuid: '1',
    euid: '40203',
    type: 3,
    sort: 1,
    device: 'v2_h5',
    hpsFlag: 0,
    category: 1,
    md: null,
    tid: null,
  );

  MatchListReq req1 = MatchListReq(
    cuid: '1',
    euid: '40203',
    type: 3,
    sort: 1,
    device: 'v2_h5_st',
    hpsFlag: 0,
    category: 1,
    md: null,
    tid: null,
  );
  print(req1 == req);
  print(req1.hashCode == req.hashCode);
}

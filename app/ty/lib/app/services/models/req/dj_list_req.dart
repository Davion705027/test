
class DJListReq {
  int? category;
  String csid;
  String cuid; // 菜单id
  String euid;
  // String? device;//设备
  int? hpsFlag;
  String? md;
  int sort; // 排序1:热门 2时间
  int type;

  DJListReq({this.category, required this.csid, required this.cuid, required this.euid, this.hpsFlag,
    this.md, required this.sort, required this.type});

  String getRequestSessionKey(bool collection) {
    return 'cuid=$cuid euid=$euid type=$type sort=$sort hpsFlag=$hpsFlag category$category md=$md collection=${collection ? 'collection' : ''}';
    // return '$cuid$euid$type$sort$hpsFlag$category$md${collection ? 'collection' : ''}';
  }
}
class SportMenu {
  String mi;//`${常规球类csid}${一级菜单id}`; //例如 足球+今日  1012
  String euid;//
  int iconIndex;//图片下标
  String title;//标题名称
  int? count;//数量

  SportMenu({
    required this.mi,
    required this.euid,
    required this.iconIndex,
    required this.title,
    this.count,
  });

  @override
  String toString() {
    return 'SportMenu{mi: $mi, euid: $euid, iconIndex: $iconIndex, title: $title, count: $count}';
  }
}

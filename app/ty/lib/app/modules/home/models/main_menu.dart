class MainMenu {
  int mi;
  String code;
  int type;

  MainMenu(this.mi, this.code,this.type);

  get isChampion => mi == 400;

  get isEarly => mi == 3;

  get isPlay => mi == 1;

  get isMatchBet => mi == 6;

  get isToday => mi == 2;

  @override
  String toString() {
    return 'Menu{mi: $mi, code: $code}';
  }
  ///一级菜单
  static List<MainMenu> menuList = [
    MainMenu(2, 'today',3), // 今日
    MainMenu(1, 'play',1), // 滚球
    MainMenu(3, 'early',4), // 早盘
    MainMenu(6, 'match_bet',11), // 串关
    MainMenu(400, 'champion',100), // 冠军
  ];
}

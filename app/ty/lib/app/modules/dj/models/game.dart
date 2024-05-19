
class Game {
  String name;
  int csid;
  int euid;
  String tid;
  String? img;
  String alias;

  Game(this.name, this.csid, this.euid, this.tid, this.img, this.alias);

  static List<Game> leagueList = [
    Game("收藏", 0, 0,'0', "", 'all'),
    Game("英雄联盟", 100, 41002,'239', "", 'serie_league'),
    Game("Dota2", 101,41001, '320', "", 'spanish_league'),
    Game("王者荣耀", 103,41003, '276', "", 'german_league'),
    Game("CS:Go/CS2", 102,41004, '79', "", 'french_league'),
  ];
}

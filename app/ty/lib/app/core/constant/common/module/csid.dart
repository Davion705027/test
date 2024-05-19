class Csid {

  /**
   * @description: 获取各球种背景图片
   * @param {String} csid 球种id
   * @return {String} 返回各球种背景图片
   */

static computed_background  (csid)  {
    var LOCAL_PROJECT_FILE_PREFIX = 'assets';
  var football = '${LOCAL_PROJECT_FILE_PREFIX}/image/png/football.png'; //足球
  var basketball = '${LOCAL_PROJECT_FILE_PREFIX}/image/png/basketball.png'; //篮球
  var baseball = '${LOCAL_PROJECT_FILE_PREFIX}/image/png/baseball.png'; //棒球
  var ice_hockey = '${LOCAL_PROJECT_FILE_PREFIX}/image/jpg/ice_hockey.jpg'; //冰球
  var tennis = '${LOCAL_PROJECT_FILE_PREFIX}/image/png/tennis.png'; //网球
  var usa_football = '${LOCAL_PROJECT_FILE_PREFIX}/image/png/usa_football.png'; // 美足
  var snooker = '${LOCAL_PROJECT_FILE_PREFIX}/image/jpg/snooker.jpg'; //斯诺克
  var ping_pong = '${LOCAL_PROJECT_FILE_PREFIX}/image/jpg/ping_pong.jpg'; //乒乓球
  var volleyball = '${LOCAL_PROJECT_FILE_PREFIX}/image/png/volleyball.png'; // 排球
  var badminton = '${LOCAL_PROJECT_FILE_PREFIX}/image/jpg/badminton.jpg'; //羽毛球
  var handball = '${LOCAL_PROJECT_FILE_PREFIX}/image/common/png/handball.png'; //手球
  var boxing = '${LOCAL_PROJECT_FILE_PREFIX}/image/common/png/boxing.png'; //拳击
  var beach_volleyball = '${LOCAL_PROJECT_FILE_PREFIX}/image/common/png/beach_volleyball.png'; //沙滩排球
  var rugby = '${LOCAL_PROJECT_FILE_PREFIX}/image/common/png/rugby.png'; //橄榄球
  var hockey = '${LOCAL_PROJECT_FILE_PREFIX}/image/common/png/hockey.png'; //曲棍球
  var polo = '${LOCAL_PROJECT_FILE_PREFIX}/image/common/png/polo.png'; //水球
  var virtual_dog = '${LOCAL_PROJECT_FILE_PREFIX}/image/png/virtual_dog.png'; //赛狗
  var virtual_racing = '${LOCAL_PROJECT_FILE_PREFIX}/image/png/virtual_racing.png'; //赛马
  var motorcycle = '${LOCAL_PROJECT_FILE_PREFIX}/image/png/motorcycle.png'; // 虚拟摩托车
  var virtual_dirt_bike_details = '${LOCAL_PROJECT_FILE_PREFIX}/image/png/virtual_dirt_bike_details.png'; // 虚拟泥地摩托车

  var background_img = "";
  // 3棒、4冰、5网、7斯诺克、8乒乓、10羽毛球 1001虚拟足球、1002赛狗、1011赛马
    switch (csid) {
      case "1": // 足球
      case "1001": // 虚拟足球
        background_img = football;
        break;
      case "2": // 篮球
      case "1004": // 虚拟篮球
        background_img = basketball;
        break;
      case "3": // 棒球
        background_img = baseball;
        break;
      case "4": // 冰球
        background_img = ice_hockey;
        break;
      case "5": // 网球
        background_img = tennis;
        break;
      case "6": // 美足
        background_img = usa_football;
        break;
      case "7": // 斯诺克
        background_img = snooker;
        break;
      case "8": // 乒乓
        background_img = ping_pong;
        break;
      case "9": // 排球
        background_img = volleyball;
        break;
      case "10": // 羽毛球
        background_img = badminton;
        break;
      case "11": //手球
        background_img = handball;
        break;
      case "12": //拳击
        background_img = boxing;
        break;
      case "13": //沙滩排球
        background_img = beach_volleyball;
        break;
      case "14": //橄榄球
        background_img = rugby;
        break;
      case "15": //曲棍球
        background_img = hockey;
        break;
      case "16": //水球
        background_img = polo;
        break;
      case "1002": // 虚拟赛狗
        background_img = virtual_dog;
        break;
      case "1011": // 虚拟赛马
        background_img = virtual_racing;
        break;
      case "1010": // 虚拟摩托
        background_img = motorcycle;
        break;
      case "1009": // 虚拟泥地摩托车
        background_img = virtual_dirt_bike_details;
        break;
    }
    //if (background_img.isNotEmpty)
    //  useMittEmit(MITT_TYPES.EMIT_GET_BACKGROUND_IMG, background_img);
    return background_img;
}

  /**
   * 球种id枚举
   * H5/PC  对应配置文件 新增 csid_map_name 对应以下国际化
   * 例： name: i18n_t('csid_map_name.xxx')
   */
  static const CSID_CONFIG = {
    'csid_1': { 'csid': "1", 'mark': "足球", 'name': ''},
    'csid_2': { 'csid': "2", 'mark': "篮球"},
    'csid_3': { 'csid': "3", 'mark': "棒球"},
    'csid_4': { 'csid': "4", 'mark': "冰球"},
    'csid_5': { 'csid': "5", 'mark': "网球"},
    'csid_6': { 'csid': "6", 'mark': "美式足球"},
    'csid_7': { 'csid': "7", 'mark': "斯诺克"},
    'csid_8': { 'csid': "8", 'mark': "乒乓球"},
    'csid_9': { 'csid': "9", 'mark': "排球"},
    'csid_10': { 'csid': "10", 'mark': "羽毛球"},
    'csid_11': { 'csid': "11", 'mark': "手球"},
    'csid_12': { 'csid': "12", 'mark': "拳击"},
    'csid_13': { 'csid': "13", 'mark': "沙滩排球"},
    'csid_14': { 'csid': "14", 'mark': "联合式橄榄球"},
    'csid_15': { 'csid': "15", 'mark': "曲棍球"},
    'csid_16': { 'csid': "16", 'mark': "水球"},
    'csid_17': { 'csid': "17", 'mark': "田径"},
    'csid_18': { 'csid': "18", 'mark': "政治娱乐"},
    'csid_19': { 'csid': "19", 'mark': "游泳"},
    'csid_20': { 'csid': "20", 'mark': "体操"},
    'csid_21': { 'csid': "21", 'mark': "跳水"},
    'csid_23': { 'csid': "23", 'mark': "举重"},
    'csid_24': { 'csid': "24", 'mark': "射箭"},
    'csid_25': { 'csid': "25", 'mark': "击剑"},
    'csid_26': { 'csid': "26", 'mark': "冰壶"},
    'csid_27': { 'csid': "27", 'mark': "跆拳道"},
    'csid_28': { 'csid': "28", 'mark': "高尔夫"},
    'csid_29': { 'csid': "29", 'mark': "自行车"},
    'csid_30': { 'csid': "30", 'mark': "赛马"},
    'csid_31': { 'csid': "31", 'mark': "帆船"},
    'csid_32': { 'csid': "32", 'mark': "划船"},
    'csid_33': { 'csid': "33", 'mark': "赛车运动"},
    'csid_34': { 'csid': "34", 'mark': "柔道"},
    'csid_35': { 'csid': "35", 'mark': "空手道"},
    'csid_36': { 'csid': "36", 'mark': "摔跤"},
    'csid_37': { 'csid': "37", 'mark': "板球"},
    'csid_38': { 'csid': "38", 'mark': "飞镖"},
    'csid_39': { 'csid': "39", 'mark': "沙滩足球"},
    'csid_40': { 'csid': "40", 'mark': "其他"},
    'csid_100': { 'csid': "100", 'mark': "英雄联盟"},
    'csid_101': { 'csid': "101", 'mark': "Dota2"},
    'csid_102': { 'csid': "102", 'mark': "CS.GO"},
    'csid_103': { 'csid': "103", 'mark': "王者荣耀"},
    'csid_1001': { 'csid': "1001", 'mark': "VR足球"},
    'csid_1002': { 'csid': "1002", 'mark': "VR赛狗"},
    'csid_1007': { 'csid': "1007", 'mark': "VR泥地赛车"},
    'csid_1008': { 'csid': "1008", 'mark': "VR卡丁车"},
    'csid_1009': { 'csid': "1009", 'mark': "VR泥地摩托车"},
    'csid_1010': { 'csid': "1010", 'mark': "VR摩托车"},
    'csid_1011': { 'csid': "1011", 'mark': "VR赛马"},
    'csid_1012': { 'csid': "1012", 'mark': "VR马车赛"},

  };

  /**
   * 球种id 和 play_name_mapping 对应关系
   *
   */
  static const play_name_mapping_csid = {
    1: "足球",
    2: "篮球",
    3: "棒球",
    4: "冰球",
    5: "网球",
    6: "美式足球",
    7: "斯诺克",
    8: "乒乓球",
    9: "排球",
    10: "羽毛球",
    11: "手球",
    12: "拳击",
    13: "沙滩排球",
    14: "橄榄球",
    15: "曲棍球",
    16: "水球",
    100: "英雄联盟",
    101: "dota2",
    102: "csgo",
    103: "王者荣耀",
    1001: "VR足球",
    1002: "VR赛狗",
    1007: "VR泥地赛车",
    1008: "VR卡丁车",
    1009: "VR泥地摩托车",
    1010: "VR摩托车",
    1011: "VR赛马",
    1012: "VR马车赛",
  };


  /**
   * 电子竞技
   */
  static const esports_csid = [100, 101, 103, 102];

  /**
   * 电竞子菜单
   */
// { ct: 0, mi: "2100", st: 1, csid: "100" },
// { ct: 0, mi: "2101", st: 2, csid: "101" },
// { ct: 0, mi: "2103", st: 3, csid: "103" },
// { ct: 0, mi: "2102", st: 4, csid: "102" },
  static dianjing_sublist() {
    List esport = [];
    for (int index = 0; index < esports_csid.length; index++) {
      dynamic item = esports_csid[index];
      esport.add(
          { 'ct': 0, 'mi': '2${item}', 'st': index + 1, 'csid': '$item'});
    }

    return esport;
  }


  /**
   * H5 赛事 csid 映射二级菜单 menu_type
   */
  static const csid_map_sub_menu_type = {
    1: 5, // 足球"
    2: 7, // 篮球"
    3: 19, // 棒球"
    4: 18, // 冰球"
    5: 13, // 网球"
    6: 20, // 美式足球"
    7: 14, // 斯诺克"
    8: 16, // 乒乓球"
    9: 17, // 排球"
    10: 15, // 羽毛球"
    11: 43, // 手球"
    12: 44, // 拳击"
    13: 45, // 沙滩排球"
    14: 22, // 联合式橄榄球"
    // 14: 45 ,// 橄榄球"
    15: 23, // 曲棍球"
    16: 24, // 水球"
  };


  /**
   * H5 赛事 csid 映射让球玩法ID
   */
  static const csid_map_concede_points_id = {
    1: 4, // 足球"
    2: 39, // 篮球"
    3: 243, // 棒球"
    4: 4, // 冰球"
    5: 154, // 网球"
    6: 39, // 美式足球"
    7: 181, // 斯诺克"
    8: 172, // 乒乓球"
    9: 172, // 排球"
    10: 172, // 羽毛球"
    11: 43, // 手球"
    12: 44, // 拳击"
    13: 45, // 沙滩排球"
    14: 22, // 联合式橄榄球"
    // 14: 45 ,// 橄榄球"
    15: 23, // 曲棍球"
    16: 24, // 水球"
  };

// 精灵图对应的位置
  static const sprite_images_postion = {
    0: 2, //下标从0开始
    1: 3,
    2: 4,
    3: 14,
    4: 22,
    5: 6,
    6: 11,
    7: 10,
    8: 9,
    9: 5,
    10: 8,
    11: 28,
    12: 16,
    13: 27,
    14: 12,
    15: 23,
    16: 13,
    17:44,
    18: 18,
    19:46,
    20:48,
    21:47,
    22:52,
    23:49,
    24:50,
    25:51,
    26:55,
    27:56,
    28:24,
    29:45,
    30:65,
    31:53,
    32:54,
    33:42,
    34:58,
    35:57,
    36:59,
    37:21,
    38:20,
    39:60,
    40:66,
    50:64,
    90: 62,
    91: 63,
    100:67,//赛果 我的注单
    300: 33,
    2000: 15,
    2100: 29,
    2101: 30,
    2103: 31,
    2102: 32,
    31001: 34,
    31004: 35,
    31011: 25, 
    31002: 26,
    31009: 41,
    31010: 42,
    50000: 1,
    3000: 69,
    4000: 68,
  };

// 复刻版联赛对应的位置
  static const league_sprite_images_postion = {
    1: 22, //世界杯 下标从0开始
    2: 6, //欧冠
    3: 2, //英超
    4: 9, //意甲
    5: 3, //西甲
    6: 4, //德甲
    7: 5, //法甲
    8: 39, //中超
  };

  // 赔率映射值
  static const odds_table = {
    'EU': '1',
    'HK': '2',
    'MY': '3',
    'GB': '4',
    'US': '5',
    'ID': '6',
  };

  // 独赢类玩法
  static const only_win = {
    1: [
      1,
      13,
      17,
      25,
      32,
      101,
      105,
      106,
      111,
      119,
      126,
      129,
      231,
      310,
      311,
      326,
      329,
      333,
      345,
      346,
      353,
      370,
      384
    ],
    2: [37, 43, 44, 48, 54, 60, 66, 153],
    3: [242, 283],
    4: [1, 259],
    5: [153, 162, 168],
    6: [17, 37],
    7: [153],
    8: [153],
    9: [153, 162],
    10: [153],
    11: [1, 17, 259,],
    12: [153, 339],
    13: [153, 162],
    14: [1, 17, 126],
    15: [1, 17, 48, 54, 60, 66],
    16: [1, 17, 44, 50, 56, 62, 259],
    17: [],
    18: [],
    19: [],
    20: [],
    21: [],
    22: [],
    23: [],
    24: [],
    25: [],
    26: [],
    27: [],
    28: [],
    29: [],
    30: [],
    31: [],
    32: [],
    33: [],
    34: [],
    35: [],
    36: [],
    37: [],
    38: [],
    39: [],
    40: [],
    50: [],
    90: [],
    91: [],
    100: [],
    101: [],
    102: [],
    103: [],
    104: [],
    105: [],
    201: [],
    202: [],
    203: [],
    204: [],
    205: [],
    1001: [20001, 20010, 20013, 20025, 20026, 20030],
    1002: [],
    1003: [],
    1004: [20043],
    1007: [],
    1008: [],
    1009: [],
    1010: [],
    1011: [],
    1012: [],
    1013: [],
  };

  // 亚洲版pc精灵图对应的位置
  static const sprite_images_postion_new_pc = {
    'item_0': 0, //下标从0开始
    'item_1': 1,
    'item_2': 3,
    'item_3': 28,
    'item_4': 2,
    'item_5': 19,
    'item_6': 4,
    'item_7': 15,
    'item_8': 7,
    'item_9': 6,
    'item_10': 22,
    'item_11': 13,
    'item_12': 10,
    'item_13': 12,
    'item_14': 20,
    'item_15': 8,
    'item_16': 14,
    'item_17': 17,
    'item_18': 26,
    'item_19': 21,
    'item_20': 16,
    'item_21': 18,
    'item_23': 29,
    'item_24': 30,
    'item_25': 31,
    'item_28': 33,
    'item_29': 32,
    'item_40': 35,
    'item_50': 9,
    'item_90': 60,
    'item_91': 61,
    'item_100': 44,
    'item_101': 41,
    'item_102': 43,
    'item_103': 42,
    'item_300': 36,
    'item_400': 37,
    'item_2000': 38,
    'item_10001': 36,
    'item_10002': 37,
    'item_10003': 38,
    'item_30': 42,
    'item_31': 43,
    'item_32': 44,
    'item_26': 45,
    'item_27': 46,
    'item_33': 47,
    'item_34': 48,
    'item_35': 49,
    'item_36': 50,
    'item_37': 51,
    'item_38': 52,
    'item_39': 53,
    'item_22': 55,
    'item_1010': 24,
    'item_1002': 11,
    'item_1001': 39,
    'item_1004': 40,
    'item_1011': 23,
    'item_1009': 5
  };

  // 欧洲版图标对应背景
  static const oz_sprite_bg_images_postion = {
    101: 0,
    102: 1,
    103: 2,
    104: 3,
    105: 4,
    106: 5,
    107: 6,
    108: 7,
    109: 8,
    110: 9,
    111: 10,
    112: 11,
    113: 12,
    114: 13,
    115: 14,
    116: 15,
    117: 16,
    118: 17,
    119: 18,
    120: 19,
    121: 20,
    122: 21,
    123: 22,
    124: 23,
    125: 24,
    126: 25,
    127: 26,
    128: 27,
    129: 28,
    130: 29,
    131: 30,
    132: 31,
    133: 32,
    134: 33,
    135: 34,
    136: 35,
    137: 36,
    138: 37,
    139: 38,
    140: 39,
    150: 40,
    2100: 41,
    2101: 42,
    2102: 43,
    2103: 44,
    1001: 45,
    1002: 46,
    1004: 47,
    1009: 48,
    1010: 49,
    1011: 50,
    400: 51,
    190: 52,
    191: 53
  };

  // 赛果详情地图 miid -> string
  static const result_detail_images_postion = {
    1 : 'assets/images/detail/bg/football.jpg',
    2 : 'assets/images/detail/bg/basketball.jpg',
    90 : 'assets/images/detail/bg/football.jpg',
    91 : 'assets/images/detail/bg/basketball.jpg',
    5 : 'assets/images/detail/bg/tennis.jpg',
    7 : 'assets/images/detail/bg/snooker_pool.jpg',
    10 : 'assets/images/detail/bg/badminton.jpg',
    8 : 'assets/images/detail/bg/ping_pong.jpg',
    3 : 'assets/images/detail/bg/baseball.jpg',
    9 : 'assets/images/detail/bg/volleyball.jpg',
    11 : 'assets/images/detail/bg/handball.jpg',
    12 : 'assets/images/detail/bg/boxing.jpg',
    13 : 'assets/images/detail/bg/beach_volleyball.jpg',
    16 : 'assets/images/detail/bg/water_polo.jpg',
    15 : 'assets/images/detail/bg/hockey.jpg',
    14 : 'assets/images/detail/bg/rugby.jpg',
    4 : 'assets/images/detail/bg/ice_hockey.jpg',
    6 : 'assets/images/detail/bg/american_football.jpg',
    18 : 'assets/images/detail/bg/rugby.jpg',
  };
}
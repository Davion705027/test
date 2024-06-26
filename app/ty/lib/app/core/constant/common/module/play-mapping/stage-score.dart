



// 滚球和今日里面需要显示比分的玩法对应的比分键值
const SCORE_BASE_KEY = {
  '4' : 'S1', // 让球盘
  '19': 'S2', // 半场让球
  '27': 'S1', // 剩余时间获胜
  '29': 'S1', // 上半场剩余时间获胜
  // '32': 'S1001', // 15分钟进球-赛果
  // '33': 'S1001',
  //S1001	0~14:59 分钟进球
  //S1002	15~29:59 分钟进球
  //S1003	30~44:59 分钟进球
  //S1004	45~59:59 分钟进球
  //S1005	60~74:59 分钟进球
  //S1006	75~89:59 分钟进球
  '33': "S1001,S1002,S1003,S1004,S1005,S1006",   // 15分钟进球-让球 阶段
  '113': 'S5', // 角球全场让球
  '121': 'S15', // 角球上半场让球
  '128': 'S7', // 加时赛-让球
  '130': 'S701', // 加时赛-上半场让球
  '143': 'S3', // 下半场让球盘
  '232': 'S5001', // 15分钟角球让球
  '269': 'S1', // 全场让球
  '270': 'S2', // 半场让球
  '306': 'S10102', // 罚牌让分
  '308': 'S10103', // 上半场罚牌比分
  '324': "S12001", // 黄牌让分
  '327': 'S14', // 上半场黄牌让分
  '334': 'S170', // 点球大战-让球
};






// 球种与阶段比分
const SPORT_PLAY_TO_STAGE_SCROE = {
  /**
      足球阶段
      6: 上半场
      7: 下半场
   */
  "1": {
    "17": {
      "6": "S2",
      "7": "S3"
    }, //半场独赢
    "18": {
      "6": "S2",
      "7": "S3"
    }, //半场大小
    "19":{
      "6": "S2",
      "7": "S3"
    }, //半场让球
    "270":{
      "6": "S2",
      "7": "S3"
    }, //半场让球
    "32": {
      "6": "S2",
      "7": "S3",
      "31": "S1"
    },//15分钟  独赢
    "33": {
      "6": "S2",
      "7": "S3",
      "31": "S1"
    },//15分钟 让球
    "34": {
      "6": "S2",
      "7": "S3",
      "31": "S1"
    }//15分钟 大小
  },
  "2": {
    "145":{
      "13": "S19",
      "14": "S20",
      "15": "S21",
      "16": "S22",
      "100": "S22",
      "301": "S20",
      "302": "S21",
      "303": "S22"
    }, //第{X}节{主队}总分
    "146":{
      "13": "S19",
      "14": "S20",
      "15": "S21",
      "16": "S22",
      "100": "S22",
      "301": "S20",
      "302": "S21",
      "303": "S22"
    }, //第{X}节{客队}总分
    "147":{
      "13": "S19",
      "14": "S20",
      "15": "S21",
      "16": "S22",
      "100": "S22",
      "301": "S20",
      "302": "S21",
      "303": "S22"
    }, //第{X}节首先获得{Y}分(三项)
    "215":{
      "13": "S19",
      "14": "S20",
      "15": "S21",
      "16": "S22",
      "100": "S22",
      "301": "S20",
      "302": "S21",
      "303": "S22"
    } //第{X}节首先获得{Y}分
  },
  // 棒球
  "3":{
    "275": {
      "401": "S120",
      "402": "S120",
      "403": "S121",
      "404": "S121",
      "405": "S122",
      "406": "S122",
      "407": "S123",
      "408": "S123",
      "409": "S124",
      "410": "S124",
      "411": "S125",
      "412": "S125",
      "413": "S126",
      "414": "S126",
      "415": "S127",
      "416": "S127",
      "417": "S128",
      "418": "S128",
      "41910": "S129",
      "42010": "S129",
      "421": "S120",
      "422": "S121",
      "423": "S121",
      "424": "S122",
      "425": "S122",
      "426": "S123",
      "427": "S123",
      "428": "S124",
      "429": "S124",
      "430": "S125",
      "431": "S125",
      "432": "S126",
      "433": "S126",
      "434": "S127",
      "435": "S127",
      "436": "S128",
      "437": "S128",
      "43910": "S129"
    },
    "276": {
      "401": "S120",
      "402": "S120",
      "403": "S121",
      "404": "S121",
      "405": "S122",
      "406": "S122",
      "407": "S123",
      "408": "S123",
      "409": "S124",
      "410": "S124",
      "411": "S125",
      "412": "S125",
      "413": "S126",
      "414": "S126",
      "415": "S127",
      "416": "S127",
      "417": "S128",
      "418": "S128",
      "41910": "S129",
      "42010": "S129",
      "421": "S120",
      "422": "S121",
      "423": "S121",
      "424": "S122",
      "425": "S122",
      "426": "S123",
      "427": "S123",
      "428": "S124",
      "429": "S124",
      "430": "S125",
      "431": "S125",
      "432": "S126",
      "433": "S126",
      "434": "S127",
      "435": "S127",
      "436": "S128",
      "437": "S128",
      "43910": "S129"
    },
    "280": {
      "401": "S120",
      "402": "S120",
      "403": "S121",
      "404": "S121",
      "405": "S122",
      "406": "S122",
      "407": "S123",
      "408": "S123",
      "409": "S124",
      "410": "S124",
      "411": "S125",
      "412": "S125",
      "413": "S126",
      "414": "S126",
      "415": "S127",
      "416": "S127",
      "417": "S128",
      "418": "S128",
      "41910": "S129",
      "42010": "S129",
      "421": "S120",
      "422": "S121",
      "423": "S121",
      "424": "S122",
      "425": "S122",
      "426": "S123",
      "427": "S123",
      "428": "S124",
      "429": "S124",
      "430": "S125",
      "431": "S125",
      "432": "S126",
      "433": "S126",
      "434": "S127",
      "435": "S127",
      "436": "S128",
      "437": "S128",
      "43910": "S129"
    },
    "281": {
      "401": "S120",
      "402": "S120",
      "403": "S121",
      "404": "S121",
      "405": "S122",
      "406": "S122",
      "407": "S123",
      "408": "S123",
      "409": "S124",
      "410": "S124",
      "411": "S125",
      "412": "S125",
      "413": "S126",
      "414": "S126",
      "415": "S127",
      "416": "S127",
      "417": "S128",
      "418": "S128",
      "41910": "S129",
      "42010": "S129",
      "421": "S120",
      "422": "S121",
      "423": "S121",
      "424": "S122",
      "425": "S122",
      "426": "S123",
      "427": "S123",
      "428": "S124",
      "429": "S124",
      "430": "S125",
      "431": "S125",
      "432": "S126",
      "433": "S126",
      "434": "S127",
      "435": "S127",
      "436": "S128",
      "437": "S128",
      "43910": "S129"
    },
    "282": {
      "401": "S120",
      "402": "S120",
      "403": "S121",
      "404": "S121",
      "405": "S122",
      "406": "S122",
      "407": "S123",
      "408": "S123",
      "409": "S124",
      "410": "S124",
      "411": "S125",
      "412": "S125",
      "413": "S126",
      "414": "S126",
      "415": "S127",
      "416": "S127",
      "417": "S128",
      "418": "S128",
      "41910": "S129",
      "42010": "S129",
      "421": "S120",
      "422": "S121",
      "423": "S121",
      "424": "S122",
      "425": "S122",
      "426": "S123",
      "427": "S123",
      "428": "S124",
      "429": "S124",
      "430": "S125",
      "431": "S125",
      "432": "S126",
      "433": "S126",
      "434": "S127",
      "435": "S127",
      "436": "S128",
      "437": "S128",
      "43910": "S129"
    },
    "283": {
      "401": "S120",
      "402": "S120",
      "403": "S121",
      "404": "S121",
      "405": "S122",
      "406": "S122",
      "407": "S123",
      "408": "S123",
      "409": "S124",
      "410": "S124",
      "411": "S125",
      "412": "S125",
      "413": "S126",
      "414": "S126",
      "415": "S127",
      "416": "S127",
      "417": "S128",
      "418": "S128",
      "41910": "S129",
      "42010": "S129",
      "421": "S120",
      "422": "S121",
      "423": "S121",
      "424": "S122",
      "425": "S122",
      "426": "S123",
      "427": "S123",
      "428": "S124",
      "429": "S124",
      "430": "S125",
      "431": "S125",
      "432": "S126",
      "433": "S126",
      "434": "S127",
      "435": "S127",
      "436": "S128",
      "437": "S128",
      "43910": "S129"
    },
    "287": {
      "401": "S1200",
      "402": "S1200",
      "403": "S1210",
      "404": "S1210",
      "405": "S1220",
      "406": "S1220",
      "407": "S1230",
      "408": "S1230",
      "409": "S1240",
      "410": "S1240",
      "411": "S1250",
      "412": "S1250",
      "413": "S1260",
      "414": "S1260",
      "415": "S1270",
      "416": "S1270",
      "417": "S1280",
      "418": "S1280",
      "41910": "S1290",
      "42010": "S1290",
      "421": "S1200",
      "422": "S1210",
      "423": "S1210",
      "424": "S1220",
      "425": "S1220",
      "426": "S1230",
      "427": "S1230",
      "428": "S1240",
      "429": "S1240",
      "430": "S1250",
      "431": "S1250",
      "432": "S1260",
      "433": "S1260",
      "434": "S1270",
      "435": "S1270",
      "436": "S1280",
      "437": "S1280",
      "43910": "S1290"
    },
    "288": {
      "401": "S1200",
      "402": "S1200",
      "403": "S1210",
      "404": "S1210",
      "405": "S1220",
      "406": "S1220",
      "407": "S1230",
      "408": "S1230",
      "409": "S1240",
      "410": "S1240",
      "411": "S1250",
      "412": "S1250",
      "413": "S1260",
      "414": "S1260",
      "415": "S1270",
      "416": "S1270",
      "417": "S1280",
      "418": "S1280",
      "41910": "S1290",
      "42010": "S1290",
      "421": "S1200",
      "422": "S1210",
      "423": "S1210",
      "424": "S1220",
      "425": "S1220",
      "426": "S1230",
      "427": "S1230",
      "428": "S1240",
      "429": "S1240",
      "430": "S1250",
      "431": "S1250",
      "432": "S1260",
      "433": "S1260",
      "434": "S1270",
      "435": "S1270",
      "436": "S1280",
      "437": "S1280",
      "43910": "S1290"
    },
    "289": {
      "401": "S1200",
      "402": "S1200",
      "403": "S1210",
      "404": "S1210",
      "405": "S1220",
      "406": "S1220",
      "407": "S1230",
      "408": "S1230",
      "409": "S1240",
      "410": "S1240",
      "411": "S1250",
      "412": "S1250",
      "413": "S1260",
      "414": "S1260",
      "415": "S1270",
      "416": "S1270",
      "417": "S1280",
      "418": "S1280",
      "41910": "S1290",
      "42010": "S1290",
      "421": "S1200",
      "422": "S1210",
      "423": "S1210",
      "424": "S1220",
      "425": "S1220",
      "426": "S1230",
      "427": "S1230",
      "428": "S1240",
      "429": "S1240",
      "430": "S1250",
      "431": "S1250",
      "432": "S1260",
      "433": "S1260",
      "434": "S1270",
      "435": "S1270",
      "436": "S1280",
      "437": "S1280",
      "43910": "S1290"
    }
  },
  // 乒乓球
  "8": {
    "175": {
      "8": "S120",
      "9": "S121",
      "10": "S122",
      "11": "S123",
      "12": "S124",
      "301": "S121",
      "302": "S122",
      "303": "S123",
      "304": "S124",
      "305": "S125",
      "306": "S126",
      "441": "S125",
      "442": "S126"
    },
    "176": {
      "8": "S120",
      "9": "S121",
      "10": "S122",
      "11": "S123",
      "12": "S124",
      "301": "S121",
      "302": "S122",
      "303": "S123",
      "304": "S124",
      "305": "S125",
      "306": "S126",
      "441": "S125",
      "442": "S126"
    },
    "177": {
      "8": "S120",
      "9": "S121",
      "10": "S122",
      "11": "S123",
      "12": "S124",
      "301": "S121",
      "302": "S122",
      "303": "S123",
      "304": "S124",
      "305": "S125",
      "306": "S126",
      "441": "S125",
      "442": "S126"
    },
    "178": {
      "8": "S120",
      "9": "S121",
      "10": "S122",
      "11": "S123",
      "12": "S124",
      "301": "S121",
      "302": "S122",
      "303": "S123",
      "304": "S124",
      "305": "S125",
      "306": "S126",
      "441": "S125",
      "442": "S126"
    },
    "179": {
      "8": "S120",
      "9": "S121",
      "10": "S122",
      "11": "S123",
      "12": "S124",
      "301": "S121",
      "302": "S122",
      "303": "S123",
      "304": "S124",
      "305": "S125",
      "306": "S126",
      "441": "S125",
      "442": "S126"
    },
    "203": {
      "8": "S120",
      "9": "S121",
      "10": "S122",
      "11": "S123",
      "12": "S124",
      "301": "S121",
      "302": "S122",
      "303": "S123",
      "304": "S124",
      "305": "S125",
      "306": "S126",
      "441": "S125",
      "442": "S126"
    },
  },
  // 排球
  "9": {
    "162": {
      "8": "S120",
      "9": "S121",
      "10": "S122",
      "11": "S123",
      "12": "S124",
      "17": "S124",
      "37": "S124",
      "301": "S121",
      "302": "S122",
      "303": "S123",
      "304": "S124"
    },
    "253": {
      "8": "S120",
      "9": "S121",
      "10": "S122",
      "11": "S123",
      "12": "S124",
      "17": "S124",
      "37": "S124",
      "301": "S121",
      "302": "S122",
      "303": "S123",
      "304": "S124"
    },
    "254": {
      "8": "S120",
      "9": "S121",
      "10": "S122",
      "11": "S123",
      "12": "S124",
      "17": "S124",
      "37": "S124",
      "301": "S121",
      "302": "S122",
      "303": "S123",
      "304": "S124"
    },
    "255": {
      "8": "S120",
      "9": "S121",
      "10": "S122",
      "11": "S123",
      "12": "S124",
      "17": "S124",
      "37": "S124",
      "301": "S121",
      "302": "S122",
      "303": "S123",
      "304": "S124"
    },
    "256": {
      "8": "S120",
      "9": "S121",
      "10": "S122",
      "11": "S123",
      "12": "S124",
      "17": "S124",
      "37": "S124",
      "301": "S121",
      "302": "S122",
      "303": "S123",
      "304": "S124"
    }
  }
};

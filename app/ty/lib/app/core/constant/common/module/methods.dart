/**
 * @description 球种玩法
 */

const PLAY_METHODS = [
  {
    "names": {
      "zs": "足球",
      "en": "Football"
    },
    "nameCode": "1",
    "id": "1"
  },
  {
    "names": {
      "zs": "篮球",
      "en": "Basketball"
    },
    "nameCode": "2",
    "id": "2"
  },
  {
    "names": {
      "zs": "棒球",
      "en": "Baseball"
    },
    "nameCode": "3",
    "id": "3"
  },
  {
    "names": {
      "zs": "冰球",
      "en": "Ice Hockey"
    },
    "nameCode": "4",
    "id": "4"
  },
  {
    "names": {
      "zs": "网球",
      "en": "Tennis"
    },
    "nameCode": "5",
    "id": "5"
  },
  {
    "names": {
      "zs": "美式足球",
      "en": "American Football"
    },
    "nameCode": "6",
    "id": "6"
  },
  {
    "names": {
      "zs": "斯诺克",
      "en": "Snooker"
    },
    "nameCode": "7",
    "id": "7"
  },
  {
    "names": {
      "zs": "乒乓球",
      "en": "Table Tennis"
    },
    "nameCode": "8",
    "id": "8"
  },
  {
    "names": {
      "zs": "排球",
      "en": "Volleyball"
    },
    "nameCode": "9",
    "id": "9"
  },
  {
    "names": {
      "zs": "羽毛球",
      "en": "Badminton"
    },
    "nameCode": "10",
    "id": "10"
  },
  {
    "names": {
      "zs": "手球",
      "en": "Handball"
    },
    "nameCode": "11",
    "id": "11"
  },
  {
    "names": {
      "zs": "拳击/格斗",
      "en": "Boxing/Fighting"
    },
    "nameCode": "12",
    "id": "12"
  },
  {
    "names": {
      "zs": "沙滩排球",
      "en": "Beach Volleyball"
    },
    "nameCode": "13",
    "id": "13"
  },
  {
    "names": {
      "zs": "联合式橄榄球",
      "en": "Rugby Union"
    },
    "nameCode": "14",
    "id": "14"
  },
  {
    "names": {
      "zs": "曲棍球",
      "en": "Hockey"
    },
    "nameCode": "15",
    "id": "15"
  },
  {
    "names": {
      "zs": "水球",
      "en": "Water Polo"
    },
    "nameCode": "16",
    "id": "16"
  },
  {
    "names": {
      "zs": "田径",
      "en": "Athletics"
    },
    "nameCode": "17",
    "id": "17"
  },
  {
    "names": {
      "zs": "4 x 10 km Relay",
      "en": "4 x 10 km Relay"
    },
    "nameCode": "18",
    "id": "18"
  },
  {
    "names": {
      "zs": "游泳",
      "en": "Swimming"
    },
    "nameCode": "19",
    "id": "19"
  },
  {
    "names": {
      "zs": "体操",
      "en": "Gymnastics"
    },
    "nameCode": "20",
    "id": "20"
  },
  {
    "names": {
      "zs": "跳水",
      "en": "Diving"
    },
    "nameCode": "21",
    "id": "21"
  },
  {
    "names": {
      "zs": "射击",
      "en": "Shooting"
    },
    "nameCode": "22",
    "id": "22"
  },
  {
    "names": {
      "zs": "举重",
      "en": "Weightlifting"
    },
    "nameCode": "23",
    "id": "23"
  },
  {
    "names": {
      "zs": "射箭",
      "en": "Archery"
    },
    "nameCode": "24",
    "id": "24"
  },
  {
    "names": {
      "zs": "击剑",
      "en": "Fencing"
    },
    "nameCode": "25",
    "id": "25"
  },
  {
    "names": {
      "zs": "冰壶",
      "en": "Curling"
    },
    "nameCode": "26",
    "id": "26"
  },
  {
    "names": {
      "zs": "跆拳道",
      "en": "Taekwondo"
    },
    "nameCode": "27",
    "id": "27"
  },
  {
    "names": {
      "zs": "高尔夫",
      "en": "Golf"
    },
    "nameCode": "28",
    "id": "28"
  },
  {
    "names": {
      "zs": "自行车",
      "en": "Cycling"
    },
    "nameCode": "29",
    "id": "29"
  },
  {
    "names": {
      "zs": "赛马",
      "en": "Horse Racing"
    },
    "nameCode": "30",
    "id": "30"
  },
  {
    "names": {
      "zs": "帆船",
      "en": "Sailing"
    },
    "nameCode": "31",
    "id": "31"
  },
  {
    "names": {
      "zs": "划船",
      "en": "Rowing"
    },
    "nameCode": "32",
    "id": "32"
  },
  {
    "names": {
      "zs": "赛车运动",
      "en": "Motorsport"
    },
    "nameCode": "33",
    "id": "33"
  },
  {
    "names": {
      "zs": "柔道",
      "en": "Judo"
    },
    "nameCode": "34",
    "id": "34"
  },
  {
    "names": {
      "zs": "空手道",
      "en": "karate"
    },
    "nameCode": "35",
    "id": "35"
  },
  {
    "names": {
      "zs": "摔跤",
      "en": "Wrestling"
    },
    "nameCode": "36",
    "id": "36"
  },
  {
    "names": {
      "zs": "板球",
      "en": "Cricket"
    },
    "nameCode": "37",
    "id": "37"
  },
  {
    "names": {
      "zs": "飞镖",
      "en": "Darts"
    },
    "nameCode": "38",
    "id": "38"
  },
  {
    "names": {
      "zs": "沙滩足球",
      "en": "Beach Football"
    },
    "nameCode": "39",
    "id": "39"
  },
  {
    "names": {
      "zs": "其他",
      "en": "Others"
    },
    "nameCode": "40",
    "id": "40"
  },
  {
    "names": {
      "zs": "联盟式橄榄球",
      "en": "Rugby League"
    },
    "nameCode": "41",
    "id": "41"
  },
  {
    "names": {
      "zs": "趣味",
      "en": "Fun"
    },
    "nameCode": "50",
    "id": "50"
  },
  {
    "names": {
      "zs": "英雄联盟",
      "en": "LOL"
    },
    "nameCode": "100",
    "id": "100"
  },
  {
    "names": {
      "zs": "Dota2",
      "en": "Dota2"
    },
    "nameCode": "101",
    "id": "101"
  },
  {
    "names": {
      "zs": "CS:GO",
      "en": "CS:GO"
    },
    "nameCode": "102",
    "id": "102"
  },
  {
    "names": {
      "zs": "王者荣耀",
      "en": "Honor of Kings"
    },
    "nameCode": "103",
    "id": "103"
  },
  {
    "names": {
      "zs": "绝地求生",
      "en": "PUBG"
    },
    "nameCode": "104",
    "id": "104"
  },
  {
    "names": {
      "zs": "VR足球",
      "en": "VR-Football"
    },
    "nameCode": "1001",
    "id": "1001"
  },
  {
    "names": {
      "zs": "VR赛狗",
      "en": "VR-Greyhounds"
    },
    "nameCode": "1002",
    "id": "1002"
  },
  {
    "names": {
      "zs": "VR篮球",
      "en": "VR-Basketball"
    },
    "nameCode": "1004",
    "id": "1004"
  },
  {
    "names": {
      "zs": "VR泥地赛车",
      "en": "VR-Dirttrack"
    },
    "nameCode": "1007",
    "id": "1007"
  },
  {
    "names": {
      "zs": "VR卡丁车",
      "en": "VR-Kart"
    },
    "nameCode": "1008",
    "id": "1008"
  },
  {
    "names": {
      "zs": "VR泥地摩托车",
      "en": "VR-Speedway"
    },
    "nameCode": "1009",
    "id": "1009"
  },
  {
    "names": {
      "zs": "VR摩托车",
      "en": "VR-Motorbike"
    },
    "nameCode": "1010",
    "id": "1010"
  },
  {
    "names": {
      "zs": "VR赛马",
      "en": "VR-Horse Racing"
    },
    "nameCode": "1011",
    "id": "1011"
  },
  {
    "names": {
      "zs": "VR马车赛",
      "en": "VR-Trotting"
    },
    "nameCode": "1012",
    "id": "1012"
  },
  {
    "names": {
      "zs": "FIFA",
      "en": "FIFA"
    },
    "nameCode": "1013",
    "id": "1013"
  }
];
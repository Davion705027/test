import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'dart:core';

import 'package:flutter_ty_app/app/extension/string_extension.dart';

import '../modules/login/login_head_import.dart';
import '../modules/match_detail/widgets/header/score/templates/score_child4.dart';
import '../services/models/res/match_entity.dart';
import 'csid_util.dart';

/// format-msc.js 文件
/// 分数格式化
class FormatScore {
  ///@description 根据不同赛事阶段取不同的比分
  ///@param {Object} match 赛事数据对象
  ///@param {Number} num 0-主队  1-客队
  ///@param {String} key 比赛结束显示指定比分
  ///@return {Number} 主队或客队得分
  ///
  ///角球 1001
  static int formatTotalScore(MatchEntity? match, int num,
      {String? key, String? playId}) {
    if (match == null) {
      return 0;
    }
    try {
      if (!(match.msc.isNotEmpty)) return 0;

      Map<String, List<String>> mscMap = {};
      match.msc.forEach((item) {
        List<String> splitItem = item.split("|");
        if (splitItem.length == 2) {
          mscMap[splitItem[0]] = splitItem[1].split(":");
        }
      });

      List<String>? score_;
      if (match.csid == "1" || match.csid == "11") {
        // 足球和手球
        switch (match.mmp) {
          // ///角球
          // case "6":
          //   // S555
          //   score_ = mscMap["S5"];
          //   break;
          //  41 加时赛上半场  33 加时休息  42 加时下半场 110 加时赛结束
          case "41":
          case "33":
          case "42":
          case "110":
            score_ = mscMap["S7"];
            break;
          // 50 点球大战  120 点球大战结束
          case "50":
          case "120":
            score_ = mscMap["S170"];
            break;
          // 即将加时和等待点球的阶段固定取0
          case "32":
          case "34":
            score_ = ["0", "0"];
            break;
          // 全场结束,取点球大战比分，加时赛比分或者全场比分
          case "999":
            score_ = mscMap["S170"] ?? mscMap["S7"] ?? mscMap["S1"];
            if (key != null && key.contains("S") && mscMap.containsKey(key)) {
              score_ = mscMap[key];
            }
            break;
          default:
            score_ = mscMap["S1"];
            break;
        }
      } else {
        score_ = mscMap["S1"];
      }

      if (score_ != null && score_.length > num) {
        return score_[num].toInt();
      } else {
        return 0;
      }
    } catch (error) {
      if (kDebugMode) {
        print("formatTotalScore取比分失败$error");
      }
      return 0;
    }
  }

  // 将形如 1:2 的比分字符串转换为 1-2 的格式
  static String scoreFormat(String str) {
    return str.replaceAll(':', '-');
  }

  /// @description: 在match对象上添加  msc_list_dict 数组字段
  /// @param {Map<String, dynamic>} match
  /// @param {List<String>} mscDict
  /// @return {Undefined}
  static fullMsc(MatchEntity match, List<String> mscDict) {
    match.mscListDict = [];
    mscDict.forEach((mscD) {
      String found = "";
      match.msc.forEach((mMsc) {
        if (mMsc.contains('$mscD|')) {
          found = mMsc;
        }
      });
      if (found != "") {
        match.mscListDict.add(found);
      } else {
        match.mscListDict.add('$mscD|-:-');
      }
    });
  }

  /**
   * @description: 格式化比分数据
   * @param {String} str
   * @return {List<String>}
   */
  static List<String> formatMsc(String str) {
    if (str.isEmpty) {
      return [];
    }
    List<String> list_ = str.split(RegExp(r'[:|]'));
    for (int i = 0, l = 3 - list_.length; i < l; i++) {
      list_.add('');
    }
    list_.add('msc_${list_[0]}'.tr);

    return list_;
  }

  /// @description: 比分处理
  /// @param {Object} match 赛事对象
  static List<List<String>> scoreSwitchHandle(MatchEntity match) {
    int currentSportId = int.tryParse(match.csid) ?? 0;
    if (match.msc.isEmpty) return [];
    //红牌数
    getPunishScore(match);
    List<List<String>> res = [];
    switch (currentSportId) {
      case 5:
        res = tennisScoreHandle(match);
        break;
      case 10:
        res = badmintonScoreHandle(match);
        break;
      case 8:
        res = pingpongScoreHandle(match);
        break;
      case 7: //斯诺克
        res = snoockerScoreHandle(match);
        break;
      case 2:
        res = basketBallScoreHandle(match);
        break;
      case 1:
        res = footBallScoreHandle(match);
        break;
      // 3、4、6、9棒冰美排
      case 3:
        res = baseballScoreHandle(match);
        break;
      case 4:
        res = iceHockeyScoreHandle(match);
        break;
      case 6:
        res = usFootballScoreHandle(match);
        break;
      case 9:
        res = volleyballScoreHandle(match);
        break;
      case 11:
        res = footBallScoreHandle(match);
        break;
      case 12: //拳击
        res = snoockerScoreHandle(match);
        break;
      case 13:
        res = volleyballScoreHandle(match);
        break;
      case 14: //英式橄榄球
        res = footBallScoreHandle(match);
        break;
      case 15: //曲棍球
        // res = hockeyScoreHandle(match);
        break;
      case 16: //水球
        // res = waterPoloScoreHandle(match);
        break;
      case 101: //dota比分获取
      case 100: //lol比分获取
      case 102: //Cs go比分获取
      case 103: //王者荣耀比分获取
        res = dotaScoreHandle(match);
        break;
    }
    return res;
  }

  /// @description: 获取红牌数
  /// @param {Object} match
  static getPunishScore(MatchEntity match) {
    if (match.msc.isEmpty) return;
    match.msc.forEach((fScore) {
      //红牌
      if (fScore.contains('S11|')) {
        List<String> score2 = fScore.split('S11|')[1].split(':');
        match.homeRedScore = int.parse(score2[0]);
        match.awayRedScore = int.parse(score2[1]);
      }
      //黄牌
      if (fScore.contains('S12|')) {
        List<String> score2 = fScore.split('S12|')[1].split(':');
        match.homeYellowScore = int.parse(score2[0]);
        match.awayYellowScore = int.parse(score2[1]);
      }
    });
  }

  /*
    *  部分玩法比分*/

  static String formatminScore(MatchEntity? match,
      {int? index, bool isMain = false}) {
    num csid = match?.csid.toNum() ?? 0;
    int position = SpriteImagesPosition.data[csid] ?? 0;
    String score = "";
    // 网球取S103
    if (csid == 5 && currentScore("S103", match!) != "") {
      if (isMain) {
        score = currentScore2("S103", match!, index!);
      } else {
        score = formatScore(currentScore("S103", match));
      }
    }
    // 斯诺克, 乒乓球, 羽毛球, 排球, 沙滩排球 取赛事阶段范围内的最大为当前比分
    else if ([7, 8, 9, 10, 13].contains(csid)) {
      score = formatScore(currentScore(currentScoreCommon(match!), match!));
    }
    // 冰球三节-局比分
    else if (csid == 4 && mmpArr1.contains(match?.mmp)) {
      score = formatScore(currentScore(currentScoreCommon(match!), match!));
    }
    // 冰球+橄榄球+曲棍球 加时赛比分
    else if (['4', '14', '15'].contains(csid) &&
        ['40', '440', '41', '33', '42'].contains(match?.mmp) &&
        currentScore('S7', match!) != "") {
      score = formatScore(currentScore("S7", match!));
    }
    // 冰球+橄榄球+曲棍球+水球 点球大战比分
    else if (['4', '14', '15', '16'].contains(csid) &&
        (match?.mmp == "34" || match?.mmp == "50") &&
        currentScore('S170', match!) != "") {
      score = formatScore(currentScore("S170", match!));
    }
    return score;
  }

  static String currentScore(String? str, MatchEntity match) {
    String content = "";
    for (var v in match.msc) {
      List<String> splitV = v.split("|");
      if (splitV.length == 2 && splitV[0] == str) {
        content = splitV[1];
        break;
      }
    }
    return content;
  }

  static String currentScore2(String? str, MatchEntity match, int index) {
    String content = "";
    List string = [];
    for (var v in match.msc) {
      List<String> splitV = v.split("|");
      if (splitV.length == 2 && splitV[0] == str) {
        string = splitV[1].split(":");
        content = string[index];
        break;
      }
    }
    return content;
  }

  /// 比分格式设置
  static String formatScore(String res) {
    String str = "";
    if (res.contains("|")) {
      List<String> arr = res.split("|");
      str = arr[1];
    } else if (res.contains(":")) {
      str = res;
    }

    List<String> scoreParts = str.split(":");
    if (scoreParts.length == 2) {
      return '${scoreParts[0]} - ${scoreParts[1]}';
    } else {
      return '';
    }
  }

  static examineMmp(MatchEntity match) {
    // 将休息状态的发球方置空显示，不显示绿色小点;
    if (mmpArr.contains(match.mmp)) {
      match.mat = "";
    }
  }

  static String currentScoreCommon(MatchEntity match) {
    int num = 0;
    match.msc.forEach((v) {
      int current = int.parse(v.split("|")[0].substring(1));
      if (current > num && current >= 120 && current <= 159) {
        num = current;
      }
    });

    if (num != 0 && num != 1) {
      return "S$num";
    } else {
      return "";
    }
  }

  /// @description: 网球比分处理
  /// @param {Map<String, dynamic>} match 赛事对象
  static List<List<String>> tennisScoreHandle(MatchEntity match) {
    List<String> mscDict = ['S1', 'S23', 'S39', 'S55']; //全场大比分 第一盘 第二盘 第三盘比分
    fullMsc(match, mscDict);
    List<List<String>> mscList = [], dictMscList = [];
    String currentScoreSplit = 'S1|';
    if (match.msc.isNotEmpty) {
      match.msc.forEach((fScore) {
        if (fScore.contains(currentScoreSplit)) {
          List<String> score2 = fScore.split(currentScoreSplit)[1].split(':');
          match.homeScore = score2[0];
          match.awayScore = score2[1];
        } else {
          String code = fScore.split('|')[0];
          if (['S23', 'S39', 'S55', 'S71', 'S87'].contains(code)) {
            mscList.add(formatMsc(fScore));
          }
        }
      });
      mscList.sort((a, b) {
        int aCode = 0, bCode = 0;
        try {
          aCode = int.parse(a[0].split('S')[1]);
          bCode = int.parse(b[0].split('S')[1]);
        } catch (e) {
          print(e);
        }
        return aCode - bCode;
      });
      if (match.homeScore == "") match.homeScore = "0";
      if (match.awayScore == "") match.awayScore = "0";
      match.mscFormat = mscList;
    }
    if (match.mscListDict.isNotEmpty) {
      match.mscListDict.forEach((dict) {
        dictMscList.add(formatMsc(dict));
      });
    }
    match.mscSFormat = dictMscList;

    // 标准版只显示当前局比分
    if (
        // getNewerStandardEdition.value == 2 &&
        mscList.isNotEmpty) {
      List<List<String>> foundValidMsc = [];
      mscList.forEach((msc) {
        if (msc.length > 1) {
          if (msc[1] != '-') {
            foundValidMsc.add(msc);
          }
        }
      });
      // match['latest_score'] = foundValidMsc.sublist(foundValidMsc.length - 1);
    }
    return mscList;
  }

  /// @description: 篮球比分处理
  /// @param {Object} match 赛事对象
  /// @return {List<List<String>>}
  static List<List<String>> basketBallScoreHandle(MatchEntity match) {
    // 全场比分/1/2/上半场/3/4/下半场;
    List<String> mscDict = ["S1", "S2", "S3"];
    // 标准四节比分S2 = S19 + S20  S3 = S21 + S22
    // S2/S3 上下半场
    bool isFourSections = false; //按四节返回比分
    if (match.msc.isNotEmpty) {
      match.msc.forEach((msxD) {
        if (msxD.contains('S19|') ||
            msxD.contains('S20|') ||
            msxD.contains('S21|') ||
            msxD.contains('S22|')) {
          isFourSections = true;
        }
      });
    }
    if (isFourSections) {
      mscDict = ["S19", "S20", "S21", "S22", "S7"];
    } else {
      mscDict = ["S2", "S3", "S7"];
    }
    //中场休息
    if (match.mmp == "31") {
      mscDict = ["S2"];
    }
    if (match.mle == 73) {
      mscDict = ["S1", "S2", "S3"];
    }
    fullMsc(match, mscDict);
    List<List<String>> result = footBasketBall(match); // 篮球足球比分处理
    if (match.mscSFormat.length > 2) {
      List<List<String>> sorted = [];
      mscDict.forEach((key) {
        List<String>? r = match.mscSFormat.firstWhereOrNull(
          (mscS) => mscS.isNotEmpty && mscS[0] == key,
        );
        r ??= [key, '', '', ''];
        sorted.add(r);
      });
      match.mscSFormat = sorted;
    } else {
      match.mscSFormat = mscDict.map((dic) {
        String title = 'msc_$dic'.tr;
        return [dic, '', '', title];
      }).toList();
    }
    match.mscFormat = match.mscSFormat;

    // 标准版只显示当前局比分
    if (
        // getNewerStandardEdition.value == 2 &&
        result.length > 1) {
      List<List<String>> foundValidMsc = [];
      result.forEach((msc) {
        if (msc.length > 1) {
          if (msc[1] != '-') {
            foundValidMsc.add(msc);
          }
        }
      });
      // match['latest_score'] = foundValidMsc.sublist(foundValidMsc.length - 1);
    }

    // O01 电子篮球 只显示当前节比分  mmp  "13": "第一节", "14": "第二节", "15": "第三节", "16": "第四节",
    if (match.csid == "2" && match.cds == 'O01') {
      final mmpConfig = {"13": 1, "14": 2, "15": 3, "16": 4};
      final length = mmpConfig[match.mmp.toString()] ?? 0;
      if (length == 0) return [];
      result = List<List<String>>.from(result).sublist(0, length);
    }

    return result;
  }

  /// @description: 足球篮球
  /// @param {Map<String, dynamic>} match
  /// @return {List<List<String>>}
  static List<List<String>> footBasketBall(MatchEntity match) {
    if (match.msc.isNotEmpty) {
      //常规赛全场(S1)比分
      String split = 'S1|';
      int mmp = int.parse(match.mmp);
      if ([41, 32, 33, 42, 110].contains(mmp)) {
        split = 'S7|';
      } else if ([34, 50, 120].contains(mmp)) {
        split = 'S170|';
      }
      // if (match['csid'] == 1 || match['csid'] == 11) {
      //   if (footerSubMenuId.value == 114) { // 角球玩法
      //     split = 'S5|';
      //   }
      //   if (getCurrentMenu.value['main']['menuType'] == 28) { //赛果只显示S1 单号8410
      //     split = 'S1|';
      //   }
      // }
      bool foundFullScore = false;
      match.msc.forEach((fScore) {
        if (fScore.contains(split)) {
          List<String> sliced = formatMsc(fScore);
          match.homeScore = sliced[1];
          match.awayScore = sliced[2];
          foundFullScore = true;
        }
      });
      if (!foundFullScore) {
        match.homeScore = '0';
        match.awayScore = '0';
      }
    }

    List<List<String>> mscListDict = [];
    if (match.mscListDict.isNotEmpty) {
      match.mscListDict.forEach((fScore) {
        List<String> formattedMsc = formatMsc(fScore);
        formattedMsc = footballScoreNo(match, formattedMsc);
        mscListDict.add(formattedMsc);
      });
      match.mscSFormat = mscListDict;
    }
    match.mscFormat = mscListDict;
    return mscListDict;
  }

  /// 附加足球比分编号
  /// @param {Map<String, dynamic>} match 赛事对象
  /// @param {List<String>} list_ 比分列表
  /// @return {List<String>}
  static List<String> footballScoreNo(MatchEntity match, List<String> list_) {
    if ([1, 11, 14, 15, 16].contains(int.parse(match.csid))) {
      // 角球
      if (list_[0] == 'S5') {
        list_.add('KK');
      }
      // 上半场进球数
      else if (list_[0] == 'S2') {
        list_.add('HT');
      }
      //上下半场总进球数
      else if (list_[0] == 'S1') {
        list_.add('FT');
      }
      //加时赛比分
      else if (list_[0] == 'S7') {
        list_.add('OT');
      }
      //点球大战比分
      else if (list_[0] == 'S170') {
        list_.add('PEN');
      }
    }
    return list_;
  }

  /// @description: 排球比分处理
  /// @param {Map<String, dynamic>} match 赛事对象
  static List<List<String>> volleyballScoreHandle(MatchEntity match) {
    List<String> mscDict = [
      'S1',
      'S120',
      'S121',
      'S122',
      'S123',
      'S124'
    ]; // 全场大比分 第一局 第二局 第三局比分

    fullMsc(match, mscDict);

    List<List<String>> mscList = [];
    List<List<String>> dictMscList = [];

    // 按从小到大顺序获取比分序列
    if (match.msc.isNotEmpty) {
      int foundDictIndex = -1;
      // 按照球类取出得分(除去犯规比分等)
      mscDict.forEach((dict) {
        int dictIndex = mscDict.indexOf(dict);
        String mscCode = '$dict|';
        match.msc.forEach((fScore) {
          if (fScore.contains(mscCode)) {
            foundDictIndex = dictIndex;
            mscList.add(formatMsc(fScore));
          }
        });
      });

      // 获取当前比分
      mscList.forEach((fScore) {
        if (fScore[0] == 'S1') {
          match.homeScore = fScore[1];
          match.awayScore = fScore[2];
        }
      });

      match.mscFormat = mscList;
    }

    match.mscListDict.forEach((dict) {
      dictMscList.add(formatMsc(dict));
    });
    match.mscSFormat = dictMscList;

    // 标准版只显示当前局比分
    if (
        // getNewerStandardEdition.value == 2 &&
        mscList.length > 1) {
      List<List<String>> foundValidMsc = [];
      mscList.forEach((msc) {
        if (msc.length > 1 && msc[1] != '-') {
          foundValidMsc.add(msc);
        }
      });
      // match['latest_score'] = foundValidMsc.sublist(foundValidMsc.length - 1);
    }
    return mscList;
  }

  /// @description: 乒乓球比分处理
  /// @param {Object} match 赛事对象
  static List<List<String>> pingpongScoreHandle(MatchEntity match) {
    Map<String, int> scoreIndexMap = {
      "8": 1,
      "301": 2,
      "9": 2,
      "302": 3,
      "10": 3,
      "303": 4,
      "11": 4,
      "304": 5,
      "12": 5,
      "305": 6,
      "441": 6,
      "306": 7,
      "442": 7,
    };

    Map<int, String> numberCodeMap = {
      1: '8',
      2: '9',
      3: '10',
      4: '11',
      5: '12',
      6: '441',
      7: '442',
    };

    int maxIndex = scoreIndexMap[int.tryParse(match.mmp)] ?? 0;

    List<String> mscDict = ['S1', 'S120', 'S121', 'S122', 'S123', 'S124'];

    // 判断是否为七局五胜制
    bool is7 = false;
    if (match.mft == 7) {
      is7 = true;
    } else {
      if (match.mfo != null) {
        is7 = match.mfo.toString().contains('7') ||
            match.mfo.toString().contains('七');
      }
      if (!is7) is7 = match.msc.length > 7;
    }

    if (is7) {
      mscDict = ['S1', 'S120', 'S121', 'S122', 'S123', 'S124', 'S125', 'S126'];
    }

    fullMsc(match, mscDict);

    List<List<String>> mscList = [];
    List<List<String>> dictMscList = [];

    // 按从小到大顺序获取比分序列
    if (match.msc.isNotEmpty) {
      int foundDictIndex = -1;
      // 按照球类取出得分(出去犯规比分等)
      mscDict.asMap().forEach((dictIndex, dict) {
        String mscCode = '$dict|';
        match.msc.forEach((fScore) {
          if (fScore.contains(mscCode)) {
            foundDictIndex = dictIndex;
            mscList.add(formatMsc(fScore));
          }
        });
      });

      // 赛事到达局间休息时,初始化下一局比分为0-0并显示
      int maxCount = maxIndex + 1;
      if (mscList.length < maxCount) {
        for (int i = mscList.length; i < maxCount; i++) {
          if (mscDict[i] != "") {
            String fScore = '${mscDict[i]}|0:0';
            mscList.add(formatMsc(fScore));
          }
        }
      }

      // 如果下一局比分先到达,mmp后到达,则根据比分来确定当前局数mmp的值
      // if (foundDictIndex >= maxIndex && numberCodeMap.containsKey(foundDictIndex)) {
      //   match.mmp = numberCodeMap[foundDictIndex]!;
      // }

      mscList.forEach((fScore) {
        if (fScore[0] == 'S1') {
          match.homeScore = fScore[1];
          match.awayScore = fScore[2];
        }
      });
      match.mscFormat = mscList;
    }
    match.mscListDict.forEach((dict) {
      dictMscList.add(formatMsc(dict));
    });
    match.mscSFormat = dictMscList;

    // 标准版只显示当前局比分
    if (
        // getNewerStandardEdition.value == 2 &&
        mscList.length > 1) {
      List<List<String>> foundValidMsc = [];
      mscList.forEach((msc) {
        if (msc.length > 2) {
          if (msc[1] != '-' && msc[2] != '-') {
            foundValidMsc.add(msc);
          }
        }
      });
      // match['latest_score'] = foundValidMsc.sublist(foundValidMsc.length - 1, foundValidMsc.length);
    }
    return mscList;
  }

  /// Dota 赛事比分获取
  static List<List<String>> dotaScoreHandle(MatchEntity match) {
    List<String> mscDict = [
      'S19',
      'S20',
      'S21',
      'S22',
      'S170'
    ]; //第一局 第二局 第三局 第四局 点球比分
    fullMsc(match, mscDict);
    List<List<String>> mscList = [], dictMscList = [];

    // 按从小到大顺序获取比分序列
    if (match.msc.isNotEmpty) {
      int foundDictIndex = -1;
      // 按照球类取出得分(除去犯规比分等)
      mscDict.asMap().forEach((dictIndex, dict) {
        String mscCode = '$dict|';
        match.msc.forEach((fScore) {
          if (fScore.contains(mscCode)) {
            foundDictIndex = dictIndex;

            List<String> formatedMsc = formatMsc(fScore);
            formatedMsc = footballScoreNo(match, formatedMsc);
            mscList.add(formatedMsc);
          }
        });
      });

      match.msc.forEach((fScore) {
        if (fScore.contains('S1|')) {
          List<String> fullScore = formatMsc(fScore);
          match.homeScore = fullScore[1];
          match.awayScore = fullScore[2];
        }
      });

      match.mscFormat = mscList;
    }

    match.mscListDict.forEach((dict) {
      dictMscList.add(formatMsc(dict));
    });
    match.mscSFormat = dictMscList;

    // 标准版只显示当前局比分
    if (
        // getNewerStandardEdition.value == 2 &&
        mscList.length > 1) {
      List<List<String>> foundValidMsc = [];
      mscList.forEach((msc) {
        if (msc.length > 2) {
          if (msc[1] != '-' && msc[2] != '-') {
            foundValidMsc.add(msc);
          }
        }
      });
      // match['latest_score'] = foundValidMsc.sublist(foundValidMsc.length - 1, foundValidMsc.length);
    }
    return mscList;
  }

  /// @description: 足球比分处理
  /// @param {Object} match 赛事对象
  static List<List<String>> footBallScoreHandle(MatchEntity match) {
    // 角球:S5 上半场:S2 全场比分:S1 下半场:S3 红牌:S11 黄牌:S12 点球:S10 加时:S7 点球大战:S170
    List<String> mscDict = ["S5", "S2", "S3", "S1", "S7"];
    // 110-加时结束的时候，显示：角球、半场（HT）、全场（FT）、加时比分（OT）
    // 34-等待点球大战的是，显示：角球、半场（HT）、全场（FT）、加时比分（OT）
    // 50-点球大战的时候，显示：角球、半场（HT）、全场（FT）、加时比分（OT）
    int mmp = int.parse(match.mmp);
    if ([110, 34, 50].contains(mmp)) {
      mscDict = ["S5", "S2", "S1", "S7"];
    } else if ([100, 32, 33].contains(mmp)) {
      mscDict = ["S5", "S2", "S1"];
    } else if ([0, 6].contains(mmp)) {
      //上半场 加时赛上半场
      mscDict = ["S5"];
    } else if (mmp == 31) {
      // 中场休息
      mscDict = ["S5", "S2"];
    } else if (mmp == 7) {
      // 下半场
      mscDict = ["S5", "S2"];
    } else if ([41, 42].contains(mmp)) {
      // 加时下半场
      mscDict = ["S5", "S2", "S1"];
    } else if (mmp == 50) {
      // 点球大战
      mscDict = ["S5", "S1", "S7"];
    }
    // 手球 点球大战结束
    if (match.csid == "11") {
      mscDict = ['S2', "S1"];
      if (mmp == 120) {
        mscDict = ['S2', "S1", "S7", "S170"];
      }
    }
    // 英式橄榄球
    if (match.csid == "14") {
      mscDict = ['S2', "S7", "S170", "S1"];
    }
    // 曲棍球
    if (match.csid == "15") {
      mscDict = ['S19', "S20", "S21", "S22", "S7", "S170"];
    }
    // 赛果
    // if (get_current_menu.value['main']['menuType'] == 28) {
    //   String splitedType = footBallScoreType(match);
    //   if (splitedType == "S1|") { //无点球大战无加时赛
    //     mscDict = ["S5", "S2"];
    //   }
    //   else if (splitedType == "S170|") { //有点球大战
    //     mscDict = ["S5", "S2", "S1", "S7", "S170"];
    //   }
    //   else if (splitedType == "S7|") { //有加时赛无点球大战
    //     mscDict = ["S5", "S2", "S1", "S7"];
    //   }
    // }
    fullMsc(match, mscDict);
    List<List<String>> result = footBasketBall(match);
    if (match.mscSFormat.isNotEmpty) {
      List<List<String>> sorted = [];
      mscDict.forEach((key) {
        List<List<String>> r =
            match.mscSFormat.where((mscS) => key == mscS[0]).toList();
        if (r.isNotEmpty) {
          sorted.add(r[0]);
        }
      });
      match.mscSFormat = sorted;
    } else {
      match.mscSFormat = mscDict.map((dic) {
        String title = "msc_$dic".tr;
        return [dic, '', '', title];
      }).toList();
    }
    // match['latest_score'] = result;
    return result;
  }

  /// @description: 棒球比分处理
  /// @param {Object} match 赛事对象
  static List<List<String>> baseballScoreHandle(MatchEntity match) {
    List<String> mscDict = [
      'S1',
      'S3014',
      'S120',
      'S121',
      'S122',
      'S123',
      'S124',
      'S125',
      'S126',
      'S127',
      'S128',
      'S129',
      'S130',
      'S131',
      'S132',
      'S133',
      'S134',
      'S135',
      'S136',
      'S137',
      'S138',
      'S139',
      'S140',
      'S141',
      'S142',
      'S143',
      'S144',
      'S145',
      'S146'
    ];

    fullMsc(match, mscDict);
    List<List<String>> mscList = [];
    List<List<String>> dictMscList = [];

    // 按从小到大顺序获取比分序列
    if (match.msc.isNotEmpty) {
      mscDict.forEach((dict) {
        String mscCode = '$dict|';
        match.msc.forEach((fScore) {
          if (fScore.contains(mscCode)) {
            mscList.add(formatMsc(fScore));
          }
        });
      });

      List<String>? mscA0;
      match.msc.forEach((fScore) {
        if (fScore.contains('S1|')) {
          mscA0 = formatMsc(fScore);
        }
      });

      // 获取当前比分
      if (mscA0 != null && mscA0!.isNotEmpty) {
        match.homeScore = mscA0![1];
        match.awayScore = mscA0![2];
      } else {
        match.homeScore = '0';
        match.awayScore = '0';
      }

      match.mscFormat = mscList;
    }

    match.mscListDict.forEach((dict) {
      dictMscList.add(formatMsc(dict));
    });
    match.mscSFormat = dictMscList;
    // match['latest_score'] = mscList;
    return mscList;
  }

  /// @description: 冰球比分处理
  /// @param {Object} match 赛事对象
  /// @return {Object}
  static List<List<String>> iceHockeyScoreHandle(MatchEntity match) {
    // S170 点球大战
    List<String> mscDict = [
      'S1',
      'S120',
      'S121',
      'S122',
      'S123',
      'S124',
      'S7',
      'S170'
    ]; // 全场大比分 第一局 第二局 第三局... 以此类推

    Map<String, int> scoreIndexMap = {
      "0": 1,
      "1": 1,
      "301": 2,
      "2": 2,
      "302": 3,
      "3": 3
    };

    int maxIndex = scoreIndexMap[match.mmp.toString()] ?? -1;

    fullMsc(match, mscDict);

    List<List<String>> mscList = [];
    List<List<String>> dictMscList = [];

    // 按从小到大顺序获取比分序列
    if (match.msc.isNotEmpty) {
      int foundDictI = -1;
      // 按照球类取出得分(除去犯规比分等)
      mscDict.forEach((dict) {
        int dictI = mscDict.indexOf(dict);
        String mscCode = '$dict|';
        match.msc.forEach((fScore) {
          if (fScore.contains(mscCode)) {
            foundDictI = dictI;
            mscList.add(formatMsc(fScore));
          }
        });
      });
      // 赛事到达局间休息时,初始化下一局比分为0-0并显示
      int maxCount = maxIndex + 1;
      if (mscList.length < maxCount) {
        for (int i = mscList.length; i < maxCount; i++) {
          if (mscDict[i] != null) {
            String fScore = '${mscDict[i]}|0:0';
            mscList.add(formatMsc(fScore));
          }
        }
      }

      // 获取当前比分
      if (mscList.isNotEmpty) {
        List<String>? fScore = mscList[0];
        if (fScore.isNotEmpty) {
          match.homeScore = fScore[1];
          match.awayScore = fScore[2];
        }
      } else {
        match.homeScore = '0';
        match.awayScore = '0';
      }

      match.mscFormat = mscList;
    }

    match.mscListDict.forEach((dict) {
      dictMscList.add(formatMsc(dict));
    });
    match.mscSFormat = dictMscList;

    // 标准版只显示当前局比分
    if (
        // getNewerStandardEdition.value == 2 &&
        mscList.length > 1) {
      List<List<String>> foundValidMsc = [];
      mscList.forEach((msc) {
        if (msc.length > 2) {
          if (msc[1] != '-' && msc[2] != '-') {
            foundValidMsc.add(msc);
          }
        }
      });
      // match['latest_score'] =
      //     foundValidMsc.sublist(foundValidMsc.length - 1, foundValidMsc.length);
    }
    return mscList;
  }

  /// @description: 美式足球比分处理
  /// @param {Object} match 赛事对象
  /// @return {Object}
  static List<List<String>> usFootballScoreHandle(MatchEntity match) {
    List<String> mscDict = ['S19', 'S20', 'S21', 'S22']; // 第一局 第二局 第三局 第四局比分

    fullMsc(match, mscDict);

    List<List<String>> mscList = [];
    List<List<String>> dictMscList = [];

    // 按从小到大顺序获取比分序列
    if (match.msc.isNotEmpty) {
      int foundDictI = -1;
      // 按照球类取出得分(除去犯规比分等)
      mscDict.forEach((dict) {
        int dictI = mscDict.indexOf(dict);
        String mscCode = '$dict|';
        match.msc.forEach((fScore) {
          if (fScore.contains(mscCode)) {
            foundDictI = dictI;
            mscList.add(formatMsc(fScore));
          }
        });
      });

      List<String> s1List = [];
      match.msc.forEach((score) {
        if (score.contains('S1|')) {
          s1List = score.split('S1|')[1].split(':');
        }
      });

      // 获取当前比分
      if (s1List.length > 1) {
        match.homeScore = s1List[0];
        match.awayScore = s1List[1];
      } else {
        match.homeScore = '0';
        match.awayScore = '0';
      }

      match.mscFormat = mscList;
    }

    match.mscListDict.forEach((dict) {
      dictMscList.add(formatMsc(dict));
    });
    match.mscSFormat = dictMscList;

    // 标准版只显示当前局比分
    if (
        // getNewerStandardEdition.value == 2 &&
        mscList.length > 1) {
      List<List<String>> foundValidMsc = [];
      mscList.forEach((msc) {
        if (msc.length > 2) {
          if (msc[1] != '-' && msc[2] != '-') {
            foundValidMsc.add(msc);
          }
        }
      });
      // match['latest_score'] =
      //     foundValidMsc.sublist(foundValidMsc.length - 1, foundValidMsc.length);
    }
    return mscList;
  }

  ///@description 角球 红牌 黄牌
  ///@param {Undefined}
  ///@return {Array} 角球 红牌 黄牌数
  static String footballScoreStatusArray(MatchEntity match, int index) {
    List<String> msc = List.from(match.msc);
    // 比分升序排列 取出比分阶段后面的数字作为判断条件 返回是数组
    //  msc.sort((a, b) {
    //    String? numIndexA = a.split("|")[0];
    //    String? numIndexB = b.split("|")[0];
    //    int numA = numIndexA != "" ? int.parse(numIndexA.substring(1)) : 0;
    //    int numB = numIndexB != "" ? int.parse(numIndexB.substring(1)) : 0;
    //    return numA.compareTo(numB);
    //  });

    // List<String> scoreArr = ['0:0', '0:0', '0:0'];
    // // 循环取出接口返回的比分里面的角球、红牌和黄牌数
    // msc.forEach((item) {
    //   String? numIndex = item.split("|")[0];
    //   String? score = item.split("|")[1];
    //   if (numIndex == 'S5') {
    //     scoreArr[0] = score;
    //   } else if (numIndex == 'S11') {
    //     scoreArr[1] = score;
    //   } else if (numIndex == 'S12') {
    //     scoreArr[2] = score;
    //   }
    // });
    String scoreArr = '0';
    for (var item in msc) {
      String numIndex = item.split("|")[0] ?? "";
      if (numIndex.isNotEmpty && numIndex == 'S11') {
        String score = item.split("|")[1] ?? "";
        scoreArr = score.split(':')[index];
        break;
      }
    }
    return scoreArr;
  }

  /// @description: 斯诺克比分处理
  /// @param {Object} match 赛事对象
  static List<List<String>> snoockerScoreHandle(MatchEntity match) {
    String keyStr =
        '1,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140';
    // let key_array = key_str.split(',');

    // let count = 0;
    // try {
    //   if (match.mfo) {
    //     count = match.mfo.match(/\d*/)[0] * 1;
    //   }
    // } catch (e) { console.error(e); }
    // if (isNaN(count) || count < 6) {
    //   count = 6;
    // } else {
    //   count = 12;
    // }

    // key_array = key_array.slice(0, count);

    List<String> mscArray = [];
    for (int i = 120; i <= 159; i++) {
      mscArray.add('${i}');
    }

    List<String> mscDict = mscArray.map((k) => 'S$k').toList();
    fullMsc(match, mscDict);

    List<List<String>> mscList = [];
    List<String> s1Score = [];
    List<List<String>> dictMscList = [];
    if (match.msc.isNotEmpty) {
      List<List<String>> scoreList = [];
      match.msc.forEach((fScore) {
        if (fScore.contains('S1|')) {
          s1Score = formatMsc(fScore);
        } else {
          scoreList.add(formatMsc(fScore));
        }
      });
      scoreList.forEach((fScore) {
        String code = fScore[0];
        if (mscArray.contains(code.replaceFirst('S', ''))) {
          mscList.add(fScore);
        }
      });

      mscList.sort((a, b) {
        int aCode = 0, bCode = 0;
        try {
          aCode = int.parse(a[0].split('S')[1]);
          bCode = int.parse(b[0].split('S')[1]);
        } catch (e) {
          print(e);
        }
        return aCode - bCode;
      });

      if (s1Score.length > 2) {
        match.homeScore = s1Score[1];
        match.awayScore = s1Score[2];
      }

      if (match.homeScore == "") match.homeScore = "0";
      if (match.awayScore == "") match.awayScore = "0";
      match.mscFormat = mscList;
    }

    match.mscListDict.forEach((dict) {
      dictMscList.add(formatMsc(dict));
    });
    match.mscSFormat = dictMscList;

    return mscList;
  }

  /// @description: 羽毛球比分处理
  /// @param {Object} match 赛事对象
  static List<List<String>> badmintonScoreHandle(MatchEntity match) {
    Map<String, int> scoreIndexMap = {
      "8": 1,
      "301": 2,
      "9": 2,
      "302": 3,
      "10": 3,
      "303": 4,
      "11": 4,
      "11": 4,
      "304": 5,
      "12": 5
    };
    Map<int, String> numberCodeMap = {
      1: '8',
      2: '9',
      3: '10',
      4: '11',
      5: '12',
    };
    int maxIndex = scoreIndexMap[match.mmp.toString()] ?? 0;

    List<String> mscDict = ['S1', 'S120', 'S121', 'S122', 'S123', 'S124'];

    //region 判断是否为七局五胜制
    bool is7 = false;
    if (match.mft == 7) {
      is7 = true;
    } else {
      if (match.mfo != null) {
        is7 = match.mfo.indexOf('7') > -1;
        if (!is7) {
          is7 = match.mfo.indexOf('七') > -1;
        }
      }
      if (!is7) is7 = match.msc.length > 7;
    }
    if (is7) {
      mscDict = ['S1', 'S120', 'S121', 'S122', 'S123', 'S124', 'S125', 'S126'];
    }
    //endregion

    fullMsc(match, mscDict);

    List<List<String>> mscList = [], dictMscList = [];

    if (match.msc.isNotEmpty) {
      int foundDictIndex = -1;
      // 按照球类取出得分(除去犯规比分等)
      mscDict.asMap().forEach((dictIndex, dict) {
        String mscCode = '$dict|';
        match.msc.forEach((fScore) {
          if (fScore.contains(mscCode)) {
            foundDictIndex = dictIndex;
            mscList.add(formatMsc(fScore));
          }
        });
      });

      // 赛事到达局间休息时，初始化下一局比分为0-0并显示
      int maxCount = maxIndex + 1;
      if (mscList.length < maxCount) {
        for (int i = mscList.length; i < maxCount; i++) {
          if (mscDict[i] != null) {
            String fScore = '${mscDict[i]}|0:0';
            mscList.add(formatMsc(fScore));
          }
        }
      }

      // 如果下一局比分先到达，mmp后到达，则根据比分来确定当前局数mmp的值
      // if (foundDictIndex >= maxIndex) {
      //   match['mmp'] = int.parse(numberCodeMap[foundDictIndex]);
      // }

      //获取当前比分
      int mmpNum = int.tryParse(match.mmp.toString()) ?? 0;
      if ([301, 302, 303, 304, 305, 306].contains(mmpNum)) {
        match.homeScore = "0";
        match.awayScore = "0";
      } else {
        mscList.forEach((fScore) {
          if (fScore[0] == 'S1') {
            match.homeScore = fScore[1];
            match.awayScore = fScore[2];
          }
        });
      }
      match.mscFormat = mscList;
    }

    match.mscListDict.forEach((dict) {
      dictMscList.add(formatMsc(dict));
    });
    match.mscSFormat = dictMscList;

    // 标准版只显示当前局比分
    if (
    // getNewerStandardEdition.value == 2 &&
        mscList.length > 1) {
      List<List<String>> foundValidMsc = [];
      mscList.forEach((msc) {
        if (msc.length > 1) {
          if (msc[1] != null && msc[1] != '-') {
            foundValidMsc.add(msc);
          }
        }
      });
      // match['latest_score'] = foundValidMsc.sublist(foundValidMsc.length - 1, foundValidMsc.length);
    }
    return mscList;
  }



}

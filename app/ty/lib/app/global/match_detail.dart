
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';


///
/// @param {*} data 接口返回的整个 data 对象
/// @returns msc: ["S1|48:52"] => msc: {S1:{home: 48,away: 52}}
/// @Description: 主要是将详情数据msc 转化为 对象形式，便于数据分析与比分榜使用
Map<String, dynamic> buildMsc(MatchEntity data) {
  Map<String, dynamic> obj = {};
  List<String> msc = data.msc;
  if (msc.isNotEmpty) {
    List<dynamic> mscArray = List.from(msc);
    for (var item in mscArray) {
      List<String> format = item.split("|");
      // 比分格式判断
      if (format.isNotEmpty &&
          format[0].isNotEmpty &&
          format[1].isNotEmpty &&
          format[1].contains(":")) {
        String scoreType = format[0]; // 比分类型
        List<String> scoreArr = format[1].split(":"); // 比分类型对应的比分
        // 主队比分
        String home = scoreArr.elementAt(0);
        // 客队比分
        String away = scoreArr.elementAt(1);
        // 比分对象
        obj[scoreType] = {
          'home': home,
          'away': away,
          'percentage': 0,
        };
        // 主队和客队必须有一个不为0
        if (!(home == "0" && away == "0")) {
          //统计面板百分比计算
          // 计算主队得分的所占百分比
          if ([
            "S17",
            "S18",
            "S1101",
            "S108",
            "S107",
            "S110"
          ].contains(scoreType)) {
            obj[scoreType]['percentage'] = ((int.parse(obj[scoreType]['home']) /
                        (int.parse(obj[scoreType]['home']) +
                            int.parse(obj[scoreType]['away'])))
                    .toDouble() *
                100)
                .toInt();
          } else {
            // 计算客队得分所占的百分比
            obj[scoreType]['percentage'] = ((int.parse(obj[scoreType]['away']) /
                        (int.parse(obj[scoreType]['home']) +
                            int.parse(obj[scoreType]['away'])))
                    .toDouble() *
                100)
                .toInt();
          }
        }
      }
    }
  }
  return obj;
}

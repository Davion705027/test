/**
 * @Author xlight
 * @Date 2024/2/4 13:58
 */

import '../../index.dart';

extension TYFormatCsid on TYFormat {
  /**
   * @Description 根据球种ID获取球种中文名称
   * @param csid:球种ID
   */
  static String csidToSportName(String csid)
  {
    int? intCsid = int.tryParse(csid);
    String sportName = '';
    switch(intCsid){
      case 1:
        sportName = '足球';
        break;
      case 2:
        sportName = '篮球';
        break;
      case 3:
        sportName = '棒球';
        break;
      case 4:
        sportName = '冰球';
        break;
      case 5:
        sportName = '网球';
        break;
      case 6:
        sportName = '美式足球';
        break;
      case 7:
        sportName = '斯诺克';
        break;
      case 8:
        sportName = '乒乓球';
        break;
      case 9:
        sportName = '排球';
        break;
      case 10:
        sportName = '羽毛球';
        break;
      case 11:
        sportName = '手球';
        break;
      case 12:
        sportName = '拳击';
        break;
      case 13:
        sportName = '沙滩排球';
        break;
      case 14:
        sportName = '联合式橄榄球';
        break;
      case 15:
        sportName = '曲棍球';
        break;
      case 16:
        sportName = '水球';
        break;
    }
    return sportName;
  }
}
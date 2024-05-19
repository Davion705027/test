import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/model/bet_count_model.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/model/shop_cart_item.dart';

import '../../../generated/locales.g.dart';

class ShopCartUtil{
  static Map betCountMap = {
    2:[BetCountModel('2001',LocaleKeys.bet_bet_2001,"2串1",1)],
    3:[BetCountModel('3001',LocaleKeys.bet_bet_3001,"3串1",1),BetCountModel('2001',LocaleKeys.bet_bet_2001,"2串1",3),BetCountModel('3004',LocaleKeys.bet_bet_3004,"3串4",4)],
    4:[BetCountModel('4001',LocaleKeys.bet_bet_4001,"4串1",1),BetCountModel('2001',LocaleKeys.bet_bet_2001,"2串1",6),BetCountModel('3001',LocaleKeys.bet_bet_3001,"3串1",4),BetCountModel('40011',LocaleKeys.bet_bet_40011,"4串11",11)],
    5:[BetCountModel('5001',LocaleKeys.bet_bet_5001,"5串1",1),BetCountModel('2001',LocaleKeys.bet_bet_2001,"2串1",10),BetCountModel('3001',LocaleKeys.bet_bet_3001,"3串1",10),BetCountModel('4001',LocaleKeys.bet_bet_4001,"4串1",5),BetCountModel('50026',LocaleKeys.bet_bet_50026,"5串26",26)],
    6:[BetCountModel('6001',LocaleKeys.bet_bet_6001,"6串1",1),BetCountModel('2001',LocaleKeys.bet_bet_2001,"2串1",15),BetCountModel('3001',LocaleKeys.bet_bet_3001,"3串1",20),BetCountModel('4001',LocaleKeys.bet_bet_4001,"4串1",15),BetCountModel('5001',LocaleKeys.bet_bet_5001,"5串1",6),BetCountModel('60057',LocaleKeys.bet_bet_60057,"6串57",57)],
    7:[BetCountModel('7001',LocaleKeys.bet_bet_7001,"7串1",1),BetCountModel('2001',LocaleKeys.bet_bet_2001,"2串1",21),BetCountModel('3001',LocaleKeys.bet_bet_3001,"3串1",35),BetCountModel('4001',LocaleKeys.bet_bet_4001,"4串1",35),BetCountModel('5001',LocaleKeys.bet_bet_5001,"5串1",21),BetCountModel('6001',LocaleKeys.bet_bet_6001,"6串1",7),BetCountModel('700120',LocaleKeys.bet_bet_700120,"7串120",120)],
    8:[BetCountModel('8001',LocaleKeys.bet_bet_8001,"8串1",1),BetCountModel('2001',LocaleKeys.bet_bet_2001,"2串1",28),BetCountModel('3001',LocaleKeys.bet_bet_3001,"3串1",56),BetCountModel('4001',LocaleKeys.bet_bet_4001,"4串1",70),BetCountModel('5001',LocaleKeys.bet_bet_5001,"5串1",56),BetCountModel('6001',LocaleKeys.bet_bet_6001,"6串1",28),BetCountModel('7001',LocaleKeys.bet_bet_7001,"7串1",8),BetCountModel('800247',LocaleKeys.bet_bet_800247,"8串247",247)],
    9:[BetCountModel('9001',LocaleKeys.bet_bet_9001,"9串1",1),BetCountModel('2001',LocaleKeys.bet_bet_2001,"2串1",36),BetCountModel('3001',LocaleKeys.bet_bet_3001,"3串1",84),BetCountModel('4001',LocaleKeys.bet_bet_4001,"4串1",126),BetCountModel('5001',LocaleKeys.bet_bet_5001,"5串1",126),BetCountModel('6001',LocaleKeys.bet_bet_6001,"6串1",84),BetCountModel('7001',LocaleKeys.bet_bet_7001,"7串1",36),BetCountModel('8001',LocaleKeys.bet_bet_8001,"8串1",9),BetCountModel('900502',LocaleKeys.bet_bet_900502,"9串502",502)],
    10:[BetCountModel('10001',LocaleKeys.bet_bet_10001,"10串1",1),BetCountModel('2001',LocaleKeys.bet_bet_2001,"2串1",45),BetCountModel('3001',LocaleKeys.bet_bet_3001,"3串1",120),BetCountModel('4001',LocaleKeys.bet_bet_4001,"4串1",210),BetCountModel('5001',LocaleKeys.bet_bet_5001,"5串1",252),BetCountModel('6001',LocaleKeys.bet_bet_6001,"6串1",210),BetCountModel('7001',LocaleKeys.bet_bet_7001,"7串1",120),BetCountModel('8001',LocaleKeys.bet_bet_8001,"8串1",45),BetCountModel('9001',LocaleKeys.bet_bet_9001,"9串1",10),BetCountModel('10001013',LocaleKeys.bet_bet_10001013,"10串1013",1013)],
  };

  static Map betTipsMap = {
    '2001':BetTipsModel('2001',LocaleKeys.app_h5_bet_toltips_2001_title,LocaleKeys.app_h5_bet_toltips_2001_content),
    '3001':BetTipsModel('3001',LocaleKeys.app_h5_bet_toltips_3001_title,LocaleKeys.app_h5_bet_toltips_3001_content),
    '4001':BetTipsModel('4001',LocaleKeys.app_h5_bet_toltips_4001_title,LocaleKeys.app_h5_bet_toltips_4001_content),
    '5001':BetTipsModel('5001',LocaleKeys.app_h5_bet_toltips_5001_title,LocaleKeys.app_h5_bet_toltips_5001_content),
    '6001':BetTipsModel('6001',LocaleKeys.app_h5_bet_toltips_6001_title,LocaleKeys.app_h5_bet_toltips_6001_content),
    '7001':BetTipsModel('7001',LocaleKeys.app_h5_bet_toltips_7001_title,LocaleKeys.app_h5_bet_toltips_7001_content),
    '8001':BetTipsModel('8001',LocaleKeys.app_h5_bet_toltips_8001_title,LocaleKeys.app_h5_bet_toltips_8001_content),
    '9001':BetTipsModel('9001',LocaleKeys.app_h5_bet_toltips_9001_title,LocaleKeys.app_h5_bet_toltips_9001_content),
    '10001':BetTipsModel('10001',LocaleKeys.app_h5_bet_toltips_10001_title,LocaleKeys.app_h5_bet_toltips_10001_content),
    '3004':BetTipsModel('3004',LocaleKeys.app_h5_bet_toltips_3004_title,LocaleKeys.app_h5_bet_toltips_3004_content),
    '40011':BetTipsModel('3004',LocaleKeys.app_h5_bet_toltips_40011_title,LocaleKeys.app_h5_bet_toltips_40011_content),
    '50026':BetTipsModel('50026',LocaleKeys.app_h5_bet_toltips_50026_title,LocaleKeys.app_h5_bet_toltips_50026_content),
    '60057':BetTipsModel('60057',LocaleKeys.app_h5_bet_toltips_60057_title,LocaleKeys.app_h5_bet_toltips_60057_content),
    '700120':BetTipsModel('700120',LocaleKeys.app_h5_bet_toltips_700120_title,LocaleKeys.app_h5_bet_toltips_700120_content),
    '800247':BetTipsModel('800247',LocaleKeys.app_h5_bet_toltips_800247_title,LocaleKeys.app_h5_bet_toltips_800247_content),
    '900502':BetTipsModel('900502',LocaleKeys.app_h5_bet_toltips_900502_title,LocaleKeys.app_h5_bet_toltips_900502_content),
    '10001013':BetTipsModel('10001013',LocaleKeys.app_h5_bet_toltips_10001013_title,LocaleKeys.app_h5_bet_toltips_10001013_content),
  };

  static String calcBifen(List<String> msc, int csid, int ms, int hpid) {
    // 只有足球滚球展示基准分
    if (msc.isEmpty || csid != 1 || ms == 0) return "";
    String? s;
    RegExp regExp;
    String mscString = msc.join(',');

    if (hpid == 128) {
      regExp = RegExp(r'S7\|[0-9]+\:[0-9]+');
      s = regExp.stringMatch(mscString);
    } else if (hpid == 130) {
      regExp = RegExp(r'S701\|[0-9]+\:[0-9]+');
      s = regExp.stringMatch(mscString);
    } else if (hpid == 143) {
      regExp = RegExp(r'S3\|[0-9]+\:[0-9]+');
      s = regExp.stringMatch(mscString);
    } else if ([4, 27, 29, 269, 336].contains(hpid)) {
      regExp = RegExp(r'S1\|[0-9]+\:[0-9]+');
      s = regExp.stringMatch(mscString);
    } else if (hpid == 19) {
      regExp = RegExp(r'S2\|[0-9]+\:[0-9]+');
      s = regExp.stringMatch(mscString);
    } else if (hpid == 113) {
      regExp = RegExp(r'S5\|[0-9]+\:[0-9]+');
      s = regExp.stringMatch(mscString);
    } else if (hpid == 121) {
      regExp = RegExp(r'S15\|[0-9]+\:[0-9]+');
      s = regExp.stringMatch(mscString);
    }

    if (s != null) {
      String str = s.split("|")[1];
      return "(${str.replaceAll(":", "-")})";
    }

    return "";
  }

  static String teamsShow(ShopCartItem item){
    const corner_ball = ["111","114","115","116","117","118","119","122","123","124","226","227","228","229"];
    const penalty_hpid = ["307","309","310","311","312","313","314","315","316","317","318","319","320","321","322","323","125","230"];
    if (corner_ball.contains(item.playId) || penalty_hpid.contains(item.playId)) {
      return '${item.home} vs ${item.away}';
    }
    return '';
  }

  static List<BetCountModel> getBetCountJoint(int count){
    List<BetCountModel>? ret = betCountMap[count];
    return ret??[];
  }

  static String getCodeMessage(String code,{String? message}){
    String text = '';
    switch(code){
      case '200':
        text = message??LocaleKeys.bet_message_loading.tr;
        break;
      case '0402001':
      case '0402002':
      case '0402003':
      case '0402005':
      case '0402006':
      case '0402007':
      case '0402008':
        //盘口已失效
        text = LocaleKeys.bet_message_m_0402001.tr;
        break;
      case '0402011':
      case '0402012':
      case '0402016':
      case '0402022':
      case '0402024':
      case '0402025':
      case '0402026':
      case '0402043':
      case '0402044':
      case '0402045':
      case '0402046':
      case '0402047':
      case '04020448':
      case '04020449':
      case '0400451':
      case '0400452':
      case '0400461':
      case 'DJ006':
        text = LocaleKeys.bet_message_m_0402001.tr;
        break;
      case '0402009':
      case '0402010':
      case '0402023':
      case '0402027':
      case '0402028':
      // 投注项盘口、赔率或有效性产生变化!
        text = LocaleKeys.bet_message_m_0402009.tr;
        break;
      case '0402014':
        // 网络异常，请在注单中查看投注结果
        text = LocaleKeys.bet_message_m_0402014.tr;
        break;

      case '0402015':
      case '0402017':
      case '0402020':
      case '0402021':
      case '0402039':
      case '0402040':
      case '0402041':
      case '0400456':
      case '0400457':
      case '0400458':
      case '0400462':
      case '0400463':
      case '0400500':
      case 'XXXXXX':
      case 'DJ999':
      // 投注未成功~再试一次吧
        text = LocaleKeys.bet_message_m_0402015.tr;
        break;

      case '0402018':
      case '0402019':
      case '0402038':
      case '0400450':
      // 投注未成功，请稍后再试
        text = LocaleKeys.bet_message_m_0402018.tr;
        break;

      case '132113':
      // 投注失败，请重新选择投注项
        text = LocaleKeys.bet_message_m_132113.tr;
        break;

      case '0402035':
      case '0400454':
      case '0400455':
      // 余额不足，请您先充值
        text = LocaleKeys.bet_message_m_0402035.tr;
        break;

      case '0402042':
      // 网络异常，请联系客服
        text = LocaleKeys.bet_message_m_0402042.tr;
        break;

      case '0400453':
      //  "m_0400453": "账户异常，请联系客服",
        text = LocaleKeys.bet_message_m_0400453.tr;
        break;

      case '0400459':
      //  "m_0400459": "盘口确认中，请稍等",
        text = LocaleKeys.bet_message_m_0400459.tr;
        break;

      case '0400460':
      //  "m_0400460": "拒绝投注",
        text = LocaleKeys.bet_message_m_0400460.tr;
        break;

      case '0400464':
      case '0400475':
      // "m_0400464": "额度已变更，再试一次吧~",
        text = LocaleKeys.bet_message_m_0400464.tr;
        break;

      case '0400468':
      //  "m_0400468": "比分已变更，再试一次吧",
        text = LocaleKeys.bet_message_m_0400468.tr;
        break;

      case '0400469':
      // "m_0400469": "投注项盘口、赔率或有效性产生变化!",
        text = LocaleKeys.bet_message_m_0400469.tr;
        break;


      case 'M400004':
      //未定义
        //text = LocaleKeys.bet_message_m_M400004.tr;
        text = code;
        break;

      case 'M400005':
        text = LocaleKeys.bet_message_m_M400005.tr;
        break;

      case 'M400007':
        text = LocaleKeys.bet_message_m_M400007.tr;
        break;

      case 'M400009':
        text = LocaleKeys.bet_message_m_M400009.tr;
        break;

      case 'M400010':
      case 'DJ002':
        text = LocaleKeys.bet_message_m_M400010.tr;
        break;

      case 'M400011':
        text = LocaleKeys.bet_message_m_M400011.tr;
        break;

      case 'M400012':
        text = LocaleKeys.bet_message_m_M400012.tr;
        break;

      case '0401038':
        text = LocaleKeys.bet_message_m_0401038.tr;
        break;

      case 'DJ001':
        text = LocaleKeys.bet_message_m_DJ001.tr;
        break;

      case 'DJ003':
        text = LocaleKeys.bet_message_m_DJ003.tr;
        break;

      case 'DJ004':
        text = LocaleKeys.bet_message_m_DJ004.tr;
        break;

      case 'DJ005':
        text = LocaleKeys.bet_message_m_DJ005.tr;
        break;

      case '400004':
        text = LocaleKeys.bet_message_m_400004.tr;
        break;

      case '0402601':
        text = LocaleKeys.bet_message_m_0402601.tr;
        break;

      default:
        code = message??'';
        break;

    }

    return text;
  }

  static void showBetError(String code,{String? message}){
    String errMsg = getCodeMessage(code,message: message);
    ToastUtils.showGrayBackground(errMsg);
  }
}
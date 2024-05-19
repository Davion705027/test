import 'package:flutter_ty_app/app/global/data_store_operate/data_store_ctr_ws.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:flutter_ty_app/app/global/ws/ws_type.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
///101 102 103 104 106  201 203 901
class AppWebSocketBus  {
  static AppWebSocketBus? _instance;

  static AppWebSocketBus instance() {
    _instance ??= AppWebSocketBus._();
    return _instance!;
  }
  AppWebSocketBus._() {}

  static bool listLimit =  false;
  ///公共推送事件
   pubicWsPush(String cmd,data) {
    ///列表滚动 不更新UI
    if(listLimit) return;
    switch (cmd) {
    /// 赛事状态
      case WsType.C101:
        Bus.getInstance().wsSend(WsType(WsType.C101, data));
        break;
    /// 赛事事件
      case WsType.C102:
        Bus.getInstance().wsSend(WsType(WsType.C102, data));
        break;
    /// 赛事比分
      case WsType.C103:
        Bus.getInstance().wsSend(WsType(WsType.C103, data));
        break;
    ///赛事级别盘口状态 match
      case WsType.C104:
        Bus.getInstance().wsSend(WsType(WsType.C104, data));
        break;
    ///盘口状态、赔率 hl
      case WsType.C105:
        Bus.getInstance().wsSend(WsType(WsType.C105, data));
        break;
    ///注单订阅盘口状态、赔率 投注项级别  ol
      case WsType.C106:
        Bus.getInstance().wsSend(WsType(WsType.C106, data));
        break;
    ///赛事视频/动画状态
      case WsType.C107:
        Bus.getInstance().wsSend(WsType(WsType.C107, data));
        break;
    ///财务推送
      case WsType.C108:
        Bus.getInstance().wsSend(WsType(WsType.C108, data));
        break;
      case WsType.C109:
        Bus.getInstance().wsSend(WsType(WsType.C109, data));
        break;
    ///赛事订阅C1-玩法数量（C110）
      case WsType.C110:
        Bus.getInstance().wsSend(WsType(WsType.C110, data));
        break;
    ///玩法集变更
      case WsType.C112:
        Bus.getInstance().wsSend(WsType(WsType.C112, data));
        break;
    /// C120盘口结束时间(针对冠军赛事)
      case WsType.C120:
        Bus.getInstance().wsSend(WsType(WsType.C120, data));
        break;
    /// 订单状态
      case WsType.C201:
        Bus.getInstance().wsSend(WsType(WsType.C201, data));
        break;
    /// 未结算订单数
      case WsType.C202:
        Bus.getInstance().wsSend(WsType(WsType.C202, data));
        break;

    /// 重新获取余额
      case WsType.C203:
        UserController.to.getBalance();
        Bus.getInstance().wsSend(WsType(WsType.C202, data));
        break;
    /// 提前结算投注项 C21订阅
      case WsType.C210:
        UserController.to.getBalance();
        Bus.getInstance().wsSend(WsType(WsType.C210, data));
        break;
    /// 赛事提前结算状态变化
      case WsType.C211:
        Bus.getInstance().wsSend(WsType(WsType.C211, data));
        break;
    /// 菜单栏目
      case WsType.C301:
        Bus.getInstance().wsSend(WsType(WsType.C301, data));
        break;
    /// 赛事开赛通知状态
      case WsType.C302:
        Bus.getInstance().wsSend(WsType(WsType.C302, data));
        break;
    ///新增玩法/盘口通知
      case WsType.C303:
        Bus.getInstance().wsSend(WsType(WsType.C303, data));
        break;
    /// C304主副盘变更
      case WsType.C304:
        Bus.getInstance().wsSend(WsType(WsType.C304, data));
        break;
    /// 新版UI菜单 数量推送
      case WsType.C501:
        Bus.getInstance().wsSend(WsType(WsType.C501, data));
        break;
    /// 热门直播推送
      case WsType.C601:
        Bus.getInstance().wsSend(WsType(WsType.C601, data));
        break;
    ///补充赛事时间
      case WsType.C801:
        Bus.getInstance().wsSend(WsType(WsType.C801, data));
        break;
    /// 联赛关盘补充(C901)
      case WsType.C901:
        Bus.getInstance().wsSend(WsType(WsType.C901, data));
        break;
        ///赛事事件
      case WsType.C1021:
        Bus.getInstance().wsSend(WsType(WsType.C601, data));
        break;
        ///菜单栏顺序变更
      case WsType.C3011:
        Bus.getInstance().wsSend(WsType(WsType.C601, data));
        break;
      default:
        break;
    }
  }
}

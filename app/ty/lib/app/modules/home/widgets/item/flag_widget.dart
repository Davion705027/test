import 'package:flutter_ty_app/app/core/constant/common/index.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/lodash.dart';

import '../../../../global/user_controller.dart';

///子玩法图标
class FlagWidget extends StatelessWidget {
  MatchEntity matchEntity;
  int type;///0常规 1新手版
  FlagWidget({super.key, required this.matchEntity, required this.type,});

  /*
*   ///  预约结算 start 0：关；1：开
  /// bookedSettleSwitchBasketball    预约提前结算开关-篮球
  /// bookedSettleSwitchFootball      预约提前结算开关-足球
  /// partSettleSwitchBasketball      部分提前结算开关-篮球
  /// partSettleSwitchFootball        部分提前结算开关-足球
  /// settleSwitch                    足球提前结算开关
  /// settleSwitchBasket              篮球提前结算开关
  /// sysBookedSettleSwitch           系统预约提前结算开关
  /// sysPartSettleSwitch             系统部分提前结算开关
* */



  @override
  Widget build(BuildContext context) {
   // List<Widget> widgets = createWidgets();

    // 是否显示角球
    bool getCornerKick() {
      List<String> list = lodash.get(matchEntity.toJson(), 'msc');
      if (list.isEmpty) {
        return false;
      }
      bool isShow = false;
      // 代替方案
      // var obj = buildMsc(matchEntity);
      // var s5 = lodash.get(obj, 'S5');
      // if (s5 != null) {
      //   print(s5.values.toList());
      //   s5.values.toList().forEach((t) {
      //     if (t != null) {
      //       isShow = true;
      //     }
      //   });
      // }
      // return isShow;

      // 切割S5| 如果是0:0 也需要显示角球
      try {
        var str = list.firstWhere((element) => element.contains('S5|'));
        // var S5 = str.split('S5|')[1].split(':')[1];
        // isShow = S5 != null;
        isShow = str.isNotEmpty;
        return isShow;
      } catch (e) {
        return false;
      }
    }

    return SizedBox(
      height: 18.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 正常的 优先级 ： lvs 直播   muUrl 视频  animationUrl 动画
          if (UserController.to.userInfo.value?.ommv == 1)
            matchEntity.mvs > -1
                ? ImageView(
                    'assets/images/sport/ico_footerball.svg',
                    width: 18.w,
                    height: 18.w,
                  ).marginOnly(right: 4.w)
                : ColorFiltered(
                    colorFilter:
                        const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                    child: ImageView(
                      'assets/images/sport/ico_footerball.svg',
                      width: 18.w,
                      height: 18.w,
                    ).marginOnly(right: 4.w),
                  ),

          ///  muUrl  视频
          (matchEntity.mms > 1 && [1, 2, 7, 10, 110].contains(matchEntity.ms))
              ? ImageView(
                  'assets/images/sport/ico_video.svg',
                  width: 18.w,
                  height: 18.w,
                ).marginOnly(right: 4.w)
              : ColorFiltered(
                  colorFilter:
                      const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                  child: ImageView(
                    'assets/images/sport/ico_video.svg',
                    width: 18.w,
                    height: 18.w,
                  ).marginOnly(right: 4.w),
                ),

          /// mng 是否中立场   1:是中立场，0:非中立场
          if (![5, 10, 7, 8, 13].contains(int.tryParse(matchEntity.csid)) &&
              matchEntity.mng != 0)
            ImageView(
              'assets/images/sport/midfield_icon_app.svg',
              width: 18.w,
              height: 18.w,
            ).marginOnly(right: 4.w),

          ///  角球
          if (matchEntity.csid == '1' && getCornerKick())
            ImageView(
              'assets/images/sport/ico_cornerkick.svg',
              width: 18.w,
              height: 18.w,
            ).marginOnly(right: 4.w),
          //  此赛事支持提前结算
          if ( matchEntity.csid == '1' &&UserController.to.isSettleSwitch()&&matchEntity.mearlys == 1||matchEntity.csid == '2' &&UserController.to.isSettleSwitchBasket()&&matchEntity.mearlys == 1)
            ImageView(
              'assets/images/sport/ico_time.svg',
              width: 18.w,
              height: 17.w,
            ).marginOnly(right: 4.w),


        ],
      ),
    ).paddingZero.marginOnly(bottom: type==0?5.h:0.w);
  }

  List<Widget> createWidgets() {
    List<String> list = [];
    list.addAll([
      'assets/images/sport/ico_footerball.svg',
      'assets/images/sport/ico_video.svg',
    ]);
    if (!CsidUtil.is_eports_csid(matchEntity.csid)) {
      list.addAll([
        'assets/images/sport/ico_zhubo.svg',
        'assets/images/sport/ico_cornerkick.svg',
        'assets/images/sport/ico_time.svg',
      ]);
    }
    return list
        .map((e) => ImageView(
              e,
              width: 18.w,
              height: 18.w,
            ).marginOnly(right: 4.w))
        .toList();
  }
}

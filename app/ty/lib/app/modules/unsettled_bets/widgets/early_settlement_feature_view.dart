import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/rule_statement_view.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import '../../../../generated/locales.g.dart';
import '../../../global/user_controller.dart';
import '../../../global/ws/ws_app.dart';
import '../../../utils/utils.dart';
import '../../../widgets/image_view.dart';
import '../await_bets/await_bets_logic.dart';

class EarlySettlementFeatureView extends StatelessWidget {
  const EarlySettlementFeatureView({
    Key? key,
    required this.information,
    required this.index,
    required this.turnOnEarlySettlement,
    required this.earlySettlementBeingRequested,
    required this.earlySettlementSuccessfulType,
  }) : super(key: key);
  final String information;
  final int index, earlySettlementSuccessfulType;
  final bool turnOnEarlySettlement, earlySettlementBeingRequested;

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<AwaitBetsLogic>();
    String prefix = '';
    if (earlySettlementSuccessfulType == 1) {
      prefix = LocaleKeys.early_btn4.tr;
    } else if (earlySettlementSuccessfulType == 2) {
      prefix = LocaleKeys.early_btn5.tr;
    } else if (turnOnEarlySettlement) {
      prefix = LocaleKeys.app_h5_bet_confirm.tr + LocaleKeys.early_btn2_1.tr;
    } else {
      prefix = LocaleKeys.early_btn2_1.tr;
    }
    String substance = prefix +
        setAmount(information) +
        '(' +
        UserController.to.currCurrency() +
        ')';
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RuleStatementView(),
        if (earlySettlementSuccessfulType == 3)
          Text(
            LocaleKeys.early_info2.tr,
            style: TextStyle(
              color: Colors.red,
              fontSize: 12.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ),
        InkWell(
          onTap: () => {logic.setTurnOnEarlySettlement(index)},
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 40.h,
            margin: EdgeInsets.only(top: 4.h),
            decoration: BoxDecoration(
                color: context.isDarkMode
                    ? const Color(0xFF127DCC)
                    : const Color(0xff179CFF),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  substance,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                if (earlySettlementBeingRequested)
                  ImageView(
                    'assets/images/bets/early_settlement_loding.gif',
                    width: 24.w,
                    height: 24.w,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

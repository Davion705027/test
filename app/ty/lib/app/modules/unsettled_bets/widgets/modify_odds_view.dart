import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/models/res/get_h5_pre_bet_orderlist_entity.dart';
import '../../login/login_head_import.dart';
import '../bookin_bets/bookin_bets_logic.dart';

class ModifyOddsView extends StatelessWidget {
  const ModifyOddsView({
    Key? key,
    required this.index,
    required this.data,
  }) : super(key: key);

  final int index;
  final GetH5PreBetOrderlistDataRecordxData data;

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<BookinBetsLogic>();
    bool canBeModified = data!.canBeModified;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (canBeModified)
            Container(
              margin: EdgeInsets.only(top: 8.h),
              padding: const EdgeInsets.all(6),
              decoration: ShapeDecoration(
                color: context.isDarkMode
                    ? Colors.white.withOpacity(0.03999999910593033)
                    : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => {
                      logic.setModifyOdds(index, 0),
                    },
                    onLongPress: () => {
                    logic.setModifyOdds(index, 0),
                  },
                    child: Container(
                      margin: const EdgeInsets.all(6),
                      child: ImageView(
                        context.isDarkMode
                            ? 'assets/images/bets/component_darkmode_increase.png'
                            : 'assets/images/bets/component_decrease.png',
                        width: 16.w,
                        height: 16.w,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        '@  ' + data.detailList[0].oddFinallyChange,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: context.isDarkMode
                              ? Colors.white.withOpacity(0.8999999761581421)
                              : const Color(0xFF303442),
                          fontSize: 13,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => {
                      logic.setModifyOdds(index, 1),
                    },
                    onLongPress: () => {
                      logic.setModifyOdds(index, 1),
                    },
                    child: Container(
                      margin: const EdgeInsets.all(6),
                      child: ImageView(
                        context.isDarkMode
                            ? 'assets/images/bets/component_darkmode_decrease.png'
                            : 'assets/images/bets/component_increase.png',
                        width: 16.w,
                        height: 16.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () =>
                        {logic.setModifyOdds(index, canBeModified ? 4 : 2)},
                    child: Container(
                      height: 35.h,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: context.isDarkMode
                                ? const Color(0xFF127DCC)
                                : const Color(0xff179CFF),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            canBeModified
                                ? LocaleKeys.common_cancel.tr
                                : LocaleKeys.app_h5_bet_cancel_appoint.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: context.isDarkMode
                                  ? const Color(0xFF127DCC)
                                  : const Color(0xff179CFF),
                              fontSize: 12,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: InkWell(
                    onTap: () =>
                        {logic.setModifyOdds(index, canBeModified ? 5 : 3)},
                    child: Container(
                      height: 35.h,
                      decoration: ShapeDecoration(
                        color: context.isDarkMode
                            ? const Color(0xFF127DCC)
                            : const Color(0xff179CFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            canBeModified
                                ? LocaleKeys.app_h5_bet_confirm.tr
                                : LocaleKeys.common_edit.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

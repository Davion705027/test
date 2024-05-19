import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/locales.g.dart';
import '../../../widgets/image_view.dart';
import '../../login/login_head_import.dart';
import '../../settled_bets/settled_bets_logic.dart';

class ExtendView extends StatelessWidget {
  const ExtendView({
    Key? key,
    required this.index,
    required this.preSettleExpand,
  }) : super(key: key);
  final int index;
  final bool preSettleExpand;

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<SettledBetsLogic>();
    Color color = context.isDarkMode
        ? Colors.white.withOpacity(0.8999999761581421)
        : const Color(0xFF303442);
    return InkWell(
      onTap: () => {logic.onPreSettleExpand(index)},
      child: Container(
        margin: EdgeInsets.only(top: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.app_h5_cathectic_cash_details.tr,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            ImageView(
              preSettleExpand
                  ? 'assets/images/bets/icon_up.gif'
                  : 'assets/images/bets/icon_down.gif',
              width: 18.w,
              height: 18.h,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../generated/locales.g.dart';
import '../../../widgets/image_view.dart';
import '../../login/login_head_import.dart';
import '../dialog/rule_statement_dialog/rule_statement_dialog.dart';

class RuleStatementView extends StatelessWidget {
  const RuleStatementView({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Get.dialog(
          const RuleStatementDialogPage(),
          barrierColor: Colors.black.withOpacity(0.8),
        ),
      },
      child: Container(
        margin: EdgeInsets.only(top: 8.h,bottom: 4.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(

            ),
            const Spacer(),
            Text(
              LocaleKeys.app_h5_cathectic_cash_rules.tr,
              style: TextStyle(
                color:  context.isDarkMode?Colors.white.withOpacity(0.30000001192092896): const Color(0xFFAFB3C8),
                fontSize: 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ),
            ImageView(
              'assets/images/bets/prompt_nor.png',
              width: 14.w,
              height: 14.h,
            )
          ],
        ),
      ),
    );
  }
}

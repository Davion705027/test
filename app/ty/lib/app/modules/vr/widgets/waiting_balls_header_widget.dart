import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

class WaitingBallsHeaderWidget extends StatelessWidget {
  const WaitingBallsHeaderWidget({
    super.key,
    required this.hpns,
  });

  final List<String> hpns;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 18.w),
      // decoration: BoxDecoration(
      //   border: Border(
      //     top: BorderSide(
      //       width: 0.5,
      //       color: Get.isDarkMode
      //           ? Colors.white.withOpacity(0.07999999821186066)
      //           : AppColor.dividerColorLight,
      //     ),
      //   ),
      // ),
      child: Row(
        children: [
          const SizedBox().expanded(),
          DefaultTextStyle(
            style: TextStyle(
              fontSize: 10,
              color: Get.isDarkMode
                  ? Colors.white.withOpacity(0.8999999761581421)
                  : '#303442'.hexColor,
              height: 14 / 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: hpns
                  .map(
                    (e) => Text(
                      e,
                      textAlign: TextAlign.center,
                    ).expanded(),
                  )
                  .toList(),
            ),
          ).expanded(),
        ],
      ),
    );
  }
}

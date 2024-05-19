import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

class SearchNoData extends StatelessWidget {
  const SearchNoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 44.h,
          alignment: Alignment.center,
          color: context.isDarkMode
              ? Colors.white.withOpacity(0.04)
              : Colors.white,
          child: Text(
            LocaleKeys.app_h5_search_search_tips.tr,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: context.isDarkMode
                    ? Colors.white.withOpacity(0.3)
                    : Colors.black54),
          ),
        ),
        Expanded(
          child: Container(
            height: double.infinity,
            color: context.isDarkMode
                ? Colors.transparent
                : const Color(0xFFF2F2F6),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../login/login_head_import.dart';

class DividingLineView extends StatelessWidget {
  const DividingLineView({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              height: 1.h,
              color:context.isDarkMode? Colors.white.withOpacity(0.07999999821186066): const Color(0xFFE4E6ED),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:get/get.dart';

class BalanceIconButton extends StatelessWidget {
  const BalanceIconButton({
    super.key,
    this.balance = '1,000,000.00',
    this.onTap,
  });

  final VoidCallback? onTap;
  final String balance;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: GetBuilder<UserController>(
        builder: (controller) {
          return GestureDetector(
            onTap: () {
              // Get.toNamed(Routes.DJView);
            },
            child: Container(
              padding:
                  EdgeInsets.only(top: 2.h, left: 4.w, right: 6.w, bottom: 2.h),
              height: 22.h,
              margin: EdgeInsets.only(right: 14.w),
              decoration: ShapeDecoration(
                color: Get.isDarkMode
                    ? Colors.white.withOpacity(0.03999999910593033)
                    : const Color(0xFFF2F2F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              child: Row(
                children: [
                  ImageView('assets/images/home/icon_trans_nor.svg',
                      width: 16.w, height: 16.w),
                  Container(width: 5.w),
                  Text(
                    controller.balance.value != null
                        ? controller.toAmountSplit(
                        controller.balance.value!.amount.toString())
                        : '-',
                    style: TextStyle(
                      color: Get.isDarkMode
                          ? Colors.white.withOpacity(0.699999988079071)
                          : const Color(0xFF303442),
                      fontSize: 14.sp,
                      fontFamily: 'DIN Alternate',
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

class CommonAppBar {
  static AppBar arrowBack(
    BuildContext context, {
    String title = '',
    VoidCallback? onBack,
    List<Widget>? actions,
    double? elevation,
    bool? centerTitle,
    Widget? flexibleSpace,
    Color? backgroundColor,
    Color? arrowColor,
    Color? titleColor,
    Widget? cusTitle,
    Widget? cusLeading,
  }) =>
      AppBar(
        backgroundColor: backgroundColor ??
            (Get.isDarkMode ? Colors.transparent : AppColor.colorWhite),
        title: cusTitle ??
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: titleColor ??
                    (Get.isDarkMode
                        ? AppColor.colorWhite
                        : AppColor.color303442),
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
        elevation: elevation ?? 0.0,
        centerTitle: centerTitle ?? true,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        leading: cusLeading ??
            GestureDetector(
              onTap: onBack ?? Get.back,
              child: UnconstrainedBox(
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20.w,
                  color: (Get.isDarkMode
                      ? AppColor.colorWhite
                      : AppColor.color303442),
                ),
                //  ImageView(
                //   'assets/images/icon/icon_arrowleft_nor.png',
                //   width: 20.w,
                //   height: 20.w,
                //   color: (Get.isDarkMode
                //       ? AppColor.colorWhite
                //       : AppColor.color303442),
                // ),
              ),
            ),
        actions: actions,
        flexibleSpace: flexibleSpace,
      );
}

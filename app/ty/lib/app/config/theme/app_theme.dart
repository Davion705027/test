import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_color.dart';

class AppTheme {
  static ThemeData createTheme({
    required Brightness brightness,
    required Color background,
    required Color primaryTextColor,
    required Color labelTextColor,
    required Color primaryColor,
    required Color cardBgColor,
    required Color divider,
  }) {
    final baseTextTheme = brightness == Brightness.dark
        ? Typography.blackMountainView
        : Typography.whiteMountainView;

    return ThemeData(
      useMaterial3: false,
      fontFamily: "DIN Alternate",
      brightness: brightness,
      canvasColor: background,
      cardColor: background,
      dividerColor: divider,
      primarySwatch: AppColor.createMaterialColor(primaryColor),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      dividerTheme: DividerThemeData(
        color: divider,
        space: 1,
        thickness: 1,
      ),
      scrollbarTheme: ScrollbarThemeData(
        radius: const Radius.circular(10),

        /// 滚动条的常亮
        thumbVisibility: MaterialStateProperty.all<bool>(true),
        thumbColor: MaterialStateProperty.all(Colors.white.withOpacity(0.08)),
        trackColor: MaterialStateProperty.all(Colors.white.withOpacity(0.08)),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: AppColor.createMaterialColor(primaryColor),
        // primaryColorDark: primaryColor,
        accentColor: primaryColor,
        backgroundColor: background,
        brightness: brightness,
      ),
      tabBarTheme: TabBarTheme(
        /// 点击 hover颜色
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        dividerColor: Colors.transparent,
        dividerHeight: 0,
        labelColor: primaryTextColor,
        unselectedLabelColor: labelTextColor,
        labelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: const Color(0xFF3E65FF),
            width: 3.h,
          ),
          insets: EdgeInsets.only(bottom: 4.h),
        ),
      ),
      splashFactory: NoSplash.splashFactory,
      primaryColor: primaryColor,
      appBarTheme: AppBarTheme(
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        color: background,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: primaryTextColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFF546371),
        size: 24.0,
      ),
      scaffoldBackgroundColor: background,
      drawerTheme: DrawerThemeData(
        elevation: 0,
        backgroundColor: background,
        width: 0.7.sw,
      ),
      inputDecorationTheme: InputDecorationTheme(
        // contentPadding: EdgeInsets.symmetric(vertical: 0.h),
        isDense: true,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF96A5AA),
            width: 1,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
            width: 1,
          ),
        ),
        labelStyle: TextStyle(
          color: labelTextColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: TextStyle(
          color: labelTextColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      cardTheme: CardTheme(
        color: cardBgColor,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 0,
      ),
      textTheme: TextTheme(
        displayLarge: baseTextTheme.displayLarge?.copyWith(
          fontSize: 40.sp,
          color: primaryTextColor,
          fontWeight: FontWeight.w600,
        ),
        displaySmall: baseTextTheme.displaySmall?.copyWith(
          fontSize: 25.sp,
          color: primaryTextColor,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: baseTextTheme.titleLarge?.copyWith(
          fontSize: 17.sp,
          color: primaryTextColor,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: baseTextTheme.titleMedium?.copyWith(
          fontSize: 14.sp,
          color: primaryTextColor,
          fontWeight: FontWeight.w700,
        ),
        titleSmall: baseTextTheme.titleSmall?.copyWith(
          fontSize: 13.sp,
          color: primaryTextColor,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(
          fontSize: 14.sp,
          color: primaryTextColor,
        ),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(
          fontSize: 13.sp,
          color: primaryTextColor,
        ),
        bodySmall: baseTextTheme.bodySmall?.copyWith(
          fontSize: 12.sp,
          color: primaryTextColor,
        ),
        labelLarge: baseTextTheme.labelLarge?.copyWith(
          fontSize: 13.sp,
          color: labelTextColor,
        ),
        labelMedium: baseTextTheme.labelMedium?.copyWith(
          fontSize: 12.sp,
          color: labelTextColor,
        ),
        labelSmall: baseTextTheme.labelSmall?.copyWith(
          fontSize: 11.sp,
          color: labelTextColor,
        ),
      ),
    );
  }

  static ThemeData get light => createTheme(
        brightness: Brightness.light,
        background: AppColor.bgColorLight,
        primaryTextColor: AppColor.colorTextPrimaryLight,
        primaryColor: AppColor.colorPrimary,
        cardBgColor: AppColor.cardBgColorLight,
        divider: AppColor.dividerColorLight,
        labelTextColor: AppColor.colorTextSecondaryLight,
      );

  static ThemeData get dark => createTheme(
        brightness: Brightness.dark,
        background: AppColor.bgColorDark,
        primaryTextColor: AppColor.colorTextPrimaryDark,
        primaryColor: AppColor.colorPrimary,
        cardBgColor: AppColor.cardBgColorDark,
        divider: AppColor.dividerColorDark,
        labelTextColor: AppColor.colorTextPrimaryDark,
      );
}

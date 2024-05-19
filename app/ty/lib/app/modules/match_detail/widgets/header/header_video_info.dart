import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../controllers/match_detail_controller.dart';

class HeaderVideoInfo extends StatefulWidget {
  const HeaderVideoInfo({super.key, required this.controller});

  final MatchDetailController controller;

  @override
  State<HeaderVideoInfo> createState() => _HeaderVideoInfoState();
}

class _HeaderVideoInfoState extends State<HeaderVideoInfo>
    with SingleTickerProviderStateMixin {
  // 动画控制器
  late final AnimationController _controller;

  late final Animation<double> _animation;

  // 定义动画开始与结束值
  late final Tween<double> _sizeTween;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    _sizeTween = Tween(begin: 0, end: 1);
    _controller.value = 0.0;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isOpenVideoInfo =
          widget.controller.detailState.isOpenVideoInfo.value;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (isOpenVideoInfo == true) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      });

      return SizeTransition(
        sizeFactor: _sizeTween.animate(_animation),
        child: Container(
          color: Get.theme.tabPanelBackgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          child: Text(
            "${LocaleKeys.app_info_rules_rule1.tr}${LocaleKeys.app_info_rules_rule2.tr}",
            style: TextStyle(
              color: Get.isDarkMode ? Colors.white : const Color(0xFF7981A4),
              fontSize: 12.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );
    });
  }
}

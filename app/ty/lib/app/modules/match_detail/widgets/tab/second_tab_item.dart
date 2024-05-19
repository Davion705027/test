import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';

typedef WidgetCenterBack = Function(Point center);

/// 子tab标题单个item
class SecondTabItem extends StatefulWidget {
  const SecondTabItem(this.text,
      {super.key,
      this.active = false,
      required this.onTap,
      this.fullscreen = false,
      this.centerBack});

  /// 标签选中状态
  final bool active;
  final String text;
  final bool fullscreen;
  final WidgetCenterBack? centerBack;

  final VoidCallback onTap;

  @override
  State<SecondTabItem> createState() => _SecondTabItemViewState();
}

class _SecondTabItemViewState extends State<SecondTabItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
        _scrollExcursion();
      },
      child: Container(
        height: widget.fullscreen ? 30 : 30.h,
        padding:
            EdgeInsets.symmetric(horizontal: widget.fullscreen ? 12 : 12.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.active
              ? widget.fullscreen
                  ? const Color.fromRGBO(18, 125, 204, 1)
                  : Get.theme.secondTabPanelSelectedColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(widget.fullscreen ? 20 : 20.r),
        ),
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: widget.active
                  ? widget.fullscreen
                      ? Colors.white
                      : Get.theme.secondTabPanelSelectedFontColor
                  : widget.fullscreen
                      ? const Color.fromRGBO(97, 103, 131, 0.6)
                      : Get.theme.secondTabPanelUnSelectedFontColor,
              fontSize: widget.fullscreen ? 12 : 13.sp,
              fontFamily: 'PingFang SC',
              fontWeight: widget.active ? FontWeight.w500 : FontWeight.w400),
        ),
      ),
    );
  }

  void _scrollExcursion() {
    RenderObject? renderObject = context.findRenderObject();
    //获取元素尺寸
    Rect? rect = renderObject?.paintBounds;
    //获取元素位置
    var vector3 = renderObject?.getTransformTo(null).getTranslation();
    if (vector3 != null && rect != null && widget.centerBack != null) {
      widget.centerBack!(Point(
          vector3.x + rect.size.width / 2, vector3.y + rect.size.height / 2));
    }
  }
}

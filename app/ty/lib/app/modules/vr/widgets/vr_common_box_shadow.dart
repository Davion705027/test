import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:get/get.dart';

class VrCommonBoxShadow extends StatefulWidget {
  const VrCommonBoxShadow({
    super.key,
    this.color,
    required this.child,
    this.padding,
    this.onTap,
    this.width,
    this.height,
    this.borderRadius = 8,
  });

  final Color? color;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final double borderRadius;

  @override
  State<VrCommonBoxShadow> createState() => _VrCommonBoxShadowState();
}

class _VrCommonBoxShadowState extends State<VrCommonBoxShadow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: widget.padding,
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.color ??
              (Get.isDarkMode
                  ? Colors.white.withOpacity(0.03999999910593033)
                  : AppColor.colorWhite),
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 6,
              color: Colors.black.withOpacity(0.04),
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}

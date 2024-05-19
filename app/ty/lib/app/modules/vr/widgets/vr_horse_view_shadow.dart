import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';

class VrHorseViewShadow extends StatelessWidget {
  const VrHorseViewShadow({
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
  final Widget child;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? AppColor.colorWhite,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 6,
              color: Colors.black.withOpacity(0.04),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

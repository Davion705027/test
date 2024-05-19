import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:get/get.dart';

class VrCommonOddsBox extends StatefulWidget {
  const VrCommonOddsBox({
    super.key,
    this.color,
    required this.child,
    this.padding,
    this.onTap,
    this.width,
    this.height,
    this.borderRadius = 8,
    // this.isSelected = false,
    this.ol,
    this.childBuilder,
  });

  final Color? color;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final Widget? Function(bool isSelected)? childBuilder;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final double borderRadius;
  // final bool isSelected;
  final MatchHpsHlOl? ol;

  @override
  State<VrCommonOddsBox> createState() => _VrCommonOddsBoxState();
}

class _VrCommonOddsBoxState extends State<VrCommonOddsBox> {
  late bool _isSelected;

  @override
  void initState() {
    _isSelected = ShopCartController.to.currentBetController?.itemList
            .firstWhereOrNull((item) =>
                widget.ol != null && item.playOptionsId == widget.ol?.oid) !=
        null;
    Bus.getInstance().on(EventType.oddsButtonUpdate, (_) {
      if (mounted) {
        bool checked = ShopCartController.to.isCheck(widget.ol?.oid);
        if (_isSelected != checked) {
          setState(() {
            _isSelected = checked;
          });
        }
      }
    });
    super.initState();
  }

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
              (_isSelected
                  ? (Get.isDarkMode
                      ? Colors.white.withOpacity(0.2)
                      : '#D1EBFF'.hexColor)
                  : (Get.isDarkMode
                      ? Colors.white.withOpacity(0.03999999910593033)
                      : AppColor.colorWhite)),
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 6,
              color: Colors.black.withOpacity(0.04),
            ),
          ],
        ),
        child: widget.childBuilder?.call(_isSelected) ?? widget.child,
      ),
    );
  }
}

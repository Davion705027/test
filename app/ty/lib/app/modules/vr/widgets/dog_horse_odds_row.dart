import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:get/get.dart';

import 'vr_common_box_shadow.dart';

class DogHorseOddsRow extends StatefulWidget {
  const DogHorseOddsRow({
    super.key,
    required this.rank,
    this.iconSrc,
    this.title,
    this.subtitle,
    this.onTap,
    required this.teamNum,
    this.ol,
    this.lockWidget,
  });

  final int rank;
  final String teamNum;
  final String? iconSrc;
  final String? title;
  final String? subtitle;
  final VoidCallback? onTap;
  final MatchHpsHlOl? ol;
  final Widget? lockWidget;

  @override
  State<DogHorseOddsRow> createState() => _DogHorseOddsRowState();
}

class _DogHorseOddsRowState extends State<DogHorseOddsRow> {
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
    return VrCommonBoxShadow(
      onTap: widget.onTap,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      color: _isSelected
          ? (Get.isDarkMode
              ? Colors.white.withOpacity(0.2)
              : '#D1EBFF'.hexColor)
          : Get.isDarkMode
              ? Colors.white.withOpacity(0.03999999910593033)
              : AppColor.colorWhite,
      child: Row(
        children: [
          ImageView(
            widget.iconSrc ??
                'assets/images/vr/vr_dog_horse_rank${widget.teamNum}.png',
            width: 20.w,
            height: 20.w,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              widget.title ?? 'Annette Black',
              style: TextStyle(
                fontSize: 12,
                color: _isSelected
                    ? Get.isDarkMode
                        ? Colors.white
                        : '#127DCC'.hexColor
                    : Get.isDarkMode
                        ? Colors.white
                        : '#303442'.hexColor,
              ),
            ),
          ),
          widget.lockWidget ??
              Text(
                widget.subtitle ?? '${widget.rank + 1}',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: _isSelected
                      ? Get.isDarkMode
                          ? Colors.white
                          : '#127DCC'.hexColor
                      : Get.isDarkMode
                          ? Colors.white
                          : '#303442'.hexColor,
                  fontWeight: FontWeight.w700,
                  // 设计稿字体：Akrobat，字重：bold，字号：12
                  // fontFamily: '',
                ),
              ),
        ],
      ),
    );
  }
}

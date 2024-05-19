import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../../../utils/bus/bus.dart';
import '../../../../../utils/bus/event_enum.dart';
import '../../../../shop_cart/shop_cart_controller.dart';

enum BetButtonLayoutDirection {
  horizontal,
  vertical,
}

class BetButton extends StatefulWidget {
  const BetButton({
    super.key,
    required this.height,
    required this.width,
    this.direction = BetButtonLayoutDirection.vertical,
    required this.matchHpsHlOl,
  });

  final double height;
  final double width;
  final MatchHpsHlOl matchHpsHlOl;
  final BetButtonLayoutDirection? direction;

  @override
  State<BetButton> createState() => _BetButtonState();
}

class _BetButtonState extends State<BetButton> {
  bool selected = false;

  @override
  void initState() {
    super.initState();
    Bus.getInstance().on(EventType.oddsButtonUpdate, (_) {
      if (mounted) {
        bool checked = ShopCartController.to.isCheck(widget.matchHpsHlOl.oid);
        if (selected != checked) {
          setState(() {
            selected = checked;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    Bus.getInstance().off(EventType.oddsButtonUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataStoreController>(
        id: DataStoreController.to.getOid(widget.matchHpsHlOl.oid),
        builder: (logic) {
          MatchHpsHlOl ol =
              DataStoreController.to.getOlById(widget.matchHpsHlOl.oid) ??
                  widget.matchHpsHlOl;

            child:
          return Container(
            height: widget.height,
            width: widget.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                boxShadow:  const [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                    spreadRadius: 0,
                  )],color: selected
                  ? Get.theme.oddsButtonSelectedBackgroundColor
                  : (context.isDarkMode
                      ? Colors.white.withOpacity(0.07999999821186066)
                      : const Color(0xFFFFFFFE)),
              borderRadius: BorderRadius.circular(
                  widget.direction == BetButtonLayoutDirection.vertical
                      ? 4.w
                      : 8.w),
            ),
            child: buildHorizontal(ol, context),
          );
        });
  }

  Widget buildHorizontal(MatchHpsHlOl ol, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              ol.on ?? '',
              // minFontSize: 8,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withOpacity(0.8999999761581421)
                    : Color(0xFF303442),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          AutoSizeText(
            formatNumber(ol.ov ?? 0),
            textAlign: TextAlign.center,
            minFontSize: 10,
            style: TextStyle(
              color: context.isDarkMode
                  ? Colors.white.withOpacity(0.8999999761581421)
                  : Color(0xFF303442),
              fontSize: 14.sp,
              fontFamily: "Akrobat",
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  /// 只显示三位有效数字
  String formatNumber(int number) {
    double result = number / 100000;
    String resultStr;
    if (result >= 100) {
      resultStr = result.toStringAsFixed(0);
    } else if (result >= 10) {
      resultStr = result.toStringAsFixed(1);
    } else {
      resultStr = result.toStringAsFixed(2);
    }
    return resultStr;
  }
}

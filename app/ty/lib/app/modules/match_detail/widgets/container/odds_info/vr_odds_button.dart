import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../core/format/project/module/format-odds-conversion-mixin.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../../../utils/bus/bus.dart';
import '../../../../../utils/bus/event_enum.dart';
import '../../../../../widgets/image_view.dart';
import '../../../../shop_cart/shop_cart_controller.dart';
import '../../../models/odds_button_enum.dart';

/// vr虚拟体育无变赔投注按钮
class VrOddsButton extends StatefulWidget {
  const VrOddsButton({
    super.key,
    this.width,
    this.height,
    this.direction = OddsTextDirection.vertical,
    required this.match,
    required this.hps,
    required this.ol,
    required this.hl,
    required this.isDetail,
    this.index,
  });

  final double? width;
  final double? height;

  final MatchEntity match;
  final MatchHps hps;
  final MatchHpsHlOl ol;
  final MatchHpsHl hl;

  final bool isDetail;
  final int? index;

  /// 水平或者垂直
  final OddsTextDirection direction;

  @override
  State<VrOddsButton> createState() => _OddsButtonState();
}

class _OddsButtonState extends State<VrOddsButton> {
  bool selected = false;

  @override
  void initState() {
    Bus.getInstance().on(EventType.oddsButtonUpdate, (_) {
      if (mounted) {
        bool checked = ShopCartController.to.isCheck(widget.ol.oid);
        if (selected != checked) {
          setState(() {
            selected = checked;
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // Bus.getInstance().off(EventType.oddsButtonUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // ol.result == null 排除赛果
        if (widget.ol.result == null && widget.ol.os != 2) {
          OddsButtonState state = OddsButtonState.betState(
              widget.match.mhs, widget.hl.hs, widget.ol.os);
          if (state == OddsButtonState.open) {
            ShopCartController.to.addBet(
                widget.match, widget.hps, widget.hl, widget.ol,
                betType: OddsBetType.vr, isDetail: widget.isDetail);
          }
        }
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        alignment: Alignment.center,
        padding: widget.isDetail
            ? EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h)
            : EdgeInsets.symmetric(vertical: 2.h),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: selected
              ? Get.theme.oddsButtonSelectedBackgroundColor
              : Get.theme.oddsButtonBackgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          shadows: widget.isDetail
              ? [
                  BoxShadow(
                    color: Get.theme.oddsButtonShadowColor,
                    blurRadius: 8,
                    offset: Offset(0, 2.h),
                    spreadRadius: 0,
                  )
                ]
              : null,
        ),
        child: _buildBody(widget.ol),
      ),
    );
  }

  _buildBody(MatchHpsHlOl ol) {
    return widget.direction == OddsTextDirection.vertical
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _buildContent(ol),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _buildContent(ol),
          );
  }

  _buildContent(MatchHpsHlOl ol) {
    return <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIcons(ol),
          if (widget.direction == OddsTextDirection.horizontal)
            // 赔率名称
            _buildOddsName(ol),
        ],
      ),

      if (widget.direction == OddsTextDirection.vertical)
        SizedBox(
          height: 6.h,
        ),
      // 赔率值
      _buildOddsValue(ol),
    ];
  }

  /// 赔率名称
  Widget _buildOddsName(MatchHpsHlOl ol) {
    return Text(
      ol.on,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(
        fontSize: widget.isDetail ? 12.sp : 10.sp,
        color: Get.theme.oddsButtonNameFontColor,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  /// 赔率值
  Widget _buildOddsValue(MatchHpsHlOl ol) {
    if (ol.result == null) {
      if (ol.os == 2) {
        return _buildLock(ol);
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            TYFormatOddsConversionMixin.computeValueByCurOddType(
                ol.ov,
                widget.hps.hpid,
                widget.hps.hsw.split(','),
                int.tryParse(widget.match.csid) ?? 0),
            style: TextStyle(
              fontSize: widget.isDetail ? 16.sp : 12.sp,
              color: Get.theme.oddsButtonValueFontColor,
              fontWeight: FontWeight.w400,
              fontFamily: "Akrobat",
            ),
          )
        ],
      );
    } else {
      // 赛果展示
      int result = ol.result!;
      String resultText = "";
      if ([0, 1, 2, 3, 4, 5, 6].contains(result)) {
        resultText = "virtual_sports_result_$result".tr;
      } else {
        LocaleKeys.virtual_sports_result_0.tr;
      }
      return AutoSizeText(
        resultText,
        style: TextStyle(
          fontSize: widget.isDetail ? 15.sp : 12.sp,
          // "0": '未知',
          // "1": '未知',
          // "2": '走水',
          // "3": '输',
          // "4": '赢',
          // "5": '赢半',
          // "6": '输半',
          color: (result == 4 || result == 5)
              ? const Color(0xFFE95B5B)
              : Get.theme.oddsButtonValueFontColor,
          fontWeight: FontWeight.w700,
          fontFamily: "Akrobat",
        ),
      );
    }
  }

  // 锁
  _buildLock(MatchHpsHlOl ol) {
    return ImageView(
      'assets/images/detail/match-icon-lock.svg',
      width: 16.w,
      height: 16.w,
    );
  }

  Widget _buildIcons(MatchHpsHlOl ol) {
    if (widget.index != null) {
      return ImageView(
        'assets/images/vr/vr_dog_horse_rank${widget.index! + 1}.svg',
        width: 20.w,
        height: 20.w,
      );
    } else {
      if (ol.on.contains("/")) {
        List<String> ons = ol.on.split("/");
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: ons
              .map((e) => ImageView(
                    'assets/images/vr/vr_dog_horse_rank${e.trim()}.svg',
                    width: 20.w,
                    height: 20.w,
                  ))
              .toList(),
        );
      } else {
        return Container();
      }
    }
  }
}

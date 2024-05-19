import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../core/format/project/module/format-odds-conversion-mixin.dart';
import '../../../../../../global/data_store_controller.dart';
import '../../../../../../services/models/res/vr_hot_entity.dart';
import '../../../../../../utils/bus/bus.dart';
import '../../../../../../utils/bus/event_enum.dart';
import '../../../../../../widgets/image_view.dart';
import '../../../../../shop_cart/shop_cart_controller.dart';
import '../../../../models/bet_item_collection.dart';
import '../../../../models/odds_button_enum.dart';

/// vr虚拟体育玩法模板8 热门玩法 单独处理
class Temp8 extends StatefulWidget {
  const Temp8({
    super.key,
    required this.item,
    required this.match,
  });

  final VrHotEntity item;
  final MatchEntity match;

  @override
  State<Temp8> createState() => _OddsItemState();
}

class _OddsItemState extends State<Temp8> with SingleTickerProviderStateMixin {
  // 动画控制器
  late final AnimationController _controller;

  late final Animation<double> _animation;

  // 定义动画开始与结束值
  late final Tween<double> _sizeTween;

  // 定义展开折叠
  bool expanded = true;
  Map<String, BetItemCollection> playObj = {};
  Map<String, dynamic> playObj2 = {};
  Map<String, String> hswObj = {};

  Map<String, bool> selects = {};

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    _sizeTween = Tween(begin: 0, end: 1);
    _controller.value = 1.0;
    getOdds();
    Bus.getInstance().on(EventType.oddsButtonUpdate, (_) {
      if (mounted) {
        playObj.forEach((key, value) {
          bool checked = ShopCartController.to.isCheck(value.ol.oid);
          if (selects[key] != checked) {
            setState(() {
              selects[key] = checked;
            });
          }
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    // Bus.getInstance().off(EventType.oddsButtonUpdate);
    super.dispose();
  }

  void getOdds() {
    Map<String, BetItemCollection> playObj1 = {};

    List<MatchHps> plays = widget.item.plays;
    plays.forEach((item) {
      List<MatchHpsHl> hl = item.hl;
      for (var i = 0; i < hl.length; i++) {
        List<MatchHpsHlOl> ol = hl[i].ol;
        for (var j = 0; j < ol.length; j++) {
          BetItemCollection betItem = BetItemCollection(
            ol: ol[j],
            hl: hl[i],
            hps: item,
          );
          String teamId = ol[j].teamId;
          String key = item.hpid + teamId;
          hswObj[item.hpid] = item.hsw;
          playObj1[key] = betItem;
          selects[key] = false;
        }
        playObj2[item.hpid] = item;
      }
    });
    playObj = playObj1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.h, left: 5.w, right: 5.w, bottom: 8.h),
      decoration: BoxDecoration(
        color: Get.theme.betPanelBackGroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          // 阴影
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.04),
            blurRadius: 12,
            offset: Offset(0, 4.h),
            spreadRadius: 0,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                if (expanded) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              });
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                height: 36.h,
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.item.hotName,
                      style: TextStyle(
                          color: Get.theme.betPanelFontColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp),
                    ),
                    widget.item.plays.isNotEmpty
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                widget.item.plays[0].hpn,
                                style: TextStyle(
                                    color: Get.theme.betPanelFontColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp),
                              ),
                              SizedBox(
                                width: 40.w,
                              ),
                              Text(
                                widget.item.plays[1].hpn,
                                style: TextStyle(
                                    color: Get.theme.betPanelFontColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp),
                              ),
                              SizedBox(
                                width: 40.w,
                              ),
                              if (widget.match.csid != '1009')
                                Text(
                                  widget.item.plays[2].hpn,
                                  style: TextStyle(
                                      color: Get.theme.betPanelFontColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp),
                                ).marginOnly(right: 12.w),
                              AnimatedRotation(
                                duration: const Duration(milliseconds: 200),
                                turns: expanded ? 0 : -0.25,
                                child: ImageView(
                                  Get.isDarkMode
                                      ? 'assets/images/detail/ico_arrowdown_nor_night.svg'
                                      : 'assets/images/detail/ico_arrowdown_nor.svg',
                                  width: 12.w,
                                  height: 12.w,
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                )),
          ),
          if (expanded)
            Container(
              height: 0.5,
              color: Get.theme.betPanelUnderlineColor,
            ),
          SizeTransition(
            sizeFactor: _sizeTween.animate(_animation),
            child: _buildOddWidget(),
          ),
        ],
      ),
    );
  }

  Widget _buildOddWidget() {
    return Column(
      children: widget.item.team.map((e) => _buildLine(e)).toList(),
    );
  }

  Widget _buildLine(VrHotTeam team) {
    int index = widget.item.team.indexOf(team);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageView(
                'assets/images/vr/vr_dog_horse_rank${index + 1}.svg',
                width: 20.w,
                height: 20.w,
              ).marginOnly(right: 8.w),
              SizedBox(
                width: 120.w,
                child: Text(
                  team.teamName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Get.theme.betPanelFontColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _oddsButton('20033${team.teamId}'),
              SizedBox(
                width: 10.w,
              ),
              _oddsButton('20034${team.teamId}'),
              SizedBox(
                width: 10.w,
              ),
              if (widget.match.csid != '1009')
                _oddsButton('20035${team.teamId}').marginOnly(right: 16.w),
            ],
          )
        ],
      ),
    );
  }

  Widget _oddsButton(String oid) {
    BetItemCollection? betItem = playObj[oid];
    if (betItem == null) {
      return Container();
    }

    MatchHps hps = betItem.hps!;
    MatchHpsHlOl ol = betItem.ol;
    MatchHpsHl hl = betItem.hl;
    return InkWell(
      onTap: () {
        // ol.result == null 排除赛果
        if (ol.result == null) {
          if (ol.os != 2) {
            ShopCartController.to.addBet(widget.match, hps, hl, ol,
                betType: OddsBetType.vr, isDetail: true);
          }
        }
      },
      child: Container(
        height: 40.h,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 2.h),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: selects[oid]!
              ? Get.theme.oddsButtonSelectedBackgroundColor
              : Get.theme.oddsButtonBackgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          shadows: [
            BoxShadow(
              color: Get.theme.oddsButtonShadowColor,
              blurRadius: 8,
              offset: Offset(0, 2.h),
              spreadRadius: 0,
            )
          ],
        ),
        child: _buildContent(betItem),
      ),
    );
  }

  _buildContent(BetItemCollection betItem) {
    // 赔率值
    return _buildOddsValue(betItem);
  }

  /// 赔率值
  Widget _buildOddsValue(BetItemCollection betItem) {
    MatchHpsHlOl ol = betItem.ol;
    MatchHps hps = betItem.hps!;
    if (ol.result == null) {
      return SizedBox(
        width: 55.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (ol.os == 2) _buildLock(ol),
            if (ol.os != 2)
              AutoSizeText(
                TYFormatOddsConversionMixin.computeValueByCurOddType(
                    ol.ov,
                    hps.hpid,
                    hps.hsw.split(','),
                    int.tryParse(widget.match.csid) ?? 0),
                maxLines: 1,
                minFontSize: 5,
                style: TextStyle(
                  fontSize: 14,
                  // 红升绿降
                  color: Get.theme.oddsButtonValueFontColor,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Akrobat",
                ),
              )
          ],
        ),
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
          fontSize: 15.sp,
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
}

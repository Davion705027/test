import 'package:auto_size_text/auto_size_text.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/home/logic/other_player_name_to_playid.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../../../core/format/project/module/format-odds-conversion-mixin.dart';
import '../../../../../global/data_store_controller.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../../../utils/bus/bus.dart';
import '../../../../../utils/bus/event_enum.dart';
import '../../../../../utils/global_timer.dart';
import '../../../../../widgets/image_view.dart';
import '../../../../home/controllers/home_controller.dart';
import '../../../../home/logic/home_controller_logic.dart';
import '../../../../shop_cart/shop_cart_controller.dart';
import '../../../models/odds_button_enum.dart';
import '../../../models/odds_change_timer_task.dart';

/// 变赔投注按钮 + 赛果
class OddsButton extends StatefulWidget {
  const OddsButton({
    super.key,
    this.width,
    this.height,
    this.name,
    this.direction = OddsTextDirection.vertical,
    this.match,
    this.hps,
    this.ol,
    this.hl,
    this.isDetail = false,
    this.secondaryPaly = false,
    this.betType = OddsBetType.common,
    this.fullscreen = false,
    this.nameColor,
    this.playId = '',

    ///波胆类型  type = 0 时需要单独处理
    this.type = 1,
    this.radius,
  });

  final double? width;
  final double? height;

  final MatchEntity? match;
  final MatchHps? hps;
  final MatchHpsHlOl? ol;
  final MatchHpsHl? hl;

  /// 投注项文本 详情有写不同模板不同name拼接
  final String? name;

  /// 水平或者垂直
  final OddsTextDirection direction;

  /// 针对列表和详情某些样式不同 做区分
  final bool isDetail;
  final bool secondaryPaly;

  final OddsBetType betType;

  ///首页列表 子玩法id
  final String playId;
  final int type;

  final bool fullscreen;
  final Color? nameColor;

  // 圆角
  final double? radius;

  @override
  State<OddsButton> createState() => _OddsButtonState();
}

class _OddsButtonState extends State<OddsButton> {
  int status = 0; // 10 红升  -10绿降
  int oldOv = 0; // 记录旧赔率
  Timer? timer;
  bool selected = false; // 是否选中
  // 投注类型
  OddsBetType oddsBetType = OddsBetType.common;
  late Size size ;

  @override
  void initState() {
    oddsBetType = widget.betType;


    if (widget.ol != null) {
      MatchHpsHlOl ol =
          DataStoreController.to.getOlById(widget.ol!.oid) ?? widget.ol!;
      oldOv = ol.ov;
    }
    Bus.getInstance().on(EventType.oddsButtonUpdate, (_) {
      if (mounted) {
        bool checked = ShopCartController.to.isCheck(widget.ol?.oid);
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    size=MediaQuery.of(context).size;
  }

  @override
  void didUpdateWidget(covariant OddsButton oldWidget) {
    selected = ShopCartController.to.isCheck(widget.ol?.oid);
    // 更新oldOv
    if (oldWidget.ol != widget.ol && widget.ol != null) {
      MatchHpsHlOl ol =
          DataStoreController.to.getOlById(widget.ol!.oid) ?? widget.ol!;
      oldOv = ol.ov;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.ol == null || ObjectUtil.isEmpty(widget.ol?.oid)) {
      return Container(
        width: widget.width,
        height: widget.height,
        alignment: Alignment.center,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: widget.fullscreen
              ? Colors.white.withOpacity(0.08)
              : Get.theme.oddsButtonBackgroundColor,
          //设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 4.w)),
        ),
        child: widget.secondaryPaly == true &&
                widget.playId == playIdConfig.hpsBold
            ? _BodanClose()
            : _Placeholder(),
      );
    }
    selected = ShopCartController.to.isCheck(widget.ol?.oid);
    return GetBuilder<DataStoreController>(
        id: DataStoreController.to.getOid(widget.ol!.oid),
        builder: (controller) {
          MatchHpsHlOl ol =
              DataStoreController.to.getOlById(widget.ol!.oid) ?? widget.ol!;
          //  MatchHpsHlOl ol = widget.ol!;
          _oddsChange(ol);
          // GlobalTimer.getInstance().dispose();

          return InkWell(
            onTap: () {
              /*
              * 如果有键盘 先隐藏键盘
              * */
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
              // ol.result == null 排除赛果
              if (widget.match != null &&
                  widget.hps != null &&
                  ol.result == null) {
                OddsButtonState state = OddsButtonState.betState(
                    widget.match!.mhs, widget.hl!.hs, ol.os);
                if (state == OddsButtonState.open) {
                  /// 设置当前投注类型
                  _adjustOddsBetType();
                  ShopCartController.to.addBet(
                      widget.match!, widget.hps!, widget.hl, ol,
                      betType: oddsBetType,
                      isDetail: widget.isDetail,
                      secondaryPaly: widget.secondaryPaly);
                  setState(() {
                    selected = ShopCartController.to.isCheck(widget.ol?.oid);
                  });
                }
              }
            },
            child: Container(
              width: widget.width,
              height: widget.height,
              alignment: Alignment.center,
              padding: widget.isDetail
                  ? const EdgeInsets.symmetric(horizontal: 8, vertical: 2)
                  : const EdgeInsets.symmetric (vertical: 0),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: selected
                    ? widget.fullscreen
                        ? Colors.white.withOpacity(0.2)
                        : Get.theme.oddsButtonSelectedBackgroundColor
                    : widget.fullscreen
                        ? Colors.white.withOpacity(0.08)
                        : Get.theme.oddsButtonBackgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.radius ?? 8)),
                shadows: widget.isDetail
                    ? [
                        BoxShadow(
                          color: widget.fullscreen
                              ? Colors.transparent
                              : Get.theme.oddsButtonShadowColor,
                          blurRadius: 8,
                          offset: Offset(0, 2.h),
                          spreadRadius: 0,
                        )
                      ]
                    : null,
              ),
              child: _buildBody(widget.ol!, ol),
            ),
          );
        });
  }

  //赔率 单独更新
  _buildBody(
    MatchHpsHlOl ol,
    MatchHpsHlOl valueol,
  ) {
    if (widget.match == null || widget.hps == null || widget.hl == null) {
      // 占位符
      return _buildClose(ol: valueol);
    }

    return widget.direction == OddsTextDirection.vertical
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _buildContent(ol, valueol),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _buildContent(ol, valueol),
          );
  }

  _buildContent(MatchHpsHlOl ol, MatchHpsHlOl valueol) {
    OddsButtonState state =
        OddsButtonState.betState(widget.match!.mhs, widget.hl!.hs, valueol.os);
    if (state == OddsButtonState.lock) {
      return widget.isDetail
          ? _buildLock(valueol)
          : !widget.secondaryPaly
              ? <Widget>[_Placeholder()]
              : widget.playId == playIdConfig.hpsBold ||
                      widget.playId == playIdConfig.hpsCompose
                  ? <Widget>[valueol.ov == null ? _Placeholder() : _lockImage()]
                  : <Widget>[
                      if (ObjectUtil.isNotEmpty(_oddsName(ol)) &&
                          widget.playId != playIdConfig.hpsBold)
                        _buildOddsName(ol),
                      _lockImage()
                    ];
    } else if (state == OddsButtonState.open) {
      return !widget.secondaryPaly
          ? <Widget>[
              // 赔率名称 赛果不能这样判断 这里排除赛果
              if (ObjectUtil.isNotEmpty(_oddsName(ol)) &&
                      TYFormatOddsConversionMixin.computeValueByCurOddType(
                              valueol.ov,
                              widget.hps!.hpid,
                              widget.hps!.hsw.split(','),
                              int.tryParse(widget.match!.csid) ?? 0) !=
                          "-" ||
                  Get.currentRoute == Routes.matchResultsDetails)
                _buildOddsName(ol),
              if (widget.direction == OddsTextDirection.horizontal)
                const SizedBox(
                  width: 2,
                ),
              // 赔率值
              _buildOddsValue(valueol),
            ]
          : <Widget>[
              // 赔率名称
              if (ObjectUtil.isNotEmpty(_oddsName(ol))) _buildOddsName(ol),
              if (widget.direction == OddsTextDirection.horizontal)
                const SizedBox(
                  width: 2,
                ),
              // 赔率值
              _buildOddsValue(valueol),
            ];
    } else {
      if (widget.isDetail) {
        return _buildLock(valueol);
      }
      return <Widget>[
        !widget.secondaryPaly
            ? _Placeholder()
            : widget.playId == playIdConfig.hps15Minutes
                ? _Placeholder()
                : _lockImage()
      ];
    }
  }

  String _oddsName(MatchHpsHlOl ol) {
    OddsButtonState state =
        OddsButtonState.betState(widget.match!.mhs, widget.hl!.hs, ol.os);
    if (ObjectUtil.isEmptyString(widget.name)) {
      ///
      if (widget.match?.csid == "1" &&
          (widget.playId == playIdConfig.hps15Minutes) &&
          (ol.ot == "Over" || ol.ot == "Under")) {
        /// 15分钟玩法 1007
        if (!ObjectUtil.isEmptyString(ol.on)) {
          return ol.on;
        }
        return ol.onb;
      } else if ((widget.playId == playIdConfig.hpsCompose) &&
          !ObjectUtil.isEmptyString(ol.onb)) {
        /// 特殊组合 1010
        return ol.onb + ol.on;
      } else if ((widget.playId == playIdConfig.hpsBold) &&
          ol.ot.isNotEmpty &&
          (ObjectUtil.isNotEmpty(ol.ot) && ol.ot == "Other")) {
        /// 波胆显示 “其他” 单独处理
        return LocaleKeys.list_other.tr;
      } else if (!ObjectUtil.isEmptyString(ol.onb)) {
        return ol.onb;
      } else {
        if (!ObjectUtil.isEmptyString(ol.on)) {
          return ol.on;
        } else {
          /// 独赢的没有赔率名称 显示主队客队平局
          if (widget.hps?.chpid == '1' ||
              widget.playId == playIdConfig.hpsPunish) {
            if (ol.ot == '1') {
              return widget.playId == playIdConfig.hpsPunish
                  ? LocaleKeys.ouzhou_bet_col_bet_col_1_bet_col_1.tr
                  : LocaleKeys.ouzhou_bet_col_bet_col_4_bet_col_1.tr;
            } else if (ol.ot == '2') {
              return widget.playId == playIdConfig.hpsPunish
                  ? LocaleKeys.ouzhou_bet_col_bet_col_1_bet_col_2.tr
                  : LocaleKeys.ouzhou_bet_col_bet_col_4_bet_col_2.tr;
            } else {
              return LocaleKeys.ouzhou_bet_col_bet_col_1_bet_col_X.tr;
            }
          } else {
            return '';
          }
        }
      }
    } else {
      if (state == OddsButtonState.lock &&
          widget.playId == playIdConfig.hpsBold) {
        return "";
      } else {
        return widget.name!;
      }
    }
  }

  /// 赔率名称
  Widget _buildOddsName(MatchHpsHlOl ol) {
    if (widget.isDetail) {
      // 详情投注项对应玩法集模板特殊展示
      return _buildDetailOddsName(ol);
    } else {
      return AutoSizeText(
        _oddsName(ol),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textScaleFactor: MediaQuery.of(context).textScaleFactor,
        style: TextStyle(
          fontSize: widget.isDetail ? 12 : size.width<=360 ? 8 : 11,
          color: widget.nameColor ??
              (selected
                  ? Get.theme.oddsButtonSelectFontColor
                  : context.isDarkMode
                      ? const Color(0x4Dffffff)
                      : const Color(0xFFAFB3C8)),
          fontWeight: FontWeight.w400,
          fontFamily: 'PingFang SC',
        ),
        minFontSize: 6,
      );
    }
  }

  /// 赔率值
  Widget _buildOddsValue(MatchHpsHlOl ol) {
    if (ol.result == null) {
      return Stack(
        alignment: AlignmentDirectional.center,
        children: [
          if (status == 10)
            Positioned(
              left: 0,
              child: ImageView(
                'assets/images/detail/odds_up.svg',
                width: widget.fullscreen ? 10 : 10.w,
              ),
            ),
          if (status == -10)
            Positioned(
              left: 0,
              child: ImageView(
                'assets/images/detail/odds_down.svg',
                width: widget.fullscreen ? 10 : 10.w,
              ),
            ),
          AutoSizeText(
            TYFormatOddsConversionMixin.computeValueByCurOddType(
                ol.ov,
                widget.hps!.hpid,
                widget.hps!.hsw.split(','),
                int.tryParse(widget.match!.csid) ?? 0),
            maxLines: 1,
            minFontSize: 6,
            textScaleFactor: MediaQuery.of(context).textScaleFactor,
            style: TextStyle(
              fontSize: widget.isDetail ? 15 : size.width<=360 ? 8 : 12,
              // 红升绿降
              color: status == 0
                  ? (selected
                      ? widget.fullscreen
                          ? Colors.white.withOpacity(0.9)
                          : Get.theme.oddsButtonSelectFontColor
                      : widget.fullscreen
                          ? Colors.white.withOpacity(0.9)
                          : Get.theme.oddsButtonValueFontColor)
                  : status == 10
                      ? const Color(0xFFE95B5B)
                      : const Color(0xFF4AB06A),
              fontWeight: FontWeight.bold,
              fontFamily: "Akrobat",
            ),
          ).marginOnly(
              left: widget.fullscreen ? 10 : 10.w,
              right: widget.direction == OddsTextDirection.vertical
                  ? (widget.fullscreen ? 10 : 10.w)
                  : 0)
        ],
      );
    } else {
      // 赛果展示
      // "0": '未知',
      // "1": '未知',
      // "2": '走水',
      // "3": '输',
      // "4": '赢',
      // "5": '赢半',
      // "6": '输半',
      int result = ol.result!;
      String resultText = "";
      if ([0, 1, 2, 3, 4, 5, 6].contains(result)) {
        resultText = "virtual_sports_result_$result".tr;
      } else {
        LocaleKeys.virtual_sports_result_0.tr;
      }
      return AutoSizeText(
        resultText,
        maxLines: 1,
        style: TextStyle(
          fontSize: 15,
          color: (result == 4 || result == 5)
              ? const Color(0xFFE95B5B)
              : Get.theme.oddsButtonValueFontColor,
          fontWeight: FontWeight.w400,
          fontFamily: "Akrobat",
        ),
        minFontSize: 6,
      );
    }
  }

  /// 变赔处理
  void _oddsChange(MatchHpsHlOl ol) {
    if (ol.ov != oldOv) {
      // 变赔
      status = 0;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (mounted) {
          setState(() {
            if (oldOv != 0 && (ol.ov / 1000).ceil() > (oldOv / 1000).ceil()) {
              status = 10;
              oldOv = ol.ov;
            } else if (oldOv != 0 &&
                (ol.ov / 1000).ceil() < (oldOv / 1000).ceil()) {
              status = -10;
              oldOv = ol.ov;
            } else {
              status = 0;
              oldOv = ol.ov;
            }
          });
          // GlobalTimer.getInstance().push(OddsChangeTimerTask(
          //     id: ol.oid,
          //     seconds: 3,
          //     callback: () {
          //       if (mounted) {
          //         // 三秒后清除相关符号
          //         setState(() {
          //           status = 0;
          //         });
          //       }
          //     }));
          timer?.cancel();
          timer = Timer.periodic(const Duration(seconds: 3), (t) {
            if (mounted) {
              // 三秒后清除相关符号
              setState(() {
                status = 0;
                t.cancel();
              });
            }
          });
        }
      });
    }
  }

  _buildClose({MatchHpsHlOl? ol}) {


    return _lockImage();
  }

  /// 波胆空数据 显示 需要单独处理
  _BodanClose({MatchHpsHlOl? ol}) {
    return HomeController.to.firstMap == null &&
            HomeController.to.lastMap == null
        ? _Placeholder()
        : HomeController.to.lastMap == null &&
                HomeController.to.firstMap != null &&
                widget.type == 1
            ? _Placeholder()
            : HomeController.to.lastMap != null &&
                    HomeController.to.firstMap == null &&
                    widget.type == 0
                ? _Placeholder()
                : _lockImage();
  }

  _buildLock(MatchHpsHlOl ol) {
    return <Widget>[
      // 赔率名称 详情页并且csid!=1
      if (widget.isDetail && widget.match?.csid != "1") _buildOddsName(ol),

      // 锁
      _lockImage()
    ];
  }

  // 锁
  _lockImage() {
    return const ImageView(
      'assets/images/detail/match-icon-lock.svg',
      width: 16,
      height: 16,
    );
  }

  // 占位符
  _Placeholder() {
    return Text(
      "-",
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(
        color: widget.fullscreen
            ? Colors.white.withOpacity(0.5)
            : Get.theme.oddsButtonNameFontColor,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  _buildDetailOddsName(MatchHpsHlOl ol) {
    // 玩法集2 需要显示赔率名蓝色字体
    if (widget.hps?.hpt == 2) {
      String? osn = (widget.hps?.title as List<MatchHpsTitle>)
          .firstWhereOrNull((element) => ol.otd == element.otd)
          ?.osn;
      String left = (osn ?? "");
      // 计算文本大小
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: left,
          style: TextStyle(
            fontSize: widget.isDetail ? 12 :  10,
            color: selected
                ? widget.fullscreen
                    ? Colors.white.withOpacity(0.9)
                    : Get.theme.oddsButtonSelectFontColor
                : widget.fullscreen
                    ? Colors.white.withOpacity(0.5)
                    : Get.theme.oddsButtonNameFontColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 1,
      );
      textPainter.layout();

      return Container(
        alignment: Alignment.center,
        child: LayoutBuilder(builder: (context, covariant) {
          double? width;
          if (textPainter.width > covariant.maxWidth) {
            width = covariant.maxWidth - 40;
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width,
                child: Text(
                  left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: widget.isDetail ? 12 : 10,
                    color: selected
                        ? widget.fullscreen
                            ? Colors.white.withOpacity(0.9)
                            : Get.theme.oddsButtonSelectFontColor
                        : widget.fullscreen
                            ? Colors.white.withOpacity(0.5)
                            : Get.theme.oddsButtonNameFontColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              AutoSizeText(
                widget.name ??
                    (ObjectUtil.isEmptyString(ol.on) ? ol.onb : ol.on),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: widget.isDetail ? 12 : 10,
                  color: const Color.fromRGBO(23, 156, 255, 1),
                  fontWeight: FontWeight.w400,
                ),
                minFontSize: 6,
              ),
            ],
          );
        }),
      );
    }
    // 玩法集5 不展示赔率名称
    else if (widget.hps?.hpt == 5) {
      return Container();
    }
    // 左右展示
    else if (widget.hps?.hpt == 0 || widget.hps?.hpt == 6) {
      return Expanded(
        child: AutoSizeText(
          widget.name ?? (ObjectUtil.isEmptyString(ol.on) ? ol.onb : ol.on),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontSize: widget.isDetail ? 12 : 10,
            color: selected
                ? widget.fullscreen
                    ? Colors.white.withOpacity(0.9)
                    : Get.theme.oddsButtonSelectFontColor
                : widget.fullscreen
                    ? Colors.white.withOpacity(0.5)
                    : Get.theme.oddsButtonNameFontColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    } else {
      return Text(
        widget.name ?? (ObjectUtil.isEmptyString(ol.on) ? ol.onb : ol.on),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          fontSize: widget.isDetail ? 12 : 10,
          color: selected
              ? widget.fullscreen
                  ? Colors.white.withOpacity(0.9)
                  : Get.theme.oddsButtonSelectFontColor
              : widget.fullscreen
                  ? Colors.white.withOpacity(0.5)
                  : Get.theme.oddsButtonNameFontColor,
          fontWeight: FontWeight.w400,
        ),
      );
    }
  }

  _adjustOddsBetType() {
    switch (Get.currentRoute) {
      case Routes.vrSportDetail:
        oddsBetType = OddsBetType.vr;
      case Routes.DJView:
        oddsBetType = OddsBetType.esport;
    }
  }
}

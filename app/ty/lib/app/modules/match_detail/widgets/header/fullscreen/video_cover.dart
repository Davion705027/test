import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/webview_extension.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../global/data_store_controller.dart';
import '../../../../../global/user_controller.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../../../widgets/image_view.dart';
import '../../../controllers/match_detail_controller.dart';
import '../../../models/header_type_enum.dart';
import '../../container/odds_info_container.dart';
import '../../tab/bet_mode_tab_widget.dart';
import 'analysis.dart';
import 'change_line.dart';

/// 视频动画全屏时顶部展示信息及交互 这里不使用.w .h
class VideoCover extends StatefulWidget {
  const VideoCover(
      {super.key, required this.match, required this.controller, this.tag});

  final MatchEntity match;
  final MatchDetailController controller;
  final String? tag;

  @override
  State<VideoCover> createState() => _VideoCoverState();
}

class _VideoCoverState extends State<VideoCover> {
  bool showInfo = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataStoreController>(
      id: DataStoreController.to.getMatchId(widget.match.mid),
      builder: (dataStoreController) {
        MatchEntity matchEntity =
            dataStoreController.getMatchById(widget.match.mid) ?? widget.match;
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            // 上 分数展示 返回
            Positioned(
              top: 0,
              left: 0,
              child: _buildTop(matchEntity),
            ),
            // 右 投注 赛事分析
            Positioned(
              right: 0,
              child: _buildRight(matchEntity),
            ),
            // 下 按钮
            Positioned(
              bottom: 0,
              left: 0,
              child: _buildBottom(),
            ),
            // 赛事直播说明
            if (showInfo)
              Positioned(
                bottom: 0,
                child: _buildLiveInfo(),
              ),
          ],
        );
      },
    );
  }

  _buildBottom() {
    return Container(
      height: 110,
      width: 1.sw,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color.fromRGBO(0, 0, 0, 1),
            Color.fromRGBO(0, 0, 0, 0.87),
            Color.fromRGBO(0, 0, 0, 0.4),
            Color.fromRGBO(0, 0, 0, 0),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showInfo = true;
                    });
                    widget.controller.changeVideoTopShow(true);
                    widget.controller.detailState.topShowPermanent = true;
                    // ToastUtils.message(
                    //     title: LocaleKeys.info_rules_auto.tr,
                    //     content:
                    //         "${LocaleKeys.info_rules_rules_rule1.tr}\n${LocaleKeys.info_rules_rules_rule2.tr}",
                    //     fullscreen: true);
                  },
                  child: const ImageView(
                    'assets/images/detail/info.svg',
                    width: 24,
                  ),
                ),
                Row(
                  children: [
                    // 视频才显示声音
                    if (widget.controller.detailState.headerType.value ==
                            HeaderType.live &&
                        !widget.controller.detailState.isDJDetail)
                      InkWell(
                        onTap: () {
                          widget.controller.changeVideoTopShow(true);
                          widget.controller.switchVideoVolume();
                        },
                        child: Obx(() {
                          return ImageView(
                            widget.controller.detailState.liveMuted.value
                                ? 'assets/images/detail/mute.svg'
                                : 'assets/images/detail/sound.svg',
                            width: 24,
                          );
                        }),
                      ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        widget.controller.changeVideoTopShow(true);
                        widget.controller.fullscreen(false);
                      },
                      child: const SizedBox(
                        width: 24,
                        height: 24,
                        child: ImageView(
                          'assets/images/detail/un-full-screen.svg',
                          width: 24,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildTop(MatchEntity match) {
    return Container(
      height: 110,
      width: 1.sw,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(0, 0, 0, 1),
            Color.fromRGBO(0, 0, 0, 0.87),
            Color.fromRGBO(0, 0, 0, 0.4),
            Color.fromRGBO(0, 0, 0, 0),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => widget.controller.back(),
                  child: Container(
                    width: 24,
                    height: 44,
                    alignment: Alignment.center,
                    child: const ImageView(
                      "assets/images/detail/icon_arrowleft_nor_night.svg",
                      boxFit: BoxFit.fill,
                      width: 8,
                      height: 14,
                    ),
                  ),
                ),
                // 比分 动画不显示对阵信息
                // if(widget.controller.detailState.headerType.value == HeaderType.live)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      match.mhn,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ).marginOnly(right: 16),
                    Text(
                      widget.controller.eSportsScoring(match)
                          ? LocaleKeys.mmp_eports_scoring.tr
                          : match.ms != 110
                              ? widget.controller.getMsc(match.msc)
                              : "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'PingFang HK',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      match.man,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                      ),
                    ).marginOnly(left: 16)
                  ],
                ),
                Obx(() {
                  return InkWell(
                    onTap: () {
                      sliderLeft(
                          ChangeLine(
                            tag: widget.tag,
                            width: 270,
                          ),
                          width: 270);
                    },
                    child: Container(
                      width: 48,
                      height: 24,
                      padding: const EdgeInsets.all(2),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side:
                                const BorderSide(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: AutoSizeText(
                          widget.controller.detailState.playTypeList[
                              widget.controller.detailState.selectLine.value],
                          maxLines: 1,
                          minFontSize: 10,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                })
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildRight(MatchEntity match) {
    return SafeArea(
      child: SizedBox(
        width: 68,
        height: 1.sh / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                widget.controller.changeVideoTopShow(true);
                double width = 375;
                // 在状态蓝的一侧，则加上状态的高度
                if (_isHasStatusBar()) {
                  width = width + MediaQuery.of(context).padding.top;
                }
                sliderLeft(_buildBetContainer(match, width), width: width);
              },
              child: const ImageView(
                "assets/images/detail/fullscreen-oddsinfo.svg",
                boxFit: BoxFit.fill,
                width: 32,
              ).marginOnly(bottom: 16),
            ),
            if (widget.controller.detailState.headerType.value ==
                HeaderType.live)
              if (match.mvs > -1 && UserController.to.userInfo.value?.ommv != 0)
                GestureDetector(
                  onTap: () {
                    widget.controller.changeVideoTopShow(true);
                    widget.controller.loadAnimation(match);
                  },
                  child: const ImageView(
                    "assets/images/detail/fullscreen-animate.svg",
                    boxFit: BoxFit.fill,
                    width: 32,
                  ).marginOnly(bottom: 16),
                ),
            if (widget.controller.detailState.headerType.value ==
                HeaderType.animate)
              if (match.mms > 1 || match.pmms == 1)
                GestureDetector(
                  onTap: () {
                    widget.controller.changeVideoTopShow(true);
                    widget.controller.loadVideo(match);
                  },
                  child: const ImageView(
                    "assets/images/detail/fullscreen-live.svg",
                    boxFit: BoxFit.fill,
                    width: 32,
                  ).marginOnly(bottom: 16),
                ),
            // GestureDetector(
            //   onTap: () {
            //     widget.controller.changeVideoTopShow(true);
            //     double width = 375;
            //     // 在状态蓝的一侧，则加上状态的高度
            //     if (_isHasStatusBar()) {
            //       width = width + MediaQuery.of(context).padding.top;
            //     }
            //     // 赛事分析
            //     sliderLeft(_buildAnalysisContainer(match, width), width: width);
            //   },
            //   child: const ImageView(
            //     "assets/images/detail/fullscreen-analysis.svg",
            //     boxFit: BoxFit.fill,
            //     width: 32,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  /// 投注列表弹窗
  Widget _buildBetContainer(MatchEntity match, double width) {
    return Container(
      height: 1.sh,
      width: width,
      padding: EdgeInsets.only(
          top: 16,
          left: 16,
          right: _isHasStatusBar() ? Get.statusBarHeight : 16),
      color: Colors.transparent,
      child: SafeArea(
        left: false,
        top: false,
        right: false,
        child: Column(
          children: [
            // 比分
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    match.mhn,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ).marginOnly(right: 16),
                ),
                Text(
                  widget.controller.detailState.isDJDetail
                      ? LocaleKeys.mmp_eports_scoring.tr
                      : match.ms != 110
                          ? widget.controller.getMsc(match.msc)
                          : "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'PingFang HK',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    match.man,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ).marginOnly(left: 16),
                )
              ],
            ).marginOnly(bottom: 6),
            // tab
            BetModeTab(
              tag: widget.tag,
              fullscreen: true,
            ),
            //投注列表
            Expanded(
                child: OddsInfoContainer(
              tag: widget.tag,
              refresh: true,
            )),
          ],
        ),
      ),
    );
  }

  /// 当前方向是否在状态栏
  bool _isHasStatusBar() {
    // 获取设备的方向
    final isLandscapeLeft = MediaQuery.of(context).orientation ==
            Orientation.landscape &&
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;
    // 如果是左横屏
    if (isLandscapeLeft) {
      return false;
    } else {
      return true;
    }
  }

  /// 赛事分析
  Widget _buildAnalysisContainer(MatchEntity match, double width) {
    return SizedBox(
      height: 1.sh,
      width: width,
      child: Analysis(),
    );
  }

  _buildLiveInfo() {
    return Container(
      height: 110,
      width: 1.sw,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color.fromRGBO(0, 0, 0, 1),
            Color.fromRGBO(0, 0, 0, 0.87),
            Color.fromRGBO(0, 0, 0, 0.4),
            Color.fromRGBO(0, 0, 0, 0),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 36, right: 36, bottom: 30),
            child: Text(
              LocaleKeys.app_info_rules_rule1.tr +
                  LocaleKeys.app_info_rules_rule2.tr,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 15,
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// 左滑
sliderLeft(Widget child, {double width = 375}) {
  Get.generalDialog(
    navigatorKey: Get.key,
    barrierDismissible: true,
    transitionDuration: const Duration(milliseconds: 300),
    barrierLabel: MaterialLocalizations.of(Get.context!).dialogLabel,
    barrierColor: Colors.black.withOpacity(0),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      // 滑动方向 从右到左
      return SlideTransition(
        position: CurvedAnimation(
          parent: animation,
          curve: Curves.easeIn,
        ).drive(Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset(1 - width / 1.sw, 0),
        )),
        child: child,
      );
    },
    pageBuilder: (context, _, __) {
      return OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
        } else if (orientation == Orientation.portrait) {
          Get.back();
        }
        return GestureDetector(
          onTap: () {
            // Get.back();
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              color: const Color.fromRGBO(0, 0, 0, 0.8),
              width: width,
              height: 1.sh,
              child: child,
            ),
          ),
        );
      });
    },
  );
}

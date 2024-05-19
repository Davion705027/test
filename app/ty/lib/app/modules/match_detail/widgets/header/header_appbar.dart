import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:marquee/marquee.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../global/data_store_controller.dart';
import '../../../../utils/format_score_util.dart';
import '../../../../widgets/image_view.dart';
import '../../constant/detail_constant.dart';
import '../../controllers/match_detail_controller.dart';
import '../../models/header_type_enum.dart';
import 'match_select_widget.dart';
import 'stage/match_stage.dart';

/// 详情页头部置顶、滚动时的悬浮条
class HeaderAppbar extends StatefulWidget {
  const HeaderAppbar({super.key, this.tag});

  final String? tag;

  @override
  State<HeaderAppbar> createState() => _HeaderAppbarState();
}

class _HeaderAppbarState extends State<HeaderAppbar>
    with SingleTickerProviderStateMixin {
  final _refreshSubject = BehaviorSubject<Function>();
  late AnimationController _animationController;

  bool runMarquee = false;

  @override
  void initState() {
    // 跑马灯5秒后开启
    5.delay(() {
      if (mounted) {
        setState(() {
          runMarquee = true;
        });
      }
    });
    _refreshSubject
        .debounceTime(const Duration(milliseconds: 1100))
        .listen((callback) {
      // 防抖
      callback();
    });
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reset();
        }
      });

    super.initState();
  }

  @override
  void dispose() {
    _refreshSubject.close();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchDetailController>(
        tag: widget.tag,
        builder: (controller) {
          if (controller.detailState.match == null) return Container();
          MatchEntity match = controller.detailState.match!;
          return GetBuilder<DataStoreController>(
              id: DataStoreController.to.getMatchId(match.mid),
              builder: (dataStoreController) {
                MatchEntity matchEntity =
                    dataStoreController.getMatchById(match.mid) ?? match;
                return Container(
                  height: appbarHeight,
                  width: 1.sw,
                  padding: EdgeInsets.only(
                      left: 6.w, top: 4.h, bottom: 4.h, right: 14.w),

                  /// 根据是否置顶渲染不动的widget
                  child: Obx(() => controller.detailState.appbarPinned.value
                      ? _pinnedAppbar(matchEntity, controller)
                      : _normalAppbar(matchEntity, controller)),
                );
              });
        });
  }

  /// 未置顶
  _normalAppbar(MatchEntity match, MatchDetailController controller) {
    /// 未置顶时正常标题时宽度
    double normalTitleWidth = 190.w;
    // maxMarqueeWidth = 正常标题时宽度 - 右侧三角形图标宽度以及边距
    double maxMarqueeWidth = normalTitleWidth - 12.w - 4.w;

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        /// 返回 增大触摸区域
        Positioned(
          left: 0,
          child: InkWell(
            onTap: () => controller.back(),
            child: Container(
              width: 24.w,
              height: appbarHeight,
              alignment: Alignment.center,
              child: ImageView(
                "assets/images/detail/icon_arrowleft_nor_night.svg",
                boxFit: BoxFit.fill,
                width: 8.w,
              ),
            ),
          ),
        ),

        /// 中间
        controller.detailState.headerType.value == HeaderType.normal
            ? GestureDetector(
                onTap: () {
                  /// 下拉联赛选择
                  Get.generalDialog(
                    navigatorKey: Get.key,
                    barrierDismissible: true,
                    transitionDuration: const Duration(milliseconds: 300),
                    barrierLabel:
                        MaterialLocalizations.of(Get.context!).dialogLabel,
                    barrierColor: Colors.black.withOpacity(0.5),
                    transitionBuilder:
                        (context, animation, secondaryAnimation, child) {
                      // 滑动方向 从上到下
                      return SlideTransition(
                        position: CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeIn,
                        ).drive(Tween<Offset>(
                          begin: const Offset(0, -1.0),
                          end: Offset.zero,
                        )),
                        child: child,
                      );
                    },
                    pageBuilder: (context, _, __) {
                      return MatchSelectWidget(tag: widget.tag);
                    },
                  );
                },
                child: Container(
                  width: normalTitleWidth,
                  alignment: Alignment.center,
                  child:

                      /// 标题滚动
                      needMarquee(
                              text: match.tn,
                              fontSize: 18.sp,
                              maxWidth: maxMarqueeWidth)
                          ? _buildMarqueeTitle(
                              maxMarqueeWidth, match, controller)
                          : _buildNormalTitle(match, controller),
                ),
              )
            : _buildVsScore(match, controller),
        if (controller.detailState.headerType.value == HeaderType.normal)
          Positioned(
            right: 0,
            child: InkWell(
              onTap: () {
                _refreshSubject.add(controller.refreshData);
                if (_animationController.status == AnimationStatus.completed ||
                    _animationController.status == AnimationStatus.dismissed) {
                  _animationController.forward();
                }
              },
              child: RotationTransition(
                turns:
                    Tween(begin: 0.0, end: 10.0).animate(_animationController),
                child: ImageView(
                  'assets/images/shopcart/refresh1.png',
                  color: Colors.white,
                  width: 18.w,
                  height: 18.w,
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// 置顶
  _pinnedAppbar(MatchEntity match, MatchDetailController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            /// 返回 增大触摸区域
            InkWell(
              onTap: () => controller.back(),
              child: Container(
                width: 24.w,
                height: appbarHeight,
                alignment: Alignment.center,
                child: ImageView(
                  "assets/images/detail/icon_arrowleft_nor_night.svg",
                  boxFit: BoxFit.fill,
                  width: 8.w,
                ),
              ),
            ),

            /// 队伍1
            SizedBox(
              width: 75.w,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      match.mhn,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  if (controller.isTopShowScore(match) &&
                      !controller.eSportsScoring(match))
                    AutoSizeText(
                      FormatScore.formatTotalScore(match, 0).toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'DIN'),
                    ).marginOnly(left: 8.w),
                ],
              ),
            ),
          ],
        ),

        /// 赛事阶段状态
        InkWell(
          onTap: () {
            controller.detailState.scrollController.animateTo(
              0.0,
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
            );
          },
          child: MatchStage(
            match: match,
            isPinnedAppbar: true,
          ),
        ),

        /// 队伍2
        SizedBox(
          width: 85.w,
          child: Row(
            children: [
              if (controller.isTopShowScore(match) &&
                  !controller.eSportsScoring(match))
                Text(
                  FormatScore.formatTotalScore(match, 1).toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'DIN'),
                ).marginOnly(right: 8.w),
              Expanded(
                child: Text(
                  match.man,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ).marginOnly(right: 8.w),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 滚动标题
  _buildMarqueeTitle(
      double maxWidth, MatchEntity match, MatchDetailController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        runMarquee
            ? SizedBox(
                width: maxWidth,
                child: Marquee(
                  text: match.tn,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                  velocity: 30.0,
                  blankSpace: 10.w,
                ),
              )
            : Expanded(
                child: Text(
                  match.tn,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
        SizedBox(
          width: 4.w,
        ),
        // 三角形图标
        ImageView(
          "assets/images/detail/icon_arrowdown_nor_night.svg",
          boxFit: BoxFit.fill,
          width: 12.w,
          height: 12.w,
        )
      ],
    );
  }

  /// 正常标题
  _buildNormalTitle(MatchEntity match, MatchDetailController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 联赛名
        Text(
          match.tn,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        // 三角形图标
        ImageView(
          "assets/images/detail/icon_arrowdown_nor_night.svg",
          boxFit: BoxFit.fill,
          width: 12.w,
          height: 12.w,
        )
      ],
    );
  }

  /// 计算标题是否滚动
  bool needMarquee(
      {required String text,
      required double fontSize,
      required double maxWidth}) {
    // 计算文本大小 超过规定边界则使用跑马灯
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w400),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    textPainter.layout();

    if (textPainter.width > maxWidth) {
      return true;
    }
    return false;
  }

  _buildVsScore(MatchEntity match, MatchDetailController controller) {
    // 视频直播、动画直播点击屏幕 显示隐藏
    return AnimatedOpacity(
      /// 顶部按钮控制
      opacity: controller.detailState.videoTopShow.value ? 1.0 : 0,
      duration: const Duration(milliseconds: 300),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              match.mhn,
              maxLines: 1,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ).marginOnly(right: 16),
          ),
          Text(
            controller.eSportsScoring(match)
                ? LocaleKeys.mmp_eports_scoring.tr
                : match.ms != 110
                    ? controller.getMsc(match.msc)
                    : "",
            style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 120.w,
            child: Text(
              match.man,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ).marginOnly(left: 16),
          )
        ],
      ),
    );
  }
}

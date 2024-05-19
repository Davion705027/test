import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../services/models/res/match_entity.dart';
import '../../../../utils/csid_util.dart';
import '../../../../utils/lodash.dart';
import '../../../../utils/oss_util.dart';
import '../../../../utils/widget_utils.dart';
import '../../../../widgets/image_view.dart';
import '../../../../widgets/loading.dart';
import '../../constant/detail_constant.dart';
import '../../controllers/match_detail_controller.dart';
import '../../models/header_type_enum.dart';
import 'fullscreen/video_cover.dart';

/// 背景图、动画、视频组件
class HeaderBackground extends StatefulWidget {
  const HeaderBackground(
      {super.key,
      this.match,
      required this.controller,
      this.tag,
      // this.fullscreen = false
      });

  final MatchEntity? match;
  final MatchDetailController controller;
  final String? tag;
  // final bool fullscreen;

  @override
  State<HeaderBackground> createState() => _HeaderBackgroundState();
}

class _HeaderBackgroundState extends State<HeaderBackground> {
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// 数据仓库没有match情况
    if (widget.match == null) {
      return Stack(children: [
        _buildNormalHeader(),
        Positioned(
          top: Get.mediaQuery.padding.top,
          left: 0,
          child: Container(
            height: appbarHeight,
            padding:
                EdgeInsets.only(left: 6.w, top: 4.h, bottom: 4.h, right: 14.w),
            child: InkWell(
              onTap: () => widget.controller.back(),
              child: Container(
                width: 24.w,
                height: appbarHeight,
                alignment: Alignment.center,
                child: ImageView(
                  widget.controller.detailState.isMatchSelectExpand.value &&
                          !Get.isDarkMode
                      ? "assets/images/detail/icon_arrowleft_nor.svg"
                      : "assets/images/detail/icon_arrowleft_nor_night.svg",
                  boxFit: BoxFit.fill,
                  width: 8.w,
                ),
              ),
            ),
          ),
        ),
      ]);
    }

    return Listener(
      onPointerUp: (_) {
        if ((widget.controller.detailState.headerType.value ==
                    HeaderType.live &&
                widget.controller.detailState.videoUrl != '') ||
            (widget.controller.detailState.headerType.value ==
                    HeaderType.animate &&
                widget.controller.detailState.animationUrl != '')) {
          widget.controller.detailState.videoTopShow.value =
              !widget.controller.detailState.videoTopShow.value;
          widget.controller.detailState.topShowPermanent = false;
          timer?.cancel();
          timer = Timer.periodic(const Duration(seconds: 5), (t) {
            widget.controller.changeVideoTopShow(false);
            // widget.controller.detailState.videoTopShow.value = false;
          });
        }
      },
      child: Obx(() {
        // 视频
        if (widget.controller.detailState.headerType.value == HeaderType.live ||
            widget.controller.detailState.headerType.value ==
                HeaderType.animate ||
            widget.controller.detailState.headerType.value ==
                HeaderType.replay) {
          if (widget.controller.detailState.liveLoading.value &&
              widget.controller.detailState.headerType.value !=
                  HeaderType.replay) {
            return Container(
              color: Colors.black,
              height: widget.controller.detailState.fullscreen.value ? 1.sh : headerHeight,
              child: const CupertinoActivityIndicator(
                color: Colors.white,
              ).center,
            );
          } else {
            if ((widget.controller.detailState.headerType.value ==
                        HeaderType.live &&
                    widget.controller.detailState.videoUrl != '') ||
                (widget.controller.detailState.headerType.value ==
                        HeaderType.animate &&
                    widget.controller.detailState.animationUrl != '') ||
                widget.controller.detailState.headerType.value ==
                    HeaderType.replay) {
              // double marginTop =
              //     controller.detailState.headerType.value == HeaderType.live
              //         ? 0
              //         : Get.mediaQuery.padding.top;
              /// 允许屏幕自由旋转
              // SystemChrome.setPreferredOrientations([
              //   DeviceOrientation.portraitUp,
              //   DeviceOrientation.portraitDown,
              //   DeviceOrientation.landscapeLeft,
              //   DeviceOrientation.landscapeRight,
              // ]);

              // if (!widget.controller.detailState.fullscreen.value) {
              //   double animateHeaderHeight = 1.sw / (animateRatio) + Get.mediaQuery.padding.top;
              //   // 防止多次调用
              //   if(widget.controller.detailState.animateHeaderHeight.value != animateHeaderHeight){
              //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              //       // 动画竖屏 高度需要调整 宽度全屏 比例按照980 / 556
              //       widget.controller.detailState.animateHeaderHeight.value =
              //           1.sw / (animateRatio) + Get.mediaQuery.padding.top;
              //       widget.controller.update();
              //     });
              //   }
              //
              // }

              String initUrl = "";
              switch (widget.controller.detailState.headerType.value) {
                case HeaderType.live:
                  initUrl = widget.controller.detailState.videoUrl;
                  break;
                case HeaderType.animate:
                  initUrl = widget.controller.detailState.animationUrl;
                  break;
                default:
                  initUrl = widget.controller.detailState.replayUrl;
                  break;
              }

              InAppWebViewSettings settings = InAppWebViewSettings(
                  isInspectable: false,
                  mediaPlaybackRequiresUserGesture: false,
                  allowsInlineMediaPlayback: true,
                  iframeAllow: "camera; microphone",
                  underPageBackgroundColor: Colors.black,
                  forceDark: ForceDark.ON,
                  iframeAllowFullscreen: true);
              return Container(
                alignment: Alignment.center,
                // 状态栏设置黑色
                color: Colors.black,
                // 非全屏时 动画 设置高度 防止 显示不全问题
                height: widget.controller.detailState.fullscreen.value
                    ? 1.sh
                    : widget.controller.detailState.headerType.value ==
                            HeaderType.animate
                        ? widget
                            .controller.detailState.animateHeaderHeight.value
                        : headerHeight,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          // 适配动画全屏
                          horizontal: widget.controller.detailState.fullscreen.value &&
                                  widget.controller.detailState.headerType
                                          .value ==
                                      HeaderType.animate
                              ? (1.sw - 1.sh * animateRatio).abs() / 2
                              : 0,
                          vertical: 0),
                      child: InAppWebView(
                        initialSettings: settings,
                        initialUrlRequest: URLRequest(url: WebUri(initUrl)),
                        onWebViewCreated: (controller) {
                          widget.controller.detailState.webViewController =
                              controller;
                        },
                        onPermissionRequest: (controller, request) async {
                          return PermissionResponse(
                              resources: request.resources,
                              action: PermissionResponseAction.GRANT);
                        },
                        onConsoleMessage: (controller, consoleMessage) {
                          if (kDebugMode) {
                            // print(consoleMessage);
                          }
                        },
                        onLoadStop: (InAppWebViewController controller,
                            WebUri? url) {

                        },
                      ).paddingOnly(top: Get.mediaQuery.padding.top),
                    ),

                    // 全屏时 状态栏、分数、按钮展示
                    if (widget.controller.detailState.fullscreen.value)
                      WillPopScope(
                        onWillPop: () async {
                          /**
                           *返回 false route不再响应物理返回事件，拦截返回事件自行处理
                           */
                          //全屏时禁止左滑返回
                          return false;
                        },
                        child: Visibility(
                          visible:
                              widget.controller.detailState.videoTopShow.value,
                          child: VideoCover(
                            tag: widget.tag,
                            match: widget.match!,
                            controller: widget.controller,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            } else {
              return Container(
                height: widget.controller.detailState.fullscreen.value ? 1.sh : headerHeight,
                color: Colors.black,
                child: Text(
                  LocaleKeys.video_sorry.tr,
                  style: const TextStyle(color: Colors.white),
                ).center,
              );
            }
          }
        }
        // 赛事信息
        else {
          return _buildNormalHeader();
        }
      }),
    );
  }

  Widget _buildNormalHeader() {
    /// 禁用手机横屏
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);

    String csid = widget.match?.csid ?? widget.controller.detailState.csid;
    try {
      String bgUrl =
          lodash.get(DetailCsidConfig.detailCsidConfig, 'CSID_$csid.detail.B');
      String? base64 =
          lodash.get(DetailCsidConfig.detailCsidConfig, 'CSID_$csid.base64');
      if (base64 == null) {
        return Container(
          height: headerHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                  OssUtil.getServerPath(
                    bgUrl,
                  ),
                ),
                fit: BoxFit.cover),
          ),
        );
      } else {
        return SizedBox(
            width: 1.sw,
            height: headerHeight,
            child: WidgetUtils.base64ImageWidget(baseUrl: base64));
      }
    } catch (e) {
      return const CupertinoActivityIndicator().center;
    }
  }
}

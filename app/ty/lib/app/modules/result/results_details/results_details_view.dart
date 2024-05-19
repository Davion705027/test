import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:get/get.dart';
import '../../../../generated/locales.g.dart';
import '../../../utils/oss_util.dart';
import '../../../widgets/image_view.dart';
import '../../../widgets/loading.dart';
import '../../../widgets/no_data.dart';
import '../../match_detail/widgets/container/odds_info_container.dart';
import '../widgets/details_head_widget.dart';
import '../widgets/details_menu_widget.dart';
import '../widgets/details_title_widget.dart';
import '../widgets/featured_events_widget.dart';
import '../widgets/match_replay_widget.dart';
import '../widgets/mi_apuesta_widget.dart';
import 'results_details_controller.dart';

class ResultsDetailsPage extends StatefulWidget {
  const ResultsDetailsPage({Key? key}) : super(key: key);

  @override
  State<ResultsDetailsPage> createState() => _ResultsDetailsPageState();
}

class _ResultsDetailsPageState extends State<ResultsDetailsPage> {
  final controller = Get.find<ResultsDetailsController>();
  final logic = Get.find<ResultsDetailsController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResultsDetailsController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            decoration: context.isDarkMode
                ? BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        OssUtil.getServerPath(
                          'assets/images/detail/bg-dark.png',
                        ),
                      ),
                      fit: BoxFit.cover,
                    ),
                  )
                : const BoxDecoration(
                    color: Color(0xFFF2F2F6),
                  ),
            child: Stack(
              children: [
                Column(
                  children: [
                    if (controller.detailData != null)
                      controller.playVideo == true ? _playVideo() : _head(),
                    if (controller.detailData != null) _menu(),
                    Expanded(
                      child: Obx(() {
                        return _body();
                      }),
                    ),
                  ],
                ),
                GetBuilder<ResultsDetailsController>(
                    id: 'ResultDetailHeadMatchList',
                    builder: (controller) {
                      return DetailsTitleWidget(
                        isDark: context.isDarkMode,
                        headMenu: controller.headMenu,
                        onHeadMenu: () => controller.onHeadMenu(),
                        detailData: controller.detailData,
                        headMatchList: controller.headMatchList,
                        onHeadMatch: (matchItem) =>
                            controller.onHeadMatch(matchItem),
                        mid: controller.mid,
                        titleIndex: controller.titleIndex,
                      );
                    }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _head() {
    return DetailsHeadWidget(
      isDark: context.isDarkMode,
      typePicture: controller.typePicture,
      onHeadMenu: () => controller.onHeadMenu(),
      detailData: controller.detailData,
      onRefresh: () => controller.onRefresh(),
      animationController: controller.animationController,
      headerMap: controller.headerMap,
    );
  }

  Widget _playVideo() {
    InAppWebViewSettings settings = InAppWebViewSettings(
        mediaPlaybackRequiresUserGesture: false,
        allowsInlineMediaPlayback: true,
        iframeAllow: "camera; microphone",
        iframeAllowFullscreen: true);
    return Stack(
      children: [
        SizedBox(
          height: 230.h,
          child: InAppWebView(
            initialSettings: settings,
            initialUrlRequest: URLRequest(url: WebUri(controller.playVideoUrl)),
            onWebViewCreated: (webViewController) {
              controller.webViewController = webViewController;
            },
            onPermissionRequest: (controller, request) async {
              return PermissionResponse(
                  resources: request.resources,
                  action: PermissionResponseAction.GRANT);
            },
            onConsoleMessage: (controller, consoleMessage) {
              if (kDebugMode) {
                print(consoleMessage);
              }
            },
          ),
        ),
        SafeArea(
          child: Row(
            children: [
              InkWell(
                onTap: () => controller.onClosVideo(),
                child: Container(
                  margin: EdgeInsets.only(
                    left: 10.w,
                  ),
                  child: ImageView(
                    'assets/images/icon/icon_arrowleft_nor.png',
                    width: 20.w,
                    height: 20.h,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 20.w,
                ),
                child: ImageView(
                  'assets/images/icon/replay_logo.svg',
                  width: 60.w,
                  height: 20.h,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _menu() {
    return DetailsMenuWidget(
      isDark: context.isDarkMode,
      onExpandAll: () => controller.onExpandAll(),
      onEventHeadIndex: (index) => controller.onEventHeadIndex(index),
      eventHeadIndex: controller.eventHeadIndex,
      event: controller.event,
      bet: controller.bet,
      playback: controller.playback,

    );
  }

  Widget _body() {
    if (controller.loading.value) {
      return const Loading();
    }
    if (controller.eventHeadIndex == 0) {
      return controller.detailData != null
          ? const OddsInfoContainer(refresh: true,)
          : NoData(
              content: LocaleKeys.analysis_football_matches_no_data.tr,
              top: 0.h,
            );
    } else if (controller.eventHeadIndex == 1) {
      return controller.matcheHandpickData.isNotEmpty
          ? FeaturedEventsWidget(
              isDark: context.isDarkMode,
              matcheHandpickData: controller.matcheHandpickData,
              onGoToDetails: (item) => controller.onGoToDetails(item))
          : NoData(
              content: LocaleKeys.analysis_football_matches_no_data.tr,
              top: 0.h);
    } else if (controller.eventHeadIndex == 2) {
      return MiApuestaWidget(
        isDark: context.isDarkMode,
        miApuestaData: controller.miApuestaData,
      );
    } else if (controller.eventHeadIndex == 3) {
      return MatchReplayWidget(
        isDark: context.isDarkMode,
        videoHead: controller.videoHead,
        videoIndex: controller.videoIndex,
        onSelectVideo: (index) => controller.onSelectVideo(index),
        detailData: controller.detailData,
        headerMap: controller.headerMap,
        eventList: controller.eventList,
        onPlayVideo: (eventItem) => controller.onPlayVideo(eventItem),
      );
    }
    return Container();
  }
}

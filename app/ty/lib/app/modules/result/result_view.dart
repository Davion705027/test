import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/modules/result/gaming_results/gaming_results_view.dart';
import 'package:flutter_ty_app/app/modules/result/normal_results/normal_results_view.dart';
import 'package:flutter_ty_app/app/modules/result/widgets/title_widget.dart';
import 'package:get/get.dart';

import '../../utils/oss_util.dart';
import '../../widgets/image_view.dart';
import 'championship_results/championship_results_view.dart';
import 'result_controller.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final controller = Get.find<ResultController>();
  final logic = Get.find<ResultController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResultController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            decoration: context.isDarkMode
                ? BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        OssUtil.getServerPath(
                          'assets/images/icon/head1.png',
                        ),
                      ),
                      fit: BoxFit.cover,
                    ),
                  )
                : const BoxDecoration(
                    color: Colors.white,
                  ),
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //头部
                  _title(),
                  Expanded(
                    child: controller.titleIndex == 0
                        ? NormalResultsPage(controller.titleIndex)
                        : controller.titleIndex == 1
                            ? GamingResultsPage(controller.titleIndex)
                            :  ChampionshipResultsPage(controller.titleIndex),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //头部
  Widget _title() {
    return Container(
      margin: EdgeInsets.only(left: 14.w, right: 14.w),
      height: AppBar().preferredSize.height - 15,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 0,
            child: InkWell(
              onTap: () => Get.back(),
              child: Icon(
                Icons.arrow_back_ios,
                size: 18.w,
                color:
                    context.isDarkMode ? Colors.white : const Color(0xFF303442),
              ),
            ),
          ),
          /*  Container(
            width: 280.w,
            alignment: Alignment.center,
            child: TabBar(
              indicatorColor: Colors.transparent,
              indicator: const BoxDecoration(),
              isScrollable: false,
              dividerHeight: 0,
              labelPadding: EdgeInsets.zero,
              controller: controller.titleTabController,
              onTap: (index) => controller.onTitleIndex(index),
              tabs: List<TitleWidget>.generate(controller.titleList.length,
                  (index) {
                return TitleWidget(
                  onTap: () => controller.onTitleIndex(index),
                  title: controller.titleList[index],
                  isSelected: controller.titleIndex == index ? true : false,
                  isDark: context.isDarkMode,
                );
              }).toList(),
            ),
          ),*/
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List<TitleWidget>.generate(
                      controller.titleList.length, (index) {
                    return TitleWidget(
                      onTap: () => controller.onTitleIndex(index),
                      title: controller.titleList[index],
                      isSelected: controller.titleIndex == index ? true : false,
                      isDark: context.isDarkMode,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Obx(() {
              return controller.titleIndex != 2 &&
                      ConfigController.to.accessConfig.value.filterSwitch
                  ? InkWell(
                      onTap: () => controller.onSelectLeague(),
                      child: ImageView(
                        'assets/images/icon/icon_filter_nor.png',
                        width: 24.w,
                        height: 24.w,
                        color: context.isDarkMode
                            ? Colors.white.withOpacity(0.5)
                            : const Color(0xFF7981A3),
                      ),
                    )
                  : Container();
            }),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<ResultController>();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/oss_util.dart';
import '../widgets/championship_itme_widget.dart';
import 'championship_results_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../widgets/image_view.dart';
import '../widgets/date_widget.dart';
import '../widgets/download_data_widget.dart';
import '../widgets/results_no_data_widget.dart';

class ChampionshipResultsPage extends StatefulWidget {
  final int titleIndex;

  const ChampionshipResultsPage(this.titleIndex, {super.key});

  @override
  State<ChampionshipResultsPage> createState() =>
      _ChampionshipResultsPageState();
}

class _ChampionshipResultsPageState extends State<ChampionshipResultsPage> {
  final controller = Get.find<ChampionshipResultsController>();
  final logic = Get.find<ChampionshipResultsController>().logic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: context.isDarkMode
                ?  BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        OssUtil.getServerPath(
                          'assets/images/icon/head2.png',
                        ),
                      ),
                      fit: BoxFit.cover,
                    ),
                  )
                : const BoxDecoration(
                    color: Color(0xFFF2F2F6),
                  ),
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  color:  context.isDarkMode ? null : Colors.white,
                  child: Column(
                    children: [
                      _date(),
                    ],
                  ),
                ),
                _body(),
              ],
            ),
          ),
          GetBuilder<ChampionshipResultsController>(
            id: "back",
            builder: (controller) {
              return controller.returnToFirst == true
                  ? Positioned(
                      right: 20.w,
                      bottom: 50.h,
                      child: InkWell(
                        onTap: () => controller.scrollToFirstItem(),
                        child: ImageView(
                          context.isDarkMode
                              ? 'assets/images/icon/icon-top-dark.png'
                              : 'assets/images/icon/icon-top-light.png',
                          width: 30.w,
                          height: 30.w,
                        ),
                      ),
                    )
                  : Container();
            },
          )
        ],
      ),
    );
  }

  //日期删选
  Widget _date() {
    return GetBuilder<ChampionshipResultsController>(
      id: "date",
      builder: (controller) {
        return Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 14.w, right: 14.w,bottom: 6.h),
          child: TabBar(
            indicatorColor: Colors.transparent,
            indicator: const BoxDecoration(),
            isScrollable: true,
            dividerHeight: 0,
            labelPadding: EdgeInsets.zero,
            controller: controller.dateTabController,
            onTap: (index) => controller.onDateIndex(index),
            tabs:
                List<DateWidget>.generate(controller.dateList.length, (index) {
              return DateWidget(
                title: controller.dateList[index].date,
                isSelected: controller.dateIndex == index ? true : false,
                isDark: context.isDarkMode,
                titleIndex: widget.titleIndex,
              );
            }).toList(),
          ),
        );
      },
    );
  }

  //列表
  Widget _body() {
    return GetBuilder<ChampionshipResultsController>(
      id: "data",
      builder: (controller) {
        return Expanded(
            child: controller.downloadData == true
                ? const DownloadDataWidget()
                : controller.noData == false
                    ? _item()
                    : const ResultsNoDataWidget());
      },
    );
  }

  //全部赛事
  Widget _item() {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: controller.groupList.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        controller: controller.scrollController,
        itemBuilder: (context, index) {
          return ChampionshipItemWidget(
            index: index,
            isDark: context.isDarkMode,
            onExpandItem: (item) => controller.onExpandItem(item),
            dataItem: controller.groupList[index],
          );
        });
  }
}

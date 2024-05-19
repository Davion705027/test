import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/oss_util.dart';
import '../../../widgets/image_view.dart';
import '../../../widgets/scroll_index_widget.dart';
import '../gaming_results/gaming_results_controller.dart';
import '../widgets/all_events_widget.dart';
import '../widgets/date_widget.dart';
import '../widgets/download_data_widget.dart';
import '../widgets/results_itme_widget.dart';
import '../widgets/results_no_data_widget.dart';
import '../widgets/type_filter_widget.dart';
import 'normal_results_controller.dart';

class NormalResultsPage extends StatefulWidget {
  final int titleIndex;

  const NormalResultsPage(this.titleIndex, {super.key});

  @override
  State<NormalResultsPage> createState() => _NormalResultsPageState();
}

class _NormalResultsPageState extends State<NormalResultsPage> {
  final controller = Get.find<NormalResultsController>();
  final logic = Get.find<NormalResultsController>().logic;

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
                  color:  context.isDarkMode ? null : Colors.white,
                  child: Column(
                    children: [
                      _date(),
                      _typeFilter(),
                    ],
                  ),
                ),
                GetBuilder<NormalResultsController>(
                  id: "data",
                  builder: (controller) {
                    return controller.downloadData == true
                        ? Container()
                        : controller.noData == false
                            ? _allEvents()
                            : Container();
                  },
                ),
                _body(),
              ],
            ),
          ),
          GetBuilder<NormalResultsController>(
            id: "back",
            builder: (controller) {
              return controller.returnToFirst == true
                  ? Positioned(
                      right: 14.w,
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
    return GetBuilder<NormalResultsController>(
      id: "date",
      builder: (controller) {
        return Container(
          margin: EdgeInsets.only(left: 14.w, right: 14.w),
          alignment: Alignment.centerLeft,
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

  //类型筛选
  Widget _typeFilter() {
    return GetBuilder<NormalResultsController>(
      id: "type",
      builder: (controller) {
        return Container(
          height: 60.h,
          width: double.maxFinite,
          margin: EdgeInsets.only(
            left: 14.w,
            right: 14.w,
          ),
          child: Row(
            children: [
              Visibility(
                visible: controller.leftShow,
                child: Expanded(
                  flex: 0,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: TypeFilterWidget(
                      onTap: () => controller
                          .onTypeFilterIndex(controller.typeFilterIndex),
                      title: controller
                          .typeFilterList[controller.typeFilterIndex].name,
                      miid:controller
                          .typeFilterList[controller.typeFilterIndex].miid,  
                      isSelected: controller.typeFilterIndex ==
                              controller.typeFilterIndex
                          ? true
                          : false,
                      isDark: context.isDarkMode,
                      index: controller.typeFilterIndex,
                      titleIndex: widget.titleIndex,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child:ListView.builder(
                  itemCount: controller.typeFilterList.length,
                  scrollDirection: Axis.horizontal,
                  controller: controller.typeScrollController,
                  itemBuilder: (context, index) {
                    return TypeFilterWidget(
                      onTap: () => controller.onTypeFilterIndex(index),
                      miid: controller.typeFilterList[index].miid,
                      title: controller.typeFilterList[index].name,
                      isSelected:
                      controller.typeFilterIndex == index ? true : false,
                      isDark: context.isDarkMode,
                      index: index,
                      titleIndex: widget.titleIndex,
                    );
                  },
                ),
              ),
              Visibility(
                visible: controller.rightShow,
                child: Expanded(
                  flex: 0,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: TypeFilterWidget(
                      onTap: () => controller
                          .onTypeFilterIndex(controller.typeFilterIndex),
                      miid: controller.typeFilterList[controller.typeFilterIndex].miid,
                      title: controller
                          .typeFilterList[controller.typeFilterIndex].name,
                      isSelected: controller.typeFilterIndex ==
                              controller.typeFilterIndex
                          ? true
                          : false,
                      isDark: context.isDarkMode,
                      index: controller.typeFilterIndex,
                      titleIndex: widget.titleIndex,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //列表
  Widget _body() {
    return GetBuilder<NormalResultsController>(
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
  Widget _allEvents() {
    return AllEventsWidget(
      isDark: context.isDarkMode,
      onExpandAll: () => controller.onExpandAll(),
      isExpandAll: controller.isExpandAll,
    );
  }

  //全部赛事
  Widget _item() {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: controller.matcheResultData.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        controller: controller.scrollController,
        itemBuilder: (context, index) {
          TidDataList dataItem = controller.matcheResultData[index];
          return ResultsItemWidget(
            isDark: context.isDarkMode,
            dataItem: dataItem,
            onExpandItem: () => controller.onExpandItem(dataItem),
            onGoToDetails: (item) =>
                controller.onGoToDetails(item, widget.titleIndex),
            index: index,
          );
        });
  }
}

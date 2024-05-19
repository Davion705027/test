import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/widgets/no_data_widget.dart';
import 'package:get/get.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/models/res/get_filter_match_list_new_entity.dart';
import '../../../utils/oss_util.dart';
import '../../../widgets/image_view.dart';
import 'league_filter_controller.dart';
import 'dart:math' as math;
class LeagueFilterPage extends StatefulWidget {
  const LeagueFilterPage({Key? key}) : super(key: key);

  @override
  State<LeagueFilterPage> createState() => _LeagueFilterPageState();
}

class _LeagueFilterPageState extends State<LeagueFilterPage> {
  final controller = Get.find<LeagueFilterController>();
  final logic = Get.find<LeagueFilterController>().logic;

  @override
  Widget build(BuildContext context) {
    double stateHeight = MediaQueryData.fromView(View.of(context)).padding.top;
    // var h = WidgetsBinding.instance!.window.padding.top / WidgetsBinding.instance!.window.devicePixelRatio;
    return SingleChildScrollView(
      padding: EdgeInsets.only(top:stateHeight),
      child: GetBuilder<LeagueFilterController>(
        builder: (controller) {
          return SizedBox(
            height: 650.h,
            child: ClipRRect(
              borderRadius:  BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
              child:Container(
                color: context.isDarkMode ? const Color(0xFF272931)  :  const Color(0xFFF8F9FA),
                child: Column(
                  children: [
                    Container(
                      color: context.isDarkMode ?  const Color(0xFF272931):  Colors.white,
                      child: Column(
                        children: [
                          _title(),
                          _searchBar(),
                          _selectAllBox(),
                        ],
                      ),
                    ),

                    _leagueFilter(),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _title() {
    return Container(
        margin: EdgeInsets.only(
          left: 14.w,
          right: 14.w,
        ),
        height: 62.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Get.back(),
              child: Text(
                LocaleKeys.common_cancel.tr,
                style: TextStyle(
                  color: const Color(0xFF179CFF),
                  fontSize: 17.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(
              LocaleKeys.filter_match_select_title.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color:
                    context.isDarkMode ? Colors.white : const Color(0xFF303442),
                fontSize: 18.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ),
            InkWell(
              onTap: ()=>controller.onFinish(),
              child: Text(
                LocaleKeys.common_finish.tr,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: const Color(0xFF179CFF),
                  fontSize: 17.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ));
  }

  Widget _searchBar() {
    return Container(
      height: 40.h,
      margin: EdgeInsets.only(
        left: 14.w,
        right: 14.w,
      ),
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: context.isDarkMode
            ? Colors.white.withOpacity(0.03999999910593033)
            : const Color(0xFFF2F2F6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
        ),
        alignment: Alignment.center,
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          onChanged: (value)=>controller.debounceSearch(),
          controller: controller.searchController,
          keyboardType: TextInputType.text,
          textAlign: TextAlign.start,
          cursorColor: const Color(0xFF179CFF),
          style: TextStyle(
            color: context.isDarkMode ? Colors.white : Colors.black,
            fontSize: 14.sp,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w400,
          ),
          // onChanged: (c) => controller.onChanges(c),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: LocaleKeys.filter_match_key.tr,
            hintStyle: TextStyle(
              color: context.isDarkMode
                  ? Colors.white.withOpacity(0.20000000298023224)
                  : const Color(0xFFC9CDDB),
              fontSize: 14.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withOpacity(0.0)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withOpacity(0.0)),
            ),
            icon: ImageView(
              "assets/images/icon/icon_fesearch_nor.png",
              height: 22.w,
              width: 22.w,
            ),
            suffixIcon: GestureDetector(
              onTap:()=> controller.onClearSearchText(),
              child: Container(
                alignment: Alignment.centerRight,
                width: 20.w,
                padding: EdgeInsets.only(
                  right: 10.w,
                ),
                child: controller.searchController.text.isNotEmpty ?
                ImageView(
                  "assets/images/icon/league-close-icon.svg",
                  height: 15.w,
                  width: 15.w,

                ):Container(width: 15,),
              ),
            ),
          ),

        ),
      ),
    );
  }

  Widget _selectAllBox() {
    return Container(
      margin: EdgeInsets.only(left: 14.w, right: 25.w, top: 15.h, bottom: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         controller.searchController.text.isNotEmpty &&  controller.renderGroupList.isEmpty ?
          Text(
            LocaleKeys.app_h5_search_search_tips.tr,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: context.isDarkMode ? Colors.white.withOpacity(0.7) : const Color(0xFFAFB3C8),
              fontSize: 14.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ):Container(),
          controller.renderGroupList.isNotEmpty ?
          InkWell(
            onTap: () => controller.onSelectAll(),
            child: Row(
              children: [
                Text(
                  LocaleKeys.common_all_select.tr,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: context.isDarkMode ? Colors.white.withOpacity(0.30000001192092896) : const Color(0xFFAFB3C8),
                    fontSize: 14.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  width: 5.w,
                ),
                ImageView(
                  controller.selectAll == false
                      ? "assets/images/icon/search_unselected.png"
                      : "assets/images/icon/search_selected.png",
                  height: 20.w,
                  width: 20.w,
                )
              ],
            ),
          ):Container(),

        ],
      ),
    );
  }

  Widget _leagueFilter() {
    return
      controller.noData == true ?
      const NoDataWidget() :
      Expanded(
        child: Stack(
          children: [
            ListViewObserver(
              controller: controller.listObserverController,
              child: ListView.builder(
                  controller: controller.autoScrollController,
                  padding: EdgeInsets.zero,
                  itemCount: controller.renderGroupList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    RenderGroupModel currentRenderGroup = controller.renderGroupList[index];
                    // if( currentRenderGroup.list.isEmpty)return Container();
                    return Container(
                      alignment: Alignment.center,
                      margin:  EdgeInsets.only(top: index == 0 ? 0.h:5.h,bottom: index == controller.renderGroupList.length-1 ? 350.h: 0.h ),
                      child: Column(
                        children: [
                          if(!controller.onlyOne)
                            Container(
                              height:48.h,
                              color: context.isDarkMode ?  const Color(0xFF1E2029)  :const Color(0xFFF2F2F6),
                              child: Container(
                                margin:  EdgeInsets.only(left: 14.w,right: 25.w),
                                child: InkWell(
                                  onTap: ()=> controller.onClickItemExpand(currentRenderGroup),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Transform.rotate(
                                            angle: currentRenderGroup.isExpand ? -math.pi/2 : 0,
                                            child: ImageView(
                                              "assets/images/icon/icon_expand_gray_night.png",
                                              height: 16.w,
                                              width: 16.w,
                                            ),
                                          ),
                                          Container(width: 8.w,),
                                          Text(
                                            currentRenderGroup.spell == 'HOT' ? LocaleKeys.search_hot_league.tr : currentRenderGroup.spell,
                                            style: TextStyle(
                                              color: context.isDarkMode ? Colors.grey : const Color(0xFF303442),
                                              fontSize: 14,
                                              fontFamily: 'PingFang SC',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                      InkWell(
                                        onTap: ()=>controller.onSelectGroup(currentRenderGroup),
                                        child: ImageView(
                                          currentRenderGroup.isSelect == false
                                              ? "assets/images/icon/search_unselected.png"
                                              : "assets/images/icon/search_selected.png",
                                          height: 20.w,
                                          width: 20.w,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          currentRenderGroup.isExpand ? Container()
                              : Column(
                            children: generateGroupContainers(currentRenderGroup),
                          ),

                        ],
                      ),
                    );
                  }),
              onObserve: (resultModel) =>
                  controller.onObserves(resultModel.firstChild?.index),
            ),
            _letterDeletion(),
          ],
        ),
      );
  }

  Widget _letterDeletion() {
    return Stack(
      children: [
        Positioned(
          height: double.maxFinite,
          width: 25.w,
          right: 0,
          child: GestureDetector(
            onVerticalDragDown: (DragDownDetails details)=> controller.toOnVerticalDragDown(details),
            onVerticalDragEnd:  (DragEndDetails details)=> controller.toOnVerticalDragEnd(details),
            onVerticalDragUpdate: (DragUpdateDetails details)=> controller.toOnVerticalDragUpdate(details) ,
            child: Container(
              margin: EdgeInsets.only(top: 20.h, ),
              child: Column(
                children:
                List<Widget>.generate(controller.indexList.length, (index) {
                  if (controller.indexList[index] == 'HOT') {
                    return GestureDetector(
                      onTap: () => controller.changeIndex(index),
                      child: Container(
                        alignment: Alignment.center,
                        child: ImageView(
                          controller.currentIndex == index
                              ? "assets/images/icon/icon_hot_not_select.png"
                              : "assets/images/icon/icon_hot_select.png",
                          height: 18.w,
                          width: 18.w,
                        ),
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () => controller.changeIndex(index),
                      child: Container(
                        alignment: Alignment.center,
                        height: 16.w,
                        width: 16.w,
                        decoration:
                        controller.currentIndex == index
                            ? const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        )
                            : null,
                        child: Text(
                          controller.indexList[index],
                          style: TextStyle(
                            color:    controller.currentIndex == index ? Colors.white : const Color(0xFF7981A4),
                            fontSize: 10.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  }
                }),
              ),
            ),
          ),
        ),
        controller.indicator == true ?
        Positioned(
          right: 25.w,
          top: controller.location,
          child: Container(
            width: 58.w,
            height: 48.h,
            alignment: Alignment.center,
            decoration:  BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  OssUtil.getServerPath(
                    "assets/images/icon/bg_sellabel.png",
                  ),
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(right: 10.w, ),
              child: Text(
                controller.indexList[controller.currentIndex].toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ):Container(),
      ],
    );
  }

  // 生成分组UI
 generateGroupContainers(RenderGroupModel currentRenderGroup){
    List<GetFilterMatchListNewData> groupList = currentRenderGroup.list;
   return  List.generate(groupList.length, (index){
     var groupItem = groupList[index];
      return Container(
        height:48.h,
        margin:  EdgeInsets.only(left: 30.w,right: 25.w),
        decoration:
        groupList.length-1 != index ?
        BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withOpacity(0.3), // Set the color of the bottom border
              width: 0.5.w, // Set the width of the bottom border
            ),
          ),
        ): null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                groupItem.picUrlthumb.isNotEmpty ?
                ImageView(
                  groupItem.picUrlthumb,
                  height: 22.w,
                  width: 22.w,
                  cdn: true,
                ) :
                ImageView(
                  'assets/images/league/match_cup.svg',
                  height: 22.w,
                  width: 22.w,
                ),
                Container(width: 10.w,),
                SizedBox(
                  width: 200.w,
                  child: Text(
                    groupItem.nameText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: context.isDarkMode ? Colors.white : const Color(0xFF303442),
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '(${groupItem.num})',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: context.isDarkMode ?Colors.white.withOpacity(0.30000001192092896) : const Color(0xFFAFB3C8) ,
                    fontSize: 14.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(width: 10.w,),
                InkWell(
                  onTap: () => controller.onSelectItem(groupItem),
                  child: ImageView(
                    groupItem.isSelect == false
                        ? "assets/images/icon/search_unselected.png"
                        : "assets/images/icon/search_selected.png",
                    height: 20.w,
                    width: 20.w,
                  ),
                )
              ],
            ),

          ],
        ),
      );
    });

  }

  @override
  void dispose() {
    Get.delete<LeagueFilterController>();
    super.dispose();
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';

import '../../../../../login/login_head_import.dart';
import '../../amalyze_match_data/analyze_match_data_logic.dart';

/**
 * @author[xiongwei]
 * @version[创建日期，2024/2/28 15:32]
 * @function[功能简介 ]
 **/
typedef AnalyzeTabbarListener=Function(int page);
class AnalyzeTabbar extends StatefulWidget {
  List<String> tabs = ["基本面", "盘面", "技术面"];
  AnalyzeTabbarListener analyzeTabbarListener;
  TabController tabController;
  double?  widgetWidth=200.w;
  AnalyzeTabbar(this.tabs,this.analyzeTabbarListener,this.tabController,{Key? key,this.widgetWidth}) : super(key: key);

  @override
  State<AnalyzeTabbar> createState() => MSTabbarAnalyzeDemo1State(this.tabs);
}

class MSTabbarAnalyzeDemo1State extends State<AnalyzeTabbar> {
  List<String> tabs=[];
  MSTabbarAnalyzeDemo1State(this.tabs);
  initTeams( List<String>  tabs){
    this.tabs=tabs;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return   Container(
      height: 50.w,
      width: 1.sw,
      decoration: BoxDecoration(
        color: Get.theme.tabPanelBackgroundColor,

      ),
      child: Center(
        child:  Container(
          height: 50.w,
          width: widget.widgetWidth,
          decoration: BoxDecoration(
            color: Get.theme.tabPanelBackgroundColor,
          ),
          child: Container(
            height: 16.w,
            padding: EdgeInsets.symmetric(horizontal:8.w),
            margin: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.w),
            decoration: BoxDecoration(
                color: Get.theme.betPanelUnderlineColor,
                borderRadius: BorderRadius.all(Radius.circular(8.w))
            ),
            child:TabBar(
              controller: widget.tabController,
              labelColor: Get.theme.analyzeSecondTabPanelSelectedFontColor,
              labelStyle: const TextStyle(
                fontSize: 12,
                height: 16 / 12,
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelColor:Get.theme.analyzeSecondTabPanelUnSelectedFontColor,
              unselectedLabelStyle: const TextStyle(
                fontSize: 12,
                height: 16 / 12,
              ),
              indicatorPadding:EdgeInsets.symmetric(horizontal:getContaineWidth()+5.w,vertical: 1.w),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(8.w),
                color: Get.theme.tabPanelBackgroundColor,

              ),
              tabs: widget.tabs.map((e) {
                return Tab(child:
                Container(
                  constraints: BoxConstraints(maxWidth: 100.w),
                  child: Text(
                    e,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                ),);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
  double getContainePadding(){
    if(widget.tabs.length==4){
      return 8.w;
    }else if(widget.tabs.length==3){
      return 4.w;
    }else if(widget.tabs.length==2){
      return -10.w;
    }
    return 0;
  }
  double getContaineWidth(){
    if(widget.tabs.length==2){
      return -55.w;
    }else if(widget.tabs.length==3){
      return -50.w;
    }else if(widget.tabs.length==4){
      return -41.w;
    }
    return 0;
  }
}

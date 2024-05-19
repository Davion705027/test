import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';

import '../../../../../login/login_head_import.dart';

/**
 * @author[xiongwei]
 * @version[创建日期，2024/2/28 15:32]
 * @function[功能简介 ]
 **/

class AnalyzeTabbarNew extends StatefulWidget {
  List<String> tabs = ["基本面", "盘面", "技术面"];
  Function(int page) analyzeTabbarListener;
  TabController tabController;
  double? widgetWidth = 200.w;
  String? fromTabPage;
  AnalyzeTabbarNew(this.tabs, this.analyzeTabbarListener, this.tabController,
      {Key? key, this.widgetWidth,this.fromTabPage})
      : super(key: key);

  @override
  State<AnalyzeTabbarNew> createState() => MSTabbarDemo1State(tabs);
}

class MSTabbarDemo1State extends State<AnalyzeTabbarNew> {
  List<String> tabs=[];
  MSTabbarDemo1State(this.tabs);
  initTeams( List<String>  tabs){
    this.tabs=tabs;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.w,
      width: 1.sw,
      decoration: BoxDecoration(
        color: Get.theme.tabPanelBackgroundColor,
      ),
      child: Container(
        height: 50.w,
        width: widget.widgetWidth,
        decoration: BoxDecoration(
          color: Get.theme.analsTextTabBgColor,
        ),
        child: Container(
          height: 24.w,
          margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: '#C9CDDB'
                .hexColor
                .withOpacity(0.2), // Get.theme.analsTextTabBgColor,
            borderRadius: BorderRadius.all(Radius.circular(8.w)),
          ),
          child: TabBar(
            controller: widget.tabController,
            labelColor: Get.theme.analsTextTabSelectColor,
            padding: EdgeInsets.zero,
            labelStyle: const TextStyle(
              fontSize: 12,
              height: 16 / 12,
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelColor: Get.theme.analsTextTabUnSelectColor,
            unselectedLabelStyle: const TextStyle(
              fontSize: 12,
              height: 16 / 12,
            ),
            indicatorPadding: EdgeInsets.zero,
            indicator: BoxDecoration(
              // borderRadius: BorderRadius.circular(8.w),
              color: Get.theme.tabPanelBackgroundColor,
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: widget.tabs.map(
                  (e) {
                return Text(
                  e,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }

  double getContaineWidth() {
    if (widget.tabs.length == 2) {
      return -70.w;
    } else if (widget.tabs.length == 3) {
      return -50.w;
    } else if (widget.tabs.length == 4) {
      return -30.w;
    }
    return 0;
  }


}

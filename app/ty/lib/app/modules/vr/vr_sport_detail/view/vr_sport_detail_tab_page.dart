import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../utils/oss_util.dart';
class vrSportDetailTabPageWidget extends GetView<VrSportDetailLogic> {
  @override
  Widget build(BuildContext context) {
    return controller.state.matchDetailList.isEmpty?const SizedBox():Container(
      decoration: context.isDarkMode
          ?  BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            OssUtil.getServerPath(
              'assets/images/home/color_background_skin.png',
            ),
          ),
          fit: BoxFit.cover,
        ),
      )
          : const BoxDecoration(
        // color: Color(0xfff2f2f6),
        color: Colors.white,
      ),
      height: 40.w,
      child: TabBar(
        controller: controller.state.matchTabController,
        indicatorSize: TabBarIndicatorSize.label,
        tabAlignment: TabAlignment.center,
        isScrollable: true,
        dividerHeight: 0,
        labelPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        // indicatorColor: const Color(0xff3E65FF),
        indicator: const CustomTabIndicator(
            width: 45,
            borderSide: BorderSide(width: 3.0, color: Color(0xFF179CFF))),
        tabs: _tabList(context),
      ),
    );
  }

  List<Tab> _tabList(BuildContext context) {
    return controller.state.matchDetailList.asMap().keys.map((index) {
      return Tab(
        child: GetBuilder(
            id: 'bottomPage',
            init: VrSportDetailLogic(),
            builder: (controller) {
          String name = controller.state.matchDetailList[index];
          bool isSelect = controller.state.matchTabController?.index == index;
          double width = MediaQuery.of(context).size.width /
              controller.state.matchDetailList.length;
          return Visibility(
              visible: true,
              child: Container(
                  padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 10),
                  alignment: Alignment.center,
                  width: width,
                  // color: Colors.white,
                  height: 40.w,
                  child: FittedBox(
                    child: Text(
                      name,
                      style: TextStyle(
                          color: isSelect
                              ? context.isDarkMode ?const Color(0xFF127DCC):const Color(0xFF179CFF)
                              : context.isDarkMode ?Colors.white.withOpacity(0.5):const Color(0xFF7981A4),
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                          height: 0.10,
                          fontSize: 14),
                    ),
                  )));
        }),
      );
    }).toList();
  }
}

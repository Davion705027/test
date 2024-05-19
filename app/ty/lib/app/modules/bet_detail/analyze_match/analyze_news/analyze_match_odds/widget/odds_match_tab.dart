import 'package:flutter/widgets.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/analyze_match_odds/analyze_match_odds_logic.dart';

import '../../../../../login/login_head_import.dart';

/**
 * @author[xiongwei]
 * @version[创建日期，2024/2/28 15:32]
 * @function[功能简介 ]
 **/
class OddsMatchTab extends StatefulWidget {
  const OddsMatchTab({Key? key}) : super(key: key);

  @override
  State<OddsMatchTab> createState() => _MSTabbarDemo1State();
}

class _MSTabbarDemo1State extends State<OddsMatchTab> {
  List<String> _tabs = ["让球", "独赢", "大小"];

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<AnalyzeMatchOddsLogic>();
    return   Container(
      height: 40.w,
      color: AppColor.colorWhite,
      padding: const EdgeInsets.only(top: 8),
      child: TabBar(
        controller: logic.tabController,
        padding: EdgeInsets.zero,
        labelPadding: const EdgeInsets.only(bottom: 6),
        labelColor: '#179CFF'.hexColor,
        labelStyle: const TextStyle(
          fontSize: 12,
          height: 16 / 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelColor: '#7981A4'.hexColor,
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          height: 16 / 12,
        ),
        indicator: UnderlineTabIndicator(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(
            width: 2,
            color: '#179CFF'.hexColor,
          ),
        ),
        tabs: _tabs.map((e) {
          return Tab(text: e,);
        }).toList(),
      ),
    );
  }
}

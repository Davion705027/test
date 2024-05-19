/**
 * @Author swifter
 * @Date 2024/3/3 10:18
 */
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../../widgets/RoundedUnderlineTabIndicator.dart';
import '../../../setting_menu/league_filter/manager/league_manager.dart';
import '../../models/main_menu.dart';

class DateTimeMenuWidget extends StatelessWidget {
  const DateTimeMenuWidget({
    super.key,
    required this.menu,
    required this.onDateTimeChanged,
  });

  final MainMenu menu;
  final ValueChanged<int?> onDateTimeChanged;

  @override
  Widget build(BuildContext context) {
    if (!(menu.isEarly || menu.isMatchBet)) return const SizedBox();
    final List<Map<String, dynamic>> dateTimeMap = [];
    // 如果是早盘，显示全部和今日起的后七天数据
    if (menu.isEarly) {
      dateTimeMap.add({'title': LocaleKeys.app_h5_match_all.tr, 'val': null});
    } else {
      // 如果是滚球，显示今日和今日起的后七天数据（H5逻辑是这样的）
      dateTimeMap.add({'title': LocaleKeys.menu_itme_name_today.tr, 'val': 0});
    }

    /// 当前日期的中午12点时间
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime(now.year, now.month, now.day, 12, 0, 0);
    int length = 8;
    for (int i = 0; i < length; i++) {
      dateTime = dateTime.add(const Duration(days: 1));
      if (i == length - 1) {
        dateTimeMap.add({
          'title': LocaleKeys.list_other.tr,
          'val': -dateTime.millisecondsSinceEpoch
        });
      } else {
        dateTimeMap.add({
          'title':
              '${dateTime.month.toString().padLeft(2, '0')}/${dateTime.day}',
          'val': dateTime.millisecondsSinceEpoch
        });
      }
    }
    return DefaultTabController(
      length: 9,
      key: ValueKey('${menu.mi}'),
      child: Container(
        height: 23.h,
        alignment: Alignment.centerLeft,
        child: TabBar(
          isScrollable: true,
          onTap: (index) {
            onDateTimeChanged(dateTimeMap[index]['val']);
            //更新联赛筛选时间戳
            LeagueManager.md = dateTimeMap[index]['val'].toString();
          },
          padding: EdgeInsets.zero,
          indicator: RoundedUnderlineTabIndicator(
            color: const Color(0xFF127DCC),
            radius: 4.0,
          ),
          indicatorSize: TabBarIndicatorSize.label, // 设置下
          labelColor: const Color(0xFF127DCC),
          unselectedLabelColor: context.isDarkMode
              ? Colors.white.withAlpha(50)
              : const Color(0xFF7981A4),
          unselectedLabelStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            fontFamily: 'PingFang SC',
          ),
          labelStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'PingFang SC',
          ),
          tabs: dateTimeMap.map((e) => Tab(text: e['title'])).toList(),
        ),
      ).marginOnly(bottom: 2.h),
    );
  }
}

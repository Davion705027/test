import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';

import '../../../../../db/app_cache.dart';
import '../../../../../db/csid_title.dart';
import '../../../../../utils/widget_utils.dart';
import '../../../controllers/home_controller.dart';
import '../../../controllers/secondary_expand_controller.dart';

///全场独赢 .......联赛标题下的赔率类型
class BetTitleGroupWidget extends StatefulWidget {
  const BetTitleGroupWidget(
      {super.key, required this.hps, required this.matchEntity});

  final MatchEntity matchEntity;
  final List<MatchHps> hps;

  @override
  State<BetTitleGroupWidget> createState() => _BetTitleGroupWidgetState();
}

class _BetTitleGroupWidgetState extends State<BetTitleGroupWidget> {
  late PageController pageController;
  int _currentPage = 0;

  @override
  void initState() {
    setState(() {
      _currentPage =SecondaryController.index;
    });
    pageController = PageController(initialPage: _currentPage,
        keepPage: true, viewportFraction: 1);
    super.initState();

    WidgetUtils.instance().stream.listen((event) {
      if (mounted) {
        setState(() {
          _currentPage = event;
        });
        pageController.animateToPage(_currentPage, duration: const Duration(milliseconds: 300), curve: Curves.ease);
      }
    });

  }

  @override
  void dispose() {
    //Bus.getInstance().off(EventType.changeBetType);
    pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // List<String> titles = widget.hps
    //     .map((e) => e.hpn)
    //     .toList()
    //     .where((element) => element.isNotEmpty)
    //     .toList();
    // if (titles.isEmpty || titles.join().isEmpty) {
    //   titles.addAll([
    //     '全场赌赢',
    //     '全场让球',
    //     '全场大小',
    //   ]);
    // }
    List<String> titles = [];

    int csidTitleCount = csidTitleCountMap[widget.matchEntity.csid] ?? 0;
    if (csidTitleCount > 0) {
      for (int i = 0; i < csidTitleCount; i++) {
        titles.add('list_title_${widget.matchEntity.csid}_title_$i'.tr);
      }
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(right: 8.w),
          alignment: Alignment.centerRight,
          child: SizedBox(
            height: 20.h,
            width: 184.w,
            child: PageView(
              /// 禁止手动滑动
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              pageSnapping: false,
              /// 将titles 三个分为一组
              children: titles.length > 2
                  ? List.generate((titles.length / 3).ceil(), (index) {
                      return _buildTitle(titles.sublist(
                          index * 3, min(titles.length, (index + 1) * 3)));
                    })
                  : [_buildTitle(titles)],
            ),
          ),
        ),
      ],
    );
  }

  _buildTitle(List<String> titles) {
    return SizedBox(
      height: 18.h,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 60.w,
            alignment: Alignment.center,
            child: Text(
              titles[index],
              overflow: TextOverflow.ellipsis,
              // minFontSize: 5,
              style: TextStyle(
                fontSize: 10.sp,
                color: context.isDarkMode
                    ?  const Color(0xE5FFFFFF)
                    : const Color(0xff303442),
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 2.w,
          );
        },
        itemCount: titles.length,
      ),
    );
  }
}

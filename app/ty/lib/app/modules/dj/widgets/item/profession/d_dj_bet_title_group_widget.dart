import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/services/models/res/dj_list_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';

class DJBetTitleGroupWidget extends StatefulWidget {
  const DJBetTitleGroupWidget({super.key, required this.hps});
  final List<MatchHps> hps;

  @override
  State<DJBetTitleGroupWidget> createState() => _DJBetTitleGroupWidgetState();
}

class _DJBetTitleGroupWidgetState extends State<DJBetTitleGroupWidget> {
  late PageController pageController;

  @override
  void initState() {
    pageController =
        PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> titles = widget.hps.map((e) => e.hpn).toList();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(
          height: 1,
          color: Color(0xffE4E6ED),
        ),
        Container(
          height: 18.h,
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 184.w,
            child: PageView(
              /// 禁止手动滑动
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              pageSnapping: false,

              /// 将titles 三个分为一组
              children: List.generate((titles.length / 3).ceil(), (index) {
                return _buildTitle(titles.sublist(index * 3, (index + 1) * 3));
              }),
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
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 60.w,
            alignment: Alignment.center,
            child: Text(
              titles[index],
              style: TextStyle(
                fontSize: 10.sp,
                color: const Color(0xff303442),
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

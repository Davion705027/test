import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/odds_button.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../../../utils/bus/bus.dart';
import '../../../../../utils/bus/event_enum.dart';

class OddGroupWidget extends StatefulWidget {

  final MatchEntity matchEntity;
  // List<DjListHps> hps;
  OddGroupWidget({super.key,required this.matchEntity});

  @override
  State<OddGroupWidget> createState() => _OddGroupWidgetState();
}

class _OddGroupWidgetState extends State<OddGroupWidget> {
  late PageController pageController;
  int _currentPage = 0;
  @override
  void initState() {
    pageController = PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
    Bus.getInstance().on(EventType.changeBetType, (index) {
      pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
    });
    super.initState();
  }

  @override
  void dispose() {
    //Bus.getInstance().off(EventType.changeBetType);
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<MatchHps> matchHpsList = widget.matchEntity.hps;
    // 三个一组
    int lenght = (matchHpsList.length / 3).ceil();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 184.w,
          height: 68.h,
          child: PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                Bus.getInstance().emit(EventType.changeBetType, index);
                _currentPage = index;
              });
            },
            children: List.generate(lenght, (index) {
              List<MatchHps> groupList =  matchHpsList.getRange(index*3, (index+1)*3).toList();
              return _buildOddGroup(groupList);
            }),
          ),
        ),
      /*  if(lenght > 1) Container(
          height: 10.h,
          alignment: Alignment.center,
          child: Row(
            children: [
              Container(
                height: 2.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.h),
                  color:  _currentPage == 0 ?  const Color(0xff179CFF) : const Color(0xff179CFF).withOpacity(0.4),
                ),
                width: _currentPage == 0 ? 6.w : 4.w,
              ),
              SizedBox(width: 2.w,),
              Container(
                height: 2.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.h),
                  color:  _currentPage == 1 ?  const Color(0xff179CFF) : const Color(0xff179CFF).withOpacity(0.4),
                ),
                width: _currentPage == 1 ? 6.w : 4.w,
              ),
            ],
          ),
        ),*/
      ],
    );
  }
  Widget _buildOddGroup( List<MatchHps> groupList) {
    List<Widget> widgets = [];
    for (int i = 0; i < 3; i++) {
      MatchHps element = groupList[i];
      List<MatchHpsHlOl> ol = [];
      // Get.log('element.hl[0].ol ${element.hl[0].ol}');
      int count = 2;//需要占位数
      int default_num = 2;//最大行数
      if(element!=null
          && element.hl!=null
          && element.hl[0]!=null
          && element.hl[0].ol!=null
          && element.hl[0].ol.isNotEmpty){
        ol = element.hl[0].ol;
        count = default_num-ol.length;
      }
      if(count > 0){//占位
        for (int j = 0; j < count; j++) {
          var fakeOl = MatchHpsHlOl();
          ol.add(fakeOl);
        }
      }
      widgets.add(_buildOdds(element,ol),);
    }
    // groupList.forEach((element) {
    //   List<MatchHpsHlOl> ol = element.hl[0].ol;
    //   widgets.add(_buildOdds( element,ol),);
    // });
    return SizedBox(
      width: 184.w,
      height: 33.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widgets
      ),
    );
  }

  Widget _buildOdds(MatchHps hps,List<MatchHpsHlOl> list) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: list
          .map((e) =>
          // OddButton(height: list.length > 2 ? 32.h : 49.h, width: 60.w,
          //   matchEntity: widget.matchEntity,hps: hps,odd_item: e,)
      OddsButton(
          betType: OddsBetType.esport,
          height: list.length > 2 ? 33.h : 33.h,
          width: 60.w,
          match: widget.matchEntity,
          hps: hps,
          ol: e,
          // name: e.ott + e.on,
          hl: hps.hl.safeFirst,
          radius:2.0)
      )
          .toList(),
    );
  }
}

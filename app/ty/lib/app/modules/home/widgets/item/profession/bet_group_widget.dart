import 'dart:math';

import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/logic/other_player_name_to_playid.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/widget_utils.dart';

import '../../../../match_detail/widgets/container/odds_info/odds_button.dart';
import '../../../controllers/secondary_expand_controller.dart';

/*
* 赛事列表 基本item
* */
class BetGroupWidget extends StatefulWidget {
  const BetGroupWidget(
      {super.key,
      required this.matchEntity,
      required this.hps,
      required this.isMainPlay,
      this.playId = ''});

  final bool isMainPlay;
  final MatchEntity matchEntity;
  final List<MatchHps> hps;
  final String playId;

  /// 15分钟玩法 1007  罚牌 1003

  @override
  State<BetGroupWidget> createState() => _BetGroupWidgetState();
}

class _BetGroupWidgetState extends State<BetGroupWidget> {
  late PageController pageController;
  int _currentPage = 0;

  @override
  void initState() {
    pageController = PageController(
        initialPage: (widget.hps.length / 3).ceil() >= 2
            ? SecondaryController.index
            : 0,
        keepPage: true,
        viewportFraction: 1);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        setState(() {
          _currentPage = SecondaryController.index;
        });
        pageController.jumpToPage(SecondaryController.index);
      }
    });

    super.initState();

    WidgetUtils.instance().stream.listen((event) {

      if (mounted) {
        setState(() {
          _currentPage = event;
        });
        pageController.animateToPage(event,
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
      }

    });
  }

  @override
  void didUpdateWidget(covariant BetGroupWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    pageController.dispose();
    // WidgetUtils.instance().streamController?.close();
    super.dispose();
  }

  ///15分钟 数据排序

  List<MatchHps> minutesListAll = [];

  @override
  Widget build(BuildContext context) {
    List<MatchHps> matchHpsList = widget.hps;

    if (matchHpsList.isEmpty) {
      matchHpsList.addAll([
        MatchHps(),
        MatchHps(),
        MatchHps(),
      ]);
    }else if (matchHpsList.length<3&&!widget.isMainPlay){
      for(var i = matchHpsList.length; i< 3; i ++){
        matchHpsList.addAll([
          MatchHps(),
        ]);
      }
    }
    // 三个一组
    int length = (matchHpsList.length / 3).ceil();
    /*
    * 15分钟滑动列表排序
    * */
    if (length >= 2 && widget.playId == playIdConfig.hps15Minutes&&!widget.isMainPlay) {
      if (minutesListAll.isNotEmpty) {
        minutesListAll.clear();
      }
       minutesListAll = List.from(matchHpsList)..sort((a, b) =>  a.hSpecial.compareTo(b.hSpecial));
    }


    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 184.w,
                height: _isThree() ? 100.h : 66.h,
                child: PageView(
                  controller: pageController,
                  onPageChanged: (index) async {
                    setState(() {
                      if (SecondaryController.index != index) {
                        if (length >= 2) {
                          SecondaryController.setIndex(index);
                          WidgetUtils.instance()
                              .streamController
                              ?.sink
                              .add(index);
                        }
                      }
                    });
                  },
                  children: length >= 2
                    ?   widget.playId == playIdConfig.hps15Minutes
                          ? List.generate(length, (index) {
                              List<MatchHps> groupList = minutesListAll
                                  .getRange(
                                      index * 3,
                                      min((index + 1) * 3,
                                          minutesListAll.length))
                                  .toList();
                              if (groupList.length < 2) {
                                for (int i = 0; i < 2; i++) {
                                  groupList.add(MatchHps());
                                }
                              }

                              return _buildOddGroup(groupList);
                            })
                          : List.generate(length, (index) {
                              List<MatchHps> groupList = matchHpsList
                                  .getRange(index * 3,
                                      min((index + 1) * 3, matchHpsList.length))
                                  .toList();
                              // addlist(groupList);
                              return _buildOddGroup(groupList);
                            })
                      : [_buildOddGroup(matchHpsList)],
                ),
              ),
              if (length > 1)
                Container(
                  height: 10.h,
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Container(
                        height: 2.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.h),
                          color: _currentPage == 0
                              ? context.isDarkMode
                                  ? AppColor.itemSelectColor
                                  : const Color(0xff179CFF)
                              : context.isDarkMode
                                  ? AppColor.itemNomSelectColor
                                  : const Color(0xff179CFF).withOpacity(0.4),
                        ),
                        width: _currentPage == 0 ? 6.w : 4.w,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Container(
                        height: 2.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.h),
                          color: _currentPage == 1
                              ? context.isDarkMode
                                  ? AppColor.itemSelectColor
                                  : const Color(0xff179CFF)
                              : context.isDarkMode
                                  ? AppColor.itemNomSelectColor
                                  : const Color(0xff179CFF).withOpacity(0.4),
                        ),
                        width: _currentPage == 1 ? 6.w : 4.w,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        if (length > 1 && HomeController.to.visiable)
          Positioned(
            right: 0,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: ImageView(
                _currentPage == 0
                    ? 'assets/images/detail/ico_arrow_left.gif'
                    : 'assets/images/detail/ico_arrow_right.gif',
                width: 16.w,
                height: 16.h,
              ),
            ),
          )
      ],
    ).marginOnly(bottom: !widget.isMainPlay? 5.h:0);
  }

  /// 是否有全场独赢的玩法
  bool _isThree() {
    return [1, 4, 11, 16].contains(int.tryParse(widget.matchEntity.csid));
    // bool isThree = false;
    // for (var element in widget.hps) {
    //   if (element.chpid == '1') {
    //     isThree = true;
    //   }
    // }
    // return isThree;
  }

  Widget _buildOddGroup(List<MatchHps> groupList) {
    // Get.log('groupList ${groupList.length}');
    List<Widget> widgets = [];
    for (int i = 0; i < groupList.length; i++) {
      MatchHps element = groupList[i];
      List<MatchHpsHlOl> ols = element.hl.safeFirst?.ol ?? [];
      double height = 32.h;
      if (_isThree()) {
        if (ols.length > 2) {
          height = 32.h;
        } else {
          height = 49.h;
        }
      } else {
        height = 32.h;
      }
      widgets.add(
        _buildOdds(element, ols, height, i == 0),
      );
    }

    return SizedBox(
      width: 184.w,
      height: _isThree() ? 100.h : 66.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widgets,
      ),
    );
  }

  // name = index == 0 ? LocaleKeys.ouzhou_bet_col_bet_col_1_bet_col_1.tr
  //     : LocaleKeys.ouzhou_bet_col_bet_col_1_bet_col_2.tr;
  Widget _buildOdds(
      MatchHps hps, List<MatchHpsHlOl> list, double height, bool isFirst) {
    //_isThree的第一项为3行
    int length = list.isEmpty
        ? (['1', '17'].contains(hps.chpid) || (_isThree() && isFirst) ? 3 : 2)
        : list.length;
    return SizedBox(
      width: 60.w,
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) {
          return 2.verticalSpace;
        },
        itemCount: length,
        itemBuilder: (BuildContext context, int index) {
          MatchHpsHlOl? ol = list.safe(index);
          double height = 32.h;
          if (_isThree()) {
            if (length > 2) {
              height = 32.h;
            } else {
              height = 49.h;
            }
          } else {
            height = 32.h;
          }
          if (ol == null) {
            return Container(
              width: 60.w,
              height: height,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Get.theme.oddsButtonBackgroundColor,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                "-",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Get.theme.oddsButtonNameFontColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          }
          return Container(
              decoration: const BoxDecoration(
              boxShadow:  [
              BoxShadow(
              color: Color(0x0A000000),
          blurRadius: 6,
          offset: Offset(0, 2),
          spreadRadius: 0,
          )]),
          child:OddsButton(
              key: ValueKey(widget.matchEntity.mid + widget.playId + ol.oid),
              isDetail: false,
              height: height,
              width: 60.w,
              match: widget.matchEntity,
              playId: widget.playId,
              hps: hps,
              ol: ol,
              radius: 4.w,
              secondaryPaly: !widget.isMainPlay,
              hl: hps.hl.safeFirst));
        },
      ),
    );
  }
}

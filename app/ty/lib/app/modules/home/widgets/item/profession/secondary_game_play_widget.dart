import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';

import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/global/user_controller.dart';
import 'package:flutter_ty_app/app/modules/home/logic/other_player_name_to_playid.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/secodary_build_body_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/api/match_api.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../controllers/secondary_expand_controller.dart';
import '../../../models/play_info.dart';

///角球', '15分钟', '波胆', '特色组合', '罚牌
class SecondayGamePlayWidget extends StatefulWidget {
  const SecondayGamePlayWidget({super.key, required this.matchEntity});

  final MatchEntity matchEntity;

  @override
  State<SecondayGamePlayWidget> createState() => _SecondayGamePlayWidgetState();
}

class _SecondayGamePlayWidgetState extends State<SecondayGamePlayWidget> {
  PlayInfo _playInfo = PlayInfo(
    title: '',
    playId: '',
    pids: '',
  );
  late final ScrollController scrollController = ScrollController();

  final GlobalKey _menuItemKey = GlobalKey();//获取计算弹框位置
  ///展开还是收起
  bool isSelect = false;
  bool isMoreSelect = false; //更多组合
  List listPlaysTitle = [];
  late MatchEntity match;
  List<PlayInfo> plays = []; //['角球', '15分钟', '波胆', '特色组合', '罚牌'];
  Map map = {};
  String mid = "";
  @override
  void initState() {
    match = widget.matchEntity;
    super.initState();
    ///UI刷新 初始化数据
    Map? savedMap = SecondaryController.map;
    Map? map = savedMap[match.mid];
    setState(() {
      if (map?["playInfo"] != null) {
        _playInfo = map?['playInfo'];
        mid = map?['mid'];
        isSelect = map?['isSelect'] == 1;
        isMoreSelect = map?['isSelect'] == 2;
      }

    });


  }

  @override
  Widget build(BuildContext context) {
    plays.clear();
    match = widget.matchEntity;
    /// 角球1001 加时赛1002 罚牌1003 点球大赛1004 晋级1005 冠军1006 15分钟 1007 波胆 1008 特色组合 1010
    if (match.cosCorner) {
      PlayInfo playInfo = PlayInfo(
        title: LocaleKeys.football_playing_way_corner.tr,
        playId: playIdConfig.hpsCorner,
        pids: '-111,113,-114,-119,-121,-122',
      );
      plays.add(playInfo);
    }

    if (match.cos15Minutes) {
      plays.add(PlayInfo(
          title: LocaleKeys.football_playing_way_hps15Minutes.tr,
          playId: playIdConfig.hps15Minutes,
          pids: '32,33,34,231,232,233'));
    }

    if (match.cosBold) {
      plays.add(PlayInfo(
        title: LocaleKeys.football_playing_way_hpsBold.tr,
        playId: playIdConfig.hpsBold,
        pids: '7',
      ));
    }
    if (match.compose) {
      plays.add(PlayInfo(
        title: LocaleKeys.football_playing_way_feature.tr,
        playId: playIdConfig.hpsCompose,
        pids: "13,101,345,105",
      ));
    }
    if (match.cosPunish) {
      plays.add(PlayInfo(
        title: LocaleKeys.football_playing_way_penalty_cards.tr,
        playId: playIdConfig.hpsPunish,
        pids: '310,306,307,311,308,309',
      ));
    }

    if (match.cosPromotion) {
      plays.add(PlayInfo(
        title: LocaleKeys.football_playing_way_promotion.tr,
        playId: playIdConfig.hpsPromotion,
        pids: '-135,-136',
      ));
    }
    if (match.cosOutright) {
      plays.add(PlayInfo(
        title: LocaleKeys.ouzhou_match_outrights.tr,
        playId: playIdConfig.hpsOutright,
        pids: '136',
      ));
    }
    if (match.cosOvertime) {
      plays.add(PlayInfo(
        title: LocaleKeys.football_playing_way_overtime.tr,
        playId: playIdConfig.hpsOvertime,
        pids: '-126,-128,-127,-129,-130,-332',
      ));
    }
    if (match.cosPenalty) {
      plays.add(PlayInfo(
        title: LocaleKeys.football_playing_way_penalty_shootout.tr,
        playId: playIdConfig.hpsPenalty,
        pids: '-333,-334,-335',
      ));
    }

    if (plays.isEmpty) return const SizedBox();

    return GestureDetector(
      onTap: () {},
      behavior: HitTestBehavior.translucent,
      child: Column(children: [
        _buildHeader(match, plays),
        buildBodyWidget(
          match: match,
          playInfo: _playInfo,
          isMoreSelect: isMoreSelect,
          isSelect: isSelect,
          mid: mid,
        )
      ]),
    );
  }
  double x = 0; //点击位置
  double y = 0; //点击位置
  int moreleng = 5;///显示几个子玩法加载更多
  Widget _buildHeader(MatchEntity match, List<PlayInfo> plays) {
    return Container(
      height: 28.h,
      padding: EdgeInsets.symmetric(vertical: 2.h),
      margin: EdgeInsets.only(bottom: 6.h, top: 0.h),
      alignment: Alignment.centerLeft,
      child:  ListView.separated(
          scrollDirection: Axis.horizontal,
          controller: scrollController,
          itemBuilder: (context, index) {
            PlayInfo playInfo = plays[index];
            return index < moreleng
                ? _ItemWidget(
                    title: plays[index].title,
                    isSelected:
                        (playInfo.playId == _playInfo.playId && isSelect),
                    onTap: () async {
                      double itemW = 80.w;
                      scrollController.animateTo(
                        (index * itemW) - (Get.width - itemW) * 0.5,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );

                      if (playInfo.playId != _playInfo.playId) {
                        setState(() {
                          if (_playInfo.playId == playInfo.playId) {
                            isSelect = !isSelect;
                          } else {
                            isSelect = true;
                          }
                          _playInfo = playInfo;
                          Map<String, dynamic> map = {
                            "playInfo": _playInfo,
                            "isSelect": isSelect ? 1 : 0,
                            "mid": match.mid,
                            "tag": _playInfo.playId,
                          };
                          ///存到SecondaryMatchManager
                          Map savedMap = SecondaryController.map;
                          savedMap[match.mid] = map;

                          ///关闭更多
                          if (isMoreSelect) {
                            isMoreSelect = false;
                          }
                        });
                          /**
                          * 加载对应的子玩法数据
                          * */
                        getMatchBaseInfo(match,_playInfo);
                      } else {

                        ///再次点击 取消选中相关玩法
                        setState(() {
                          isSelect = !isSelect;
                          _playInfo = PlayInfo(title: '', playId: '', pids: '');
                          Map<String, dynamic> map = {
                            "playInfo": _playInfo,
                            "isSelect": isSelect ? 1 : 0,
                            "mid": "",
                            "tag":'',
                          };
                          Map savedMap = SecondaryController.map ?? {};
                          savedMap[match.mid] = map;


                        });
                      }
                    },
                  )
                : Container(
                    key: _menuItemKey,
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    height: 28.h,
                    child: InkWell(
                      onTapDown: (details) {
                        x = details.globalPosition.dx;
                        y = details.globalPosition.dy;
                        showMoreItem(context, plays, details.globalPosition);
                      },
                      child: Row(
                        children: [
                          if (isMoreSelect == false)
                            Icon(
                              Icons.add,
                              size: 8.w,
                              color: const Color(0xffC9CDDB),
                            ),
                          Text(
                            _playInfo.title.isNotEmpty && isMoreSelect
                                ? _playInfo.title
                                : LocaleKeys.app_more_play.tr,
                            maxLines: 1,
                            style: TextStyle(
                              overflow: TextOverflow.clip,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: isMoreSelect
                                  ? const Color(0xff3AA6FC)
                                  : context.isDarkMode
                                      ? Colors.white
                                          .withOpacity(0.8999999761581421)
                                      : const Color(0xff949AB6),
                            ),
                          ),
                          SizedBox(
                            width: 5.h,
                          ),
                          if (isMoreSelect)
                            Icon(
                              Icons.keyboard_arrow_up,
                              size: 10.w,
                              color: const Color(0xff3AA6FC),
                            ),
                        ],
                      ),
                    ));
          },
          separatorBuilder: (context, index) {
            return SizedBox(width: 4.w);
          },
          itemCount: plays.length > moreleng ? moreleng + 1 : plays.length,
      ),
    );
  }

  String moreSelectTitle = "";

  ///选中标题
  Future showMoreItem(BuildContext context, List<PlayInfo> plays, details) {
    List<PlayInfo> morePlays = plays.sublist(moreleng, plays.length);

    ///计算对应点击位置 弹窗
    final RenderBox button =
        _menuItemKey!.currentContext!.findRenderObject() as RenderBox;
    var leftoffset = button.localToGlobal(Offset.zero);
    var topoffset = button.localToGlobal(Offset(0, button.size.height));

    return showMenu(
      constraints: const BoxConstraints(
          minHeight: 30, maxHeight: 100, minWidth: 60, maxWidth: 65),
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      position: RelativeRect.fromLTRB(
          leftoffset.dx,
          topoffset.dy - 15.h - (25 * (morePlays.length + 1)),
          MediaQuery.of(context).size.width,
          0),
      // 菜单栏位置
      items: List.generate(
          morePlays.length,
          (index) => PopupMenuItem(
                height: 25.h,
                padding: EdgeInsets.only(left: 8.h),
                value: index,
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        textAlign: TextAlign.start,
                        morePlays[index].title,
                        style: TextStyle(
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w500,
                          color: isMoreSelect &&
                                  _playInfo.playId == morePlays[index].playId
                              ? (context.isDarkMode
                                  ? Colors.white
                                  : Colors.black)
                              : context.isDarkMode
                                  ? const Color(0xffAFB3C8)
                                  : Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Visibility(
                      visible: isMoreSelect &&
                          _playInfo.playId == morePlays[index].playId,
                      child: Icon(
                        Icons.check,
                        size: 12,
                        color: context.isDarkMode ? Colors.white : Colors.black,
                      ),
                    )
                  ],
                ),
              )),
      elevation: 5.0,
    ).then((value) async {
      // 处理选项菜单返回的值
      if (value != null) {
        ///更多
        setState(() {
          _playInfo = morePlays[value!];
          moreSelectTitle = morePlays[value!].title;
          if (isSelect) {
            isSelect = false;
          }
          isMoreSelect = true;
        ///存取_playInfo
          Map<String, dynamic> map = {
            "playInfo": _playInfo,
            "isSelect": isMoreSelect ? 2 : 0,
            "mid": match.mid,
            "tag":_playInfo.playId,
          };
          Map savedMap = SecondaryController.map ?? {};
          savedMap[match.mid] = map;
        });
        /**
         * 加载对应的子玩法数据
         * */
        getMatchBaseInfo(match,_playInfo);
      }
    });
  }
}

getMatchBaseInfo(MatchEntity match,PlayInfo _playInfo) async {
  try {
    final res = await MatchApi.instance().getMatchBaseInfo(
        match.mid,
        UserController.to.getUid(),
        1,
        null,
        'v2_h5_st',
        _playInfo.pids,
        'is-user',
        _playInfo.playId.toInt(),
        /* "0",
              null,
              0,*/
        [{"mid":match.mid,"playId":  _playInfo.playId.toInt()}]
    );
    if (res.success && res.data != null && res.data!.isNotEmpty) {
      DataStoreController.to.updateMatch(res.data!.first);
    }
  } catch (e) {
    Get.log('getMatchBaseInfo error: $e');
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget(
      {super.key,
      required this.title,
      required this.isSelected,
      required this.onTap});

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        //constraints: BoxConstraints(maxWidth: 50.h, minWidth: 40.h),
        padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? Colors.white.withOpacity(0.03999999910593033)
              : Colors.white,
          borderRadius: BorderRadius.circular(4.r),
          border: isSelected
              ? Border.all(
                  color: const Color(0xff3AA6FC),
                  width: 1.w,
                )
              : Border.all(
                  color: Colors.transparent,
                  width: 1.w,
                ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              maxLines: 1,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? const Color(0xff3AA6FC)
                    : context.isDarkMode
                        ? const Color(0xffe5ffffff)
                        : const Color(0xff303442),
              ),
            ).marginSymmetric(horizontal: 5.w),
            Icon(
                isSelected
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                size: 10.w,
                color: isSelected
                    ? const Color(0xff3AA6FC)
                    : const Color(0xff949AB6)),
          ],
        ),
      ),
    );
  }
}

import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/home/logic/other_player_name_to_playid.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/score_list.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/team_score_widget.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import '../../../../../services/models/res/event_info_entity.dart';
import '../../../../../utils/format_score_util.dart';
import '../../../../../utils/widget_utils.dart';
import '../../../controllers/home_controller.dart';
import '../../../controllers/secondary_expand_controller.dart';
import '../flag_widget.dart';
import 'bet_group_widget.dart';

///赛事信息
/// 主玩法，角球玩法，15分钟玩法
class CornerPlayTemp extends StatefulWidget {
  CornerPlayTemp(
      {super.key,
      required this.match,
      required this.hps,
      this.isMainPlay = true,
      this.playId = ''});

  final MatchEntity match;
  final List<MatchHps> hps;
  final bool isMainPlay;
  final String playId;

  @override
  State<CornerPlayTemp> createState() => _CornerPlayTempState();
}

class _CornerPlayTempState extends State<CornerPlayTemp>
    with SingleTickerProviderStateMixin {
  // 计算15分钟 比分参数
  String hSpecial = "0";
  String minutesTitle = '';
  String language = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {


        ///更新15分钟提示
        if(!widget.isMainPlay&&widget.playId==playIdConfig.hps15Minutes){
          uptitle(SecondaryController.index);
        }
        language = StringKV.language.get() ?? "CN";
      }
    });
    WidgetUtils.instance().stream.listen((event) {
      if (mounted) {
        if(!widget.isMainPlay&&widget.playId==playIdConfig.hps15Minutes){
          uptitle(SecondaryController.index);
        }
      }
    });
    super.initState();
  }

  // 是否显示伤停补时动画
  bool isShowMststi = false;

  // 是否显示主队红牌动画
  bool isShowHomeRed = false;

  // 是否显示客队红牌动画
  bool isShowAwayRed = false;

  // 是否显示主队进球动画
  bool isShowHomeGoal = false;

  // 是否显示客队进球动画
  bool isShowAwayGoal = false;

  // 是否显示主队var动画
  bool showHomeVar = false;

  // 是否显示客队var动画
  bool showWayVar = false;

  String hit = "";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CornerPlayTemp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.match.mid == oldWidget.match.mid &&
        [1].contains(int.parse(widget.match.csid))&&HomeController.to.visiable) {
      if (!widget.isMainPlay&&widget.playId == playIdConfig.hps15Minutes) {
        int difference = (int.parse(widget.match.mst) / 60).floor();
        int residue = (difference / 15).floor();
        int olddifference = (int.parse(oldWidget.match.mst) / 60).floor();
        int oldresidue = (olddifference / 15).floor();
        if (residue != oldresidue) {
          uptitle(SecondaryController.index);
        }
      }
      ShowGoalAnimation(
        oldWidget.match,
        widget.match,
      );
      ShowGoalAnimation(
        oldWidget.match,
        widget.match,
      );
      ShowRedAnimation(
        oldWidget.match,
        widget.match,
      );
      ShowRedAnimation(
        oldWidget.match,
        widget.match,
      );
      // ShowMststiAnimation(oldWidget.match, widget.match);
      ShowHitAnimation(oldWidget.match, widget.match);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// 15分钟玩法 1007  罚牌 1003  点球大战
    bool hasRule = widget.playId == playIdConfig.hps15Minutes ||
        widget.playId == playIdConfig.hpsPunish ||
        widget.playId == playIdConfig.hpsPenalty;

    return Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: () {
                        // _isThree() ? 110.h : 90.h;
                        if (_isThree()) {
                          // 显示三行还有详细比分显示时 增加高度
                          return widget.isMainPlay
                              ? _showScoreMatchLine(widget.match)
                                  ? 125.h
                                  : 110.h
                              : !hasRule
                                  ? 92.h
                                  : 110.h;
                        } else {
                          return widget.isMainPlay
                              ? 95.h
                              : !hasRule
                                  ? 72.h
                                  : 100.h;
                        }
                      }(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TeamScoreWidget(
                              hint: hit,
                              isShowGoal: isShowHomeGoal,
                              isShowRed: isShowHomeRed,
                              isShowMststi: isShowMststi,
                              isMainPlay: widget.isMainPlay,
                              matchEntity: widget.match,
                              index: 0,
                              playId: widget.playId,
                              hSpecial: hSpecial),
                          2.verticalSpace,
                          TeamScoreWidget(
                              hint: hit,
                              isShowGoal: isShowAwayGoal,
                              isShowRed: isShowAwayRed,
                              isShowMststi: isShowMststi,
                              isMainPlay: widget.isMainPlay,
                              matchEntity: widget.match,
                              index: 1,
                              playId: widget.playId,
                              hSpecial: hSpecial),
                          Visibility(
                            visible: widget.playId == playIdConfig.hpsOvertime,
                            child: Container(
                              padding: EdgeInsets.only(top: 5.h),
                              child: Text(
                                ruleText(),
                                style: const TextStyle(
                                    height: 1.4,
                                    color: Color(0xFF7981A4),
                                    fontSize: 11),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: hasRule,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ///悬浮弹框
                                WidgetUtils.instance().showToolTip(
                                    context.isDarkMode
                                        ? const Color(0xff2E3846)
                                        : Colors.white,
                                    rullGroud(context, context.isDarkMode),
                                    ImageView(
                                      'assets/images/icon/rull.svg',
                                      width: 18.w,
                                      height: 18.w,
                                    ),
                                    arrowColor: context.isDarkMode
                                        ? const Color(0xff2E3846)
                                        : Colors.white),

                                // GestureDetector(
                                //   onTap: () async {
                                //     await WidgetUtils.instance().toolTipController.showTooltip();
                                //   },
                                //
                                //   child: SuperTooltip(
                                //     showBarrier: true,
                                //     shadowColor: Colors.transparent,
                                //     popupDirection: TooltipDirection.up,
                                //     controller:WidgetUtils.instance().toolTipController,
                                //     backgroundColor: context.isDarkMode
                                //         ? const Color(0xff2E3846)
                                //         : Colors.white,
                                //     content: rullGroud(context, context.isDarkMode),
                                //     child: ImageView(
                                //       'assets/images/icon/rull.svg',
                                //       width: 18.w,
                                //       height: 18.w,
                                //     ),
                                //   ),
                                // ),

                                5.horizontalSpace,
                                Expanded(
                                    child: Text(
                                  minutesTitle != ""
                                      ? minutesTitle
                                      : ruleText(),
                                  style: const TextStyle(
                                      height: 1.4,
                                      color: Color(0xFF7981A4),
                                      fontSize: 11),
                                ))
                              ],
                            ),
                          ),

                          ///时段和说明
                          const Spacer(),

                          if (widget.isMainPlay)
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () async {
                                final res = await Get.toNamed(
                                    Routes.matchDetail,
                                    arguments: {
                                      'mid': widget.match.mid,
                                      'csid': widget.match.csid,
                                    })?.then((value) {
                                  ///详情回列表 重新请求数据
                                  if (!ObjectUtil.isEmpty(value)) {
                                    HomeController.to.fetchData();
                                    SecondaryController.clearMap();

                                    // HomeControllerLogic.preLoadNextMatchBaseInfoList(value, true);
                                  }
                                });
                              },

                              ///状态图标
                              child: FlagWidget(
                                type: 0,
                                matchEntity: widget.match,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {},
                    child: SizedBox(
                      width: 8.w,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BetGroupWidget(
                          matchEntity: widget.match,
                          hps: widget.hps,
                          playId: widget.playId,
                          isMainPlay: widget.isMainPlay,
                        ),
                        // MultiScoreWidget(match),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 8.w,
                bottom: 5.h,
                child: Row(
                  children: [
                    if (widget.match.mfo != null &&
                        ![1, 10].contains(widget.match.ms) &&
                        [5, 7, 8, 9, 10]
                            .contains(int.parse(widget.match.csid)) &&
                        widget.match.ms == 110)
                      Text(
                        widget.match.mfo,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: context.isDarkMode
                              ? Colors.white.withOpacity(0.30000001192092896)
                              : const Color(0xffAFB3C8),
                        ),
                      ),
                  ],
                ),
              ),

              /// 展示比分区域
              Positioned(
                bottom: 0,
                right: 8.w,
                child: ScoreList(
                  match: widget.match,
                ),
              ),
            ],
          );

  }

  String title = '';
  List titleList = [
    {'value': 0, 'title': LocaleKeys.football_playing_way_hps15_title_0.tr},
    {'value': 1, 'title': LocaleKeys.football_playing_way_hps15_title_1.tr},
    {'value': 2, 'title': LocaleKeys.football_playing_way_hps15_title_2.tr},
    {'value': 3, 'title': LocaleKeys.football_playing_way_hps15_title_3.tr},
    {'value': 4, 'title': LocaleKeys.football_playing_way_hps15_title_4.tr},
    {'value': 5, 'title': LocaleKeys.football_playing_way_hps15_title_5.tr},
  ];
  // 15minutes_bet_col
  String ruleText() {
    bool isLock = false;

    /// 15分钟玩法 1007  罚牌 1003
    if (widget.playId == playIdConfig.hps15Minutes) {
      if (widget.match.ms != 1) {
        title = LocaleKeys.football_playing_way_hps15_title_0.tr;
      } else if (int.parse(widget.match.mst) == 0) {
        title = LocaleKeys.football_playing_way_hps15_title_0.tr;
      } else {

        if((widget.hps.length/3).ceil()>=2){
          if(SecondaryController.index==1){
            hSpecial = widget.hps.length>0&&widget.hps!=null ? NumUtil.subtract(num.parse(widget.hps[1].hSpecial),1).toInt().obs.string :"0";
          }else{
            hSpecial = widget.hps.length>0&&widget.hps!=null  ? NumUtil.subtract(num.parse(widget.hps[0].hSpecial),1).toInt().obs.string:"0";
          }
        }else{
          hSpecial = widget.hps.length>0&&widget.hps!=null ? NumUtil.subtract(num.parse(widget.hps[0].hSpecial),1).toInt().obs.string:"0";
        }


        if (num.parse(hSpecial).toInt()  == 2) {
          hSpecial = "3";
        }
        if (num.parse(hSpecial).toInt()  > 4) {
          hSpecial = "4"; //容错 下标不能大于4 最大特5
        }

        if (num.parse(hSpecial).toInt() < 0) {
          hSpecial = "0";
        }

        List result = titleList.where((element) => element['value'] == num.parse(hSpecial)).toList();
        title = result.first['title'];
      }
    } else if (widget.playId == playIdConfig.hpsPunish) {
      title = LocaleKeys.football_playing_way_penalty_cards.tr;
    } else if (widget.playId == playIdConfig.hpsPenalty) {
      title = LocaleKeys.football_playing_way_penalty_shootout.tr;
    } else if (widget.playId == playIdConfig.hpsOvertime) {
      title = LocaleKeys.football_playing_way_overtime.tr;
    }

    return title;
  }

  ///规则弹框
  Widget rullGroud(context, bool isDarkMode) {
    // play_way_info_5
    // items: [
    //   LocaleKeys.football_play_way_info_5.tr
    // ],
    /// 15分钟玩法 1007  罚牌 1003
    if (widget.playId == playIdConfig.hps15Minutes) {
      List titleList = [
        {
          'title': LocaleKeys
              .football_playing_way_hps_fifteen_minutes_details_0_title.tr,
          'content': LocaleKeys
              .football_playing_way_hps_fifteen_minutes_details_0_content.tr,
        },
        {
          'title': LocaleKeys
              .football_playing_way_hps_fifteen_minutes_details_1_title.tr,
          'content': LocaleKeys
              .football_playing_way_hps_fifteen_minutes_details_1_content.tr,
        },
        {
          'title': LocaleKeys
              .football_playing_way_hps_fifteen_minutes_details_2_title.tr,
          'content': LocaleKeys
              .football_playing_way_hps_fifteen_minutes_details_2_content.tr,
        },
        {
          'title': LocaleKeys
              .football_playing_way_hps_fifteen_minutes_details_3_title.tr,
          'content': LocaleKeys
              .football_playing_way_hps_fifteen_minutes_details_3_content.tr,
        },
        {
          'title': LocaleKeys
              .football_playing_way_hps_fifteen_minutes_details_4_title.tr,
          'content': LocaleKeys
              .football_playing_way_hps_fifteen_minutes_details_4_content.tr,
        },
        {
          'title': LocaleKeys
              .football_playing_way_hps_fifteen_minutes_details_5_title.tr,
          'content': LocaleKeys
              .football_playing_way_hps_fifteen_minutes_details_5_content.tr,
        },
      ];

      return Container(
        color: Colors.white,
        child: Table(
          textBaseline: TextBaseline.alphabetic,
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          defaultColumnWidth: IntrinsicColumnWidth(),
          children: titleList.asMap().keys.map((index) {
            Map show = titleList[index];
            return TableRow(children: [
              Container(
                color: isDarkMode ? const Color(0xff2E3846) : Colors.white,
                padding: EdgeInsets.all(5.w),
                child: Text(
                  show['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: isDarkMode
                          ? Colors.white.withOpacity(0.8999999761581421)
                          : const Color(0xff949AB6),
                      fontSize: 10.sp),
                ),
              ),
              Container(
                  color: isDarkMode ? const Color(0xff2E3846) : Colors.white,
                  padding: EdgeInsets.all(5.w),
                  child: Text(
                    show['content'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: isDarkMode
                            ? Colors.white.withOpacity(0.8999999761581421)
                            : const Color(0xff949AB6),
                        fontSize: 10.sp),
                  ))
            ]);
          }).toList(),
          border: TableBorder.all(color: Color(0xff949AB6), width: 0.5),
        ),
      );
    } else if (widget.playId == playIdConfig.hpsPunish ||
        widget.playId == playIdConfig.hpsPenalty) {
      return SizedBox(
        width: 200,
        child: Text(
          widget.playId == playIdConfig.hpsPunish
              ? LocaleKeys.play_way_info_5.tr
              : widget.playId == playIdConfig.hpsPenalty
                  ? LocaleKeys.play_way_info_2.tr
                  : "",
          maxLines: 4,
          style: TextStyle(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.8999999761581421)
                  : const Color(0xff949AB6),
              fontSize: 10),
        ),
      );
    } else {
      return SizedBox(
        width: 200,
        height: 50,
      );
    }
  }

  /*
  * 更新提示
  * */
  uptitle(int event) {
    if((widget.hps.length/3).ceil()>=2){
      if(event==1){
        hSpecial = widget.hps.length>0&&widget.hps!=null ? NumUtil.subtract(num.parse(widget.hps[1].hSpecial),1).toInt().obs.string :"0";
      }else{
        hSpecial = widget.hps.length>0&&widget.hps!=null  ? NumUtil.subtract(num.parse(widget.hps[0].hSpecial),1).toInt().obs.string:"0";
      }
    }else{
      hSpecial = widget.hps.length>0&&widget.hps!=null ? NumUtil.subtract(num.parse(widget.hps[0].hSpecial),1).toInt().obs.string:"0";
    }
    if (num.parse(hSpecial).toInt()  == 2) {
      hSpecial = "3";
    }
    if (num.parse(hSpecial).toInt()  > 4) {
      hSpecial = "4"; //容错 下标不能大于4 最大特5
    }

    if (num.parse(hSpecial).toInt() < 0) {
      hSpecial = "0";
    }

    ///更新15分钟提示标题
    if (widget.playId == playIdConfig.hps15Minutes) {
      if (mounted) {
        setState(() {
          List result = titleList.where((element) => element['value'] == num.parse(hSpecial)).toList();
          minutesTitle = result.first['title'];
        });
      }
    }
  }

  ///足球1 冰球4 手球11  水球16
  bool _isThree() {
    return [1, 4, 11, 16].contains(int.tryParse(widget.match.csid));
    // bool isThree = false;
    // for (var element in hps) {
    //   if (element.chpid == '1') {
    //     isThree = true;
    //   }
    // }
    // // Get.log('isThree: $isThree');
    // return isThree;
  }

  /// @description: 比分区域是否显示
  /// @param {Object} match 赛事对象
  _showScoreMatchLine(MatchEntity match) {
    // 网斯乒羽(5,7,8,10)  棒冰美排(3、4、6、9)
    int csid = int.tryParse(match.csid) ?? 0;
    bool result = false;
    result = match.ms == 1 &&
        [
          // 1,
          2, 3, 4, 5, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
        ].contains(csid);
    return result;
  }


  Map<String, dynamic> s1Score(MatchEntity match) {
    Map<String, dynamic> score = {
      'home': 0,
      'away': 0,
      'mid': match.mid,
    };

    for (String item in match.msc) {
      if (item.split("|")[0] == "S1") {
        score = {
          'home': FormatScore.formatTotalScore(match, 0),
          'away': FormatScore.formatTotalScore(match, 1),
          'mid': match.mid,
        };
        break; // 只取第一个符合条件的比分
      }
    }

    return score;
  }

  Map<String, dynamic> s11Score(MatchEntity match) {
    Map<String, dynamic> score = {
      'home': 0,
      'away': 0,
    };

    for (String item in match.msc) {
      if (item.split("|")[0] == "S11") {
        List<String> scoreValues = item.split("|")[1].split(":");
        score = {
          'home': scoreValues.isNotEmpty ? scoreValues[0].toInt() : 0,
          'away': scoreValues.length > 1 ? scoreValues[1].toInt() : 0,
        };
        break; // 只取第一个符合条件的比分
      }
    }

    return score;
  }

  // 重置
  resetEvent() {
    isShowHomeGoal = false;
    isShowAwayGoal = false;
    isShowHomeRed = false;
    isShowAwayRed = false;
    isShowMststi = false;
  }

  // 比分和红牌数值变化时设置时间
  Map<String, int> scoreTime = {"S1": 0, "S11": 0};

  /*
    * 足球比分变化
    *
    *  // 是否显示主队进球动画
     bool isShowHomeGoal = false;
     // 是否显示客队进球动画
     bool isShowAwayGoal = false;
    * */
  ShowGoalAnimation(MatchEntity oldmatch, MatchEntity match) {
    // 比分变化 只有足球
    Map<String, dynamic> newS1Score = s1Score(match);
    Map<String, dynamic> oldS1Score = s1Score(oldmatch);
    // 主客队比分数值变化，则更新对应时间

    if (newS1Score["home"] != oldS1Score['home'] ||
        newS1Score["away"] != oldS1Score['away']) {
      // 主客队比分数值变化，则更新对应时间
      if (newS1Score["home"] > 0 || newS1Score["away"] > 0) {
        scoreTime["S1"] = DateTime.now().millisecondsSinceEpoch;
      }
      // 主队
      if (newS1Score["home"] > 0 && newS1Score["home"] > oldS1Score['home']) {
        resetEvent();
        isShowHomeGoal = (scoreTime["S1"] ?? 0) > (scoreTime["S11"] ?? 0);
        5.seconds.delay(() {
          if (mounted) {
            setState(() {
              isShowHomeGoal = false;
            });
          }
        });
      } else {
        isShowHomeGoal = false;
      }
      // 客队
      if (newS1Score["away"] > 0 && newS1Score["away"] > oldS1Score['away']) {
        resetEvent();
        isShowAwayGoal = (scoreTime["S1"] ?? 0) > (scoreTime["S11"] ?? 0);
        5.seconds.delay(() {
          if (mounted) {
            setState(() {
              isShowAwayGoal = false;
            });
          }
        });
      } else {
        isShowAwayGoal = false;
      }
    }
  }

  /*
    * 红牌动画
    * // 是否显示主队红牌动画
     bool isShowHomeRed = false;
      是否显示客队红牌动画
     bool isShowAwayRed = false;
    * */
  ShowRedAnimation(
    MatchEntity oldmatch,
    MatchEntity match,
  ) {
    if (match.mid == oldmatch.mid && match.csid == "1") {
      // 红牌
      Map<String, dynamic> newS11Score = s11Score(match);
      Map<String, dynamic> oldS11Score = s11Score(oldmatch);
      if (newS11Score["home"] != oldS11Score['home'] ||
          newS11Score["away"] != oldS11Score['away']) {
        // 主客队比分数值变化，则更新对应时间
        if (newS11Score["home"] > 0 || newS11Score["away"] > 0) {
          scoreTime["S11"] = DateTime.now().millisecondsSinceEpoch;
        }
        // 主队
        if (newS11Score["home"] > 0 &&
            newS11Score["home"] >= newS11Score['away']) {
          isShowHomeRed = !isShowHomeGoal &&
              (scoreTime["S11"] ?? 0) > (scoreTime["S1"] ?? 0);
          5.seconds.delay(() {
            if (mounted) {
              setState(() {
                isShowHomeRed = false;
              });
            }
          });
        } else {
          isShowHomeRed = false;
        }
        // 客队
        if (newS11Score["away"] > 0 &&
            newS11Score["away"] >= newS11Score['home']) {
          isShowAwayRed = !isShowAwayGoal &&
              (scoreTime["S11"] ?? 0) > (scoreTime["S1"] ?? 0);
          5.seconds.delay(() {
            if (mounted) {
              setState(() {
                isShowAwayRed = false;
              });
            }
          });
        } else {
          isShowAwayRed = false;
        }
      }
    }
  }

  /*
    * 显示伤停补时动画
    * */
  ShowMststiAnimation(MatchEntity oldmatch, MatchEntity match) {
    ///显示伤停补时动画
    if (["6", "7"].contains(match.mmp) && ObjectUtil.isNotEmpty(match.mststi)) {
      int oldMststi = int.parse(oldmatch.mststi);
      int mststi = int.parse(match.mststi);
      if (mststi != oldMststi && mststi != '0' && mststi > oldMststi) {
        scoreTime["S1"] = DateTime.now().millisecondsSinceEpoch;
        isShowMststi = (scoreTime["S1"] ?? 0) > (scoreTime["S11"] ?? 0);
        5.seconds.delay(() {
          if (mounted) {
            setState(() {
              isShowMststi = false;
            });
          }
        });
      } else {
        isShowMststi = false;
      }
    }
  }

  ShowHitAnimation(MatchEntity oldmatch, MatchEntity match) {
    ///显示伤停补时动画
    if (oldmatch.mid == match.mid &&
        ObjectUtil.isNotEmpty(match.cmec) &&
        match.cmec != oldmatch.cmec) {
      hit = "";
      for (var e in HomeController.to.EventInfoList) {
        if (match.cmec == e.nameCode) {
            if (mounted) {
              setState(() {
                hit = gethint( language,e);
              });
            }
          break; // 只取第一个符合条件的比分
        }
      }
      // 主队
  /*    setState(() {
        hit = match.cmec ;
      });*/
      if (ObjectUtil.isNotEmpty(hit)) {
        isShowMststi=false;
        scoreTime["S1"] = DateTime.now().millisecondsSinceEpoch;
        isShowMststi = (scoreTime["S1"] ?? 0) > (scoreTime["S11"] ?? 0);
        8.seconds.delay(() {
         if (mounted) {
           setState(() {
             hit = "";
             isShowMststi = false;
           });
         }
        });
      } else {
        hit = "";
        isShowMststi = false;
      }
    }
  }

  String gethint(String language, EventInfo2Data data) {
    switch (language) {
      case "CN":
        return data.zh;
      case "TW":
        return data.tw;
      case "GB":
        return data.tw;
      case "VN":
        return data.es;
      case "TH":
        return data.th;
      case "MY":
        return data.mya;
      case "ID":
        return data.es;
      case "PT":
        return data.es;
      case "KR":
        return data.es;
      case "ES":
        return data.es;
      case "MM":
        return data.es;
    }
    return data.zh;
  }
}

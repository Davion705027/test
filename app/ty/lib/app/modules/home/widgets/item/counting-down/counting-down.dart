import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_ty_app/app/core/MatchListClass.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/format_date_util.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';

import '../../../../../utils/global_timer.dart';

// 对应vue: user-pc-vite/src/base-h5/components/common/counting-down.vue
class Countingdown extends StatefulWidget {
  final MatchEntity match;

  Countingdown(this.match);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<Countingdown> {
  late String title;
  String countingTime = '00:00';
  bool goon = false;

  late bool isAdd;

  /// 计时器步长
  double step = 1.0;

  /// 计时器开始计时时间
  double reduceSecond = 0.0;

  /// 定时器
  // Timer? timer;

  @override
  void initState() {
    super.initState();

    try {
      init();
    } catch (e) {}
  }

  init() {
    isAdd = [1, 4, 11, 14, 100, 101, 102, 103]
        .contains(int.tryParse(widget.match.csid) ?? 0);

    // 初始化修正设置步长
    step = MatchListClass.matchVrStep(widget.match, step);
    // 计时器计时时间
    try {
      reduceSecond = double.tryParse(widget.match.mst) ?? 0;
    } catch (e) {
      print(e);
    }

    computeCounter();
    // getSyncMatchTime();

    /// 初始化定时器
    // timer?.cancel();
    // timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
    //   if (!mounted) {
    //     return;
    //   }
    //   setState(() {
    //     computeCounter();
    //     // getSyncMatchTime();
    //   });
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool showMststi() {
    var match = widget.match;
    if (match.csid != "1") {
      return false;
    }
    if ([6, 7].contains(match.mmp.toInt())) {
      return match.mststi != '' && match.mststi != '0';
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    title = MatchListClass.matchPeriodMap(widget.match);
    return StreamBuilder(

        ///绑定stream
        stream: GlobalStreamTimer.getInstance().streamController.stream,

        ///默认的数据
        initialData: 0,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          // 进入详情页停止定时器
          if (Get.currentRoute == Routes.matchDetail) {
            return Container();
          }
          computeCounter();
          return RepaintBoundary(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (title != '')
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      color: context.isDarkMode
                          ? Colors.white.withOpacity(0.30000001192092896)
                          : const Color(0xffAFB3C8),
                    ),
                  ),

              // 倒计时 正计时
              // if(showTimeCounting())
              //   TimeWidget(matchEntity: widget.match),
              if (showTimeCounting())
                AutoSizeText(
                  FormatDate.countingTimeCtrShowFormat(
                      widget.match, countingTime),
                  maxLines: 1,
                  minFontSize: 8,
                  style: TextStyle(
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                      color: context.isDarkMode
                        ? Colors.white.withOpacity(0.30000001192092896)
                        : const Color(0xffAFB3C8),
                  ),
                ).marginOnly(left: 4.w),

              // 对应vue  MatchInjoureingTime  组件
              if (showMststi())
                Container(
                  margin: const EdgeInsets.only(left: 4, right: 4),
                  child: Text(
                    "+${widget.match.mststi}'",
                    style:  TextStyle(
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      letterSpacing: 2.w,
                      color: context.isDarkMode
                          ? Colors.white.withOpacity(0.30000001192092896)
                          : const Color(0xffAFB3C8),
                    ),
                  ),
                ),

              if ([2, 4, 6, 15, 16].contains(widget.match.csid.toInt()) &&
                  [301, 302, 303].contains(widget.match.mmp.toInt()))
                Text(
                  widget.match.mlet,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: context.isDarkMode
                        ? Colors.white.withOpacity(0.30000001192092896)
                        : const Color(0xffAFB3C8),
                  ),
                ),
            ],
          ));
        });
  }

  /// 获取同步的赛事时间
  // getSyncMatchTime() {
  //   if (widget.isPinnedAppbar) {
  //     final matchTimeMap = MapKV.matchTime.get();
  //     if (matchTimeMap != null && matchTimeMap.containsKey(widget.match.mid)) {
  //       countingTime = matchTimeMap[widget.match.mid];
  //     }
  //   }
  // }
  @override
  didUpdateWidget(covariant Countingdown oldWidget) {
    bool widgetIsChange = oldWidget.match != widget.match;
    bool mstIsChange =  oldWidget.match.mst != widget.match.mst;
    bool mmtIsChange =  oldWidget.match.mmp != widget.match.mmp && widget.match.mmp == "6" &&
        !((int.tryParse(widget.match.mst) ?? 0) != 0);
    bool messIsChange = oldWidget.match.mess != widget.match.mess;
    // bool csidIsChange = oldWidget.match.csid != widget.match.csid;
    // bool mmpIsChange = oldWidget.match.mmp != widget.match.mmp;
    // bool msIsChange = oldWidget.match.ms != widget.match.ms; // || csidIsChange || mmpIsChange || msIsChange

    //  // 篮球冰球开始或暂停
    bool messIs1 = messIsChange && ["2", "4", "100", "101", "102", "103"].contains(widget.match.csid) && widget.match.mess == 1;


    if(widgetIsChange || mstIsChange || mmtIsChange || messIsChange ){
      
       try {
          reduceSecond = double.tryParse(widget.match.mst) ?? 0;
        } catch (e) {
          print(e);
        }
        
        computeCounter();  
    }

    // if (oldWidget.match != widget.match) {
    //   // 初始化修正设置步长
    //   step = MatchListClass.matchVrStep(widget.match, 1);
    //   // 计时器计时时间
    //   reduceSecond = double.tryParse(widget.match.mst) ?? 0;
    //   computeCounter();
    // }
    // // 初始化修正设置步长
    // step = MatchListClass.matchVrStep(widget.match, step);
    // // 计时器计时时间
    // reduceSecond = double.tryParse(widget.match.mst);
    // computeCounter();
    // 倒计时总时间变化执行计时

    // if (oldWidget.match.mst != widget.match.mst) {
    //   try {
    //     reduceSecond = double.tryParse(widget.match.mst) ?? 0;
    //   } catch (e) {
    //     print(e);
    //   }
    //   computeCounter();
    // }

    // // 赛事阶段变化执行计时
    // if (widget.match.mmp == "6" &&
    //     !((int.tryParse(widget.match.mst) ?? 0) == 0)) {
    //   reduceSecond = double.tryParse(widget.match.mst) ?? 0;
    //   computeCounter();
    // }

    // // 篮球冰球开始或暂停
    // if (oldWidget.match.mess != widget.match.mess) {
    //   if (["2", "4", "100", "101", "102", "103"].contains(widget.match.csid)) {
    //     if (widget.match.mess == 1) {
    //       computeCounter();
    //     }
    //   }
    // }
    super.didUpdateWidget(oldWidget);
  }

  void getCountingTime() {
    if (reduceSecond <= 0 || widget.match.mmp == "0") {
      countingTime = '00:00';
      return;
    }

    int secondCount = reduceSecond.toInt();
    String minutes, second;

    minutes = (secondCount ~/ 60).toString().padLeft(2, '0');
    int minutesToSecond = (int.tryParse(minutes) ?? 0) * 60;
    second = (secondCount - minutesToSecond).toString().padLeft(2, '0');

    // 水球
    if (widget.match.csid == "16") {
      String waterPCountingDown =
          LocaleKeys.list_water_polo_countdown.tr; // 这里替换为对应的国际化字符串
      int fMinutes = (secondCount ~/ 60).ceil();
      fMinutes = fMinutes > 0 ? fMinutes : 1;
      countingTime = waterPCountingDown.replaceFirst('S%', fMinutes.toString());
    } else {
      countingTime = '$minutes:$second';
    }

    // 防止时间出现负数
    if (countingTime.startsWith('-')) {
      countingTime = countingTime.substring(1);
      countingTime = (countingTime[1] == ':' ? '0' : '') + countingTime;
    }
  }

  // 获取当前计时时间
  computeCounter() {
    // C01赛事使用mstrc字段数据
    // if(match?.cds == "1500" && matchmstrc){
    //   detailState.matchDetailData.update((val) {
    //     val?.mst = matchmstrc;
    //   });
    // }
    // 获取当前计时时间
    getCountingTime();
    String csid = widget.match.csid;
    int mess = widget.match.mess;
    String mmp = widget.match.mmp;
    int ms = widget.match.ms;
    if (
        // 暂停 mess = 0
        mess == 0 ||
            // 足球 csid : 1 同时赛事为等待加时
            (csid == "1" && mmp == "32") ||
            // 0：赛事为未开赛则暂停 或局间休息暂停
            ["0", "301", "302", "303", "304", "305", "306"].contains(mmp) ||
            // 全局暂停|中断
            [2, 10].contains(ms)) {
      goon = false;
    } else if (mess == 1) {
      goon = true;
    }
    // 不满足暂停条件则执行
    if (goon) {
      // 是否为累加计时器
      if (["1", "4", "11", "14", "100", "101", "102", "103"].contains(csid)) {
        reduceSecond += step;
        // if(widget.match.maid == "115136"){

        //   print(reduceSecond);
        // }
        // 是足球时 计算特n , 可视区域数据不多,请求3个mid和1一个mid没有区别 因此直接调用页脚刷新
        //         if(props.matchcsid == 1){
        //           // 15分钟玩法 调用
        //           set_min15(reduce_second,(mmp_15_min)=>{
        //             useMittEmit(MITT_TYPES.EMIT_MENU_CHANGE_FOOTER_CMD, {
        //               text: "mid-refresh", // 只更新对应的mid
        //               mid:props.matchmid
        //             });
        //           });
        //           // 5分钟玩法 调用
        //           set_min5(reduce_second,(mmp_5_min)=>{
        //             useMittEmit(MITT_TYPES.EMIT_MENU_CHANGE_FOOTER_CMD, {
        //               text: "mid-refresh", // 只更新对应的mid
        //               mid:props.matchmid
        //             });
        //           });
        //         }
      } else {
        reduceSecond--;
      }
    }
  }

  bool showTimeCounting() {
    try {
      int csid = int.tryParse(widget.match.csid) ?? 0;
      int mmp = int.tryParse(widget.match.mmp) ?? 0;

      if ([5, 10, 8, 7, 3, 9, 13].contains(csid)) {
        return false;
      } else if (csid == 1) {
        return ![
          0,
          30,
          31,
          32,
          33,
          34,
          50,
          61,
          80,
          90,
          100,
          110,
          120,
          301,
          302,
          303,
          445
        ].contains(mmp);
      } else if (csid == 4) {
        if (widget.match.mlet != '') {
          List<int> mmps = [1, 2, 3, 40, 50];
          return mmps.contains(mmp);
        }
        return false;
      } else if (csid == 6) {
        if (widget.match.mlet != '') {
          if (mmp == 40 && countingTime == '00:00') {
            return false;
          }
          List<int> mmps = [13, 14, 15, 16, 40];
          return mmps.contains(mmp);
        }
        return false;
      } else if ([100, 101, 102, 103].contains(csid)) {
        if (mmp > -1) {
          return true;
        }
      } else {
        return ![
          0,
          30,
          31,
          32,
          33,
          34,
          50,
          61,
          80,
          90,
          100,
          110,
          120,
          301,
          302,
          303,
          445
        ].contains(mmp);
      }
    } catch (e) {}
    return false;
  }
}

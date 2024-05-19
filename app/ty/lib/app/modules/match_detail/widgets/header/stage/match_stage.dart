import 'package:auto_size_text/auto_size_text.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/stage/templates/stage_child1.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/stage/templates/stage_child10.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/stage/templates/stage_child11.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/stage/templates/stage_child13.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/stage/templates/stage_child14.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/stage/templates/stage_child15.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/stage/templates/stage_child16.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/stage/templates/stage_child2.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/stage/templates/stage_child3.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/stage/templates/stage_child4.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/stage/templates/stage_child5.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/stage/templates/stage_child6.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/stage/templates/stage_child7.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/stage/templates/stage_child8.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/stage/templates/stage_child9.dart';
import 'package:get/get.dart';
import '../../../../../../generated/locales.g.dart';
import '../../../../../db/app_cache.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../../../utils/bus/bus.dart';
import '../../../../../utils/bus/event_enum.dart';
import '../../../../../utils/csid_util.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'show_start_time.dart';
import 'templates/stage_child101.dart';

/// 赛事阶段组件（赛事状态、总比分、倒计时）
class MatchStage extends StatefulWidget {
  const MatchStage({
    super.key,
    required this.match,
    this.isPinnedAppbar = false,
    this.isMatchSelect = false,
  });

  final MatchEntity match;

  /// 是否是置顶头部
  final bool isPinnedAppbar;

  /// 是否是联赛下拉
  final bool isMatchSelect;

  @override
  State<MatchStage> createState() => _MatchStageState();
}

class _MatchStageState extends State<MatchStage> {
  /// 控制是否显示开赛时间 小于1小时（即将开赛）不显示
  bool isOneHour = false;

  @override
  void initState() {
    initEvent();
    Bus.getInstance().on(EventType.matchNoStart, (_) {
      initEvent();
    });
    super.initState();
  }

  @override
  void dispose() {
    if (!widget.isPinnedAppbar) {
      // MapKV.matchTime.remove();
    }
    Bus.getInstance().off(EventType.matchNoStart);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MatchStage oldWidget) {
    initEvent();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 87.w, maxWidth: 120.w),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (ObjectUtil.isNotEmpty(
                      matchStageContentTop(widget.isPinnedAppbar)) &&
                  matchStageContentTop(widget.isPinnedAppbar) != "isOneHour")
                AutoSizeText(
                  matchStageContentTop(widget.isPinnedAppbar) ?? "",
                  maxLines: 1,
                  minFontSize: 8,
                  style: TextStyle(
                    color: widget.isMatchSelect
                        ? Get.theme.subSelectTitleColor
                        : Colors.white,
                    fontSize: widget.isPinnedAppbar ? 14.sp : 12.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: widget.isPinnedAppbar
                        ? FontWeight.w500
                        : FontWeight.w400,
                  ),
                ),

              // 显示即将开赛时间
              if (matchStageContentTop(widget.isPinnedAppbar) == "isOneHour")
                ShowStartTime(
                  match: widget.match,
                  isPinnedAppbar: widget.isPinnedAppbar,
                  isMatchSelect: widget.isMatchSelect,
                ),

              /// 显示赛事阶段和赛事时间组件
              if (matchStageContentTop(widget.isPinnedAppbar) == "")
                Row(
                  children: [
                    getMatchStageTemplate(),
                  ],
                ),

              /// 是否中立场 即将开赛不显示中立场
              if (isMidField() && widget.match.ms != 110)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(23, 156, 255, 1),
                      borderRadius: BorderRadius.circular(4.r)),
                  child: AutoSizeText(
                    "N",
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // 控制是否显示赛事时间
  initEvent() {
    // 当前时间戳 1709022665703
    int nowTimeStamp = DateTime.now().millisecondsSinceEpoch;
    int mgt = int.tryParse(widget.match.mgt) ?? 0;
    // 赛事开始时间 - 当前时间 小于一小时并且大于0时为true
    isOneHour = (mgt - nowTimeStamp) < 3600 * 1000 && (mgt - nowTimeStamp) > 0;
  }

  /// 根据csid显示赛事阶段和赛事时间模板 tag对应不同依赖 多赛事阶段情况
  Widget getMatchStageTemplate() {
    /// 置顶时 matchTimeDt更新后才显示
    String csid = widget.match.csid;
    if (esportsCSID.contains(int.tryParse(csid))) {
      // 电竞赛事
      csid = "101";
    }
    switch (csid) {
      // 足球
      case "1":
        return StageChild1(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect);
      // 篮球
      case "2":
        return StageChild2(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect);
      // 棒球
      case "3":
        return StageChild3(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect);
      // 冰球
      case "4":
        return StageChild4(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect);
      // 网球
      case "5":
        return StageChild5(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect);
      //美式足球
      case "6":
        return StageChild6(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect);
      // 斯诺克
      case "7":
        return StageChild7(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect);
      // 斯诺克
      case "8":
        return StageChild8(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect);
      // 排球
      case "9":
        return StageChild9(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect);
      // 羽毛球
      case "10":
        return StageChild10(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect);
      // 手球
      case "11":
        return StageChild11(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect);
      // 沙滩排球
      case "13":
        return StageChild13(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect);
      // 橄榄球
      case "14":
        return StageChild14(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect);
      // 曲棍球
      case "15":
        return StageChild15(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect);
      // 橄榄球
      case "16":
        return StageChild16(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect);
      // 电竞
      case "101":
        return StageChild101(
            isPinnedAppbar: widget.isPinnedAppbar,
            match: widget.match,
            isMatchSelect: widget.isMatchSelect);
      default:
        return Container();
    }
  }

  /// 赛事阶段 1、足球；2、篮球；3、棒球；4、冰球；5、网球；6、美足； 7、斯诺克； 8、乒乓球；9、排球； 10、羽毛球； 11、手球； 12、拳击； 13、沙滩排球
  /// mng 是否中立场   1:是中立场，0:非中立场
  bool isMidField() {
    int csid = int.tryParse(widget.match.csid) ?? 0;
    int mng = widget.match.mng;
    if (![5, 10, 7, 8, 13].contains(csid) && mng == 1) {
      return true;
    }
    return false;
  }

  /// 赛事阶段显示内容 上部分
  String? matchStageContentTop(isPinnedAppbar) {
    // 赛事未开赛
    if (widget.match.ms == 0) {
      // 即将开赛的赛事不显示日期
      if (!isOneHour) {
        // 距离开赛时间大于一个小时 显示月和日
        return DateFormat(LocaleKeys.time2.tr).format(
            DateTime.fromMillisecondsSinceEpoch(
                int.tryParse(widget.match.mgt) ?? 0));
      }
      if (isPinnedAppbar && isOneHour) {
        return "isOneHour";
      }

      return null;
    }

    // 赛事结束
    else if (widget.match.ms == 3 || widget.match.mo == 1) {
      if (["1", "2"].contains(widget.match.csid)) {
        return LocaleKeys.match_info_match_over.tr;
      } else {
        return LocaleKeys.match_info_match_end.tr;
      }
    } else if (widget.match.ms == 110) {
      return "ms_${widget.match.ms}".tr;
    }

    return "";
  }
}

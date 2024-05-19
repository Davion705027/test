import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../../../generated/locales.g.dart';
import '../../../login/login_head_import.dart';

class TimeWidget extends StatefulWidget {
  const TimeWidget({super.key, required this.matchEntity});

  final MatchEntity matchEntity;

  @override
  State<TimeWidget> createState() => _TimeWidgetState();
}

// 时间: mst已经开赛时间（滚球）   mgt开赛时间 （早盘） ms:110 即将开赛（加上）
class _TimeWidgetState extends State<TimeWidget> {
  // 记时器
  /// 正向记录时间
  int _seconds = 0;
  late StreamController<int> _secondsStreamController;
  late Stream<int> _secondsStream;
  Timer? _timer;
  bool _isTimerRunning = true;
  bool isAdd = false;

  @override
  void initState() {
    super.initState();
    _secondsStreamController = StreamController<int>.broadcast();
    _secondsStream = _secondsStreamController.stream;

    isAdd = [1, 4, 11, 14, 100, 101, 102, 103]
        .contains(int.tryParse(widget.matchEntity.csid));
    // 如果是滚球赛事，开启计时器
    if (widget.matchEntity.mcg == 1) {
      _seconds = widget.matchEntity.mst.toInt();
      _startTimer();
    }
  }

  _startTimer() {
    _seconds = widget.matchEntity.mst.toInt();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_isTimerRunning) {
        if (_seconds <= 0) {
          _stopTimer();
          return;
        }
        var csid = widget.matchEntity.csid;

        // 篮球-- 足球++
        _secondsStreamController.add(isAdd ? _seconds++ : _seconds--);
      } else {
        _timer?.cancel();
      }
    });
  }

  _stopTimer() {
    _timer?.cancel();
    _timer = null;
    _isTimerRunning = false;
  }

  @override
  void dispose() {
    _stopTimer();
    _secondsStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool displaysCountdown = true;
    if (widget.matchEntity.csid == '1' &&
        ['31', '100', '110', '120', '999'].contains(widget.matchEntity.mmp)) {
      displaysCountdown = false;
    }
    if (widget.matchEntity.mcg == 1 && displaysCountdown) {
      return StreamBuilder<int>(
        stream: _secondsStream,
        initialData: _seconds,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          // 描述格式化
          String format = '';
          // 分秒
          int minutes = (snapshot.data ?? 0) ~/ 60;

          // C01赛事只显示分钟不显示秒
          bool isC01 =
              widget.matchEntity.cds == 'C01' && widget.matchEntity.csid == '1';
          format = minutes.toString().padLeft(2, '0');
          if (!isC01) {
            int seconds = (snapshot.data ?? 0) % 60;
            format += ':${seconds.toString().padLeft(2, '0')}';
          }
          // format =
          //     '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
          return Row(
            children: [
              Text(
                minutes > 0 ? format : "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  height: 1.6,
                  color: context.isDarkMode
                      ? Colors.white.withOpacity(0.30000001192092896)
                      : Color(0xffAFB3C8),
                ),
              ),
              if (showMststi())
                Container(
                  margin: const EdgeInsets.only(left: 4, right: 4),
                  child: Text(
                    "+${widget.matchEntity.mststi}'",
                    style:  TextStyle(
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      height: 1.6,
                      letterSpacing: 2,
                        color: context.isDarkMode
                            ? Colors.white.withOpacity(0.30000001192092896)
                            : const Color(0xffAFB3C8),
                    ),
                  ),
                ),

            ],
          );
        },
      );
    } else if (widget.matchEntity.ms == 110) {
      //  即将开赛 ms = 110

      return Text(
        'ms_110'.tr,
        style: TextStyle(
          fontFamily: 'PingFang SC',
          fontWeight: FontWeight.w400,
          fontSize: 11.sp,
          color: context.isDarkMode
              ? Colors.white.withOpacity(0.30000001192092896)
              : const Color(0xffAFB3C8),
        ),
      ).marginOnly(right: 4.w);
    } else {
      if (widget.matchEntity.csid == '1' &&
          ['31'].contains(widget.matchEntity.mmp)) {
        return SizedBox(); //中场休息
      }
      String time = DateUtil.formatDateMs(widget.matchEntity.mgt.toInt(),
          format: LocaleKeys.time11.tr);
      return Text(
        time,
        style: TextStyle(
          fontFamily: 'PingFang SC',
          fontWeight: FontWeight.w400,
          fontSize: 11.sp,
          color: context.isDarkMode
              ? Colors.white.withOpacity(0.30000001192092896)
              : Color(0xffAFB3C8),
        ),
      );
    }
  }

  bool showMststi() {
    var match = widget.matchEntity;
    if (match.csid != "1") {
      return false;
    }
    if ([6, 7].contains(match.mmp.toInt())) {
      return match.mststi != '' && match.mststi != '0';
    }
    return false;
  }
}

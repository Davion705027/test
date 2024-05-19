import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../../../utils/global_timer.dart';

class CountingdownStart extends StatefulWidget {
  final MatchEntity match;
  final String mgtTime;

  CountingdownStart(this.match, this.mgtTime);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountingdownStart> {
  late int startMinutes;
  late bool show;
  // late Timer? timeout;

  @override
  void initState() {
    super.initState();
    startMinutes = 1;
    show = false;
    countingDown();
  }

  @override
  void dispose() {
    // timeout?.cancel();
    super.dispose();
  }

  void countingDown() {
    if (widget.mgtTime != null && widget.mgtTime.isNotEmpty) {
      int startTime = int.tryParse(widget.mgtTime) ?? 0;

      // int initServer = PageSourceData.initTime['serverTime'];
      // int initLocal = PageSourceData.initTime['localTime'];
      int nowLocal = DateTime.now().millisecondsSinceEpoch;
      // int subLocalTime = nowLocal - initLocal;
      int nowServerTime = nowLocal + IntKV.diffTime.get()!;

      int subTime = startTime - nowServerTime;
      show = false;

      if (widget.match.mcg != 1 && subTime < 60 * 60 * 1000) {
        int timeWaiting = subTime > 5 * 60 * 1000 ? 60 * 1000 : 1000;

        if (subTime > 0) {
          setState(() {
            show = true;
            startMinutes = DateTime.fromMillisecondsSinceEpoch(subTime).minute;
            if (startMinutes < 1) {
              startMinutes = 1;
            }
          });

          // timeout = Timer(Duration(milliseconds: timeWaiting), countingDown);
        } else {
          // Call your function when countdown ends
          // useMittEmit(MITT_TYPES.EMIT_COUNTING_DOWN_START_ENDED, widget.match['mid']);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: show && startMinutes > 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Text(
            // i18nTc('list.after_time_start', [startMinutes.toString()]),
            startMinutes.toString(),
            style: TextStyle(fontSize: 12.0), // Adjust font size as needed
          ),
          // Text(LocaleKeys.list_after_time_start.tr.replaceFirst(
          // '{0}', MatchUtil.getStartCountTime(widget.matchEntity).toString()))
        ),
      ),
    );
  }
}

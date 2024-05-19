import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';

class BasketballRemainTimeWidget extends StatefulWidget {
  const BasketballRemainTimeWidget({
    super.key,
    this.isFinish = false,
  });

  final bool isFinish;

  @override
  State<BasketballRemainTimeWidget> createState() =>
      _BasketballRemainTimeWidgetState();
}

class _BasketballRemainTimeWidgetState
    extends State<BasketballRemainTimeWidget> {
  Timer? _timer;
  final int _totalTime = 18;
  int _goneSeconds = 0;
  int _goneMillseconds = 0;

  @override
  void initState() {
    if (!widget.isFinish) {
      // 10秒时间
      _timer ??= Timer.periodic(1.milliseconds, (timer) {
        _goneMillseconds += 1;
        if (_goneMillseconds == 60) {
          _goneMillseconds = 0;
          _goneSeconds += 1;
        }
        if (mounted) setState(() {});

        if (_goneSeconds >= 9 && _goneMillseconds >= 59) {
          _timer?.cancel();
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: '#303442'.hexColor,
          ),
          margin: const EdgeInsets.symmetric(horizontal: (380 - 267) / 2),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          alignment: Alignment.center,
          child: Column(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final maxWidth = constraints.maxWidth;

                  final doneRatio =
                      widget.isFinish ? 1 : _goneSeconds / max(1, _totalTime);

                  const hMargin = 6.0;
                  final leftMargin = (maxWidth - hMargin * 2) * doneRatio;

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.virtual_sports_match_status_0.tr,
                            style: TextStyle(
                              color: doneRatio > 0
                                  ? AppColor.colorDanger
                                  : '#C9CDDB'.hexColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            LocaleKeys.virtual_sports_match_status_1.tr,
                            style: TextStyle(
                              color: doneRatio >= 0.5
                                  ? AppColor.colorDanger
                                  : '#C9CDDB'.hexColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            LocaleKeys.virtual_sports_match_status_2.tr,
                            style: TextStyle(
                              color: doneRatio >= 1
                                  ? AppColor.colorDanger
                                  : '#C9CDDB'.hexColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            color: AppColor.colorDanger,
                            height: 1.w,
                            child: Container(
                              color: '#C9CDDB'.hexColor,
                              margin: EdgeInsets.only(left: max(0, leftMargin)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 4,
                                backgroundColor: doneRatio >= 0
                                    ? AppColor.colorDanger
                                    : '#C9CDDB'.hexColor,
                              ),
                              CircleAvatar(
                                radius: 4,
                                backgroundColor: doneRatio >= 0.5
                                    ? AppColor.colorDanger
                                    : '#C9CDDB'.hexColor,
                              ),
                              CircleAvatar(
                                radius: 4,
                                backgroundColor: doneRatio >= 1
                                    ? AppColor.colorDanger
                                    : '#C9CDDB'.hexColor,
                              ),
                            ],
                          ),
                        ],
                      ).marginSymmetric(horizontal: hMargin),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          LocaleKeys.virtual_sports_match_status_x_to_ended.tr.replaceAll(
              '%s',
              widget.isFinish
                  ? '00:00'
                  : '${'${10 - _goneSeconds}'.padLeft(2, '0')}:${'${59 - _goneMillseconds}'.padLeft(2, '0')}'),
          style: TextStyle(
            color: '#F5F8FA'.hexColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

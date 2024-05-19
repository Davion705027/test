import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/extensions/vr_sport_extensions.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_match_entity.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:get/get.dart';

class NextMatchCountdownWidget extends StatefulWidget {
  const NextMatchCountdownWidget({
    super.key,
    this.nextVrMatch,
    this.onCountdownEnd,
    this.callbackSeconds = 10,
  });

  final VrMatchEntity? nextVrMatch;
  final VoidCallback? onCountdownEnd;

  /// 触发回调时间：单位秒，默认 10 秒
  final int callbackSeconds;

  @override
  State<NextMatchCountdownWidget> createState() =>
      _NextMatchCountdownWidgetState();
}

class _NextMatchCountdownWidgetState extends State<NextMatchCountdownWidget> {
  // 下一场比赛的倒计时提示
  Timer? _nextVrMatchTimer;
  late ValueNotifier<int> _nextVrMatchTime;

  int _initialSeconds = 0;
  late int _callbackSeconds;

  void _initTimer() {
    final match = widget.nextVrMatch?.matchs
        .firstWhereOrNull((element) => element.mgt.isNotEmpty);
    final diffSeconds = match?.diffSeconds ?? 0;
    _initialSeconds = diffSeconds;

    _nextVrMatchTime = ValueNotifier(diffSeconds);
    _nextVrMatchTimer = Timer.periodic(
      1.seconds,
      (timer) {
        _nextVrMatchTime.value--;
        // 时间充足的情况下最少展示10秒才回调
        if (_initialSeconds - _nextVrMatchTime.value >= _callbackSeconds ||
            _nextVrMatchTime.value <= _callbackSeconds) {
          widget.onCountdownEnd?.call();
          _nextVrMatchTimer?.cancel();
          _nextVrMatchTimer = null;
        }
      },
    );
  }

  @override
  void initState() {
    _callbackSeconds = widget.callbackSeconds;
    _initTimer();

    super.initState();
  }

  @override
  void dispose() {
    _nextVrMatchTimer?.cancel();
    _nextVrMatchTimer = null;
    _nextVrMatchTime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _nextVrMatchTime,
      builder: (context, seconds, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.black.withOpacity(0.6),
              ),
              margin: const EdgeInsets.only(right: 14),
              constraints: const BoxConstraints(minHeight: 24),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.nextVrMatch?.no ?? '第4轮',
                    style: const TextStyle(
                      color: AppColor.colorWhite,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    seconds <= 0 ? '' : seconds.secondsToCountdown,
                    style: const TextStyle(
                      color: AppColor.colorWarning,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const ImageView(
                    'assets/images/vr/video_countdown_icon.svg',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'dart:async';

import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import 'simple_circular_progress_bar.dart';
// import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class VrSportingVideoCountdownWidget extends StatefulWidget {
  const VrSportingVideoCountdownWidget({
    super.key,
    this.progressColor,
    this.backColor,
    required this.no,
    this.size = 110,
    this.valueSize,
    this.roundSize,
    this.mgt = '',
    this.onCountdownFinished,
  });

  final Color? progressColor;
  final Color? backColor;
  final String no;
  final String mgt;
  final double size;
  final double? valueSize;
  final double? roundSize;
  final VoidCallback? onCountdownFinished;

  @override
  State<VrSportingVideoCountdownWidget> createState() =>
      _VrSportingVideoCountdownWidgetState();
}

class _VrSportingVideoCountdownWidgetState
    extends State<VrSportingVideoCountdownWidget> {
  late ValueNotifier<double> _notifier;
  Timer? _timer;
  double _diffSeconds = 0;

  double _getDiffseconds() {
    final endSeconds = ((int.tryParse(widget.mgt) ?? 0) / 1000);
    final nowSeconds = DateTime.now().millisecondsSinceEpoch / 1000;
    final diffSeconds = endSeconds - nowSeconds;
    return diffSeconds;
  }

  @override
  void initState() {
    _diffSeconds = _getDiffseconds();
    double diffSeconds = _diffSeconds;
    _notifier = ValueNotifier(diffSeconds);
    _timer = Timer.periodic(1.seconds, (timer) {
      diffSeconds--;
      if (diffSeconds <= 0) {
        widget.onCountdownFinished?.call();
        _timer?.cancel();
        _timer == null;
      }
      _notifier.value = diffSeconds;
    });
    super.initState();
  }

  @override
  void dispose() {
    _notifier.dispose();
    _timer?.cancel();
    _timer == null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _notifier,
      builder: (context, value, child) {
        if (value <= 0) return const SizedBox();
        Color color = AppColor.colorWarning;
        bool changeColor = value < 80;
        if (changeColor) {
          color = AppColor.colorDanger;
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SimpleCircularProgressBar(
              key: ValueKey(changeColor),
              mergeMode: false,
              size: widget.size,
              maxValue: _diffSeconds,
              backStrokeWidth: 2,
              valueNotifier: _notifier,
              animationDuration: 0,
              backColor: widget.backColor ?? Colors.black26,
              progressStrokeWidth: 2,
              progressColors: [color],
              onGetText: (double value) {
                return Text(
                  value.toInt().secondsToCountdown,
                  style: TextStyle(
                    fontSize: widget.valueSize ?? 30,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
            const SizedBox(height: 18),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black.withOpacity(0.4),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: Text(
                widget.no,
                style: TextStyle(
                  color: AppColor.colorWhite,
                  fontSize: widget.roundSize ?? 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

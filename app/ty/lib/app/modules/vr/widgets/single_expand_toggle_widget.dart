import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';

class SingleExpandToggleWidget extends StatefulWidget {
  const SingleExpandToggleWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isExpand,
    this.onToggleExpand,
    required this.time,
    this.cusTime = '',
  });

  final String title;
  final String subtitle;
  // ms 时间戳字符串
  final String time;
  final String cusTime;
  final bool isExpand;
  final ValueChanged<bool>? onToggleExpand;

  @override
  State<SingleExpandToggleWidget> createState() =>
      _SingleExpandToggleWidgetState();
}

class _SingleExpandToggleWidgetState extends State<SingleExpandToggleWidget> {
  late ValueNotifier<bool> _isExpand;
  late ValueNotifier<int> _diffSeconds;
  Timer? _timer;

  _onToggleExpand() {
    _isExpand.value = !_isExpand.value;
    widget.onToggleExpand?.call(_isExpand.value);
  }

  @override
  void initState() {
    _isExpand = ValueNotifier(widget.isExpand);
    final beginSeconds = ((int.tryParse(widget.time) ?? 0) / 1000);
    final nowSeconds = DateTime.now().millisecondsSinceEpoch / 1000;
    int diffSeconds = (beginSeconds - nowSeconds).ceil();
    _diffSeconds = ValueNotifier(diffSeconds);
    if (diffSeconds <= 0) {
      // 比赛中
      _diffSeconds.value = -1;
    } else {
      _timer = Timer.periodic(
        1.seconds,
        (timer) {
          diffSeconds--;
          _diffSeconds.value = diffSeconds;
          if (diffSeconds <= 0) {
            _timer?.cancel();
            _timer = null;
          }
        },
      );
    }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant SingleExpandToggleWidget oldWidget) {
    if (oldWidget.isExpand != widget.isExpand) {
      _isExpand.value = widget.isExpand;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _isExpand.dispose();
    _timer?.cancel();
    _timer = null;
    _diffSeconds.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onToggleExpand,
      child: Container(
        constraints: BoxConstraints(minHeight: 24.w),
        // padding: EdgeInsets.symmetric(vertical: 4.w),
        child: Row(
          children: [
            Container(
              width: 2.w,
              height: 12,
              margin: EdgeInsets.only(right: 6.w),
              decoration: BoxDecoration(
                color: '#179CFF'.hexColor,
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(2),
                ),
              ),
            ),
            Expanded(
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 12.sp,
                  color:
                      Get.isDarkMode ? AppColor.colorWhite : '#303442'.hexColor,
                  fontWeight: FontWeight.w600,
                ),
              ).paddingSymmetric(vertical: 4.w),
            ),
            Text(
              widget.subtitle,
              style: TextStyle(
                fontSize: 10,
                color:
                    Get.isDarkMode ? AppColor.colorWhite : '#303442'.hexColor,
              ),
            ),
            SizedBox(width: 4.w),
            Container(
              decoration: BoxDecoration(
                color: '#7981A4'.hexColor,
                borderRadius: BorderRadius.circular(4),
              ),
              constraints: const BoxConstraints(minHeight: 14, minWidth: 40),
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              alignment: Alignment.center,
              child: ValueListenableBuilder(
                valueListenable: _diffSeconds,
                builder: (context, diffSeconds, child) {
                  final text = diffSeconds <= 0
                      ? LocaleKeys.virtual_sports_match_status_playing.tr
                      : diffSeconds.secondsToCountdown;
                  return Text(
                    widget.cusTime.isNotEmpty ? widget.cusTime : text,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColor.colorWhite,
                    ),
                  );
                },
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _isExpand,
              builder: (context, isExpand, child) => AnimatedSwitcher(
                duration: 300.milliseconds,
                // TODO: 可能需要替换为图片：
                // assets/images/icon/icon_expand_gray_night.png
                child: Icon(
                  isExpand ? Icons.keyboard_arrow_down : Icons.navigate_next,
                  key: ValueKey(isExpand),
                  color: '#C9CDDB'.hexColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../../../bet_detail/analyze_match/analyze_news/analyze_match_result/analyze_match_result_data.dart';
import 'analyze_progressPaint.dart';

class MatchCircleProgressView extends StatefulWidget {
  ///背景圆形色值
  final Color backgroundColor;

  ///当前进度 0-100
  final double progress;

  ///进度条颜色
  final Color progressColor;

  ///圆环宽度
  final double progressWidth;

  ///宽度
  final double width;

  ///高度
  final double height;
  String? centerContent;
  AnalyzeMatchResultItem analyzeMatchResultItem;

  MatchCircleProgressView(this.analyzeMatchResultItem,
      {super.key,
      required this.progress,
      required this.width,
      required this.height,
      this.centerContent,
      this.backgroundColor = Colors.grey,
      this.progressColor = Colors.blue,
      this.progressWidth = 10.0});

  @override
  _MatchCircleProgressViewState createState() =>
      _MatchCircleProgressViewState();
}

class _MatchCircleProgressViewState extends State<MatchCircleProgressView>
    with TickerProviderStateMixin {
  static const double _Pi = 3.14;
  Animation<double>? animation;
  late AnimationController controller;
  late CurvedAnimation curvedAnimation;
  late Tween<double> tween;
  double? oldProgress;

  @override
  void initState() {
    super.initState();

    print("=======>${widget.progress}");
    oldProgress = widget.progress;
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    curvedAnimation =
        CurvedAnimation(parent: controller, curve: Curves.decelerate);
    tween = Tween();
    tween.begin = 0.0;
    tween.end = oldProgress;
    animation = tween.animate(curvedAnimation);
    animation?.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  //这里是在重新赋值进度时，再次刷新动画
  void startAnimation() {
    controller.reset();
    tween.begin = oldProgress;
    tween.end = widget.progress;
    animation = tween.animate(curvedAnimation);
    controller.forward();
    oldProgress = widget.progress;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (oldProgress != widget.progress) {
      startAnimation();
    }
    return Column(
      children: [
        Center(
          child: Text(
            widget.analyzeMatchResultItem.title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Get.theme.resultTextColor,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400),
          ),
        ).marginAll(widget.progressWidth),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${(widget.analyzeMatchResultItem.proportion > 0 ? 100 - widget.analyzeMatchResultItem.proportion : 0)}%",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.sp,
                color: Get.theme.tabPanelSelectedColor,
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Container(
              width: widget.width,
              height: widget.height,
              child: RepaintBoundary(
                child: CustomPaint(
                  painter: ProgressPaint(
                      animation?.value ?? 0 / 50 * _Pi, widget.progressWidth,
                      backgroundColor: widget.progress == 0
                          ? Color(0xFFd8d8d8)
                          : widget.backgroundColor,
                      progressColor: widget.progressColor),
                  child: SizedBox(),
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Text(
              "${(widget.analyzeMatchResultItem.proportion)}%",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.sp,
                  color: Get.theme.oddsButtonValueFontColor),
            ),
          ],
        )
      ],
    );
  }
}

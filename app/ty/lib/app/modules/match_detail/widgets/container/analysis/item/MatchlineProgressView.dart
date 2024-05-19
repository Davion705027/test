/**
 * @author[xiongwei]
 * @version[创建日期，2024/2/27 17:39]
 * @function[功能简介 ]
 **/
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get_core/src/get_main.dart';

class MatchLineProgressView extends StatefulWidget {
  ///背景圆形色值
  final Color backgroundColor;

  final Color? leftColor;
  final Color? rightColor;

  final Color? leftBackgroundColor;
  final Color? rightBackgroundColor;
  ///当前进度 0-100
  final double  leftProgress;

  final double  rightProgress;
  ///进度条颜色
  final Color progressColor;

  ///圆环宽度
  final double progressWidth;

  ///宽度
  final double width;

  ///高度
  final double height;
  String? centerContent;
  int home;
  int away;
  MatchLineProgressView(
      this.home,
      this.away,
      {super.key,
      required this.leftProgress,
        required this.rightProgress,
      required this.width,
      required this.height,
      this.centerContent,
      this.backgroundColor = Colors.grey,
      this.progressColor = Colors.blue,
        this.leftColor,
        this.rightColor,
      this.leftBackgroundColor = Colors.grey,
      this.rightBackgroundColor = Colors.grey,
      this.progressWidth = 10.0});

  @override
  _MatchLineProgressViewState createState() => _MatchLineProgressViewState();
}

class _MatchLineProgressViewState extends State<MatchLineProgressView>
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
    oldProgress = widget.leftProgress;
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
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
    tween.end = widget.leftProgress;
    animation = tween.animate(curvedAnimation);
    controller.forward();
    oldProgress = widget.leftProgress;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (oldProgress != widget.leftProgress) {
      startAnimation();
    }
    return Container(
      margin: EdgeInsets.only(top:12.w),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${widget.home}",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                  color: Get.theme.tabPanelSelectedColor),
            ),
            Text(
              widget.centerContent.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.sp,
                  color: Get.theme.resultSecondTextColor),
            ),


            Text(
              "${widget.away}",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                  color: Get.theme.tabPanelSelectedColor),
            ),
          ],
        ),
        SizedBox(height: 6.w,),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
         Expanded(child:  Container(
           height: 5,
           child: ClipRRect(
             // 边界半径（`borderRadius`）属性，圆角的边界半径。
             borderRadius: BorderRadius.all(Radius.circular(10.0)),
             //需要反过来
             child: LinearProgressIndicator(
               value:(1-widget.leftProgress),
               backgroundColor: (widget.leftProgress==0)?(widget.leftBackgroundColor??Colors.grey):(widget.leftColor??Color(0xffF2F2F6)),
               valueColor: AlwaysStoppedAnimation<Color>(widget.leftBackgroundColor??Colors.grey),
             ),
           ),
         ),),
         SizedBox(width: 8.w,),
         Expanded(child:  Container(
           width: 160,
           height: 5,
           child: ClipRRect(
             // 边界半径（`borderRadius`）属性，圆角的边界半径。
             borderRadius: BorderRadius.all(Radius.circular(10.0)),
             child: LinearProgressIndicator(
               value: widget.rightProgress,
               backgroundColor:widget.rightBackgroundColor??Color(0xffF2F2F6),
               valueColor: AlwaysStoppedAnimation<Color>(widget.rightColor?? Color(0xffFEAE2B)),
             ),
           ),
         )),
        ])
      ]),
    );
  }
}

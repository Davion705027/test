import 'package:flutter/cupertino.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

class BoxShadowContainer extends StatelessWidget{
  Widget? child;
  Color? background;
  Color? color;
  double? width;
  double? height;
  double ? radius;
  EdgeInsets? padding;
  EdgeInsets? margin;
  BoxShadowContainer({super.key,this.color,this.background,this.width,this.radius,this.margin,this.child,this.height,this.padding});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return     Container(
      alignment: Alignment.centerLeft,
      width: width??1.sw,
      height:height,
      margin: margin??EdgeInsets.symmetric(horizontal:0.w),
      padding:padding??EdgeInsets.symmetric(horizontal:20.w),
      decoration: BoxDecoration(
        color: color??Colors.white,

        boxShadow: [
          // 阴影
          BoxShadow(
              color: background??Color.fromRGBO(0, 0, 0, 0.04),
              blurRadius: 8,
              offset: Offset(0, 4.w),
              spreadRadius: 0,
              blurStyle: BlurStyle.normal),
        ],
        borderRadius: BorderRadius.all(Radius.circular(8.w)),
      ),
      child: child,
    );
  }

}
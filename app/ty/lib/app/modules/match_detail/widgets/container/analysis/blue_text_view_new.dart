import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';

import '../../../../login/login_head_import.dart';

/**
 * @author[xiongwei]
 * @version[创建日期，2024/2/28 12:10]
 * @function[功能简介 ]
 **/
class BluetextNew extends StatelessWidget {
  const BluetextNew(
    this.text,
    this.width,
    this.height, {
    super.key,
    this.decoration,
  });

  final String text;
  final double width;
  final double height;
  final Decoration? decoration;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: decoration ??
          ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.w,
                color: Get.theme.secondTabPanelSelectedFontColor,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.w,
          fontWeight: FontWeight.w400,
          color: Get.theme.secondTabPanelSelectedFontColor,
        ),
      ),
    );
  }
}

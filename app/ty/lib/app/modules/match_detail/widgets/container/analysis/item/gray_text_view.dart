
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';

import '../../../../../login/login_head_import.dart';

/**
 * @author[xiongwei]
 * @version[创建日期，2024/2/28 12:10]
 * @function[功能简介 ]
 **/
class graytext extends StatelessWidget {
  const graytext(this.text,this.width,this.height, {super.key});
  final String text;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      alignment: Alignment.center,
      width: width,
      height: height,
        decoration: ShapeDecoration(
          color: Get.theme.betPanelUnderlineColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 10.w,
            fontWeight: FontWeight.w400,
            color:Get.theme.dataContainerTextColor),
      ),
    );
  }

}

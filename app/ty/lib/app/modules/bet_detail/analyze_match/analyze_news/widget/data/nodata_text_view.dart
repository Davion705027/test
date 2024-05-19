import '../../../../../../../generated/locales.g.dart';
import '../../../../../login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
/**
 * @author[xiongwei]
 * @version[创建日期，2024/3/3 02:09]
 * @function[功能简介 ]
 **/
class nodata_text_view extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      child:  Text(LocaleKeys.common_no_data.tr,
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14.sp,
            color:Get.theme.tabPanelSelectedColor),
      ),
    );
  }
}

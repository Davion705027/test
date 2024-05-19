import 'package:flutter/cupertino.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

/**
 * @author[xiongwei]
 * @version[创建日期，2024/3/2 11:01]
 * @function[功能简介 ]
 **/
class nodata_view extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      child:  ImageView("assets/images/event/no_data.png",
        width: 200.w,
        height: 250.h,
      ),
    );
  }
}

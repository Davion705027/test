
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/core/constant/common/module/csid.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:get/get.dart';

import '../utils/oss_util.dart';

class JltWidget extends StatelessWidget {
  const JltWidget({
    super.key,
    required this.miid,
    required this.selected,
  });

  // 足球 1 篮球 2
  final int miid;
  final bool selected;

  String getPath(){
    String res = 'assets/images/jlt/play-act.png';
    if(!selected){
      if(Get.isDarkMode){
        res = 'assets/images/jlt/play-dark.png'; // 48*3264
      }else{
        res = 'assets/images/jlt/play.png';
      }
    }
    // String url = OssUtil.getServerPath(res);

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24.w,
      height: 24.w,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: - (Csid.sprite_images_postion[miid] ?? 0) * 24.w,
            child: ImageView(getPath(),width: 24.w,height: 1632.w,)
          )
        ],
      ),
    );
  }
}

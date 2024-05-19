import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../services/models/res/match_entity.dart';

/// 详情页显示棒球赛事第几节以及赛事时间
class StageChild3 extends StatelessWidget {
  const StageChild3(
      {super.key, required this.isPinnedAppbar, required this.match, required this.isMatchSelect});

  final bool isPinnedAppbar;
  final MatchEntity match;
  final bool isMatchSelect;
  @override
  Widget build(BuildContext context) {

    // ms: 0:未开始 1:进行中 2:暂停 3:结束 4:关闭
    // mmp: 0:未开赛
    // csid: 1:足球 2:篮球 3:棒球 4:冰球 5:网球 6:美式足球 7:斯诺克 8:兵乓球 9:排球 10:羽毛球

    // 从语言包里取数据文本
    // r = i18n_t('mmp')[3][mmp];
    // if(this.detail_data.mmp == 0 && this.detail_data.ms == 1){
    //   r = i18n_t('mmp')[3][401];
    // }
    String value = 'mmp_3_${match.mmp}'.tr;
    if(match.mmp == "0" && match.ms == 1){
      value = LocaleKeys.mmp_3_401.tr;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AutoSizeText(
          value,
          maxLines: 1,
          minFontSize: 8,
          style: TextStyle(
            color: isMatchSelect ? Get.theme.subSelectTitleColor : Colors.white,
            fontSize: isPinnedAppbar ? 14.sp : 12.sp,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

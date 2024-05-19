import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../generated/locales.g.dart';

class FooterView extends StatelessWidget {
  const FooterView({super.key});
  @override
  Widget build(BuildContext context) {
    Color color = Colors.white.withOpacity(0.5999999761581421);

    if (context.isDarkMode) {
      color = Colors.white.withOpacity(0.7999999761581421);
    }
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Text(
            LocaleKeys.app_pull_up_loading.tr,
            style: TextStyle(
              fontSize: 13.sp,
              color: color,
            ),
          );
        } else if (mode == LoadStatus.loading) {
          body = CupertinoActivityIndicator(
            color: color,
          );
        } else if (mode == LoadStatus.failed) {
          body = Text(
            LocaleKeys.app_failed_to_load.tr,
            style: TextStyle(
              fontSize: 13.sp,
              color: color,
            ),
          );
        } else if (mode == LoadStatus.canLoading) {
          body = Text(
            LocaleKeys.app_release_to_load_more.tr,
            style: TextStyle(
              fontSize: 13.sp,
              color: color,
            ),
          );
        } else if (mode == LoadStatus.noMore) {
          body = Text(
            LocaleKeys.app_no_more_data.tr,
            style: TextStyle(
              fontSize: 13.sp,
              color: color,
            ),
          );
        } else {
          // body = Text("没有更多数据");
          body = Text("");
        }
        return Container(
          height: 35.h,
          child: Center(
            child: body,
          ),
        );
      },
    );
  }
}

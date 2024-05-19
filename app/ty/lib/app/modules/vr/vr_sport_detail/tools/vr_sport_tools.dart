import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';

///图片加载
Widget imageloader(BuildContext context, String url) {
  return const Center(
      child: CircularProgressIndicator(
    color: Colors.white,
  ));
}

Widget imageerror(BuildContext context, String url, Object error) {
  return const ImageView(
    'assets/images/data/icondefault.png',

    ///临时添加默认图片的尺寸
    width: 50,
    // fit: BoxFit.contain,
  );
}
///悬停公共样式
class sliverChildListDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final double tabHeadHeight;
  Function? callback;

  sliverChildListDelegate(
    this.widget,
    this.tabHeadHeight,
    this.callback,
  );

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    callback!(overlapsContent, shrinkOffset);
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.transparent,
          child: widget,
        ),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => tabHeadHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => tabHeadHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

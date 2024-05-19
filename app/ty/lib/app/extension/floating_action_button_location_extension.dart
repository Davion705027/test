import 'package:flutter/material.dart';

extension FloatingActionButtonLocationOffset on FloatingActionButtonLocation {
  // offset 注意传值，因为内部都是使用的加法运算
  FloatingActionButtonLocation cusOffset({
    Offset offset = Offset.zero,
  }) {
    return _CusOffsetFabLocation(
      baseLocation: this,
      offset: offset,
    );
  }
}

class _CusOffsetFabLocation implements FloatingActionButtonLocation {
  final FloatingActionButtonLocation baseLocation;
  final Offset offset;

  _CusOffsetFabLocation({
    required this.baseLocation,
    required this.offset,
  });

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final baseOffset = baseLocation.getOffset(scaffoldGeometry);
    return baseOffset + offset;
  }
}

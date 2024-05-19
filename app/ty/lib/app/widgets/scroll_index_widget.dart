import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_core/src/get_main.dart';

typedef ViewPortCallBack = void Function(int firstIndex, int lastIndex);
typedef ScrollEndCallBack = void Function(bool endScroll);

bool isScrolling = false;

class ScrollIndexWidget extends StatelessWidget {
  final Widget child;
  final bool isStopCallback;
  final ViewPortCallBack callBack;
  final ScrollEndCallBack? endCallBack;

  const ScrollIndexWidget(
      {super.key,
      required this.child,
      required this.callBack,
      this.isStopCallback = true,
      this.endCallBack});

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: _onNotification,
      child: child,
    );
  }

  bool _onNotification(ScrollNotification notification) {
    final SliverMultiBoxAdaptorElement? element =
        findSliverMultiBoxAdaptorElement(notification.context! as Element);
    if (element == null) return false;

    final viewPortDimension = notification.metrics.viewportDimension;
    int firstIndex = 0;
    int lastIndex = 0;

    void onVisitChildren(Element element) {
      final SliverMultiBoxAdaptorParentData oldParentData =
          element.renderObject?.parentData as SliverMultiBoxAdaptorParentData;

      double layoutOffset = oldParentData.layoutOffset!;
      double pixels = notification.metrics.pixels;
      double all = pixels + viewPortDimension;

      if (layoutOffset >= pixels) {
        firstIndex = min(firstIndex, oldParentData.index!);
        if (layoutOffset <= all) {
          lastIndex = max(lastIndex, oldParentData.index!);
        }
        firstIndex = max(firstIndex, 0);
      } else {
        lastIndex = firstIndex = oldParentData.index!;
      }
    }

    element.visitChildren(onVisitChildren);

    /// 停止滚动才回调
    if (isStopCallback) {
      if (notification is ScrollEndNotification) {
        Future.delayed(Duration(milliseconds: 200), () {
          if (!isScrolling) {
            callBack(firstIndex, lastIndex);
          }
        });
      }
    } else {
      callBack(firstIndex, lastIndex);
    }
    switch (notification.runtimeType) {
      case ScrollStartNotification:
        Get.log('开始滚动');
        isScrolling = true;
        endCallBack?.call(false);
        break;
      case ScrollUpdateNotification:
        Get.log('正在滚动');
        isScrolling = true;
        endCallBack?.call(false);
        break;
      case ScrollEndNotification:
        isScrolling = false;
        Get.log('停止滚动');
        Future.delayed(const Duration(milliseconds: 200), () {
          if (!isScrolling) {
            endCallBack?.call(true);
          }
        });
        break;
      case OverscrollNotification:
        isScrolling = true;
        Get.log('滚动到边界');
        endCallBack?.call(false);
        break;
      default:
        break;
    }
    return false;
  }

  SliverMultiBoxAdaptorElement? findSliverMultiBoxAdaptorElement(
      Element? element) {
    if (element is SliverMultiBoxAdaptorElement) {
      return element;
    }
    if (element == null) {
      return null;
    }
    SliverMultiBoxAdaptorElement? target;
    element.visitChildElements((element) {
      target ??= findSliverMultiBoxAdaptorElement(element);
    });
    return target;
  }
}

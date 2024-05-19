import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/common_empty_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommonRefresher extends StatelessWidget {
  const CommonRefresher({
    super.key,
    required this.controller,
    this.scrollController,
    this.onRefresh,
    this.onLoading,
    this.enablePullDown = true,
    this.enablePullUp = false,
    this.header,
    this.footer,
    this.onTwoLevel,
    this.dragStartBehavior,
    this.primary,
    this.cacheExtent,
    this.semanticChildCount,
    this.reverse,
    this.physics,
    this.scrollDirection,
    this.child,
    this.isLoading = false,
    this.isEmpty = false,
    this.emptyView,
  });

  final RefreshController controller;
  final ScrollController? scrollController;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoading;
  final bool enablePullDown;
  final bool enablePullUp;
  final Widget? header;
  final Widget? footer;
  final ValueChanged<bool>? onTwoLevel;
  final DragStartBehavior? dragStartBehavior;
  final bool? primary;
  final double? cacheExtent;
  final int? semanticChildCount;
  final bool? reverse;
  final ScrollPhysics? physics;
  final Axis? scrollDirection;
  final Widget? child;
  // TODO: 待完善
  final bool isLoading;
  final bool isEmpty;
  final Widget? emptyView;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller,
      scrollController: scrollController,
      onRefresh: onRefresh,
      onLoading: onLoading,
      enablePullDown: enablePullDown,
      enablePullUp: enablePullUp,
      header: header,
      footer: footer,
      onTwoLevel: onTwoLevel,
      dragStartBehavior: dragStartBehavior,
      primary: primary,
      cacheExtent: cacheExtent,
      semanticChildCount: semanticChildCount,
      reverse: reverse,
      physics: physics,
      scrollDirection: scrollDirection,
      child: isLoading
          ? const CupertinoActivityIndicator().center
          : isEmpty
              ? (emptyView ?? const CommonEmptyView()).center
              : child,
    );
  }
}

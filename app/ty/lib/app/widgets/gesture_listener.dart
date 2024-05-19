import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

/// 当子widget拦截了事件时，外层无法获取Gesture时，该类可以帮助你获取外层的Gesture垂直方向事件，以便解决child事件冲突的影响
class KqVerticalDragGestureListener extends StatelessWidget {
  final Widget? child;
  final GestureDragUpdateCallback? onVerticalDragUpdate;

  const KqVerticalDragGestureListener(
      {super.key, required this.child, this.onVerticalDragUpdate});

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(gestures: {
      _MultipleVerticalDragGestureRecogniser:
      GestureRecognizerFactoryWithHandlers<
          _MultipleVerticalDragGestureRecogniser>(
              () => _MultipleVerticalDragGestureRecogniser(),
              (_MultipleVerticalDragGestureRecogniser instance) {
            instance.onUpdate = (g) {
              onVerticalDragUpdate?.call(g);
            };
          })
    }, child: child);
  }
}

class _MultipleVerticalDragGestureRecogniser
    extends VerticalDragGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    //这句就是让该widget也能获取到事件
    acceptGesture(pointer);
  }
}
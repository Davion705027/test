
// 自定义的UnderlineTabIndicator
import '../modules/login/login_head_import.dart';

class RoundedUnderlineTabIndicator extends Decoration {
  final Color color;
  final double thickness;
  final double radius;
  final EdgeInsetsGeometry insets;

  RoundedUnderlineTabIndicator({
    this.color = Colors.blue,
    this.thickness = 3.0,
    this.radius = 2.0,
    this.insets = EdgeInsets.zero,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _RoundedUnderlinePainter(this, onChanged);
  }
}

class _RoundedUnderlinePainter extends BoxPainter {
  final RoundedUnderlineTabIndicator _indicator;

  _RoundedUnderlinePainter(this._indicator, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = Offset(
        offset.dx + _indicator.insets.horizontal,
        configuration.size!.height - _indicator.thickness) &
    Size(
        configuration.size!.width -
            _indicator.insets.horizontal,
        _indicator.thickness);

    final paint = Paint()
      ..color = _indicator.color
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(_indicator.radius)),
      paint,
    );
  }
}

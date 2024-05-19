import '../../login/login_head_import.dart';

class DashedLinePainter extends CustomPainter {
  final Color color;

  DashedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square
      ..isAntiAlias = true;

    double dashHeight = 5;
    double dashSpace = 5;
    double startX = size.width / 2;

    for (double i = 0; i < size.height; i += dashHeight + dashSpace) {
      canvas.drawLine(Offset(startX, i), Offset(startX, i + dashHeight), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
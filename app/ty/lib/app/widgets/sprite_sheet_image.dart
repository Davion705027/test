import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

class SpriteSheetImage extends StatefulWidget {
  final String imagePath;
  final int top;
  final double width;
  final double height;

  static SpriteSheetImage league(
      {required int index,
      required double width,
      required double height,
      required bool isSelected}) {
    if (isSelected) {
      return SpriteSheetImage.leagueSel(
          top: index, width: width, height: height);
    }
    if (Get.isDarkMode) {
      return SpriteSheetImage.leagueNight(
          top: index, width: width, height: height);
    } else {
      return SpriteSheetImage.leagueDay(
          top: index, width: width, height: height);
    }
  }

  /// 球类夜间
  const SpriteSheetImage.sportNight(
      {Key? key, required this.top, required this.width, required this.height})
      : imagePath = 'assets/images/home/sport_night.svg',
        super(key: key);

  /// 球类白天
  const SpriteSheetImage.sportDay(
      {Key? key, required this.top, required this.width, required this.height})
      : imagePath = 'assets/images/home/sport_nor.svg',
        super(key: key);

  /// 球类选中
  const SpriteSheetImage.sportSel(
      {Key? key, required this.top, required this.width, required this.height})
      : imagePath = 'assets/images/home/sport_sel.svg',
        super(key: key);

  static SpriteSheetImage sport(
      {required int index,
      required double width,
      required double height,
      required bool isSelected}) {
    if (isSelected) {
      return SpriteSheetImage.sportSel(
          top: index, width: width, height: height);
    }
    if (Get.isDarkMode) {
      return SpriteSheetImage.sportNight(
          top: index, width: width, height: height);
    } else {
      return SpriteSheetImage.sportDay(
          top: index, width: width, height: height);
    }
  }

  /// 联赛暗黑
  const SpriteSheetImage.leagueNight(
      {Key? key, required this.top, required this.width, required this.height})
      : imagePath = 'assets/images/home/league_night.png',
        super(key: key);

  /// 联赛白天
  const SpriteSheetImage.leagueDay(
      {Key? key, required this.top, required this.width, required this.height})
      : imagePath = 'assets/images/home/league_nor.png',
        super(key: key);

  /// 联赛选中
  const SpriteSheetImage.leagueSel(
      {Key? key, required this.top, required this.width, required this.height})
      : imagePath = 'assets/images/home/league_sel.png',
        super(key: key);

  const SpriteSheetImage({
    super.key,
    required this.imagePath,
    required this.width,
    required this.height,
    required this.top,
  });

  @override
  State<SpriteSheetImage> createState() => _SpriteSheetImageState();
}

class _SpriteSheetImageState extends State<SpriteSheetImage> {
  ui.Image? image;
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
      final data = await rootBundle.load(widget.imagePath);
      final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
      final frame = await codec.getNextFrame();
      setState(() {
        image = frame.image;
      });
  }

  @override
  Widget build(BuildContext context) {
    if(image == null) return const SizedBox.shrink();

    return CustomPaint(
      size: Size(widget.width,widget.height),
      painter: _SpriteSheetPainter(
        image: image!,
        srcRect: Rect.fromLTWH(0, (widget.top * image!.width).toDouble(), image!.width.toDouble(), image!.width.toDouble())
      ),
    );
  }
}

class _SpriteSheetPainter extends CustomPainter {
  final ui.Image image;
  final Rect srcRect;

  _SpriteSheetPainter({required this.image, required this.srcRect});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImageRect(
      image,
      srcRect, // Source rectangle within the image
      Rect.fromLTWH(0, 0, size.width, size.height), // Destination rectangle on the canvas
      Paint(),
    );
  }

  @override
  bool shouldRepaint(covariant _SpriteSheetPainter oldDelegate) {
    return image != oldDelegate.image || srcRect != oldDelegate.srcRect;
  }
}

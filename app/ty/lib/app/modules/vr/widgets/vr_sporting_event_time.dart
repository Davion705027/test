import 'package:flutter/material.dart';

import 'simple_circular_progress_bar.dart';
// import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class VrSportingEventTime extends StatelessWidget {
  const VrSportingEventTime({
    super.key,
    this.progressColor,
    this.backColor,
    required this.round,
    this.size = 60,
    this.valueSize,
    this.roundSize,
  });

  final Color? progressColor;
  final Color? backColor;
  final int round;
  final double size;
  final double? valueSize;
  final double? roundSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SimpleCircularProgressBar(
          mergeMode: true,
          maxValue: 59,
          size: size,
          backStrokeWidth: 2,
          backColor: backColor ?? Colors.black26,
          progressStrokeWidth: 2,
          progressColors: [
            progressColor ?? Colors.yellow,
          ],
          onGetText: (double value) {
            return Text(
              '00:${value.toInt()}',
              style: TextStyle(
                fontSize: valueSize ?? 10,
                color: progressColor ?? Colors.yellow,
              ),
            );
          },
        ),
        const SizedBox(height: 18),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.black26,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: Text(
            '第 $round 轮',
            style: TextStyle(
              color: Colors.white,
              fontSize: roundSize,
            ),
          ),
        ),
      ],
    );
  }
}

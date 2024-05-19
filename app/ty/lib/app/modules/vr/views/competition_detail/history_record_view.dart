import 'dart:math';

import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

class HistoryRecordView extends StatelessWidget {
  const HistoryRecordView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Column：消除父组件 Expanded 效果
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w).copyWith(top: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColor.colorWhite,
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HistoryRecordScore(
                leftScore: 8,
                rightScore: 5,
              ),
              HistoryRecordScore(
                leftScore: 3,
                rightScore: 2,
              ),
              HistoryRecordScore(
                leftScore: 2,
                rightScore: 0,
              ),
              HistoryRecordScore(
                leftScore: 5,
                rightScore: 5,
              ),
              HistoryRecordScore(
                leftScore: 5,
                rightScore: 2,
              ),
              HistoryRecordPercent(),
            ],
          ),
        ),
      ],
    );
  }
}

class HistoryRecordPercent extends StatelessWidget {
  const HistoryRecordPercent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildContainer(
          percent: '80%',
          letters: ['W', 'W', 'D', 'W', 'W'],
          bgColorHexs: ['#F53F3F', '#F53F3F', '##FEAE2B', '#F53F3F', '#F53F3F'],
        ),
        const SizedBox(width: 8),
        _buildContainer(
          percent: '50%',
          letters: ['L', 'W', 'D', 'L', 'W'],
          bgColorHexs: [
            '##00B42A',
            '#F53F3F',
            '##FEAE2B',
            '##00B42A',
            '#F53F3F'
          ],
        ),
      ],
    );
  }

  Widget _buildContainer({
    required String percent,
    required List<String> letters,
    required List<String> bgColorHexs,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: '#F2F2F6'.hexColor,
        ),
        child: Column(
          children: [
            Text(
              percent,
              style: TextStyle(
                color: '#303442'.hexColor,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 4,
              children: List.generate(
                letters.length,
                (index) {
                  final letter = letters[index];
                  String bgColorHex = '#F53F3F';
                  if (bgColorHexs.isNotEmpty && bgColorHexs.length > index) {
                    bgColorHex = bgColorHexs[index];
                  }

                  return _buildLetterWidget(bgColorHex, letter);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLetterWidget(String bgColorHex, String letter) {
    return UnconstrainedBox(
      child: Container(
        constraints: const BoxConstraints(minWidth: 20, minHeight: 16),
        decoration: BoxDecoration(
          color: bgColorHex.hexColor,
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.center,
        child: Text(
          letter,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: AppColor.colorWhite,
          ),
        ),
      ),
    );
  }
}

class HistoryRecordScore extends StatelessWidget {
  const HistoryRecordScore({
    super.key,
    required this.leftScore,
    required this.rightScore,
    this.maxScore = 10,
  });

  final int leftScore;
  final int rightScore;
  final int maxScore;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$leftScore - $rightScore',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: '#303442'.hexColor,
          ),
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            _buildScoreGraphic(isLeft: true),
            const SizedBox(width: 2),
            _buildScoreGraphic(isLeft: false),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildScoreGraphic({
    required bool isLeft,
  }) {
    return Expanded(
      child: Container(
        height: 3,
        decoration: BoxDecoration(
          color: '#F2F2F6'.hexColor,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(isLeft ? 3 : 0),
            right: Radius.circular(!isLeft ? 3 : 0),
          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final maxWidth = constraints.maxWidth;
            return Container(
              margin: EdgeInsets.only(
                  left: isLeft
                      ? min(maxWidth - 1,
                          (maxScore - leftScore) / maxScore * maxWidth)
                      : 0,
                  right: !isLeft
                      ? min(maxWidth - 1,
                          (maxScore - rightScore) / maxScore * maxWidth)
                      : 0),
              decoration: BoxDecoration(
                color: (isLeft ? '#F53F3F' : '#FEAE2B').hexColor,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(isLeft ? 3 : 0),
                  right: Radius.circular(!isLeft ? 3 : 0),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

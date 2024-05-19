import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';

class VrHorseNewWidget extends StatefulWidget {
  const VrHorseNewWidget({
    super.key,
  });

  @override
  State<VrHorseNewWidget> createState() => _VrHorseNewWidgetState();
}

class _VrHorseNewWidgetState extends State<VrHorseNewWidget> {
  int _selTeamIndex = 0;

  _onTeamChanged(int index) {
    if (_selTeamIndex == index) return;
    _selTeamIndex = index;
    // TODO: 更新播放视频
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 380 / 190,
          child: Stack(
            children: [
              // TODO: video area
              Container(
                color: Colors.grey,
              ),
            ],
          ),
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 8.w,
            childAspectRatio: 179 / 40,
          ),
          shrinkWrap: true,
          padding: EdgeInsets.all(8.w),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            final isSelected = _selTeamIndex == index;
            return GestureDetector(
              onTap: () => _onTeamChanged(index),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isSelected ? '#D1EBFF'.hexColor : AppColor.colorWhite,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 2),
                      blurRadius: 6,
                      color: Colors.black.withOpacity(0.04),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTeamNameScore(
                      teamName: '布莱顿海鸥',
                      score: 0,
                      isSelected: isSelected,
                    ),
                    _buildTeamNameScore(
                      teamName: '维拉人',
                      score: 0,
                      isSelected: isSelected,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTeamNameScore({
    required String teamName,
    required int score,
    bool isSelected = false,
  }) {
    return DefaultTextStyle(
      style: TextStyle(
        fontSize: 12,
        color: (isSelected ? '#127DCC' : '#303442').hexColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              teamName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            '$score',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

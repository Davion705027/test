import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sport_replay_entity.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';

import '../../../utils/oss_util.dart';
import 'basketball_remain_time_widget.dart';

class BasketballFinishedWidget extends StatefulWidget {
  const BasketballFinishedWidget({
    super.key,
    required this.teams,
    required this.mhlu,
    required this.malu,
    this.score,
    this.onNextMatchCountdownEnd,
  });

  final List<String> teams;
  final String mhlu;
  final String malu;
  final VrSportReplayDetailScoreRanking? score;
  final VoidCallback? onNextMatchCountdownEnd;

  @override
  State<BasketballFinishedWidget> createState() =>
      _BasketballFinishedWidgetState();
}

class _BasketballFinishedWidgetState extends State<BasketballFinishedWidget> {
  bool _showFinish = false;

  @override
  void initState() {
    5.seconds.delay(() {
      _showFinish = true;
      if (mounted) setState(() {});
    });
    15.seconds.delay(() {
      widget.onNextMatchCountdownEnd?.call();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_showFinish) {
      return const BasketballRemainTimeWidget(isFinish: true);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                OssUtil.getServerPath(
                  'assets/images/vr/vr_basketball_finished_top_bg.png',
                ),
              ),
              scale: 3,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 2),
          alignment: Alignment.center,
          child: Text(
            LocaleKeys.virtual_sports_match_status_ended.tr,
            style: TextStyle(
              color: '#303442'.hexColor,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              color: AppColor.colorWhite,
              constraints: const BoxConstraints(minHeight: 54),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    constraints: const BoxConstraints(minWidth: 80),
                    alignment: Alignment.center,
                    child: Text(
                      widget.teams.firstOrNull ?? '布莱顿海鸥',
                      style: TextStyle(
                        color: '#303442'.hexColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    color: '#303442'.hexColor,
                    constraints:
                        const BoxConstraints(minWidth: 36, minHeight: 28),
                    alignment: Alignment.center,
                    child: Text(
                      widget.score?.home ?? '0',
                      style: const TextStyle(
                        color: AppColor.colorWhite,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    color: '#303442'.hexColor,
                    constraints:
                        const BoxConstraints(minWidth: 36, minHeight: 28),
                    alignment: Alignment.center,
                    child: Text(
                      widget.score?.away ?? '0',
                      style: const TextStyle(
                        color: AppColor.colorWhite,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(minWidth: 80),
                    alignment: Alignment.center,
                    child: Text(
                      widget.teams.lastOrNull ?? '维拉人',
                      style: TextStyle(
                        color: '#303442'.hexColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: -18,
              child: ImageView(
                widget.mhlu,
                cdn: true,
                width: 36,
                height: 36,
              ),
            ),
            Positioned(
              right: -18,
              child: ImageView(
                widget.malu,
                cdn: true,
                width: 36,
                height: 36,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

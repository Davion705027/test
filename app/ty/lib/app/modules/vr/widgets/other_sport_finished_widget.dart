import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/next_match_countdown_widget.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sport_replay_entity.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';

class OtherSportFinishedWidget extends StatelessWidget {
  const OtherSportFinishedWidget({
    super.key,
    required this.teams,
    this.score,
    this.onNextMatchCountdownEnd,
    this.nextVrMatch,
    this.callbackSeconds = 10,
  });

  final List<String> teams;
  final VrSportReplayDetailScoreRanking? score;
  final VoidCallback? onNextMatchCountdownEnd;
  final VrMatchEntity? nextVrMatch;

  /// 触发回调时间：单位秒，默认 10 秒
  final int callbackSeconds;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UnconstrainedBox(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.black.withOpacity(0.6),
            ),
            constraints: const BoxConstraints(minHeight: 24),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.center,
            child: Text(
              LocaleKeys.list_match_end.tr,
              style: const TextStyle(
                color: AppColor.colorWhite,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Container(
          color: Colors.black.withOpacity(0.6),
          constraints: const BoxConstraints(minHeight: 54),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageView(
                'assets/images/vr/vr_dog_horse_rank${score?.ranking1 ?? '1'}.png',
                width: 36,
                height: 36,
              ),
              ImageView(
                'assets/images/vr/vr_dog_horse_rank${score?.ranking2 ?? '2'}.png',
                width: 36,
                height: 36,
              ).marginSymmetric(horizontal: 24),
              ImageView(
                'assets/images/vr/vr_dog_horse_rank${score?.ranking3 ?? '3'}.png',
                width: 36,
                height: 36,
              ),
            ],
          ),
        ).marginSymmetric(vertical: 20),
        if (nextVrMatch != null)
          NextMatchCountdownWidget(
            nextVrMatch: nextVrMatch,
            onCountdownEnd: onNextMatchCountdownEnd,
            callbackSeconds: callbackSeconds,
          ),
      ],
    );
  }
}

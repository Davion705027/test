import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/extensions/vr_sport_extensions.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/single_expand_toggle_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/waiting_dog_horse_ratio_widget.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_match_entity.dart';

import 'waiting_balls_header_widget.dart';
import 'waiting_balls_teams_ratio_widget.dart';

class WaitingSportWidget extends StatefulWidget {
  const WaitingSportWidget({
    super.key,
    required this.type,
    required this.vrMatch,
    required this.isExpand,
    required this.title,
    this.cusTime = '',
    this.onToggleExpand,
  });

  final int type;
  final VrMatchEntity vrMatch;
  final bool isExpand;
  final String title;
  final String cusTime;
  final ValueChanged<bool>? onToggleExpand;

  @override
  State<WaitingSportWidget> createState() => _WaitingSportWidgetState();
}

class _WaitingSportWidgetState extends State<WaitingSportWidget> {
  bool get _isBalls => widget.type <= 2;

  late String _beginTime;
  Timer? _timer;
  bool _countdownEnd = false;
  late final ValueNotifier<bool> _lockOdds;

  @override
  void initState() {
    _lockOdds = ValueNotifier(false);
    _beginTime = widget.vrMatch.matchs
            .firstWhereOrNull((element) => element.mgt.isNotEmpty)
            ?.mgt ??
        '';
    if (_beginTime.isNotEmpty) {
      final beginTimeMs = int.tryParse(_beginTime) ?? 0;
      final nowMs = DateTime.now().millisecondsSinceEpoch;
      int diffMs = beginTimeMs - nowMs;
      _countdownEnd = diffMs <= 1000;
      _lockOdds.value = diffMs <= 10 * 1000;
      _timer = Timer.periodic(1.seconds, (timer) {
        diffMs -= 1000;
        if (diffMs <= 10 * 1000) {
          _lockOdds.value = diffMs <= 10 * 1000;
          if (mounted) setState(() {});
        }
        if (diffMs <= 1000) {
          _countdownEnd = true;
          if (mounted) setState(() {});
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    _lockOdds.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_countdownEnd) return const SizedBox();
    late bool isProfess;
    try {
      isProfess = HomeController.to.homeState.isProfess;
    } catch (e) {
      isProfess = true;
    }
    return Container(
      margin: EdgeInsets.only(top: 8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Get.isDarkMode
            ? Colors.white.withOpacity(0.03999999910593033)
            : AppColor.colorWhite,
      ),
      child: Column(
        children: [
          SingleExpandToggleWidget(
            key: ValueKey('eapand_${widget.vrMatch.batchNo}'),
            title: widget.title,
            subtitle: widget.vrMatch.no,
            time: _beginTime,
            cusTime: widget.cusTime,
            isExpand: widget.isExpand,
            onToggleExpand: widget.onToggleExpand,
          ),
          if (widget.isExpand)
            Column(
              children: [
                if (_isBalls) ...[
                  if (isProfess)
                    WaitingBallsHeaderWidget(
                      hpns: widget.vrMatch.hpns,
                    ),
                  ValueListenableBuilder(
                    valueListenable: _lockOdds,
                    builder:
                        (BuildContext context, bool lockOdds, Widget? child) {
                      return WaitingBallsTeamsRatioWidget(
                        key: ValueKey(lockOdds),
                        type: widget.type,
                        vrMatch: widget.vrMatch,
                        lockOdds: lockOdds,
                      );
                    },
                  ),
                ] else
                  ValueListenableBuilder(
                    valueListenable: _lockOdds,
                    builder:
                        (BuildContext context, bool lockOdds, Widget? child) {
                      return WaitingDogHorseRatioWidget(
                        type: widget.type,
                        vrMatch: widget.vrMatch,
                        lockOdds: lockOdds,
                      );
                    },
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Widget getDetailWidget(){
    return Row(
      children: [
        const SizedBox().expanded(),
        DefaultTextStyle(
          style: TextStyle(
            fontSize: 10,
            color: Get.isDarkMode
                ? Colors.white.withOpacity(0.8999999761581421)
                : '#303442'.hexColor,
            height: 14 / 10,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  [
              const Text(""),
              const Column(children: [
                const Text("")
              ],)
            ],
          ),
        ).expanded(),
      ],
    );
  }
}

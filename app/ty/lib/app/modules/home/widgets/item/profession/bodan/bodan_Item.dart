
import 'dart:math';

import 'package:flutter_ty_app/app/extension/num_extension.dart';

import '../../../../../../services/models/res/match_entity.dart';
import '../../../../../login/login_head_import.dart';
import '../../../../../match_detail/widgets/container/odds_info/odds_button.dart';
import 'package:flutter_ty_app/app/modules/home/logic/other_player_name_to_playid.dart';

class bodan_Item extends StatelessWidget {
  const bodan_Item(
      {super.key,
        required this.title,
        required this.list,
        required this.match,
        required this.hps,
        required this.maxLine,
        required this.type});

  final MatchEntity match;
  final String title;
  final MatchHps hps;
  final List<MatchHpsHlOl> list;
  final int maxLine;
  final int type;

  @override
  Widget build(BuildContext context) {
    double width = ((Get.width - 28.w - 8.w - 8.w) / 6).toDouble();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: width,
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 10.sp,
              color: context.isDarkMode
                  ? Colors.white.withOpacity(0.8999999761581421)
                  : const Color(0xff949AB6),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        4.verticalSpace,
        SizedBox(
          width: width,
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: max(list.length, maxLine),
            separatorBuilder: (BuildContext context, int index) {
              return 2.verticalSpace;
            },
            itemBuilder: (BuildContext context, int index) {
              return OddsButton(
                height: 32.w,
                width: width,
                match: match,
                radius: 4.w,
                secondaryPaly: true,
                hps: hps,
                type: type,
                hl: hps.hl.safeFirst,
                ol: list.safe(index),
                nameColor: const Color(0xff3AA6FC),
                playId: playIdConfig.hpsBold,
              );
            },
          ),
        ),
      ],
    );
  }
}

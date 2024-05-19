import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/champion/champion_item_body_widget.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/match_list_item_header_widget.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../../global/data_store_controller.dart';
import '../../../../../services/models/res/match_entity.dart';
import '../../../models/section_group_enum.dart';

/**
 * 冠军页面 item
 * */
class ChampionItemWidget extends StatelessWidget {
  const ChampionItemWidget({
    super.key,
    required this.match,
    required this.sectionGroupEnum,
  });

  final MatchEntity match;
  final SectionGroupEnum sectionGroupEnum;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataStoreController>(
        id: MATCH_ID + match.mid,
        builder: (logic) {
          MatchEntity matchEntity = logic.getMatchById(match.mid) ?? match;
          return RepaintBoundary(
            child: Container(
              padding:
                  EdgeInsets.only(top: 8.h, left: 5.w, right: 5.w, bottom: 3.h),
              child: Container(
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? Colors.white.withOpacity(0.03999999910593033)
                      : const Color(0xffF8F9FA),
                  borderRadius: BorderRadius.circular(8.r),
                  border: context.isDarkMode
                      ? null
                      : Border.all(color: const Color(0xffFFFFFF), width: 1),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MatchListItemHeaderWidget(
                      matchEntity: matchEntity,
                      onExpandChange: (value) {
                        matchEntity.isExpand = value;
                        HomeController.to.update();
                      },
                      length: matchEntity.isExpand
                          ? ""
                          : matchEntity.hps.length.toString(),
                      isGuanjun: true,
                    ).paddingSymmetric(vertical: 2.h),
                    if (matchEntity.isExpand)
                      Divider(
                        height: 0.5,
                        color: context.isDarkMode
                            ? Colors.white.withOpacity(0.07999999821186066)
                            : const Color(0xffE4E6ED),
                      ),
                    if (matchEntity.isExpand)
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ChampionItemBodyWidget(
                            matchHps: matchEntity.hps[index],
                            matchEntity: matchEntity,
                          );
                        },
                        itemCount: matchEntity.hps.length,
                      ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

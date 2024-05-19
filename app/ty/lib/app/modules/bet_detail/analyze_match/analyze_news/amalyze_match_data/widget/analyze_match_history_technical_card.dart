import 'package:flutter_ty_app/app/modules/bet_detail/analyze_match/analyze_news/amalyze_match_data/widget/analyze_match_history_technical_header.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_match_history_battle_dto_map_entity.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../match_detail/controllers/match_detail_controller.dart';
import '../../../../../match_detail/widgets/container/analysis/item/analyze_divider.dart';
import '../../../../../match_detail/widgets/container/analysis/item/text_no_data.dart';
import '../analyze_match_data_logic.dart';
import 'analyze_match_history_technical_item.dart';

class AnalyzeMatchHistoryTechnicalCard extends StatelessWidget {
  List<AnalyzeMatchHistoryBattleDTOMapEntity> entitys;
  bool first;
  AnalyzeMatchHistoryTechnicalCard(this.entitys, this.first, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyzeMatchDataLogic>(
        id: "buildRecentHistory",
        builder: (controller) {
          MatchDetailController detailController = Get.find<MatchDetailController>(tag: controller.tag);
          String url = (first == true)
              ? detailController.detailState?.match?.mhlu[0]
              : detailController.detailState?.match?.malu[0];
          return Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                height: 32.w,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Container(
                      width: 20.w,
                      height: 20.w,
                      alignment: Alignment.center,
                      child: ImageView(
                        url??"",

                        width: 20.w,
                        height: 20.w,
                        cdn: true,
                        // cdn: true,
                      ),
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Expanded(
                      child: Text(
                        entitys.firstOrNull?.coachName ??
                            '', //controller.teamsNames[first==true?0:1],
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Get.theme.tabPanelSelectedColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AnalyzeDivider(),
              buildjishu(entitys),
            ],
          );
        });
  }

  buildjishu(List<AnalyzeMatchHistoryBattleDTOMapEntity> entitys) {
    return entitys.isEmpty
        ? TextNoData()
        : Container(
        margin: EdgeInsets.all(5.w),
        child: Column(
          children: [
            AnalyzeMatchHistoryTechnicalHeader(),
            Container(
              margin: EdgeInsets.only(top: 5.w),
              child: AnalyzeDivider(),
            ),
            ListView.separated(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: entitys.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              //列表项构造器
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: AnalyzeMatchHistoryTechnicalItem(entitys[index]),
                );
              },
              //分割器构造器
              separatorBuilder: (BuildContext context, int index) {
                return AnalyzeDivider();
              },
            ),
          ],
        ));
  }
}

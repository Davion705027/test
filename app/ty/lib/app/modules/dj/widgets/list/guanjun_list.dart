import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/section_group_enum.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/champion/champion_item_widget.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/seaction_header_widget.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/widgets/scroll_index_widget.dart';

class GuanjunListView extends StatelessWidget {
  const GuanjunListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Container(
        color: context.isDarkMode
            ? Colors.white.withOpacity(0.03999999910593033)
            : const Color(0xfff2f2f6),
        child: ScrollIndexWidget(
          callBack: (int firstIndex, int lastIndex) {
            Get.log('firstIndex: $firstIndex, lastIndex: $lastIndex');
          },
          child: CustomScrollView(
            slivers: [
              ..._sliverList(controller, SectionGroupEnum.ALL),
            ],
          ),
        ),
      );
    });
  }

  List<Widget> _sliverList(
      HomeController controller, SectionGroupEnum sectionGroupEnum) {
    List<Widget> list = [];
    list.add(
      SliverToBoxAdapter(
        child: SectionHeaderWidget(
          sectionGroupEnum: sectionGroupEnum,
          isExpand: controller.homeState.expandMap[sectionGroupEnum] ?? true,
          onExpand: (isExpand) {
            controller.homeState.expandMap[sectionGroupEnum] = isExpand;
            controller.homeState.matchtSet.forEach((element) {
              MatchEntity matchEntity =
                  DataStoreController.to.getMatchById(element.mid) ?? element;
              matchEntity.isExpand = isExpand;
              DataStoreController.to.updateMatch(matchEntity);
            });
          },
        ),
      ),
    );
    list.add(
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ChampionItemWidget(
              match: controller.homeState.matchtSet[index],
              sectionGroupEnum: sectionGroupEnum,
            );
          },
          childCount: controller.homeState.matchtSet.length,
        ),
      ),
    );
    return list;
  }
}

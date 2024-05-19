import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/widgets/scroll_index_widget.dart';

import '../../../services/models/res/match_entity.dart';
import '../models/section_group_enum.dart';
import '../widgets/item/champion/champion_item_widget.dart';
import '../widgets/item/seaction_header_widget.dart';

class ChampionMatchListView extends StatefulWidget {
  const ChampionMatchListView({super.key});

  @override
  State<ChampionMatchListView> createState() => _ChampionMatchListViewState();
}

class _ChampionMatchListViewState extends State<ChampionMatchListView> {
  late ScrollController _scrollController;
  bool showTop = false;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        _scrollListener();
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      showTop = _scrollController.offset > 800;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Container(
        color: context.isDarkMode ? null : const Color(0xfff2f2f6),
        child: Stack(
          children: [
            ScrollIndexWidget(
              callBack: (int firstIndex, int lastIndex) {
                Get.log('firstIndex: $firstIndex, lastIndex: $lastIndex');
              },
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  ///
                  ..._sliverList(controller, SectionGroupEnum.ALL),
                ],
              ),
            ),
            ///返回顶部按钮
            if (showTop)
              Positioned(
                right: 14,
                bottom: 90,
                child: ImageView(
                  context.isDarkMode
                      ? 'assets/images/home/back_top_d.png'
                      : 'assets/images/home/back_top_l.png',
                  width:context.isDarkMode?30.w:40.w,
                  height:context.isDarkMode?30.w:40.w,
                  onTap: () {
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
          ],
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
            ///总展开状态
            controller.homeState.expandMap[sectionGroupEnum] = isExpand;
            ///子赛事展开状态
            controller.homeState.matchtSet.forEach((element) {
              MatchEntity matchEntity = DataStoreController.to.getMatchById(element.mid) ?? element;
              matchEntity.isExpand = isExpand;
            });
            controller.update();
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
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
        ),
      ),
    );
    return list;
  }
}

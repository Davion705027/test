import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../widgets/bets_loading/bets_loading_view.dart';
import '../widgets/footer_view.dart';
import '../widgets/no_data_hints/no_data_hints_view.dart';
import 'bookin_bets_logic.dart';

class BookinBetsPage extends StatelessWidget {
  BookinBetsPage({Key? key}) : super(key: key);

  final logic = Get.find<BookinBetsLogic>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookinBetsLogic>(
      builder: (logic) {
        return logic.loading
            ? const BetsLoadingView()
            : logic.listData.isEmpty
                ? const NoDataHintsView(
                    type: 1,
                  )
                : Expanded(
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: SmartRefresher(
                          //不允许下拉刷新
                          enablePullDown: false,
                          footer: const FooterView(),
                          //允许上拉加载
                          enablePullUp: logic.listData.isNotEmpty,
                          controller: logic.refreshController,
                          onLoading: logic.onLoadMore,
                          child: ListView.builder(
                              itemCount: logic.listData.length,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return logic.getItem(index);
                              }),
                      //列表组件
                        ),
                    ),
                  );
      },
    );
  }
}

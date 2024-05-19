import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../widgets/bets_loading/bets_loading_view.dart';
import '../widgets/footer_view.dart';
import '../widgets/no_data_hints/no_data_hints_view.dart';
import 'await_bets_logic.dart';

class AwaitBetsPage extends StatelessWidget {
  AwaitBetsPage({Key? key}) : super(key: key);

  final logic = Get.find<AwaitBetsLogic>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AwaitBetsLogic>(
      builder: (logic) {
        return  logic.loading
            ? const BetsLoadingView()
            : logic.listData.isEmpty
            ? const NoDataHintsView(
          type: 0,
        )
            :  Expanded(
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: SmartRefresher(
                    //不允许下拉刷新
                    enablePullDown: false,
                    //允许上拉加载
                    enablePullUp: logic.listData.isNotEmpty,
                    controller: logic.refreshController,
                    onLoading: logic.onLoadMore,
                    footer: const FooterView(),
                    child: ListView.builder(
                      itemCount: logic.listData.length,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return logic.getItem(index);
                      },
                    ), //列表组件
                  )
              ),
        );
      },
    );
  }
}

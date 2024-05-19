import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/settled_bets/settled_bets_logic.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../unsettled_bets/widgets/bets_loading/bets_loading_view.dart';
import '../unsettled_bets/widgets/footer_view.dart';
import '../unsettled_bets/widgets/no_data_hints/no_data_hints_view.dart';

class SettledBetsPage extends StatefulWidget {
  const SettledBetsPage({Key? key}) : super(key: key);

  @override
  State<SettledBetsPage> createState() => _SettledBetsPageState();
}

class _SettledBetsPageState extends State<SettledBetsPage> {
  final logic = Get.find<SettledBetsLogic>();
  final state = Get.find<SettledBetsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.fromLTRB(60, 80, 60, 0),
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      backgroundColor: Colors.transparent,
      elevation: 0,
      //SingleChildScrollView
      content: _body(),
    );

    return GetBuilder<SettledBetsLogic>(
      builder: (logic) {},
    );
  }

  Widget _body() {
    return GetBuilder<SettledBetsLogic>(
      builder: (logic) {
        return InkWell(
          onTap: () => {
          //  Navigator.of(context).pop(),
          },
          child: logic.loading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const BetsLoadingView(),
                    Expanded(
                      child: InkWell(
                        onTap: () => {
                          Navigator.of(context).pop(),
                        },
                      ),
                    ),
                  ],
                )
              : logic.listData.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const NoDataHintsView(
                          type: 3,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => {
                              Navigator.of(context).pop(),
                            },
                          ),
                        ),
                      ],
                    )
                  : Container(
                      width: 400.w,
                      alignment: Alignment.topCenter,
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
                              footer: const FooterView(),
                              onLoading: logic.onLoadMore,
                              //列表组件
                              child: ListView.builder(
                                itemCount: logic.listData.length,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return logic.getItem(index);
                                },
                              ))),
                    ),
        );
      },
    );
  }

  @override
  void dispose() {
    Get.delete<SettledBetsLogic>();
    super.dispose();
  }
}

import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/views/competition_detail/bet_record_view.dart';
import 'package:flutter_ty_app/app/modules/vr/views/competition_detail/history_record_view.dart';
import 'package:flutter_ty_app/app/modules/vr/views/competition_detail/ranking_list_view.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/vr_sport_video_countdown_widget.dart';
import 'package:flutter_ty_app/app/widgets/common_app_bar.dart';

import 'vr_competition_detail_controller.dart';

class VrCompetitionDetailView extends GetView<VrCompetitionDetailController> {
  const VrCompetitionDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: '#F2F2F6'.hexColor,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          _buildTopWidget(),
          ColoredBox(
            color: AppColor.colorWhite,
            child: TabBar(
              labelPadding: const EdgeInsets.only(bottom: 7),
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 24 / 14,
              ),
              labelColor: '#179CFF'.hexColor,
              unselectedLabelColor: '#7981A4'.hexColor,
              unselectedLabelStyle: const TextStyle(
                fontSize: 14,
              ),
              indicator: UnderlineTabIndicator(
                borderRadius: BorderRadius.circular(3),
                borderSide: BorderSide(
                  width: 3,
                  color: '#179CFF'.hexColor,
                ),
              ),
              controller: controller.tabController,
              tabs: controller.tabs,
            ).marginOnly(top: 2),
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: const [
                HistoryRecordView(),
                BetRecordView(),
                RankingListView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return CommonAppBar.arrowBack(
      context,
      backgroundColor: Colors.transparent,
      arrowColor: AppColor.colorWhite,
      cusTitle: InkWell(
        onTap: controller.onCompetitionChange,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              controller.competitionName,
              style: const TextStyle(
                color: AppColor.colorWhite,
                fontSize: 18,
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopWidget() {
    return  AspectRatio(
      aspectRatio: 390 / 264,
      child: Stack(
        children: [
          ImageView(
            'assets/images/vr/vr_competition_detail_top_bg.png',
            width: double.infinity,
          ),
          SafeArea(
            bottom: false,
            child: Center(
              child: VrSportVideoCountdownWidget(
                no: '11',
                size: 106,
                valueSize: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

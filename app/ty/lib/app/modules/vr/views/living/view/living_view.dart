import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/views/living/controllers/living_view_controller.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/vr_sport_video_countdown_widget.dart';
import 'package:flutter_ty_app/app/widgets/common_app_bar.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';

class VrLivingView extends GetView<VrLivingViewController> {
  const VrLivingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.arrowBack(context, title: 'VrLiving'),
      body: ListView.separated(
        itemCount: 4,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Get.toNamed(Routes.vrCompetitionDetailPage);
            },
            child: Container(
              height: 190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // TODO: 图片|视频展示
                  Builder(
                    builder: (context) {
                      if (index < 2) {
                        return VrSportVideoCountdownWidget(
                          progressColor:
                              index == 0 ? Colors.yellow : Colors.red,
                          no: '${index == 0 ? 11 : 12}',
                        );
                      }
                      if (index == 2) return _buildGoingWidget();
                      return _buildFinishedWidget();
                    },
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 12,
        ),
      ),
    );
  }

  Widget _buildFinishedWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.black26,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: Text(
            LocaleKeys.list_match_end.tr,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.black26,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '布莱顿海鸥',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                '2-1',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                '维拉人',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.black26,
              ),
              margin: EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '第4轮',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    '01:26',
                    style: const TextStyle(
                      color: Colors.yellow,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.lock_clock),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGoingWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.black26,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 30),
            Text(
              '布莱顿海鸥',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                '0-0',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
              color: Colors.red,
              child: Text(
                "12'",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

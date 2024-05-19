import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import 'common_rank_record_header.dart';

class BetRecordView extends StatelessWidget {
  const BetRecordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Column：消除父组件 Expanded 效果
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.only(bottom: 16),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w).copyWith(top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.colorWhite,
        ),
        child: Column(
          children: [
            const CommonRankRecordHeader(),
            const SizedBox(height: 4),
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 12,
                itemBuilder: (BuildContext context, int index) {
                  return CommonRankRecordItem(
                    index: index,
                    name: '巴黎圣日尔曼',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

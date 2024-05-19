import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/locales.g.dart';
import '../../../global/user_controller.dart';
import '../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../utils/utils.dart';
import '../../../widgets/image_view.dart';
import '../../login/login_head_import.dart';
import 'dividing_line_view.dart';
import 'extend_view.dart';
import 'information_view.dart';

class EarlyRedemptionDetailsView extends StatelessWidget {
  const EarlyRedemptionDetailsView({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final GetH5OrderListDataRecordxData data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          const DividingLineView(),
          if (data.preSettleExpand)
            Column(
              children: [
                InformationView(
                  information: LocaleKeys.app_h5_cathectic_all_cash_sess.tr,
                ),
                InformationView(
                  information: "${LocaleKeys.early_list2.tr}：",
                  outcome: getPreBetAmount(),
                  titleColorType: 1,
                  isAmount: true,
                ),
                InformationView(
                  information: "${LocaleKeys.bet_record_l_w.tr}：",
                  outcome: getProfitAmount(),
                  titleColorType: 1,
                  isAmount: true,
                ),
                InformationView(
                  information: "${LocaleKeys.early_list4.tr}：",
                  outcome: getBackAmount(),
                  titleColorType: 1,
                  isAmount: true,
                ),
                const DividingLineView(),
              ],
            ),
          ExtendView(
            index: index,
            preSettleExpand: data.preSettleExpand,
          ),
        ],
      ),
    );
  }

  String getPreBetAmount() {
    String preBetAmount = "";
    String managerCode = UserController.to.currCurrency();
    if (data != null && data.profitAmount != null) {
      preBetAmount =setAmount(data.preBetAmount.toString()) +' '+ managerCode;
    }
    return preBetAmount;
  }

  String getProfitAmount() {
    String profitAmount = "";
    String managerCode = UserController.to.currCurrency();
    if (data != null && data.profitAmount != null) {
      profitAmount = setAmount(data.profitAmount.toString()) +' '+ managerCode;
    }
    return profitAmount;
  }

  String getBackAmount() {
    String backAmount = "";
    String managerCode = UserController.to.currCurrency();
    if (data != null && data.backAmount != null) {
      backAmount = setAmount(data.backAmount.toString()) +' '+ managerCode;
    }
    return backAmount;
  }
}

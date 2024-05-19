import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/betting_cart_controller.dart';

class BettingCartEntrance extends GetView<BettingCartController> {
  const BettingCartEntrance({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BettingCartController>(
      key: ValueKey(controller.bettingType),
      id: 'betting_entrance',
      builder: (controller) {
        debugPrint('controller.bettingType: ${controller.bettingType}');
        if (controller.bettingType == BettingType.single) {
          return const SizedBox();
        }
        return GestureDetector(
          onTap: () {
            controller.showBettingCartDialog();
          },
          child: Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: '#179CFF'.hexColor,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ImageView(
                  'assets/images/vr/icon_betting_floating_action_button.svg',
                  width: 30.w,
                ),
                Positioned(
                  right: -7,
                  top: -5,
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.colorWhite,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: '#E95B5B'.hexColor,
                      ),
                      child: const Text(
                        '3',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColor.colorWhite,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

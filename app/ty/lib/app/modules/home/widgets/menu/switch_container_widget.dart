import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/menu/switch_button.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../../db/app_cache.dart';
import '../../../../utils/systemchrome.dart';

class SwitchContainerWidget extends StatelessWidget {
  const SwitchContainerWidget({
    Key? key,
    required this.onNewChange,
    required this.onHotChange,
  }) : super(key: key);
  final ValueChanged<bool> onNewChange;
  final ValueChanged<bool> onHotChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SwitchButton(
            value: HomeController.to.homeState.isProfess,
            onChild: Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              LocaleKeys.footer_menu_pro_v.tr,
              style: const TextStyle(
                fontWeight: FontWeight.w500
              ),
            ),
            offChild: Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              LocaleKeys.footer_menu_new_v.tr,
              style: const TextStyle(
                  fontWeight: FontWeight.w500
              ),
            ),
            onChanged: (value) {
              onNewChange(value);
            },
          ),
          Obx(() {
            return SwitchButton(
              hasIcon: true,
              value: HomeController.to.homeState.isHot,
              onChild: Text(

                  style: const TextStyle(
                      fontWeight: FontWeight.w500
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  LocaleKeys.footer_menu_hot.tr),
              offChild: Text(
                style: const TextStyle(
                    fontWeight: FontWeight.w500
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                LocaleKeys.setting_menu_time.tr,
              ),
              onChanged: (value) {
                onHotChange(value);
              },
              enable: ConfigController.to.accessConfig.value.sortCut,
            );
          }),
          SwitchButton(
            onChild: Text(
              style: const TextStyle(
                  fontWeight: FontWeight.w500
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              LocaleKeys.footer_menu_daytime.tr,
            ),
            value: HomeController.to.homeState.isLight,
            offChild: Text(
              style: const TextStyle(
                  fontWeight: FontWeight.w500
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              LocaleKeys.footer_menu_night.tr,
            ),
            onChanged: (value) {
              Get.changeThemeMode(value ? ThemeMode.light : ThemeMode.dark);
              BoolKV.theme.save(!value);
              HomeController.to.homeState.isLight = value;
              HomeController.to.update();
              SystemUtils.isDarkMode(!value);
            },
          ),
        ],
      ),
    );
  }
}

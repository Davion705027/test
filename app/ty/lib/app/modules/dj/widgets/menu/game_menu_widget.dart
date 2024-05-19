import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/models/game.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/menu/sport_menu_widget.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/sport_config_info.dart';
import 'package:get/get.dart';

import '../../../../utils/csid_util.dart';

class GameMenuWidget extends StatefulWidget {
  const GameMenuWidget(
      {super.key,
      required this.onValueChanged,
      required this.gameList,
      required this.gameId});

  final List<Game> gameList;
  final ValueChanged<String> onValueChanged;
  final String gameId;

  @override
  State<GameMenuWidget> createState() => _GameMenuWidgetState();
}

class _GameMenuWidgetState extends State<GameMenuWidget> {
  int _currentIndex = 0;
  late Timer periodicTimer ;

  // List<SportConfigInfo> sportMenuList = [];
  ValueNotifier<List<SportConfigInfo> > sportMenuList = ValueNotifier([]);
  @override
  void initState() {
    super.initState();
    sportMenuList.value = DJController.to.getMenuData();
    periodicTimer  = Timer.periodic(const Duration(seconds: 5), (timer) {
      if(Get.isRegistered<DJController>()) {
        sportMenuList.value = DJController.to.getMenuData();
      }
    });
  }

  @override
  void dispose(){
    periodicTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      GetBuilder<DJController>(builder: (controller) {
        Get.log("GameMenuWidget GetBuilder");
        sportMenuList.value = DJController.to.getMenuData();

        return  ValueListenableBuilder(
            valueListenable: sportMenuList,
            builder: (context,value,child){
              // GetBuilder<DJController>(builder: (controller) {
              // List<SportConfigInfo> sportMenuList =
              //     controller.DJState.selectDate?.menuType == 100?
              //         ConfigController.to.gameMenuList
              //         : ConfigController.to.getGameMenuListByMenuId();
              Get.log("GameMenuWidget ValueListenableBuilder");
              return Container(
                height: 40.w,
                alignment: Alignment.center,
                color: context.theme.scaffoldBackgroundColor,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: value.length,
                  itemBuilder: (BuildContext context, int index) {
                    final sportInfo = value[index];
                    int position =
                        SpriteImagesPosition.data[(sportInfo.mi.toNum() ?? 0)] ?? 0;
                    if (sportInfo.mi == "50000") {
                      position = 1;
                    }
                    return MenuItem(
                      title: ConfigController.to.getName(sportInfo.mi),
                      index: position,
                      count: sportInfo.mi == "50000"?null:ConfigController.to.getCount(sportInfo.mi, '2000'),
                      isSelected: sportInfo.mi == widget.gameId,
                      onTap: () {
                        widget.onValueChanged(sportInfo.mi);
                      },
                    );
                  },
                ),
              );
            });

      });
  }


}

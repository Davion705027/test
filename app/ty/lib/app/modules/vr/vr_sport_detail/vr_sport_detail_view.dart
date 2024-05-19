import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../utils/oss_util.dart';

class VrSportDetailPage extends GetView<VrSportDetailLogic> {
  const VrSportDetailPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffF2F2F6),
      body: SafeArea(
        left: false,
        right: false,
        top: false,
        bottom: false,
        child:
        Column(
          children: [
            ///导航
            detailsAppBar(),
            controller.state.matchDetailList.isEmpty?const SizedBox():
            ///悬停tab头部
            vrSportDetailTabPageWidget(),
            Expanded(child: Container(

                decoration: context.isDarkMode
                    ?  BoxDecoration(
                  color: Colors.black87,
                  // image: DecorationImage(
                    // image: NetworkImage(
                    //   OssUtil.getServerPath(
                    //     'assets/images/home/color_background_skin.png',
                    //   ),
                    // ),
                  //   fit: BoxFit.cover,
                  // ),
                )
                    : const BoxDecoration(
                  color: Color(0xfff2f2f6),
                ),
                child: vrSportDetailTabBarView())),
          ],
        )

      ),
    );
  }
  
}

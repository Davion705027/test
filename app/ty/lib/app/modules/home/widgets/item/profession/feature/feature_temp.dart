import 'dart:math';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/secondary_expand_controller.dart';
import 'package:flutter_ty_app/app/modules/home/logic/other_player_name_to_playid.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import '../../../../../../../generated/locales.g.dart';
import '../../../../../../utils/widget_utils.dart';
import '../../../../../match_detail/widgets/container/odds_info/odds_button.dart';
import '../../../../controllers/home_controller.dart';
///特色组合
class FeatureTemp extends StatefulWidget {
  const FeatureTemp({super.key, required this.matchEntity, required this.hps});
  final List<MatchHps> hps;

  final MatchEntity matchEntity;

  @override
  State<FeatureTemp> createState() => _FeatureTempState();
}

class _FeatureTempState extends State<FeatureTemp> {
  late PageController pageController;
  int _currentPage = 0;


  @override
  void initState() {
    pageController = PageController(  initialPage:(widget.hps.length / 3).ceil()>=2?SecondaryController.index:0,
        keepPage: true,viewportFraction: 1);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        setState(() {
          _currentPage = SecondaryController.index;
        });
        pageController.jumpToPage(SecondaryController.index);
      }
    });
    super.initState();
    WidgetUtils.instance().stream.listen((event) {

      if (mounted) {
        setState(() {
          _currentPage = SecondaryController.index;
        });
        pageController.animateToPage(event,
            duration: const Duration(milliseconds: 300), curve: Curves.ease);

      }
    });



  }
@override
  void didUpdateWidget(covariant FeatureTemp oldWidget) {

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
  List<String> titles = [
    (LocaleKeys.football_playing_way_all_both.tr),
    (LocaleKeys.football_playing_way_half_both.tr),

   ];
  List<String> titles2 = [
    (LocaleKeys.football_playing_way_all_total_goal.tr),
    (LocaleKeys.football_playing_way_half_total_goal.tr),
   ];
  @override
  Widget build(BuildContext context) {


    // 特色组合
    return GetBuilder<DataStoreController>(
        init: DataStoreController(),
        autoRemove: false,
        id: DataStoreController.to.getMatchId(widget.matchEntity.mid),
        builder: (logic) {
          MatchEntity match =widget.matchEntity;
            // hps 两个分一组
            int length = max((match.hpsCompose.length / 2).ceil(), 2);
          return
            Stack(
              alignment: Alignment.center,
              children: [

            Padding(padding: EdgeInsets.only(right: 0.w),child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 120.h,
                  child: PageView(
                    controller: pageController,
                    padEnds: true,
                    onPageChanged: (index) {
                      setState(() {
                        if(SecondaryController.index  !=index){

                          SecondaryController.setIndex(index);
                          WidgetUtils.instance().streamController?.sink.add(index);

                          //   Bus.getInstance().emit(EventType.changeBetType, index);
                          // _currentPage=index;

                        }
                      });
                    },
                    children: List.generate(length, (index) {
                      if (match.hpsCompose.isEmpty) {
                        return Row(children: [
                          _bodyItem(match, MatchHps(),titles[index],0),
                          const Spacer(),
                          _bodyItem(match, MatchHps(), titles2[index],1),
                        ]);
                      }
                      List<MatchHps> groupList = match.hpsCompose
                          .getRange(index * 2,
                          min((index + 1) * 2, match.hpsCompose.length))
                          .toList();
                      return Row(children: [

                        ///左列表
                        _bodyItem(match, groupList.safeLast ?? MatchHps(),titles[index],0),
                        const Spacer(),
                        ///右列表
                        _bodyItem(match, groupList.safeFirst ?? MatchHps(),
                            titles2[index],1),



                      ]);
                    }),
                  ),
                ),
                if (length > 1)
                  Container(
                    height: 10.h,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 2.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.h),
                            color: _currentPage == 0
                                ? context.isDarkMode ? AppColor.itemSelectColor:const Color(0xff179CFF)
                                : context.isDarkMode ? AppColor.itemNomSelectColor:const Color(0xff179CFF).withOpacity(0.4),

                          ),
                          width: _currentPage == 0 ? 6.w : 4.w,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Container(
                          height: 2.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.h),
                            color: _currentPage == 1
                                ? context.isDarkMode ? AppColor.itemSelectColor:const Color(0xff179CFF)
                                : context.isDarkMode ? AppColor.itemNomSelectColor:const Color(0xff179CFF).withOpacity(0.4),
                          ),
                          width: _currentPage == 1 ? 6.w : 4.w,
                        ),
                      ],
                    ),
                  ),
              ],
            ),),

                if(HomeController.to.visiable)
                Positioned(
                  right: 0,
                  child: ImageView(
                    _currentPage == 0
                        ? 'assets/images/detail/ico_arrow_left.gif'
                        : 'assets/images/detail/ico_arrow_right.gif',
                    width: 16.w,
                    height: 16.h,
                  ),
                )
              ],
            );
        });
  }

    /// type 0 左 1 右   分辨是左侧还是右侧列表
  Widget _bodyItem(MatchEntity match, MatchHps hps,String title,int type) {
    double width = ((Get.width - 28.w - 12.w) * 0.25).toInt().toDouble();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title,
          style: TextStyle(
            fontSize: 10.sp,
            color: context.isDarkMode
                ? Colors.white.withOpacity(0.8999999761581421) : const Color(0xff949AB6),
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        4.verticalSpace,
        SizedBox(
          width: (Get.width - 28.w - 8.w) * 0.5,
          height: 32.h * 3 + 2.w * 2,
          child: Wrap(
            spacing: 2.w,
            runSpacing: 2.w,
            children: List.generate(max(hps.hl.safeFirst?.ol.length ?? 0, 6,),
                (index) {
              return  Container(
                  decoration: const BoxDecoration(
                  boxShadow:  [
                  BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                  )]),
                  child:OddsButton(
                isDetail: false,
                playId: playIdConfig.hpsCompose,
                height: 32.h,
                radius: 4.w,
                width: width,
                match: match,
                secondaryPaly: true,
                hps: hps,
                hl: hps.hl.safeFirst,
                ///如果是左边 前后数据调换 客胜是在前  否在后
                ol:type==0? index % 2 == 0 ?  hps.hl.safeFirst?.ol.safe(index+1):hps.hl.safeFirst?.ol.safe(index-1): hps.hl.safeFirst?.ol.safe(index),
                key: (hps.hl.safeFirst?.ol.safe(index))?.oid != null
                    ? ValueKey((hps.hl.safeFirst?.ol.safe(index))?.oid)
                    : null,
              ));
            }),
          ),
        )
      ],
    );
  }
}

String getTitle(String title) {
  if (title.contains('-')) {
    return title.split('-').first.trim();
  } else {
    return title;
  }
}

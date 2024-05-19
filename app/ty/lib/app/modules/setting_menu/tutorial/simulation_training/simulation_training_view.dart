import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../utils/oss_util.dart';
import '../../../../widgets/image_view.dart';
import 'simulation_training_controller.dart';

class SimulationTrainingPage extends StatefulWidget {
  const SimulationTrainingPage({Key? key}) : super(key: key);

  @override
  State<SimulationTrainingPage> createState() => _SimulationTrainingPageState();
}

class _SimulationTrainingPageState extends State<SimulationTrainingPage> {
  final controller = Get.find<SimulationTrainingController>();
  final logic = Get.find<SimulationTrainingController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SimulationTrainingController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            decoration: context.isDarkMode
                ?  BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  OssUtil.getServerPath(
                    'assets/images/icon/tutorial_background_darks.png',
                  ),
                ),
                fit: BoxFit.cover,
              ),
            )
                : const BoxDecoration(
              color: Color(0xFFF2F2F6),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  //头部
                  _title(),
                  _body(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //头部
  Widget _title() {
    return SizedBox(
      height: 48.h,
      child: Container(
        margin: EdgeInsets.only(left: 14.w, right: 14.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Get.back(),
              child: Icon(
                Icons.arrow_back_ios,
                size: 20.w,
                color:
                context.isDarkMode ? Colors.white : const Color(0xFF303442),
              ),
            ),
            Text(
              LocaleKeys.app_h5_handicap_tutorial_answer_question.tr,
              style: TextStyle(
                color:
                context.isDarkMode ? Colors.white : const Color(0xFF303442),
                fontSize: 16.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              width: 10.w,
            ),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        //第一题
        _firstQuestion(),
        //第二题
        _question2(),
        //实战按钮
        _actualCombat(),
      ],
    );
  }

  Widget _firstQuestion() {
    return Visibility(
      visible: controller.question1,
      child: Container(
        margin: EdgeInsets.only(top: 12.h, left: 20.w, right: 20.w),
        decoration: context.isDarkMode
            ? BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25.r)),
          image:  DecorationImage(
            image: NetworkImage(
              OssUtil.getServerPath(
                'assets/images/icon/tutorial_background_darks.png',
              ),
            ),

            fit: BoxFit.cover,
          ),
        )
            : BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(25.r),
          ),
        ),
        child: Container(
          margin: EdgeInsets.all(20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 18.h,
                    decoration: ShapeDecoration(
                      color: const Color(0x33AFAFAF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: Text(
                        LocaleKeys.app_h5_handicap_tutorial_single.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: context.isDarkMode
                              ? Colors.white
                              : const Color(0xFF333333),
                          fontSize: 12.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 10.h),
                child: Text(
                  '1、${LocaleKeys.app_h5_handicap_tutorial_results_appear.tr}：${LocaleKeys.app_h5_handicap_tutorial_which_win.tr}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: context.isDarkMode
                        ? Colors.white
                        : const Color(0xFF333333),
                    fontSize: 16.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          ImageView(
                            'assets/images/icon/ml.png',
                            width: 48.w,
                            height: 48.w,
                          ),
                          Container(
                            height: 40.h,
                            margin: EdgeInsets.only(
                              top: 15.h,
                            ),
                            child: Text(
                              LocaleKeys.app_h5_handicap_tutorial_m_chesester_untied.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: context.isDarkMode
                                    ? Colors.white.withOpacity(0.8999999761581421)
                                    : Color(0xFF333333),
                                fontSize: 14.sp,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Container(
                        width: 100.w,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '1',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: context.isDarkMode
                                    ? Colors.white.withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8.h, right: 8.h),
                              width: 9.19,
                              height: 3,
                              color: context.isDarkMode
                                  ? Colors.white.withOpacity(0.8999999761581421)
                                  : const Color(0xFF333333),
                            ),
                            Text(
                              '1',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: context.isDarkMode
                                    ? Colors.white.withOpacity(0.8999999761581421)
                                    : Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          ImageView(
                            'assets/images/icon/cex.png',
                            width: 48.w,
                            height: 48.w,
                          ),
                          Container(
                            height: 40.h,
                            margin: EdgeInsets.only(
                              top: 15.h,
                            ),
                            child: Text(
                              LocaleKeys.app_h5_handicap_tutorial_chelsea.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: context.isDarkMode
                                    ? Colors.white.withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 14.sp,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () => controller.onSelect(1),
                      child: Stack(
                        children: [
                          Container(
                            width: 130.w,
                            height: 71.h,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1.w, color: Color(0x33AFAFAF)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  LocaleKeys.app_h5_handicap_tutorial_big.tr.replaceAll('%s', '2.5'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF8D8D8D),
                                    fontSize: 14.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    ImageView(
                                      'assets/images/icon/t_up.png',
                                      width: 12.w,
                                      height: 12.w,
                                    ),
                                    Container(
                                      width: 5.w,
                                    ),
                                    Text(
                                      '1.99',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFFF53F3F),
                                        fontSize: 18.sp,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          controller.select == 1
                              ? Container(
                            width: 130.w,
                            height: 71.h,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF53F3F)
                                  .withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.w,
                                  color: const Color(0xFFF53F3F),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: ImageView(
                                    'assets/images/icon/s_wrong.png',
                                    width: 24.w,
                                    height: 24.w,
                                  ),
                                ),
                              ],
                            ),
                          )
                              : Container(),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => controller.onSelect(2),
                      child: Stack(
                        children: [
                          Container(
                            width: 130.w,
                            height: 71.h,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1.w, color: Color(0x33AFAFAF)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  LocaleKeys.app_h5_handicap_tutorial_small.tr.replaceAll('%s', '2.5'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF8D8D8D),
                                    fontSize: 14.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    ImageView(
                                      'assets/images/icon/t_down.png',
                                      width: 12.w,
                                      height: 12.w,
                                    ),
                                    Container(
                                      width: 5.w,
                                    ),
                                    Text(
                                      '1.25',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: const Color(0xFF00B42A),
                                        fontSize: 18.sp,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          controller.select == 1 || controller.select == 2
                              ? Container(
                            width: 130.w,
                            height: 71.h,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF179CFF)
                                  .withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: controller.select == 1 ? 1.w: 2.w,
                                  color: controller.select == 1 ? const Color(0x33AFAFAF) : const Color(0xFF179CFF),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: ImageView(
                                    'assets/images/icon/s_right.png',
                                    width: 24.w,
                                    height: 24.w,
                                  ),
                                ),
                              ],
                            ),
                          )
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              controller.select == 1
                  ? Container(
                margin: EdgeInsets.only(
                  top: 30.h,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: ImageView(
                        'assets/images/icon/a_wrong.png',
                        width: 40.w,
                        height: 40.w,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      child: Text(
                        LocaleKeys.app_h5_handicap_tutorial_not_master.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: context.isDarkMode
                              ? Colors.white
                              .withOpacity(0.8999999761581421)
                              : const Color(0xFF333333),
                          fontSize: 16.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      child: Text(
                        LocaleKeys.app_h5_handicap_tutorial_questionsData_1_note_1.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: context.isDarkMode
                              ? Colors.white
                              .withOpacity(0.8999999761581421)
                              : const Color(0xFF333333),
                          fontSize: 14.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Get.locale!.languageCode == 'pt' || Get.locale!.languageCode == 'ko'?
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10.h,),
                      child: Text(
                        LocaleKeys.app_questionsData_1_note_2.tr,
                        style: TextStyle(
                          color: context.isDarkMode
                              ? Colors.white
                              .withOpacity(0.8999999761581421)
                              : const Color(0xFF333333),
                          fontSize: 14.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ):
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10.h,),
                      child:  RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text:  LocaleKeys.app_questionsData_1_note_2.tr.split(LocaleKeys.app_h5_handicap_tutorial_small.tr.replaceAll('%s', '2.5'))[0]  ,
                            style: TextStyle(
                              color: context.isDarkMode
                                  ? Colors.white
                                  .withOpacity(0.8999999761581421)
                                  : const Color(0xFF333333),
                              fontSize: 14.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: LocaleKeys.app_h5_handicap_tutorial_small.tr.replaceAll('%s', '2.5'),
                                  style: TextStyle(
                                    color:  Colors.blue,
                                    fontSize: 14.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  )
                              ),
                              TextSpan(
                                  text: (LocaleKeys.app_questionsData_1_note_2.tr.split(LocaleKeys.app_h5_handicap_tutorial_small.tr.replaceAll('%s', '2.5'))[1]).split(LocaleKeys.app_h5_handicap_tutorial_big.tr.replaceAll('%s', '2.5'))[0],
                                  style: TextStyle(
                                    color: context.isDarkMode
                                        ? Colors.white
                                        .withOpacity(0.8999999761581421)
                                        : const Color(0xFF333333),
                                    fontSize: 14.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  )
                              ),
                              TextSpan(
                                  text: LocaleKeys.app_h5_handicap_tutorial_big.tr.replaceAll('%s', '2.5'),
                                  style: TextStyle(
                                    color:  Colors.blue,
                                    fontSize: 14.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  )
                              ),
                              TextSpan(
                                  text: LocaleKeys.app_questionsData_1_note_2.tr.split(LocaleKeys.app_h5_handicap_tutorial_big.tr.replaceAll('%s', '2.5'))[1],
                                  style: TextStyle(
                                    color: context.isDarkMode
                                        ? Colors.white
                                        .withOpacity(0.8999999761581421)
                                        : const Color(0xFF333333),
                                    fontSize: 14.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  )
                              ),
                            ]
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      color: context.isDarkMode
                          ? Colors.white.withOpacity(0.07999999821186066)
                          : const Color(0xFFFBFBFB),
                      height: 1.h,
                    ),
                    InkWell(
                      onTap: () => controller.nextQuestion(),
                      child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        alignment: Alignment.center,
                        child: Text(
                          LocaleKeys.app_h5_handicap_tutorial_next.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF179CFF),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
                  : controller.select == 2
                  ? Container(
                margin: EdgeInsets.only(
                  top: 30.h,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: ImageView(
                        'assets/images/icon/a_right.png',
                        width: 40.w,
                        height: 40.w,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      child: Text(
                        LocaleKeys.app_h5_handicap_tutorial_red_list.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: context.isDarkMode
                              ? Colors.white
                              .withOpacity(0.8999999761581421)
                              : const Color(0xFF333333),
                          fontSize: 16.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      child: Text(
                        LocaleKeys.app_h5_handicap_tutorial_questionsData_1_note_1.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: context.isDarkMode
                              ? Colors.white
                              .withOpacity(0.8999999761581421)
                              : const Color(0xFF333333),
                          fontSize: 14.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Get.locale!.languageCode == 'pt' || Get.locale!.languageCode == 'ko'?
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10.h,),
                      child: Text(
                        LocaleKeys.app_questionsData_1_note_2.tr,
                        style: TextStyle(
                          color: context.isDarkMode
                              ? Colors.white
                              .withOpacity(0.8999999761581421)
                              : const Color(0xFF333333),
                          fontSize: 14.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ):
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10.h,),
                      child:  RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text:  LocaleKeys.app_questionsData_1_note_2.tr.split(LocaleKeys.app_h5_handicap_tutorial_small.tr.replaceAll('%s', '2.5'))[0]  ,
                            style: TextStyle(
                              color: context.isDarkMode
                                  ? Colors.white
                                  .withOpacity(0.8999999761581421)
                                  : const Color(0xFF333333),
                              fontSize: 14.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: LocaleKeys.app_h5_handicap_tutorial_small.tr.replaceAll('%s', '2.5'),
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  )
                              ),
                              TextSpan(
                                  text: (LocaleKeys.app_questionsData_1_note_2.tr.split(LocaleKeys.app_h5_handicap_tutorial_small.tr.replaceAll('%s', '2.5'))[1]).split(LocaleKeys.app_h5_handicap_tutorial_big.tr.replaceAll('%s', '2.5'))[0],
                                  style: TextStyle(
                                    color: context.isDarkMode
                                        ? Colors.white
                                        .withOpacity(0.8999999761581421)
                                        : const Color(0xFF333333),
                                    fontSize: 14.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  )
                              ),
                              TextSpan(
                                  text: LocaleKeys.app_h5_handicap_tutorial_big.tr.replaceAll('%s', '2.5'),
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  )
                              ),
                              TextSpan(
                                  text: LocaleKeys.app_questionsData_1_note_2.tr.split(LocaleKeys.app_h5_handicap_tutorial_big.tr.replaceAll('%s', '2.5'))[1],
                                  style: TextStyle(
                                    color: context.isDarkMode
                                        ? Colors.white
                                        .withOpacity(0.8999999761581421)
                                        : const Color(0xFF333333),
                                    fontSize: 14.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  )
                              ),
                            ]
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      color: context.isDarkMode
                          ? Colors.white
                          .withOpacity(0.07999999821186066)
                          : const Color(0xFFFBFBFB),
                      height: 1.h,
                    ),
                    InkWell(
                      onTap: () => controller.nextQuestion(),
                      child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        alignment: Alignment.center,
                        child: Text(
                          LocaleKeys.app_h5_handicap_tutorial_next.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF179CFF),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _question2() {
    return Visibility(
      visible: controller.question2,
      child: Container(
        margin: EdgeInsets.only(top: 12.h, left: 20.w, right: 20.w),
        decoration: context.isDarkMode
            ? BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25.r)),
          image:  DecorationImage(
            image: NetworkImage(
              OssUtil.getServerPath(
                'assets/images/icon/tutorial_background_darks.png',
              ),
            ),
            fit: BoxFit.cover,
          ),
        )
            : BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(25.r),
          ),
        ),
        child: Container(
          margin: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 18.h,
                    decoration: ShapeDecoration(
                      color: const Color(0x33AFAFAF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: Text(
                        LocaleKeys.app_h5_handicap_tutorial_single.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: context.isDarkMode
                              ? Colors.white
                              : const Color(0xFF333333),
                          fontSize: 12.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 10.h),
                child: Text(
                  '2、${LocaleKeys.app_h5_handicap_tutorial_results_appear.tr}：${LocaleKeys.app_h5_handicap_tutorial_which_win_half.tr}',

                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: context.isDarkMode
                        ? Colors.white
                        : const Color(0xFF333333),
                    fontSize: 16.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          ImageView(
                            'assets/images/icon/ml.png',
                            width: 48.w,
                            height: 48.w,
                          ),
                          Container(
                            height: 40.h,
                            margin: EdgeInsets.only(
                              top: 15.h,
                            ),
                            child: Text(
                              LocaleKeys.app_h5_handicap_tutorial_m_chesester_untied.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: context.isDarkMode
                                    ? Colors.white.withOpacity(0.8999999761581421)
                                    : Color(0xFF333333),
                                fontSize: 14.sp,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Container(
                        width: 100.w,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '1',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: context.isDarkMode
                                    ? Colors.white.withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8.h, right: 8.h),
                              width: 9.19,
                              height: 3,
                              color: context.isDarkMode
                                  ? Colors.white.withOpacity(0.8999999761581421)
                                  : const Color(0xFF333333),
                            ),
                            Text(
                              '1',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: context.isDarkMode
                                    ? Colors.white.withOpacity(0.8999999761581421)
                                    : Color(0xFF333333),
                                fontSize: 32.sp,
                                fontFamily: 'Akrobat',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          ImageView(
                            'assets/images/icon/cex.png',
                            width: 48.w,
                            height: 48.w,
                          ),
                          Container(
                            height: 40.h,
                            margin: EdgeInsets.only(
                              top: 15.h,
                            ),
                            child: Text(
                              LocaleKeys.app_h5_handicap_tutorial_chelsea.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: context.isDarkMode
                                    ? Colors.white.withOpacity(0.8999999761581421)
                                    : const Color(0xFF333333),
                                fontSize: 14.sp,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () => controller.onSelect(1),
                      child: Stack(
                        children: [
                          Container(
                            width: 130.w,
                            height: 71.h,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1.w, color: Color(0x33AFAFAF)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  LocaleKeys.app_h5_handicap_tutorial_big.tr.replaceAll('%s', '2/2.5'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF8D8D8D),
                                    fontSize: 14.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    ImageView(
                                      'assets/images/icon/t_up.png',
                                      width: 12.w,
                                      height: 12.w,
                                    ),
                                    Container(
                                      width: 5.w,
                                    ),
                                    Text(
                                      '1.99',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFFF53F3F),
                                        fontSize: 18.sp,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          controller.select == 1
                              ? Container(
                            width: 130.w,
                            height: 71.h,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF53F3F)
                                  .withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.w,
                                  color: const Color(0xFFF53F3F),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: ImageView(
                                    'assets/images/icon/s_wrong.png',
                                    width: 24.w,
                                    height: 24.w,
                                  ),
                                ),
                              ],
                            ),
                          )
                              : Container(),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => controller.onSelect(2),
                      child: Stack(
                        children: [
                          Container(
                            width: 130.w,
                            height: 71.h,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1.w, color: Color(0x33AFAFAF)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  LocaleKeys.app_h5_handicap_tutorial_small.tr.replaceAll('%s', '2/2.5'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF8D8D8D),
                                    fontSize: 14.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    ImageView(
                                      'assets/images/icon/t_down.png',
                                      width: 12.w,
                                      height: 12.w,
                                    ),
                                    Container(
                                      width: 5.w,
                                    ),
                                    Text(
                                      '1.98',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF00bd00),
                                        fontSize: 18.sp,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          controller.select == 1 ||  controller.select == 2
                              ? Container(
                            width: 130.w,
                            height: 71.h,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF179CFF)
                                  .withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: controller.select == 1 ? 1.w: 2.w,
                                  color: controller.select == 1 ? const Color(0x33AFAFAF) : const Color(0xFF179CFF),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: ImageView(
                                    'assets/images/icon/s_right.png',
                                    width: 24.w,
                                    height: 24.w,
                                  ),
                                ),
                              ],
                            ),
                          )
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              controller.select == 1
                  ? Container(
                margin: EdgeInsets.only(
                  top: 30.h,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: ImageView(
                        'assets/images/icon/a_wrong.png',
                        width: 40.w,
                        height: 40.w,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      child: Text(
                        LocaleKeys.app_h5_handicap_tutorial_not_master.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: context.isDarkMode
                              ? Colors.white
                              .withOpacity(0.8999999761581421)
                              : const Color(0xFF333333),
                          fontSize: 16.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      child: Text(
                        LocaleKeys.app_h5_handicap_tutorial_questionsData_2_note_1.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: context.isDarkMode
                              ? Colors.white
                              .withOpacity(0.8999999761581421)
                              : const Color(0xFF333333),
                          fontSize: 14.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Get.locale!.languageCode == 'pt' || Get.locale!.languageCode == 'ko'?
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10.h,),
                      child: Text(
                        LocaleKeys.app_questionsData_2_note_2.tr,
                        style: TextStyle(
                          color: context.isDarkMode
                              ? Colors.white
                              .withOpacity(0.8999999761581421)
                              : const Color(0xFF333333),
                          fontSize: 14.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ):
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10.h,),
                      child:  RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text:  LocaleKeys.app_questionsData_2_note_2.tr.substring(0, LocaleKeys.app_questionsData_2_note_2.tr.indexOf(LocaleKeys.app_h5_handicap_tutorial_small.tr.replaceAll('%s', '2/2.5')))  ,
                            style: TextStyle(
                              color: context.isDarkMode
                                  ? Colors.white
                                  .withOpacity(0.8999999761581421)
                                  : const Color(0xFF333333),
                              fontSize: 14.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: LocaleKeys.app_h5_handicap_tutorial_small.tr.replaceAll('%s', '2/2.5'),
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  )
                              ),
                              TextSpan(
                                  text:  LocaleKeys.app_questionsData_2_note_2.tr.split(LocaleKeys.app_h5_handicap_tutorial_small.tr.replaceAll('%s', '2/2.5'))[1],
                                  style: TextStyle(
                                    color: context.isDarkMode
                                        ? Colors.white
                                        .withOpacity(0.8999999761581421)
                                        : const Color(0xFF333333),
                                    fontSize: 14.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  )
                              ),
                            ]
                        ),
                      ),
                    ),
                    controller.select == 2
                        ? Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 10.h,
                          ),
                          color: context.isDarkMode
                              ? Colors.white
                              .withOpacity(0.07999999821186066)
                              : const Color(0xFFFBFBFB),
                          height: 1.h,
                        ),
                        InkWell(
                          onTap: () => controller.onBack(),
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                              top: 20.h,
                            ),
                            child: Text(
                              LocaleKeys.app_h5_handicap_tutorial_return_home.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF179CFF),
                                fontSize: 14.sp,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                        : Container(),
                  ],
                ),
              )
                  : controller.select == 2
                  ? Container(
                margin: EdgeInsets.only(
                  top: 30.h,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: ImageView(
                        'assets/images/icon/a_right.png',
                        width: 40.w,
                        height: 40.w,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      child: Text(
                        LocaleKeys.app_h5_handicap_tutorial_red_list.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: context.isDarkMode
                              ? Colors.white
                              .withOpacity(0.8999999761581421)
                              : const Color(0xFF333333),
                          fontSize: 16.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      child: Text(
                        LocaleKeys.app_h5_handicap_tutorial_questionsData_2_note_1.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: context.isDarkMode
                              ? Colors.white
                              .withOpacity(0.8999999761581421)
                              : const Color(0xFF333333),
                          fontSize: 14.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Get.locale!.languageCode == 'pt' || Get.locale!.languageCode == 'ko'?
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10.h,),
                      child: Text(
                        LocaleKeys.app_questionsData_2_note_2.tr,
                        style: TextStyle(
                          color: context.isDarkMode
                              ? Colors.white
                              .withOpacity(0.8999999761581421)
                              : const Color(0xFF333333),
                          fontSize: 14.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ):
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10.h,),
                      child:  RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text:  LocaleKeys.app_questionsData_2_note_2.tr.substring(0, LocaleKeys.app_questionsData_2_note_2.tr.indexOf(LocaleKeys.app_h5_handicap_tutorial_small.tr.replaceAll('%s', '2/2.5')))  ,
                            style: TextStyle(
                              color: context.isDarkMode
                                  ? Colors.white
                                  .withOpacity(0.8999999761581421)
                                  : const Color(0xFF333333),
                              fontSize: 14.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: LocaleKeys.app_h5_handicap_tutorial_small.tr.replaceAll('%s', '2/2.5'),
                                  style: TextStyle(
                                    color:  Colors.blue,
                                    fontSize: 14.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  )
                              ),
                              TextSpan(
                                  text:  LocaleKeys.app_questionsData_2_note_2.tr.split(LocaleKeys.app_h5_handicap_tutorial_small.tr.replaceAll('%s', '2/2.5'))[1],
                                  style: TextStyle(
                                    color: context.isDarkMode
                                        ? Colors.white
                                        .withOpacity(0.8999999761581421)
                                        : const Color(0xFF333333),
                                    fontSize: 14.sp,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  )
                              ),
                            ]
                        ),
                      ),
                    ),


                    Container(
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      color: context.isDarkMode
                          ? Colors.white
                          .withOpacity(0.07999999821186066)
                          : const Color(0xFFFBFBFB),
                      height: 1.h,
                    ),
                    InkWell(
                      onTap: () => controller.onBack(),
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          top: 20.h,
                        ),
                        child: Text(
                          LocaleKeys.app_h5_handicap_tutorial_return_home.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF179CFF),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actualCombat() {
    if (controller.select != 0) {
      return InkWell(
        onTap: () => controller.onBack(),
        child: Container(
          height: 44.h,
          width: 240.w,
          margin: EdgeInsets.only(top: 40.h),
          alignment: Alignment.center,
          decoration: context.isDarkMode
              ? ShapeDecoration(
            color: Colors.white.withOpacity(0.07999999821186066),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: Colors.white.withOpacity(0.11999999731779099),
              ),
              borderRadius: BorderRadius.circular(100),
            ),
          )
              : ShapeDecoration(
            color: const Color(0xFF333333),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Text(
            LocaleKeys.app_h5_handicap_tutorial_actual_combat.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    Get.delete<SimulationTrainingController>();
    super.dispose();
  }
}

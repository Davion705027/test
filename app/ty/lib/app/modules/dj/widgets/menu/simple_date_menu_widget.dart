import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/dj_date_entity_entity.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:get/get.dart';

class SimpleDateMenuWidget extends StatefulWidget {
  List<DjDateEntityEntity>? djDateEntity;

  SimpleDateMenuWidget(
      {super.key, this.djDateEntity, required this.onValueChanged});

  // final ValueChanged<Menu> onValueChanged;
  final ValueChanged<DjDateEntityEntity> onValueChanged;

  @override
  State<SimpleDateMenuWidget> createState() => _SimpleDateMenuWidgetState();
}

class _SimpleDateMenuWidgetState extends State<SimpleDateMenuWidget> {
  // int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 44.h,
      color: context.theme.scaffoldBackgroundColor,
      padding: EdgeInsets.only(
          left: 14.w,
          right: 14.w,
          bottom: 10.w),
      alignment: Alignment.center,
      child: Row(
        children: [
          widget.djDateEntity == []
              ? const SizedBox()
              : Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: widget.djDateEntity!
                          .map(
                            (e) => InkWell(
                              onTap: () {
                                widget.onValueChanged(e);
                                // widget.onValueChanged(e.value);
                                // setState(() {
                                //   _currentIndex = e.key;
                                // });
                                DJController.to.DJState.selectDate = e;
                              },
                              child: Column(
                                children: [
                                  Container(
                                    // height: 25,
                                    alignment: Alignment.center,
                                    child: Text(
                                      // 'menu_itme_name_${e.value.code}'.tr,
                                      //   e.value.code.toString(),
                                      e!.menuName.toString(),
                                      style: e.menuId ==
                                              DJController
                                                  .to.DJState.selectDate?.menuId
                                          ? TextStyle(
                                              color: const Color(0xFF179CFF),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                            )
                                          : TextStyle(
                                              color: context.isDarkMode
                                                  ? Colors.white.withOpacity(0.5)
                                                  : const Color(0xFFAFB3C8),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                    ).paddingSymmetric(horizontal: 6),
                                  ),
                                  SizedBox(
                                    height: 3.w,
                                  ),
                                  Container(
                                    width: 30.w,
                                    height: 2.w,
                                    color: e.menuId ==
                                            DJController
                                                .to.DJState.selectDate?.menuId
                                        ? const Color(0xFF179CFF)
                                        : Colors.transparent,
                                  )
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
          // _buildBalance(),
        ],
      ),
    );
  }
}

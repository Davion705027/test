import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/webview_extension.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../constant/detail_constant.dart';
import '../../../controllers/match_detail_controller.dart';

/// 清晰度切换
class ChangeLine extends StatefulWidget {
  const ChangeLine({super.key, this.tag, required this.width});

  final String? tag;

  // 左滑出来的宽度
  final double width;

  @override
  State<ChangeLine> createState() => _ChangeLineState();
}

class _ChangeLineState extends State<ChangeLine> {
  late MatchDetailController controller;
  int curLine = 0;

  @override
  void initState() {
    controller = Get.find<MatchDetailController>(tag: widget.tag);
    curLine = controller.detailState.selectLine.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
            top: 100,
            child: Container(
              height: 0.5.sh,
              width: 120,
              alignment: Alignment.topCenter,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.detailState.playTypeList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (controller.detailState.selectLine.value != index) {
                          controller.detailState.selectLine.value = index;
                          controller.switchVideoUrl(type: index);
                        }
                        setState(() {
                          curLine = index;
                        });
                      },
                      child: Container(
                        width: 96,
                        height: 36,
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: curLine == index
                                  ? const Color(0xFF127DCC)
                                  : Colors.white.withOpacity(0.04),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          controller.detailState.playTypeList[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: curLine == index
                                ? const Color(0xFF127DCC)
                                : Colors.white.withOpacity(0.5),
                            fontSize: 16,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  }),
            )),
        Positioned(
            bottom: 44,
            width: widget.width - 40,
            child: Text(
              LocaleKeys.app_Video_line_prompts.tr,
              textAlign: TextAlign.center,
              maxLines: 3,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 12,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ))
      ],
    );
  }
}

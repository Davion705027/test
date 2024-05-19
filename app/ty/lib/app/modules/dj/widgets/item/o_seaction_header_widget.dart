import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/dj/models/o_dj_section_group_enum.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';

import '../../../../utils/bus/event_enum.dart';
import '../../models/dj_group_expand_info.dart';

class OSeationHeaderWidget extends StatefulWidget {
  const OSeationHeaderWidget(
      {super.key,
      required this.isExpand,
      required this.onExpand,
      required this.sectionGroupEnum});

  final ValueChanged<bool> onExpand;
  final ODJSectionGroupEnum sectionGroupEnum;

  /// 是否展开
  final bool isExpand;

  @override
  State<OSeationHeaderWidget> createState() => _OSeationHeaderWidgetState();
}

class _OSeationHeaderWidgetState extends State<OSeationHeaderWidget> {
  bool _isExpand = true;

  @override
  void initState() {
    _isExpand = widget.isExpand;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color dividerColor = const Color(0xff179CFF);
    String title = '';
    String icon = '';

    switch (widget.sectionGroupEnum) {
      case ODJSectionGroupEnum.IN_PROGRESS:
        dividerColor = const Color(0xff179CFF);
        title = '进行中';
        icon = 'assets/images/league/icon_processing.svg';
        break;
      case ODJSectionGroupEnum.NOT_STARTED:
        dividerColor = const Color(0xFFF53F3F);
        title = '未开始';
        icon = 'assets/images/league/icon_notstarted.svg';
        break;
      case ODJSectionGroupEnum.ALL:
        dividerColor = const Color(0xFFFEAE2B);
        title = '全部';
        icon = 'assets/images/league/icon_all.svg';
        break;
    }

    return Column(
      children: [
        Container(
          height: 2,
          color: dividerColor,
        ),
        Container(
          color: Colors.white,
          height: 24.h,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageView(
                icon,
                width: 14.w,
                height: 14.w,
              ),
              SizedBox(
                width: 4.w,
              ),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  color: Color(0xff303442),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {

                  setState(() {
                    _isExpand = !_isExpand;
                  });
                  widget.onExpand(_isExpand);
                  Bus.getInstance().emit(EventType.djGroupExpand, DJGroupExpandInfo(
                    _isExpand,
                    widget.sectionGroupEnum,
                  ));
                },
                child: ImageView(
                  _isExpand
                      ? 'assets/images/league/seaction_expand.svg'
                      : 'assets/images/league/seaction_collpose.svg',
                  width: 20.w,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

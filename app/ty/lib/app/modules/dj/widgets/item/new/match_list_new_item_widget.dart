import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/models/dj_group_expand_info.dart';
import 'package:flutter_ty_app/app/modules/home/models/section_group_enum.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/match_list_item_header_widget.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/dj_list_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../../../utils/bus/bus.dart';
import '../../../../../utils/bus/event_enum.dart';
import '../../../controllers/dj_controller.dart';
import '../../../models/o_dj_section_group_enum.dart';
import 'new_item_body_widget.dart';

class DjNewItemWidget extends StatefulWidget {
  const DjNewItemWidget(
      {super.key, required this.match, required this.sectionGroupEnum});

  final SectionGroupEnum sectionGroupEnum;
  final MatchEntity match;

  @override
  State<DjNewItemWidget> createState() => _DjNewItemWidgetState();
}

class _DjNewItemWidgetState extends State<DjNewItemWidget> {
  bool _isExpand = false;

  @override
  void initState() {
    _isExpand = widget.match.isExpand ?? false;
    Bus.getInstance().on(EventType.djGroupExpand, (DJGroupExpandInfo data) {
      if (data.groupEnum == widget.sectionGroupEnum) {
        if (mounted) {
          setState(() {
            _isExpand = data.isExpand;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.matchDetail, arguments: {
          'mid': widget.match.mid,
          'csid': widget.match.csid,
          'isESports': true,
        })?.then((value) {
          // Dj退出详情刷新列表
          DJController.to.getDateList();
        });
      },
      child: Container(
        padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 8.h),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xffF8F9FA),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: const Color(0xffFFFFFF), width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // MatchListItemHeaderWidget(
              //   matchEntity: widget.match,
              //   onExpandChange: (value) {
              //     widget.match.isExpand = value;
              //     setState(() {
              //       _isExpand = value;
              //     });
              //   },
              //   onCollectionChange: (bool value) {
              //     widget.match.isCollection = value;
              //     setState(() {});
              //   },
              // ),
              MatchListItemHeaderWidget(
                matchEntity: widget.match,
                onExpandChange: (value) {
                  widget.match.isExpand = value;
                  // DataStoreController.to.updateMatch(widget.match);
                },
                isGuanjun: false,
              ),
              if (_isExpand)
                Divider(
                  height: 1.h,
                  color: const Color(0xFFE4E6ED),
                ),
              if (_isExpand)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return NewItemBodyWidget(
                          matchEntity: widget.match,
                          sectionGroupEnum: widget.sectionGroupEnum,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 1.h,
                          color: const Color(0xFFE4E6ED),
                        );
                      },
                      itemCount: 3),
                )
            ],
          ),
        ),
      ),
    );
  }
}

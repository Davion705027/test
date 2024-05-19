import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/odds_info/odds_item.dart';
import 'package:get/get.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../global/data_store_controller.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../models/bet_item_collection.dart';
import '../odds_button.dart';

/// 模板id=0 有title循环title 没有直接循环ol
/// 1列，超过10个显示【显示更多】按钮，可折叠
class Temp0 extends StatefulWidget {
  const Temp0({super.key, required this.matchHps, required this.fullscreen});

  final MatchHps matchHps;
  final bool fullscreen;

  @override
  State<Temp0> createState() => _Temp0State();
}

class _Temp0State extends State<Temp0> {
  bool showMore = true;

  @override
  void initState() {
    // 对模板数据量大的玩法进行折叠处理
    int length = 0;
    widget.matchHps.hl.forEach((element) {
      length += element.ol.length;
    });

    if (length > 10) {
      showMore = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MatchEntity? match =
        DataStoreController.to.getMatchById(widget.matchHps.mid);

    List<MatchHpsTitle> titleList =
        widget.matchHps.title as List<MatchHpsTitle>;

    List<BetItemCollection> collection = widget.matchHps.collection;

    List<BetItemCollection> tempCollection = collection.where((element) {
      bool flag = false;
      titleList.forEach((element2) {
        if (element.ol.otd == element2.otd) {
          flag = true;
        }
      });
      return flag;
    }).toList();
    if (titleList.isNotEmpty) {
      collection = tempCollection;
    }

    /// 获得最大列长度
    int total = collection.length;

    if (total > 10 && showMore == false) {
      collection = collection.sublist(0, 5);
    }

    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(widget.fullscreen ? 8 : 8.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: widget.fullscreen ? 8 : 8.h,
            crossAxisSpacing: widget.fullscreen ? 8 : 8.w,
            childAspectRatio: childAspectRatio(1, widget.fullscreen),
          ),
          itemBuilder: (BuildContext context, int index) {
            BetItemCollection c = collection[index];
            return OddsButton(
              match: match,
              hps: widget.matchHps,
              ol: c.ol,
              hl: c.hl,
              name: c.ol.ott + c.ol.on,
              isDetail: true,
              direction: OddsTextDirection.horizontal,
              fullscreen: widget.fullscreen,
            );
          },
          itemCount: collection.length,
        ),
        // 显示更多按钮 一列总长度大于10 显示
        if ((total) > 10)
          InkWell(
            onTap: () {
              setState(() {
                showMore = !showMore;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              height: widget.fullscreen ? 44.5 : 44.5.h,
              child: _buildOddsName(showMore
                  ? LocaleKeys.match_info_pack_up.tr
                  : LocaleKeys.match_info_show_more.tr),
            ),
          )
      ],
    );
  }

  _buildOddsName(String on) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: widget.fullscreen
            ? Colors.white.withOpacity(0.08)
            : Get.theme.oddsButtonBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadows: [
          BoxShadow(
            color: widget.fullscreen
                ? Colors.transparent
                : Get.theme.oddsButtonShadowColor,
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          )
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        on,
        style: TextStyle(
          fontSize: widget.fullscreen ? 13 : 13.sp,
          color: widget.fullscreen
              ? Colors.white.withOpacity(0.5)
              : Get.theme.oddsButtonNameFontColor,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

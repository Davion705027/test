
import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/dj/controllers/dj_controller.dart';
import 'package:flutter_ty_app/app/modules/dj/models/dj_group_expand_info.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/item/dj_match_list_item_header_widget.dart';
import 'package:flutter_ty_app/app/modules/dj/widgets/item/odd_button.dart'; 
import 'package:flutter_ty_app/app/modules/dj/widgets/item/profession/odd_group_widget.dart';
import 'package:flutter_ty_app/app/modules/home/models/section_group_enum.dart'; 
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/odds_button_enum.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:flutter_ty_app/generated/locales.g.dart'; 

import '../../../../../services/models/res/match_entity.dart'; 

class ItemGuanjunWidget extends StatefulWidget {
  const ItemGuanjunWidget({
    super.key,
    required this.sectionGroupEnum,
    required this.matchEntity,
    this.count = 0
  });

  final SectionGroupEnum sectionGroupEnum;
  final MatchEntity matchEntity;
  final int count;

  @override
  State<ItemGuanjunWidget> createState() => _ItemGuanjunWidgetState();
}

class _ItemGuanjunWidgetState extends State<ItemGuanjunWidget> {
  bool _isExpand = true;

  @override
  void initState() {
    _isExpand = widget.matchEntity.isExpand ?? false;
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
    return GetBuilder<DataStoreController>(
      id: MATCH_ID+widget.matchEntity.mid,
      builder: (DataStoreController controller) {
        // Get.log("ItemMainWidget = ${controller.getMatchById(widget.matchEntity.mid) }");
        MatchEntity matchEntity = controller.getMatchById(widget.matchEntity.mid) ?? widget.matchEntity;
      return Container(
        padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 8.h),
        child: Container(
          decoration: BoxDecoration(
            color:context.isDarkMode? Colors.white.withOpacity(0.03999999910593033): const Color(0xffF8F9FA),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color:  context.isDarkMode? Colors.white.withOpacity(0.08):const Color(0xffFFFFFF), width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DJMatchListItemHeaderWidget(
                matchEntity: matchEntity,
                onExpandChange: (value) {
                  DJController.to.clickCollop(value,matchEntity, widget.sectionGroupEnum);
                },
                onCollectionChange: (bool value) {
                  matchEntity.isCollection = value;
                  setState(() {});
                },
                  count:widget.count
              ),
              DJController.to.isCollop(matchEntity,widget.sectionGroupEnum)?const SizedBox(): ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildItem(
                      matchHps: matchEntity.hps[index],
                      matchEntity: matchEntity,
                    );
                  },
                  itemCount: matchEntity.hps.length,
                ),

            ],
          ),
        ),
      );
    },);
  }



  Widget _buildHeader(MatchHps matchHps/*MatchEntity matchEntity*/) {
    
    return Container(
      height: 20.h,
      margin: EdgeInsets.only(bottom: 8.w),
      alignment: Alignment.center,
      decoration:  BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.isDarkMode? Colors.white.withOpacity(0.08):Color(0xFFE4E6F0),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            matchHps.hps,
            style:  TextStyle(
              color:context.isDarkMode? Colors.white.withOpacity(0.3): Color(0xFF303442),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            '${DateUtil.formatDateMs(matchHps.hmed.toInt()!, format: LocaleKeys.time7.tr)} ${ LocaleKeys.match_main_cut_off.tr}',
            textAlign: TextAlign.right,
            style:  TextStyle(
              color: context.isDarkMode? Colors.white.withOpacity(0.3): Color(0xFFAFB3C8),
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }

  Widget buildItem({required MatchHps matchHps, required MatchEntity matchEntity}) {
    double width = ((Get.width - 26.w - 8.w)) / 2+8.w;
    double height = 32.w+8.w;
  return  Column(
      children: [
         Divider(
          height: 1,
          color: context.isDarkMode? Colors.white.withOpacity(0.08):Color(0xffE5E5E5),
        ),
        _buildHeader(matchHps),
        GridView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // mainAxisSpacing: 8.w,
            // crossAxisSpacing: 8.w,
            childAspectRatio: width / height,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                ShopCartController.to.addBet(
                  matchEntity,
                  matchHps,
                  null,
                  matchHps.ol.elementAt(index),
                  betType: OddsBetType.guanjun,
                );
              },
              child:  Padding(
                  padding:  EdgeInsets.all(4.w),
                  child: OddButton(
                      height: height,
                      width: width,
                      matchEntity: matchEntity,
                      hps: matchHps, odd_item: matchHps.ol.elementAt(index),
                      isHorizon: true,
                  ),
                ),
            );
          },
          itemCount: matchHps.ol.length,
        ),

      ],
    );
  }

}

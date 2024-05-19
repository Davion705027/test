import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/core/format/project/module/format-odds-conversion-mixin.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/dj_list_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';

class OddButton extends StatefulWidget {

  OddButton({super.key, required this.height, required this.width,required this.hps,required this.odd_item,required this.matchEntity,
  this.isHorizon = false});
  final double height;
  final double width;
  final MatchHps hps;
  final MatchHpsHlOl? odd_item;
  final MatchEntity matchEntity;
  bool isHorizon;
  @override
  State<OddButton> createState() => _OddButtonState();
}

class _OddButtonState extends State<OddButton> {
  int status = 0; // 10 升  -10降
  int oldOv = 0;
  @override
  void initState() {
    if (widget.odd_item != null) {
      oldOv = widget.odd_item!.ov;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  GetBuilder<DataStoreController>(
        id: OID + widget.odd_item!.oid,
        builder: (controller) {
          MatchHpsHlOl ol =
              DataStoreController.to.getOlById(widget.odd_item!.oid) ?? widget.odd_item!;
          oddsAnimate(ol);

          return Container(
              height: widget.height,
              width: widget.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:context.isDarkMode? Colors.white.withOpacity(0.03999999910593033): const Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(4.w),
              ),
              child: widget.isHorizon?buildHorizon():buildVertical()
          );
        });
  }


  Widget buildHorizon() {

    return Row(
      children: [
        SizedBox(width: 10.w),
      Expanded(
        child: Text(
          widget.odd_item!.on,
        
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 10.sp,
            color:context.isDarkMode? Colors.white.withOpacity(0.9): Colors.black,
          ),
          textAlign: TextAlign.left,
        ),
      ),
        SizedBox(width: 10.w),
      // Spacer(),
      Text(
        formatNumber(widget.odd_item!.ov),
        // (widget.odd_item!.ov/100000).toString(),
        style: TextStyle(
          fontSize: 12.sp,
          color:context.isDarkMode? Colors.white.withOpacity(0.9): const Color(0xff303442),
          fontWeight: FontWeight.w700,
          fontFamily: 'DIN Alternate',
        ),
        textAlign: TextAlign.center,
      ),
        SizedBox(width: 10.w),
    ],);
  }
  Widget buildVertical() {
    String ov = /*widget.hps!.hpn+*/getOv();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [

        is_show_title()?Text(
          // '主胜',
          widget.odd_item!.on,
          style: TextStyle(
            fontSize: 10.sp,
            color: const Color(0xffAFB3C8),
          ),
          textAlign: TextAlign.center,
        ):const SizedBox(),

        !is_show_template()&& (is_lock()|| is_close())?
        ImageView('assets/images/bets/lock.svg',
          width: 16.w,
          height: 16.w,
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (status == 10)
                  ImageView(
                    'assets/images/detail/odds_up.svg',
                    width: 10.w,
                  ),
                if (status == -10)
                  ImageView(
                    'assets/images/detail/odds_down.svg',
                    width: 10.w,
                  ),
                Text(
                          // (widget.odd_item!.ov/100000).toString(),
                          ov,
                          style: TextStyle(
                fontSize: 12.sp,
                // color: const Color(0xff303442),
                            color: status == 0
                                ? Get.theme.oddsButtonValueFontColor
                                : status == 10
                                ? const Color(0xFFE95B5B)
                                : const Color(0xFF4AB06A),
                fontWeight: FontWeight.w700,
                fontFamily: 'DIN Alternate',
                          ),
                          textAlign: TextAlign.center,
                        ),
              ],
            ),
      ],
    );
  }


  // 是否显示 -
  bool is_show_template(){
    MatchHpsHlOl? ol = widget.odd_item;
    return ol==null||(ol!=null&&ol.ov==-1);
  }

// 是否锁盘  mhs： 0 开,  1 封,  2 关,  11 锁
  bool is_lock () {
    return widget.odd_item?.os != 1 || widget.hps?.hl[0].hs == 2 || widget.matchEntity?.mhs == 2 /*|| virtual_odds_state.value == 1*/;
    // return props.odd_item.os != 1 || [2,11].includes(+props.item_hs) || [2,11].includes(+props.match_info.mhs) || virtual_odds_state.value == 1
    // return props.odd_item.os != 1 || props.item_hs !== 0 || props.match_info.mhs !== 0 || virtual_odds_state.value == 1
  }

// 是否显示标题
  bool is_show_title(){
    // return widget.hps?.hpid != 1 && !props.show_hpn;
    return widget.hps?.hpid != 1
        && widget.odd_item!.on.isNotEmpty
        && !is_show_template()
        && !is_lock()
        && !is_close();
  }

// 是否封盘
  bool is_close (){
    return widget.matchEntity?.mhs == 1 || widget.hps?.hl[0].hs == 1;
  }

  String getOv() {
    if(is_show_template()){
      return '-';
    }else if(is_lock()||is_close()){
      return 'lock';
    }else{
      return  TYFormatOddsConversionMixin.computeValueByCurOddType(widget.odd_item!.ov,
          widget.hps!.hpid,
          widget.hps!.hsw.split(','),
          int.tryParse(widget.matchEntity!.csid)??0);
    }
    return '';
  }


  void oddsAnimate(MatchHpsHlOl ol) {
    if (ol.ov != oldOv  &&  oldOv != 0) {
      if (kDebugMode) {
        print("oddsAnimate");
      }
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (mounted) {
          setState(() {
            if ((ol.ov / 1000).ceil() > (oldOv / 1000).ceil()) {
              status = 10;
              oldOv = ol.ov;
            } else if ((ol.ov / 1000).ceil() < (oldOv / 1000).ceil()) {
              status = -10;
              oldOv = ol.ov;
            } else {
              status = 0;
            }
          });
          3.seconds.delay(() {
            if (mounted) {
              // 三秒后清除相关符号
              setState(() {
                status = 0;
              });
            }
          });
        }
      });
    }
  }

  /// 只显示三位有效数字
  String formatNumber(int number) {
    double result = number / 100000;
    String resultStr;
      resultStr = result.toStringAsFixed(3);
    return resultStr;
  }

//
//   /**
//    * @description: 原始赔率(ov / 100000)小于1.01 强制显示封盘(显示锁)
//    * @return boolean 是否显示封盘样式
//    */
//   bool get_obv_is_lock  ()  {
//   return widget.odd_item!.ov < 101000;
// }
//
//
// // 是否 显示 - 或者 锁
//   bool is_show(DjListHps hps){
//     return /* widget.matchEntity.placeholder == 1 ||*/ is_close(hps,get_odd_status(hps)) || (/*MenuData.get_footer_sub_menu_id == 114 &&*/ widget.matchEntity.csid != 1);
//   }
//
// // 是否显示 -
//   bool is_show_lock  () {
//     DjListHpsHlOl? odd_item = widget.odd_item;
//   // const ol = lodash.get(props.odd_field, 'hl[0].ol', "")
//   //   const hs = lodash.get(props.odd_field, 'hl[0].hs', 0)
//    int? hs = widget.hps.hl[0].hs;
//       return odd_item == null || hs == 2;
// }
//
//   /**
//    * @description: 是否封盘odd_s == 2
//    * @return boolean
//    */
//   bool is_fengpan  (val)  {
//   // if(is_local_lock.value == 11) return false;//获取到赛果后 设置为11
//   if(widget.matchEntity.mhs == 1) return true; // mhs： 0 开,  1 封,  2 关,  11 锁
//   int? hl_hs = widget.hps.hl[0].hs;
//   if(hl_hs == 1) return true;
//   return val == 2;
// }
//
// // 是否为封盘
//   bool is_show_fenpan  ()  {
//       return !(is_fengpan(get_odd_status(widget.hps)) /*&& [11,18,19].includes(+lodash.get(props.current_tab_item, 'id'))*/)
//           // || ((widget.odd_item?.on || convert_num(widget.odd_item) == 0) && widget.matchEntity.csid != 1)
//       ;
// }
//
// // on转换为数字
//    convert_num  (odd_item)  {
//   var on = odd_item.onb || odd_item.on;
//   if(on == 0 || on == "0"){
//   return 0;
//   }
//   else if(!on){
//   return '';
//   }
//   else{
//   return on;
//   }
// }
//   /**
//    * @description: 是否是关盘
//    * @return boolean
//    */
//   bool is_close(DjListHps hps,val){
//     bool r = false;
//     // if(is_local_lock.value == 11) return false;//获取到赛果后 设置为11
//     if(widget.matchEntity.mhs == 2) return true; // mhs： 0 开,  1 封,  2 关,  11 锁
//     int? hl_hs = hps.hl[0].hs;
//     if(hl_hs== 2){ // 投注项父类关盘
//       return true;
//     }
//     if(val == 2) {
//       return false;
//     }
//     if(val == 3){
//       r = true;
//     }
//     return r;
//   }
//
// // 获取 投注项数据，
//   int get_odd_status (DjListHps hps) {
//     // var odd_item =  hps.hl[0].ol;
//     DjListHpsHlOl? odd_item = widget.odd_item;
//         int? hl_hs = hps.hl[0].hs;
//     if( odd_item == null) return 3;
//     if(hl_hs == 1 /*|| virtual_odds_state.value == 1*/){
//       return 2;
//     }
//     else if(hl_hs == 2){
//       return 3;
//     }
//     else if(hl_hs == 3){
//       return 4;
//     }
//     var ms = widget.matchEntity.ms;
//     var hs = hps.hl[0].hs;
//     var os = odd_item.os;
//     // const { ms, hs, os } = odd_item.value
//     return get_odds_active(ms, hs, os);
//   }
//
//
//   /**
//    * @Description:获取押注项逻辑转换后的最新状态(通过赛事状态,押注状态,押注项状态进行转换)
//    * @Author success
//    * @param:matchHandicapStatus - 赛事状态mhs  0:active 开, 1:suspended 封, 2:deactivated 关, 11:锁
//    * @param:status - 盘口级别状态hs   0:active 开, 1:suspended 封, 2:deactivated 关, 11:锁
//    * @param:active - 投注项级别状态os  1:开盘(激活)，2:封盘(未激活)，3投注项隐藏(不会有4 锁盘 的值返回)
//    * @return:1.开盘，2封盘，3关盘 ，4 锁盘
//    * @Date 2019/12/26 12:18:02
//    */
//   int get_odds_active(matchHandicapStatus, status, active){
//     var active_ = 1;
//     if (matchHandicapStatus != null) { // 赛事盘口有操作变化时
//       if (matchHandicapStatus == 1) { //赛事封盘状态
//         active_ = 2;
//       } else if (matchHandicapStatus == 11) { //赛事锁盘
//         if(active!=1){
//           active_ = active;
//         } else{
//           active_ = 4;
//         }
//       } else if (matchHandicapStatus == 2 || matchHandicapStatus == 3 || matchHandicapStatus == 4 || matchHandicapStatus == 5) { //赛事关盘
//         active_ = 3;
//       }
//       return active_;
//     }
//
//     if (status) { // 盘口有操作变化时
//       if (status == 1) { //盘口封盘
//         active_ = 2;
//       } else if (status == 2 || status == 3 || status == 4 || status == 5) { //盘口关盘
//         active_ = 3;
//       } else if (status == 11) { //盘口锁盘
//         active_ = 4;
//       }
//       return active_;
//     }
//     return active;
//   }
//
//   generateItem() {
//     var title = '';
//     var odd = '';
//     bool showLock = false;
//     // <!-- 占位  或者  关盘 (列表简单版时非足球赛事角球菜单时设置为关盘) :id="dom_id_show && `list-${lodash.get(odd_item, 'oid')}`"-->
//     if(is_show(widget.hps)){
//       if(is_show_lock()){
//         odd = '-';
//       }else{
//         showLock = true;
//       }
//     }else if(is_fengpan(get_odd_status(widget.hps))) {
//       // <!-- 全封(不显示盘口值) 占位时显示封-->
//
//       if(is_show_fenpan()){
//
//       }else{
//         showLock = true;
//       }
//     }else{
//      odd = (widget.odd_item!.ov/100000).toString();
//     }
//     if(showLock){
//       odd = 'lock';
//     }
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         /* Text(
//             '主胜',
//             style: TextStyle(
//               fontSize: 10.sp,
//               color: Color(0xffAFB3C8),
//             ),
//             textAlign: TextAlign.center,
//           ),*/
//         Text(
//           // '25.4',
//           odd,
//           // (widget.odd_item!.ov/100000).toString(),
//           style: TextStyle(
//             fontSize: 12.sp,
//             color: Color(0xff303442),
//             fontWeight: FontWeight.w700,
//             fontFamily: 'DIN Alternate',
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }

}

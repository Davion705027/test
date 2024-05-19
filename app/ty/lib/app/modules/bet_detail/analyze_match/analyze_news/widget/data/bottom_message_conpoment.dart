import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../widgets/image_view.dart';
class  BottomMessageConpoment extends StatelessWidget{
  @override
  Widget build(BuildContext context ) {
    // TODO: implement build
    return  Container(
      height: 80.w,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.w),
              topLeft: Radius.circular(20.w))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 170.w,
            height: 27.w,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
                color: Color(0xFFF2F2F6),
                borderRadius: BorderRadius.circular(12.w)),
            child: Row(
              children: [
                ImageView(
                  "assets/images/bets/icon_chat_nor.png",
                  width: 20.w,
                  height: 20.w,
                ),
                Text(
                  "说点什么吧…",
                  style:
                  TextStyle(color: Color(0xFFC9CDDB), fontSize: 14.sp),
                ),
              ],
            ),
          ),
          Expanded(child:  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                alignment: Alignment.center,
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                    color: Color(0xFFF2F2F6),
                    borderRadius: BorderRadius.all(Radius.circular(40.w))),
                child: ImageView(
                  "assets/images/bets/analyze_wallet.png",
                  width: 27.w,
                  height: 27.w,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                    color: Color(0xFFE8F5FF),
                    borderRadius: BorderRadius.all(Radius.circular(40.w))),
                child: Stack(
                  children: [
                    ImageView(
                      "assets/images/bets/analyze_menu.png",
                      width: 27.w,
                      height: 27.w,
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFCB66),
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.w)),
                          ),
                          child: Text(
                            "未结算",
                            style: TextStyle(
                                color: Color(0xFF856000),
                                fontWeight: FontWeight.w600,
                                fontSize: 9.sp),
                          ),
                        ))
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                    color: Color(0xFFE8F5FF),
                    borderRadius: BorderRadius.all(Radius.circular(40.w))),
                child: Stack(
                  children: [
                    ImageView(
                      "assets/images/bets/analyze_menu.png",
                      width: 27.w,
                      height: 27.w,
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFCB66),
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.w)),
                          ),
                          child: Text(
                            "未结算",
                            style: TextStyle(
                                color: Color(0xFF856000),
                                fontWeight: FontWeight.w600,
                                fontSize: 9.sp),
                          ),
                        ))
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                    color: Color(0xFFE8F5FF),
                    borderRadius: BorderRadius.all(Radius.circular(40.w))),
                child: ImageView(
                  "assets/images/bets/analyze_message.png",
                  width: 27.w,
                  height: 27.w,
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/bet_detail/bet_analyze_controller.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../bet_analyze_controller.dart';

class BetHaveBetailPage extends StatelessWidget {
  const BetHaveBetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  CustomScrollView(slivers: [
        _cover(),
        _attributes(),
        _desc(),
        _sort(),
        _list(),
      ]);
  }


  _cover() {
    return SliverToBoxAdapter(
      child: GetBuilder<BetAnalyzeController>(
        id:"betHaveAnalyzeController",
        builder: (controller) {

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      ""),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(2),

                border: Border.all(
                    color: const Color(0xffFFD99C).withOpacity(0.8), width: 1)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 10,
                  child: Text(
                    '20221015-1000期',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black.withOpacity(0.2), Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xffFFD99C).withOpacity(0.8),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            fontSize: 24.sp,
                            height: 1.2,
                            color: const Color(0xffFFD99C),
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _attributes() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            height: 0.5.h,
            margin: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(158, 158, 158, 0.00),
                    Color.fromRGBO(158, 158, 158, 0.60),
                    Color.fromRGBO(158, 158, 158, 0.00),
                  ],
                  stops: [0, 0.5, 1],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )),
          ),
          Container(
            height: 39.h,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(158, 158, 158, 0.00),
                    Color.fromRGBO(158, 158, 158, 0.10),
                    Color.fromRGBO(158, 158, 158, 0.00),
                  ],
                  stops: [0.08, 0.5, 0.92],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Image.asset('assets/images/detailnew/ic_melee.png',
                        width: 18.w, height: 18.w),
                    SizedBox(width: 3.w),
                    Text(
                      '近战',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Image.asset('assets/images/detailnew/warrior_data.png',
                        width: 18.w, height: 18.w),
                    SizedBox(width: 3.w),
                    Text('近战',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ))
                  ],
                ),
                Row(
                  children: [
                    Image.asset('assets/images/detailnew/gender.png',
                        width: 18.w, height: 18.w),
                    SizedBox(width: 3.w),
                    Text('近战',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ))
                  ],
                ),
                Text('15.023',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ))
              ],
            ),
          ),
          Container(
            height: 0.5.h,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(158, 158, 158, 0.00),
                    Color.fromRGBO(158, 158, 158, 0.60),
                    Color.fromRGBO(158, 158, 158, 0.00),
                  ],
                  stops: [0, 0.5, 1],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )),
          ),
        ],
      ),
    );
  }

  _desc() {
    return SliverToBoxAdapter(
      child: GetBuilder<BetAnalyzeController>(
          id:"betHaveAnalyzeController",
          builder: (controller) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                "",
                style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white.withOpacity(0.8),
                    height: 1.5),
              ),
            );
          }),
    );
  }

  _sort() {
    return SliverToBoxAdapter(
      child: Container(
        height: 30,
        color: Colors.white.withOpacity(0.05),
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 6,
              child: Text(
                "",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Text(
                "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Text(
               "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Text(
               "",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _list() {
    return SliverToBoxAdapter(
      child: ListView.separated(
        itemCount: 10,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        separatorBuilder: (context, index) {
          return Container(
            height: 1,
            color: Colors.white.withOpacity(0.02),
          );
        },
        itemBuilder: (context, index) {
          return _betListItem();
        },
      ),
    );
  }


  _betListItem() {
    return SizedBox(
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Row(
              children: [
                Image.asset(
                  'assets/images/detailnew/close_combat_data.png',
                  width: 16,
                  height: 16,
                ),
                SizedBox(width: 5.w),
                Text(
                  '坦克',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  omitCharacter('1245689', 6),
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 12.sp,
                  ),
                ),
                GestureDetector(
                  child: Image.asset(
                    'assets/images/detailnew/ic_copy.png',
                    width: 10,
                    height: 10,
                  ),
                  onTap: () {
                    Clipboard.setData(
                        const ClipboardData(text: '要复制的文本'));
                  },
                )
              ],
            ),
          ),
          Expanded(
            flex: 9,
            child: Text(
              '12345678',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              '1.05',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
          Expanded(
            flex: 9,
            child: Text(
              '+12345678.00',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffFD5E5F)),
            ),
          )
        ],
      ),
    );
  }

  String omitCharacter(String char, int lengths) {
    if (char.runtimeType != String) {
      return '';
    }
    if (lengths.runtimeType != int) {
      return '';
    }
    if (char.length > lengths) {
      return '${char.substring(0, lengths - 1)}...';
    } else {
      return char;
    }
  }

}
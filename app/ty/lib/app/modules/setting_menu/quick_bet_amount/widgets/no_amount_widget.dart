import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class NoAmountWidget extends StatelessWidget {
  const NoAmountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.isDarkMode ? const Color(0xFF1E2029) : Colors.white,
      child: Container(
        margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? const Color(0xFF0E1014)
              : const Color(0xFFe4e6ed),
          borderRadius: BorderRadius.circular(10.0),
        ),
        alignment: Alignment.centerLeft,
        child: Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.3),
          highlightColor: Colors.grey.withOpacity(0.3),
          child: Container(
            margin: EdgeInsets.all(
              10.w,
            ),
            child: GridView.builder(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.w,
                  crossAxisCount: 3,
                  childAspectRatio: 1.7,
                ),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: Container(
                      margin: EdgeInsets.only(top: 10.h, left: 5.w, right: 5.w),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 13.h,
                            width: 100.w,
                            decoration: ShapeDecoration(
                              color: context.isDarkMode
                                  ? Colors.white
                                      .withOpacity(0.10000000149011612)
                                  : Colors.grey.withOpacity(0.6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.r),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 25.h,
                            margin: EdgeInsets.only(top: 5.h),
                            width: 100.w,
                            decoration: ShapeDecoration(
                              color: context.isDarkMode
                                  ? Colors.white
                                      .withOpacity(0.10000000149011612)
                                  : Colors.grey.withOpacity(0.6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.r),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

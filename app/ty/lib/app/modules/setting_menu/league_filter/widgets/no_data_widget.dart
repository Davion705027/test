import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 3,
          shrinkWrap: false,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return SizedBox(
              height: 180.h,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 12.h,
                      width: 120.w,
                      margin: EdgeInsets.only(left: 20.w, top: 0.h),
                      decoration: ShapeDecoration(
                        color: Colors.grey.withOpacity(0.6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30.h),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(
                              left: 20.w,
                            ),
                            height: 18.h,
                            width: 18.w,
                            decoration: ShapeDecoration(
                              color: Colors.grey.withOpacity(0.6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 12.h,
                            width: 150.w,
                            margin: EdgeInsets.only(
                              left: 10.w,
                            ),
                            decoration: ShapeDecoration(
                              color: Colors.grey.withOpacity(0.6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30.h),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(
                              left: 20.w,
                            ),
                            height: 18.h,
                            width: 18.w,
                            decoration: ShapeDecoration(
                              color: Colors.grey.withOpacity(0.6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 12.h,
                            width: 200.w,
                            margin: EdgeInsets.only(
                              left: 10.w,
                            ),
                            decoration: ShapeDecoration(
                              color: Colors.grey.withOpacity(0.6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30.h),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(
                              left: 20.w,
                            ),
                            height: 18.h,
                            width: 18.w,
                            decoration: ShapeDecoration(
                              color: Colors.grey.withOpacity(0.6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 12.h,
                            width: 200.w,
                            margin: EdgeInsets.only(
                              left: 10.w,
                            ),
                            decoration: ShapeDecoration(
                              color: Colors.grey.withOpacity(0.6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}


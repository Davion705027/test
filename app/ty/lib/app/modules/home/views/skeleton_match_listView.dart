import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/oss_util.dart';

class SkeletonMatchListView extends StatelessWidget {
  const SkeletonMatchListView({super.key, required this.isNews});

  final bool isNews;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      children: List.generate(
        5,
        (index) =>
            isNews ? const SkeletonNewItem() : const SkeletonProfessionItem(),
      ),
    );
  }
}

class SkeletonProfessionItem extends StatelessWidget {
  const SkeletonProfessionItem({super.key});

  @override
  Widget build(BuildContext context) {
    Color? itemColor = Get.isDarkMode
        ? Colors.white.withOpacity(0.10000000149011612)
        : Colors.grey.withOpacity(0.6);

    return Container(
      // decoration: BoxDecoration(
      //   color: context.theme.scaffoldBackgroundColor,
      //   borderRadius: BorderRadius.circular(6.r),
      // ),
      decoration: Get.isDarkMode
          ? const BoxDecoration(
              // borderRadius: BorderRadius.circular(10.r),
              // image:  DecorationImage(
              //   image: NetworkImage(
              //     OssUtil.getServerPath(
              //       'assets/images/icon/tutorial_background_darks.png',
              //     ),
              //   ),
              //   fit: BoxFit.cover,
              // ),
            )
          : BoxDecoration(
              color: const Color(0xffF8F9FA),
              borderRadius: BorderRadius.circular(6.r),
            ),
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(8.w),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 16,
              decoration: ShapeDecoration(
                color: itemColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 7.h),
            Row(
              children: [
                const Spacer(),
                Container(
                  width: 60,
                  height: 12,
                  decoration: ShapeDecoration(
                    color: itemColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
                Container(
                  width: 60,
                  height: 12,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: ShapeDecoration(
                    color: itemColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
                Container(
                  width: 60,
                  height: 12,
                  decoration: ShapeDecoration(
                    color: itemColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 7.h),
            Container(
              width: 170,
              height: 12,
              decoration: ShapeDecoration(
                color: itemColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
            ),
            SizedBox(height: 7.h),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 7,
                        ),
                        Container(
                          width: 100,
                          height: 18,
                          decoration: ShapeDecoration(
                            color: itemColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: 100,
                          height: 18,
                          decoration: ShapeDecoration(
                            color: itemColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: List.generate(5, (index) {
                            return Container(
                              width: 18,
                              height: 18,
                              margin: const EdgeInsets.only(right: 4),
                              decoration: ShapeDecoration(
                                color: itemColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(3, (index) {
                          return Container(
                            width: 60,
                            height: 32,
                            decoration: ShapeDecoration(
                              color: itemColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(2, (index) {
                          return Container(
                            width: 60,
                            height: 49,
                            decoration: ShapeDecoration(
                              color: itemColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(2, (index) {
                          return Container(
                            width: 60,
                            height: 49,
                            decoration: ShapeDecoration(
                              color: itemColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 7.h),
            Row(
              children: List.generate(5, (index) {
                return Container(
                  width: 32,
                  height: 12,
                  margin: const EdgeInsets.only(right: 4),
                  decoration: ShapeDecoration(
                    color: itemColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

class SkeletonNewItem extends StatelessWidget {
  const SkeletonNewItem({super.key});

  @override
  Widget build(BuildContext context) {
    Color? itemColor = Get.isDarkMode
        ? Colors.white.withOpacity(0.10000000149011612)
        : Colors.grey.withOpacity(0.6);
    return Container(
      decoration: Get.isDarkMode
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              image:  DecorationImage(
                image: NetworkImage(
                  OssUtil.getServerPath(
                    'assets/images/icon/tutorial_background_darks.png',
                  ),
                ),
                fit: BoxFit.cover,
              ),
            )
          : BoxDecoration(
              color: const Color(0xffF8F9FA),
              borderRadius: BorderRadius.circular(6.r),
            ),
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(8.w),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 16,
              decoration: ShapeDecoration(
                color: itemColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: List.generate(5, (index) {
                return Container(
                  width: 18,
                  height: 18,
                  margin: const EdgeInsets.only(right: 4),
                  decoration: ShapeDecoration(
                    color: itemColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 20,
                    decoration: ShapeDecoration(
                      color: itemColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 20,
                    decoration: ShapeDecoration(
                      color: itemColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 90,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: itemColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 90,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: itemColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  width: 90,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: itemColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

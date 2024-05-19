import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:get/get.dart';

const int _flex1 = 124;
const int _flex2 = 79;
const int _flex3 = 79;
const int _flex4 = 79;

class CommonMatchRecordView extends StatelessWidget {
  const CommonMatchRecordView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: _flex1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            child: Text(
              '球队',
              style: TextStyle(
                fontSize: 10,
                color: '#949AB6'.hexColor,
              ),
            ),
          ),
        ),
        Expanded(
          flex: _flex2,
          child: Center(
            child: Text(
              '比赛',
              style: TextStyle(
                fontSize: 10,
                color: '#949AB6'.hexColor,
              ),
            ),
          ),
        ),
        Expanded(
          flex: _flex3,
          child: Center(
            child: Text(
              '胜/平/负',
              style: TextStyle(
                fontSize: 10,
                color: '#949AB6'.hexColor,
              ),
            ),
          ),
        ),
        Expanded(
          flex: _flex4,
          child: Center(
            child: Text(
              '积分',
              style: TextStyle(
                fontSize: 10,
                color: '#949AB6'.hexColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CommonMatchRecordItem extends StatelessWidget {
  const CommonMatchRecordItem({
    super.key,
    required this.index,
    required this.name,
    this.top3UseImg = true,
  });

  final int index;
  final String name;
  final bool top3UseImg;

  @override
  Widget build(BuildContext context) {
    final topThreeRankImg = [
      'assets/images/vr/bet_record_NO.1.png',
      'assets/images/vr/bet_record_NO.2.png',
      'assets/images/vr/bet_record_NO.3.png',
    ];
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Get.isDarkMode
                ? AppColor.dividerColorDark
                : AppColor.dividerColorLight,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: _flex1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  if (top3UseImg && index < 3)
                    ImageView(
                      topThreeRankImg[index],
                      width: 20,
                      height: 20,
                    )
                  else
                    Container(
                      constraints:
                          const BoxConstraints(minWidth: 20, minHeight: 20),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 12,
                            color: '#303442'.hexColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(width: 4),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 12,
                      color: '#303442'.hexColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: _flex2,
            child: Center(
              child: Text(
                '25',
                style: TextStyle(
                  fontSize: 12,
                  color: '#303442'.hexColor,
                ),
              ),
            ),
          ),
          Expanded(
            flex: _flex3,
            child: Center(
              child: Text(
                '5/5/6',
                style: TextStyle(
                  fontSize: 12,
                  color: '#303442'.hexColor,
                ),
              ),
            ),
          ),
          Expanded(
            flex: _flex4,
            child: Center(
              child: Text(
                '25',
                style: TextStyle(
                  fontSize: 12,
                  color: '#303442'.hexColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../widgets/image_view.dart';
import '../shop_cart_theme.dart';

class NumberKeyboard extends StatelessWidget {
  NumberKeyboard({
    Key? key,
    this.onTextInput,
    this.onTextSet,
    this.onBackspace,
    this.onCollapse,
    this.onMaxValue,
    this.currentValue,
    this.quickValues,
  }) : super(key: key);

  final ValueSetter<String>? onTextInput;
  final ValueSetter<String>? onTextSet;
  final VoidCallback? onBackspace;
  final VoidCallback? onCollapse;
  final VoidCallback? onMaxValue;
  final List<int>? quickValues;
  String? currentValue ;

  void _textInputHandler(String text) => onTextInput?.call(text);

  void _textSetHandler(String text) => onTextSet?.call(text);

  void _backspaceHandler() => onBackspace?.call();

  void _collapseHandler() => onCollapse?.call();

  void _maxValueHandler() => onMaxValue?.call();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      padding: const EdgeInsets.all(2.5),
      height: 200,
      decoration: BoxDecoration(
        color: themeData.shopcartContentBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          if(quickValues!=null)
            Expanded(
              child: Row(
                children: quickValues!.asMap().entries.map((element) {
                  double? setValue = double.tryParse(currentValue??'');
                  return TextSetKey(
                    text: element.value.toString(),
                    index: element.key,
                    onTextSet: _textSetHandler,
                    selected: (quickValues![TextSetKey.lastIndex]==setValue && TextSetKey.lastIndex == element.key)
                        || (quickValues![TextSetKey.lastIndex]!=setValue && setValue == element.value),
                  );
                }).toList(),
              ),
            ),
          if(quickValues!=null)
            Divider(height: 4,thickness: 0.5,color: Get.theme.shopcartDividerColor,),
          // Container(
          //   height: 4,
          //   margin: EdgeInsets.only(top:2),
          //   decoration: BoxDecoration(
          //     border: Border(
          //       top: BorderSide(
          //         color: Get.theme.shopcartDividerColor,
          //         width: 0.5,
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(
            child: Row(
              children: [
                TextKey(
                  text: '1',
                  onTextInput: _textInputHandler,
                ),
                TextKey(
                  text: '2',
                  onTextInput: _textInputHandler,
                ),
                TextKey(
                  text: '3',
                  onTextInput: _textInputHandler,
                ),
                MaxValueKey(
                  onMaxValue: _maxValueHandler,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              TextKey(
                                text: '4',
                                onTextInput: _textInputHandler,
                              ),
                              TextKey(
                                text: '5',
                                onTextInput: _textInputHandler,
                              ),
                              TextKey(
                                text: '6',
                                onTextInput: _textInputHandler,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              TextKey(
                                text: '7',
                                onTextInput: _textInputHandler,
                              ),
                              TextKey(
                                text: '8',
                                onTextInput: _textInputHandler,
                              ),
                              TextKey(
                                text: '9',
                                onTextInput: _textInputHandler,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
                BackspaceKey(
                  onBackspace: _backspaceHandler,
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                TextKey(
                  text: '.',
                  onTextInput: _textInputHandler,
                ),
                TextKey(
                  text: '0',
                  onTextInput: _textInputHandler,

                ),
                TextKey(
                  text: '00',
                  onTextInput: _textInputHandler,

                ),
                CollapseKey(
                  onCollapse: _collapseHandler,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


class TextKey extends StatelessWidget {
  const TextKey({
    Key? key,
    @required this.text,
    this.onTextInput,
    this.flex = 1,
  }) : super(key: key);

  final String? text;
  final ValueSetter<String>? onTextInput;
  final int flex;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Expanded(
      flex: flex,
      child: Container(
        height: 34,
        decoration: BoxDecoration(
          color: themeData.shopcartKeyboardColor,
          borderRadius: BorderRadius.circular(4),
        ),
        margin: const EdgeInsets.all(2.5),
        child: InkWell(
          onTap: () {
            onTextInput?.call(text!);
          },
          child: Container(
            child: Center(
                child: Text(text!,
                  style: TextStyle(
                    fontSize: 22,
                    color: themeData.shopcartTextColor,
                    fontWeight:FontWeight.w700,
                    fontFamily: "Akrobat",
                  ),
                )),
          ),
        ),

      ),
    );
  }
}

class TextSetKey extends StatelessWidget {
  static int lastIndex = 0;

  const TextSetKey({
    Key? key,
    @required this.text,
    this.onTextSet,
    this.flex = 1,
    this.selected = false,
    required this.index,
  }) : super(key: key);

  final String? text;
  final ValueSetter<String>? onTextSet;
  final int flex;
  final bool selected;
  final int index;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Expanded(
      flex: flex,
      child: Container(
        height: 34,
        decoration: BoxDecoration(
          color: themeData.shopcartKeyboardColor,
          borderRadius: BorderRadius.circular(8),
          border: selected?Border.all(color: const Color(0xFF179CFF), width: 1):null,
        ),
        margin: const EdgeInsets.all(2.5),
        child: InkWell(
            onTap: () {
              lastIndex = index;
              onTextSet?.call(text!);
            },
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Center(
                      child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.center,
                          child: Text(text!,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFF179CFF),
                          fontWeight:FontWeight.w700,
                          fontFamily: "Akrobat",
                        ),
                          ),
                      )),
                ),
                if(selected)
                  const Positioned(
                      bottom: -1,
                      right: -1,
                      child: ImageView('assets/images/shopcart/text_selected1.png', width: 20,)
                  )

              ],
            )



        ),

      ),
    );
  }
}

class BackspaceKey extends StatelessWidget {
  const BackspaceKey({
    Key? key,
    this.onBackspace,
    this.flex = 1,
  }) : super(key: key);

  final VoidCallback? onBackspace;
  final int flex;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          color: themeData.shopcartKeyboardColor,
        ),
        margin: const EdgeInsets.all(2.5),
        child: InkWell(
          onTap: () {
            onBackspace?.call();
          },
          child: Container(
            child: Center(
              child: ImageView('assets/images/shopcart/backspace1.png',width: 25,color: themeData.shopcartTextColor,),
            ),
          ),
        ),
      ),
    );
  }
}

class CollapseKey extends StatelessWidget {
  const CollapseKey({
    Key? key,
    this.onCollapse,
    this.flex = 1,
  }) : super(key: key);

  final VoidCallback? onCollapse;
  final int flex;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          color: themeData.shopcartKeyboardColor,
        ),
        margin: const EdgeInsets.all(2.5),
        child: InkWell(
          onTap: () {
            onCollapse?.call();
          },
          child: Container(
            child: Center(
              child: ImageView('assets/images/shopcart/collapse1.png',width: 25,color: themeData.shopcartTextColor,),
            ),
          ),
        ),
      ),
    );
  }
}

class MaxValueKey extends StatelessWidget {
  const MaxValueKey({
    Key? key,
    this.onMaxValue,
    this.flex = 1,
  }) : super(key: key);

  final VoidCallback? onMaxValue;
  final int flex;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          color: themeData.shopcartKeyboardColor,
        ),
        margin: const EdgeInsets.all(2.5),
        child: InkWell(
          onTap: () {
            onMaxValue?.call();
          },
          child: Container(
            child: Center(
                child: Text(LocaleKeys.bet_max.tr,
                  style: TextStyle(
                    fontSize: 18,
                    color: themeData.shopcartTextColor,
                    fontWeight:FontWeight.w700,
                    fontFamily: "Akrobat",
                  ),
                )),
          ),
        ),
      ),
    );
  }
}

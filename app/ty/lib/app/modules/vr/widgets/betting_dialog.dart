import 'package:flutter_ty_app/app/config/theme/app_color.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/vr_common_box_shadow.dart';

class BettingDialogUtil {
  static BettingDialogUtil of = BettingDialogUtil._();

  BettingDialogUtil._();

  // 单投
  void showSingle() {
    Get.bottomSheet(
      BettingDialog.single(),
      isScrollControlled: true,
    );
  }

  // 串投
  void showMulti() {
    Get.bottomSheet(
      BettingDialog.multi(),
      isScrollControlled: true,
    );
  }

  // 投注订单状态
  void showOrderStatus() {
    Get.bottomSheet(
      BettingDialog.orderStatus(),
      isScrollControlled: true,
    );
  }
}

class BettingDialog extends StatefulWidget {
  const BettingDialog._({
    super.key,
    required this.type,
  });

  // 仅测试用
  final int type;

  factory BettingDialog.single({
    Key? key,
  }) =>
      BettingDialog._(
        key: key,
        type: 1,
      );

  factory BettingDialog.multi({
    Key? key,
  }) =>
      BettingDialog._(
        key: key,
        type: 2,
      );

  factory BettingDialog.orderStatus({
    Key? key,
  }) =>
      BettingDialog._(
        key: key,
        type: 3,
      );

  @override
  State<BettingDialog> createState() => _BettingDialogState();
}

class _BettingDialogState extends State<BettingDialog> {
  late ValueNotifier<int?> _quickValue;

  @override
  void initState() {
    _quickValue = ValueNotifier(null);
    super.initState();
  }

  @override
  void dispose() {
    _quickValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: Get.height - 100),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildClose(),
            SizedBox(height: 12.w),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 14.w).copyWith(top: 12.w),
              decoration: BoxDecoration(
                color: AppColor.colorWhite,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24.w),
                ),
              ),
              child: Column(
                children: [
                  if (widget.type == 3)
                    _buildOrderConfirmedHeader()
                  else
                    _buildHeader(),
                  SizedBox(height: 8.w),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints(maxHeight: widget.type == 3 ? 300 : 400),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ListView.separated(
                            itemCount: widget.type == 1 ? 1 : 5,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return _buildItemCard(
                                showDelete: widget.type == 2 &&
                                    index > 0 &&
                                    index % 2 == 0,
                                disable: widget.type == 2 &&
                                    index > 0 &&
                                    index % 3 == 0,
                                ratioChanged: widget.type == 2 &&
                                    index > 0 &&
                                    index % 2 == 0,
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              height: 4.w,
                            ),
                          ),
                          if (widget.type != 3) ...[
                            _buildInput().marginSymmetric(vertical: 8.w),
                            _buildKeyboardArea(),
                          ],
                        ],
                      ),
                    ),
                  ),
                  if (widget.type == 3)
                    _buildOrderTotalAndConfirm()
                  else
                    _buildSlider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClose() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: Get.back,
          child: ImageView(
            'assets/images/shopcart/icon_close_white.svg',
            width: 28.w,
            height: 28.w,
          ).marginOnly(right: 20.w),
        ),
      ],
    );
  }




  Widget _buildHeader() {
    return Row(
      children: [
        ImageView(
          'assets/images/vr/betting_tag_${widget.type == 2 ? 'string' : 'single'}.png',
          width: 24.w,
          height: 24.w,
        ),
        SizedBox(width: 2.w),
        Text(
          widget.type == 2 ? '' : '开云体育',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: '#303442'.hexColor,
          ),
        ).expanded(),
        BettingDialogCommonDecoration(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
          borderRadius: 20.w,
          child: Row(
            children: [
              Text(
                '966,520,770.00',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: '#303442'.hexColor,
                ),
              ),
              SizedBox(width: 4.w),
              ImageView(
                'assets/images/shopcart/refresh.svg',
                width: 20.w,
                height: 20.w,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItemCard({
    bool showDelete = false,
    bool disable = false,
    bool ratioChanged = false,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.w),
      child: Stack(
        children: [
          BettingDialogCommonDecoration(
            padding: EdgeInsets.all(12.w),
            color: disable ? '#F8F9FA'.hexColor : null,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      '阿根廷 +0/0.5',
                      style: TextStyle(
                        fontSize: 14,
                        color: '#303442'.hexColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ).expanded(),
                    Text(
                      '@',
                      style: TextStyle(
                        fontSize: 14,
                        color: ratioChanged
                            ? '#F53F3F'.hexColor
                            : '#303442'.hexColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      '9.99',
                      style: TextStyle(
                        fontSize: 22,
                        color: ratioChanged
                            ? '#F53F3F'.hexColor
                            : '#303442'.hexColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    // TODO: 根据上升还是下降来选择图标
                    if (ratioChanged)
                      Icon(
                        Icons.arrow_drop_up,
                        color: '#F53F3F'.hexColor,
                      ),
                  ],
                ),
                SizedBox(width: 6.w),
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 2.w + 4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '上半场大小-附加盘 (0-0) ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: '#7981A4'.hexColor,
                                  ),
                                ),
                                TextSpan(
                                  text: '(欧洲盘)',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: '#179CFF'.hexColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '阿根廷 VS 克罗地亚',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: '#7981A4'.hexColor,
                            ),
                          ).marginSymmetric(vertical: 6.w),
                          Text(
                            '2022 PESI欧洲超级联赛',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: '#7981A4'.hexColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: 2.w,
                        decoration: BoxDecoration(
                          color: '#179CFF'.hexColor,
                          borderRadius: BorderRadius.circular(2.w),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (showDelete)
            Positioned(
              right: 0,
              bottom: 0,
              child: ImageView(
                'assets/images/vr/icon_bottom_right_delete.png',
                width: 30.w,
              ),
            ),
          if (disable)
            Positioned(
              right: 12.w,
              top: 0,
              bottom: 0,
              child: Text(
                '不支持串关投注',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: '#F53F3F'.hexColor.withOpacity(0.5),
                ),
              ).center,
            ),
          if (ratioChanged)
            Positioned(
              right: 12.w,
              top: 0,
              bottom: 0,
              child: Text(
                '赔率已更变',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: '#F53F3F'.hexColor,
                ),
              ).center,
            ),
        ],
      ),
    );
  }

  Widget buildCloseNew() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: Get.back,
          child: ImageView(
            'assets/images/shopcart/icon_close_white.svg',
            width: 28.w,
            height: 28.w,
          ).marginOnly(right: 20.w),
        ),
      ],
    );
  }


  Widget _buildInput() {
    return Row(
      children: [
        BettingDialogCommonDecoration(
          borderRadius: 12.w,
          height: 44.w,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: '限额 0.00-100,000',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: '#C9CDDB'.hexColor,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ).expanded(),
              Text(
                'RMB',
                style: TextStyle(
                  fontSize: 14,
                  color: '#C9CDDB'.hexColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ).expanded(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          height: 44.w,
          decoration: BoxDecoration(
            color: '#179CFF'.hexColor,
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: Row(
            children: [
              ImageView(
                'assets/images/shopcart/add.svg',
                width: 20.w,
                height: 20.w,
              ),
              const Text(
                '预约',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColor.colorWhite,
                ),
              ).marginOnly(left: 4.w),
            ],
          ),
        ).marginOnly(left: 8.w),
      ],
    );
  }

  Widget _buildKeyboardArea() {
    return BettingDialogCommonDecoration(
      padding: EdgeInsets.all(4.w),
      borderRadius: 12.w,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // -1 防止四舍五入超过总宽度导致换行
          final maxWidth = constraints.maxWidth - 1;
          return Column(
            children: [
              _buildQuickInput(maxWidth),
              SizedBox(height: 4.w),
              _buildKeyboard(maxWidth),
            ],
          );
        },
      ),
    );
  }

  Widget _buildQuickInput(double maxWidth) {
    final values = [
      100,
      500,
      1000,
      2000,
      5000,
    ];
    final spacing = 4.w;

    final itemWidth =
        (maxWidth - (values.length - 1) * spacing) / values.length;
    return Container(
      padding: EdgeInsets.only(bottom: 4.w),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColor.dividerColorLight,
          ),
        ),
      ),
      child: Wrap(
        spacing: spacing,
        children: List.generate(
          values.length,
          (index) {
            final value = values[index];
            return ValueListenableBuilder(
              valueListenable: _quickValue,
              builder: (context, selValue, child) {
                return Stack(
                  children: [
                    VrCommonBoxShadow(
                      onTap: () {
                        //
                        _quickValue.value = value;
                      },
                      height: 36.w,
                      width: itemWidth,
                      child: Text(
                        '$value',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: '#179CFF'.hexColor,
                        ),
                      ).center,
                    ),
                    if (selValue == value)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: ImageView(
                          'assets/images/shopcart/text_selected.svg',
                          width: 20.w,
                          height: 20.w,
                        ),
                      ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildKeyboard(double maxWidth) {
    final numValues = [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      '.',
      0,
      '00',
    ];
    final funcValues = [
      '最大',
      'delete',
      'hide',
    ];
    final spacing = 4.w;
    const columns = 4;
    final itemWidth = (maxWidth - (columns - 1) * spacing) / columns;
    final itemHeight = 36.w;

    return Row(
      children: [
        Wrap(
          spacing: spacing,
          runSpacing: 4.w,
          children: List.generate(
            numValues.length,
            (index) {
              final value = numValues[index];
              return VrCommonBoxShadow(
                height: itemHeight,
                width: itemWidth,
                child: Text(
                  '$value',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: '#303442'.hexColor,
                  ),
                ).center,
              );
            },
          ),
        ).expanded(),
        SizedBox(width: spacing),
        Wrap(
          spacing: 4.w,
          direction: Axis.vertical,
          children: List.generate(
            funcValues.length,
            (index) {
              final value = funcValues[index];
              return VrCommonBoxShadow(
                height: value == 'delete'
                    ? itemHeight * 2 + 4.w
                    : value == 'delete1'
                        ? 0
                        : itemHeight,
                width: itemWidth,
                child: Column(
                  children: [
                    Builder(
                      builder: (context) {
                        return VrCommonBoxShadow(
                          height: value == 'delete'
                              ? itemHeight * 2 + 4.w
                              : itemHeight,
                          width: itemWidth,
                          child: Builder(
                            builder: (context) {
                              if (value == 'delete') {
                                return UnconstrainedBox(
                                  child: ImageView(
                                    'assets/images/vr/icon_keyboard_delete.svg',
                                    width: 24.w,
                                    height: 24.w,
                                  ),
                                );
                              }
                              if (value == 'hide') {
                                return UnconstrainedBox(
                                  child: ImageView(
                                    'assets/images/vr/icon_keyboard_hide.svg',
                                    width: 24.w,
                                    height: 24.w,
                                  ),
                                );
                              }
                              return Text(
                                value,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: '#303442'.hexColor,
                                ),
                              ).center;
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSlider() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          color: AppColor.colorWhite,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  ImageView(
                    'assets/images/shopcart/check.png',
                    width: 16.w,
                    height: 16.w,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '自动接受最佳赔率',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: '#7981A4'.hexColor,
                    ),
                  ),
                ],
              ).paddingSymmetric(vertical: 8.w),
              Row(
                children: [
                  if (widget.type == 2) ...[
                    ImageView(
                      'assets/images/vr/icon_betting_delete.svg',
                      width: 50.w,
                    ),
                    SizedBox(width: 8.w),
                  ],
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      BettingDialogUtil.of.showOrderStatus();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      height: 50.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            '#45B0FF'.hexColor,
                            '#179CFF'.hexColor,
                          ],
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Row(
                            children: [
                              ImageView(
                                'assets/images/vr/icon_circle_arrow_right.png',
                                width: 44.w,
                                color: Colors.transparent,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: '投注',
                                      style: TextStyle(
                                        color: AppColor.colorWhite,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '  ${widget.type == 2 ? '合计' : '可赢'}',
                                      style: TextStyle(
                                        color: AppColor.colorWhite
                                            .withOpacity(0.6),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '0.00',
                                      style: TextStyle(
                                        color: AppColor.colorWhite
                                            .withOpacity(0.6),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ).expanded(),
                              Row(
                                children: [
                                  ImageView(
                                    'assets/images/icon/icon_arrow_right_grey.png',
                                    width: 16.w,
                                  ),
                                  ImageView(
                                    'assets/images/icon/icon_arrow_right_grey_01.png',
                                    width: 16.w,
                                  ),
                                  ImageView(
                                    'assets/images/icon/icon_arrow_right_grey_light.png',
                                    width: 16.w,
                                  ),
                                ],
                              ).marginOnly(right: 13.w),
                            ],
                          ),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              return Container(
                                width: constraints.maxWidth,
                                alignment: Alignment.centerLeft,
                                child: Dismissible(
                                  key: UniqueKey(),
                                  direction: DismissDirection.startToEnd,
                                  dismissThresholds: const {
                                    DismissDirection.startToEnd: 0.75,
                                  },
                                  confirmDismiss: (_) async {
                                    // bool result;
                                    // try {
                                    //   result = (await widget.action()) ?? true;
                                    // } catch (e) {
                                    //   result = false;
                                    // }

                                    // ///break the action
                                    // if (!result) return false;
                                    // setState(() {
                                    //   flag = !flag;
                                    // });
                                    // final hasVibrator =
                                    //     await Vibration.hasVibrator() ?? false;
                                    // if (widget.vibrationFlag && hasVibrator) {
                                    //   try {
                                    //     Vibration.vibrate(duration: 200);
                                    //   } catch (e) {
                                    //     print(e);
                                    //   }
                                    // }
                                    await 3.seconds.delay();
                                    return true;
                                  },
                                  child: Container(
                                    width: constraints.maxWidth - 44.w,
                                    alignment: Alignment.centerLeft,
                                    child: ImageView(
                                      'assets/images/vr/icon_circle_arrow_right.png',
                                      width: 44.w,
                                      height: 44.w,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ).expanded(),
                  Container(
                    decoration: BoxDecoration(
                      color: '#E8F5FF'.hexColor,
                      shape: BoxShape.circle,
                    ),
                    height: 50.w,
                    width: 50.w,
                    margin: EdgeInsets.only(left: 8.w),
                    child: widget.type == 2
                        ? Text(
                            '单关\n投注',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: '#179CFF'.hexColor,
                            ),
                          ).center
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ImageView(
                                'assets/images/shopcart/add.svg',
                                width: 16.w,
                                color: '#179CFF'.hexColor,
                              ),
                              Text(
                                '串',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: '#179CFF'.hexColor,
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ],
          ).marginOnly(bottom: 20.w).safeArea(top: false),
        ),
        if (widget.type == 2)
          Positioned(
            top: -20.w,
            left: 0,
            right: 0,
            child: ImageView(
              'assets/images/vr/icon_scrolldown.svg',
              width: 20.w,
              height: 20.w,
            ).center,
          ),
      ],
    );
  }

  _buildOrderConfirmedHeader() {
    return Column(
      children: [
        ImageView(
          'assets/images/vr/betting_order_status_confirmed.svg',
          width: 140.w,
        ),
        SizedBox(height: 8.w),
        Text(
          '注单已确认',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: '#179CFF'.hexColor,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderTotalAndConfirm() {
    return Column(
      children: [
        SizedBox(height: 4.w),
        BettingDialogCommonDecoration(
          padding: EdgeInsets.all(12.w),
          borderRadius: 12.w,
          child: Column(
            children: [
              _buildTotalRow(
                title: '投注金额',
                subtitle: '600,256.00',
              ),
              _buildTotalRow(
                title: '可赢金额',
                subtitle: '3,958,256.00',
              ).marginSymmetric(vertical: 12.w),
              _buildTotalRow(
                title: '注单号',
                subtitle: 'LX21351531351311321',
                subtitleStyle: TextStyle(
                  fontSize: 12,
                  color: '#7981A4'.hexColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Container(
          constraints: BoxConstraints(minHeight: 48.w),
          decoration: BoxDecoration(
            color: '#179CFF'.hexColor,
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: const Text(
            '确认',
            style: TextStyle(
              fontSize: 16,
              color: AppColor.colorWhite,
              fontWeight: FontWeight.w500,
            ),
          ).center,
        ).marginOnly(top: 8.w),
      ],
    ).marginOnly(bottom: 20.w).safeArea(top: false);
  }

  Widget _buildTotalRow({
    required String title,
    required String subtitle,
    TextStyle? subtitleStyle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: '#7981A4'.hexColor,
          ),
        ),
        Text(
          subtitle,
          style: subtitleStyle ??
              TextStyle(
                fontSize: 16,
                color: '#303442'.hexColor,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}

class BettingDialogCommonDecoration extends StatelessWidget {
  const BettingDialogCommonDecoration({
    super.key,
    this.borderRadius = 0,
    this.padding,
    this.height,
    required this.child,
    this.color,
  });

  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color ?? '#F3FAFF'.hexColor,
      ),
      child: child,
    );
  }
}

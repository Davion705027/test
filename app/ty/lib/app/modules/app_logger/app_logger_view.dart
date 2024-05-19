import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'app_logger_logic.dart';

class AppLoggerPage extends StatelessWidget {
  const AppLoggerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppLoggerLogic>(
      builder: (controller) {
        return Scaffold(
          appBar: _buildAppBar(context),
          backgroundColor: context.isDarkMode
                ? AppColor.titleBackgroundColor
                : '#F2F2F6'.hexColor,
          body: Center(
            child: Column(children: [
              GetBuilder<AppLoggerLogic>(
                id: 'status',
                builder: (_) {
                  return textButtonWidget(
                      '当前状态：${controller.logger.isCollecting ? '正在收集日志...' : '未收集日志'}',
                      controller.openOrClose,
                      controller.logger.isCollecting ? '关闭日志' : '开启日志');
                },
              ),
              GetBuilder<AppLoggerLogic>(
                id: 'size',
                builder: (_) {
                  return textButtonWidget(
                      '日志大小：${controller.logger.fileSizeText}',
                      controller.checkLog,
                      '检查日志大小');
                },
              ),

              buttonWidger('删除日志', controller.deleteLog, color: Colors.red),
              buttonWidger('添加测试日志', controller.logTest),
              buttonWidger('上传日志切片 + 自动合并切片', controller.slice),
              buttonWidger('手动合并切片', controller.logger.mergeChunks),
            ]),
          ),
        );
      },
    );
  }


  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor:
          context.isDarkMode ? AppColor.titleBackgroundColor : Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: InkWell(
        onTap: () => Get.back(),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(
            left: 10.w,
          ),
          child: Icon(
            Icons.arrow_back_ios,
            size: 20.w,
            color: context.isDarkMode ? Colors.white : const Color(0xFF303442),
          ),
        ),
      ),
      title: Text(
        'APP 日志',
        style: TextStyle(
          color: context.isDarkMode ? Colors.white : const Color(0xFF303442),
          fontSize: 16.sp,
          fontFamily: 'PingFang SC',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget textButtonWidget(String text, VoidCallback onPressed, String btnText,
     ) {
    return Container(
      margin: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 180,
            child: Text(text),
          ),
          const SizedBox(width: 00.0), // 添加间距
          Expanded(
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text(btnText),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonWidger(String text, VoidCallback onPressed, {Color? color}) {
    Color btnColor = color ?? const Color(0xFF3E65FF);
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
        height: 40.h,
        decoration: ShapeDecoration(
          color: btnColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        // width: double.maxFinite,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

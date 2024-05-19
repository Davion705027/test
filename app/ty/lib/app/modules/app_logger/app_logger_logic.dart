import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/utils/logger.dart';
import 'app_logger_state.dart';

class UploadStatus {
  RxString str = '0/0'.obs;
  RxDouble progress = 0.00.obs;
}
class AppLoggerLogic extends GetxController {
  final AppLoggerState state = AppLoggerState();
  Logger logger = Logger.getInstance();

  UploadStatus uploadStatus = UploadStatus();

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    if (logger.isCollecting) {
      startTimer();
    }
  }


  @override
  void onClose() {
    Get.delete<AppLoggerLogic>();
    super.onClose();
    cancelTimer();
  }
  cancelTimer(){
    if(_timer != null){
      _timer!.cancel();
      _timer = null;
    }
  }

  openOrClose() {
    if (logger.isCollecting) {
      logger.close();
      cancelTimer();
    } else {
      logger.open();
      startTimer();
    }
    update(['status']);
  }
  startTimer(){
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        checkLog();
      });
  }

  checkLog() async {
    logger.checkLogFile();
    update(['size']);
  }

  deleteLog() {
    showDialog('确定删除当前日志吗?', () async{
      // 进行删除操作
      await logger.clearLogFile();
      update(['size']);
      Get.back();
    });
  }

  void test() {
    logger.logTest();
  }

  void slice() async {
    // 当前还在收集
    if (logger.isCollecting) {
      showDialog('当前还在收集，确定上传日志吗?', () async {
        openOrClose(); // 关闭收集
        Get.back();
        await doSlice();
      });
    }else{
      doSlice();
    }
  }
  doSlice() async{
    Get.defaultDialog(
      title: '切片上传中...',
      content: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() => LinearProgressIndicator(
              value: uploadStatus.progress.value,
            )),
            Obx(() => Text(uploadStatus.str.value))
          ],
        ),
      ),
      barrierDismissible: false, // 禁止点击外部关闭对话框
    );

    await logger.slice(cb:(double progress,String str){
      uploadStatus.progress.value = progress;
      uploadStatus.str.value = str;
    });
    update(['size']);
    Get.back();
    uploadStatus = UploadStatus();
    Get.snackbar('提示', '日志上传成功');
  }

  void logTest() {
    logger.logTest();
    update(['size']);
    Get.snackbar("生成测试Log数据", "生成测试数据成功！");
  }
}

showDialog(String text, onPress) {
  Get.defaultDialog(
    title: '提示',
    middleText: text,
    actions: [
      TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text('取消'),
      ),
      TextButton(
        onPressed: onPress,
        child: const Text('确定'),
      ),
    ],
  );
}

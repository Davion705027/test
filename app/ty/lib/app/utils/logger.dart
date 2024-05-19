import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/global/server-time.dart';
import 'package:get/get.dart' hide Response;
import 'package:path_provider/path_provider.dart';
Dio _dio = Dio();
// String domain = 'http://localhost:18101/openapi/applogger/';
String domain = 'https://api-doc-server-new.dbsporxxxw1box.com/openapi/applogger/';
String uploadUrl = '${domain}upload';
String mergeUrl = '${domain}merge';

/*
*   不同项目修改 _PROJECT
*   chunkSize 可调整
* */
class Logger {
  static Logger? instace;
  static Logger getInstance() {
    instace ??= Logger();
    return instace!;
  }

  // 项目名称
  static const String _PROJECT = 'TY';
  // 每个切片大小，这里设置为1MB
  // int chunkSize = 1 * 1024 * 1024;
  
  List<String> buffer1 = [];
  List<String> buffer2 = [];
  // buffer数组最大存储量
  static const int bufferMaxSize = 200;
  late List<String> currentBuffer;
  // 是否开启日志
  bool isCollecting = false;
  // 存储日志的文件
  var logFile;
  // 已记录日志大小
  int fileSize = 0;
  String fileSizeText = '0B';

  Logger(){
    init();
  }
  init()async{
    currentBuffer = buffer1;
    logFile = await _getLocalFile();
    // 之前缓存的数据
    List<int> bytes = await logFile.readAsBytes();
    fileSize = bytes.length;
    checkLogFile();
  }

  Future<File> _getLocalFile() async {
    if(logFile != null)return logFile;
    String dir = (await getApplicationDocumentsDirectory()).path;
    return File('$dir/counter.txt');
  }
  
  Future uploadChunk(int index, int totalChunks, String filename, String fileChunk) async {
    try {
       return _dio.post(
        uploadUrl,
        data: {
          'index': index,
          'totalChunks': totalChunks,
          'project': Logger._PROJECT,
          'fileChunk': fileChunk,
        },
      );
      print('Chunk $index uploaded successfully');
    } catch (e) {
      print('Error uploading chunk $index: $e');
      // 处理上传失败的情况
    }
  }
  Future<void> mergeChunks() async {
    try {
       await _dio.post(
        mergeUrl,
        data: {
          'project': Logger._PROJECT,
        },
      );
      print('Chunk mergeChunk successfully');
    } catch (e) {
      print('Error mergeChunk: $e');
      // 处理上传失败的情况
    }
  }
  int getDynamicChunkSize(totalSize){
    int chunkSize =  1*1024*1024; // 1m
    if(totalSize >= 10*1024*1024){
      chunkSize = 5*1024*1024; // 5m
    }
    return chunkSize;
  }
  /*切片上传*/
  slice({Function? cb}) async{
    try{
      print(currentBuffer);
      // 内存中数据先写入
      checkCurrentBuffer();
      List<int> bytes = await logFile.readAsBytes();
      if(bytes.isEmpty)return;
      String filename = '.txt';
      int chunkSize = getDynamicChunkSize(bytes.length);
    
      int totalChunks = (bytes.length / chunkSize).ceil();

      // 开始上传 回调外部方法显示 进度
      if(cb != null){
        int n = 0;
        double progress = n/totalChunks;
        cb(progress,'$n / $totalChunks');
      }

      for (int chunk = 0; chunk < totalChunks; chunk++) {
        int start = chunk * chunkSize;
        int end = (chunk + 1 == totalChunks) ? bytes.length : (chunk + 1) * chunkSize;
        List<int> chunkBytes = bytes.sublist(start, end);
        String fileChunk = base64Encode(chunkBytes);

        await uploadChunk(chunk, totalChunks, filename, fileChunk);
        if(cb != null){
          int n = chunk+1;
          double progress = n/totalChunks;
          cb(progress,'$n / $totalChunks');
        }
        
      }
      print('切片上传完成');
      // 清除文件内容
      await clearLogFile();

      // 合并
      await mergeChunks();
      print('切片合并完成');

    }catch(e){
      print(e);
    }

  }
  

  // 开关打开
  void open() {
    isCollecting = true;
  }

  // 开关关闭
  void close() {
    isCollecting = false;
  }


  // 缓冲池 切换
  void _rotateBuffer() {
    if (currentBuffer == buffer1) {
      currentBuffer = buffer2;
      _writeBufferToFile(buffer1);
      buffer1.clear();
    } else {
      currentBuffer = buffer1;
      _writeBufferToFile(buffer2);
      buffer2.clear();
    }
  }
  // 检查内存中的buffer数组是否还有数据 
  checkCurrentBuffer(){
    _writeBufferToFile(currentBuffer);
    currentBuffer.clear();
  }

  // 写入数据
  _writeBufferToFile(List<String> buffer) {
    logFile.writeAsStringSync("${buffer.join('\n')}\n", mode: FileMode.append);
  }

  clearLogFile() async{
    try{
      await logFile.writeAsBytes(<int>[]);
      // List<int> bytes = await logFile.readAsBytes();
      fileSize = 0;
      checkLogFile();
    }catch(e){
      print(e);
    }
  }

  String getLogTime(){
    int t = serverTime.getRemoteTime();
    return getTime(t);
  }

  // 检查日志文件大小
  checkLogFile() {
    //  List<int> bytes = await logFile.readAsBytes();
    //  fileSize = bytes.length;
     fileSizeText = formatBytes(fileSize);
  }

  void logTest() {
    if (!isCollecting) return;
    String test = 'logTestlogTest messagelogTest messagelogTest messagemessage';
    int len = 600000; //3m
    String t = test * len;
    log(t);
    // for(var i=0;i<len;i++){
    //   log('$i:$test');
    // }
  }

  // ws send log
  void wsSendLog(data) {
    if (!isCollecting) return;
    String message = '$_PROJECT-APP-WS-S  $data';
    log(message);
  }

  // ws receive log
  void wsReceiveLog(data) {
    if (!isCollecting) return;
    String message = '$_PROJECT-APP-WS-R  ${data['cmd']} $data';
    log(message);
  }

  // 接口请求log
  void httpSendLog( RequestOptions options) {
    if (!isCollecting) return;
    Map obj = {
      "url": options.path,
      'params': options.queryParameters,
      'data': options.data
    };
    String message = '$_PROJECT-APP-HTTP-S  $obj';
    log(message);
  }
  // 接口响应log
  void httpReceiveLog( Response response ) {
    if (!isCollecting) return;
    Map obj = {
      // "url": response.realUri.path,
      'data': response.data
    };
    String message = '$_PROJECT-APP-HTTP-R  $obj';
    log(message);
  }

  void log(String message) {
    if (isCollecting) {
      // Get.log('正在收集');
      fileSize +=  utf8.encode(message).length;

      message = '${getLogTime()}  $message';
      currentBuffer.add(message);
      if (currentBuffer.length >= bufferMaxSize) {
        _rotateBuffer();
      }
    }
  }



}



// 格式化字节数据
String formatBytes(int bytes) {
  if (bytes < 1024) {
    return '${bytes}B';
  } else if (bytes < 1024 * 1024) {
    double kb = bytes / 1024;
    return '${kb.toStringAsFixed(2)}KB';
  } else {
    double mb = bytes / (1024 * 1024);
    return '${mb.toStringAsFixed(2)}MB';
  }
}


// 格式化时间
String getTime(int timestamp){
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  String formattedDateTime = '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-'
      '${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:'
      '${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}.'
      '${dateTime.millisecond.toString().padLeft(3, '0')}';
  return formattedDateTime;
}

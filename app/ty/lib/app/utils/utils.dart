
import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'dart:math';
import 'dart:io';

import 'package:get/get.dart';



// 简易深拷贝
Map clonedObject(obj){
  return jsonDecode(jsonEncode(obj));
}

// 判断有值 只做if判断
bool hasValue(dynamic value) {
  return value != null;
}
bool isString(dynamic value){
  return hasValue(value) && value is String;
}
// 字符串有值
bool hasStrValue(dynamic value) {
  return isString(value) && value.isNotEmpty;
}


bool isList(dynamic value){
  return hasValue(value) && value is List;
}
// 数组 并且有值
bool hasValList(dynamic value){
  return isList(value)  && value.isNotEmpty;
}
// 字符串数组 并且有值
bool isStrList(dynamic value){
  return hasValList(value)  && hasStrValue(value[0]);
}

bool isFunction(dynamic value){
  return hasValue(value) && value is Function;
}
bool isMap(dynamic value){
  return hasValue(value) && value is Map;
}
// hasOwnProperty
bool hasKey(dynamic obj,dynamic key){
  if(!hasValue(obj))return false;
  if (obj is Map) {
    return obj.containsKey(key);
  } else if (obj is List) {
    if (key is int) {
      return key >= 0 && key < obj.length;
    }
  }
  return false;
}



// 解密 单个字符串
String jiemiWord(String word,key) {
  String res = word;
  try{  
    final iv = IV.fromLength(16); // 初始化向量，长度为 16
    final encrypter = Encrypter(AES(Key.fromUtf8(key), mode: AESMode.ecb)); // 使用 AESMode.ecb 模式
    final decrypted = encrypter.decrypt64(word, iv: iv);
    res = decrypted.toString();
  } finally {
    return res;
  }
}

// api参数域名加密
String apiEncrypt(String apiStr) {
  // 解密url 内 api 字段使用的 key
  final decryptKeyUrlApi = Key.fromUtf8("OBTY20220712OBTY");
  final iv = IV.fromLength(16); // 如果使用 ECB 模式，则 IV 可以是任何值，因为它不会被使用

  final encrypter = Encrypter(AES(decryptKeyUrlApi, mode: AESMode.ecb));

  String res = '';

  if (apiStr.isNotEmpty) {
    final encrypted = encrypter.encrypt(apiStr, iv: iv);
    res = encrypted.base64;
  }

  return res;
}


// 域名拼接 防止参数不带/
String composeUrl(String a,String b){
   if(!a.endsWith('/')){
    a += '/'; 
   }
   if(b.startsWith('/')){
    b = b.substring(1);
   }
   return a+b;
}

String createGcuuid({int num = 18}) {
  List<String> strList =
  "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".split('');
  final len = strList.length;
  String uuid = quid();

  // 添加当前时间戳和随机数作为种子
  uuid += DateTime.now().millisecondsSinceEpoch.toString();
  uuid += Random().nextInt(10000).toString();

  for (int index = 0; index < num; index++) {
    uuid += strList[Random().nextInt(len)];
  }
  return uuid;
}

String quid() {
  var s = '';
  for (var i = 0; i < 9; i++) {
    s += ((Random().nextDouble() * 16).floor()).toRadixString(16);
  }
  return s;
}

/**
 * 设备3:安卓，4:iOS ，5:其他设备
 */
int getDevice() {
  int  device = 5;
  if (Platform.isAndroid) {
    device = 3;
  } else if (Platform.isIOS) {
    device = 4;
  }
  return device;
}

/**
 * 金额两位小数补零
 */
String setAmount(String amount) {
  String changeAmount = amount;
  if (amount.isNotEmpty) {
    if (amount.contains('.')) {
      List<String> split = amount.split('.');
      if (split[0].isNotEmpty && split[1].isNotEmpty) {
        if (split[1].length < 2) {
          changeAmount = amount + "0";
        }
      }
    } else {
      changeAmount = amount + ".00";
    }
  }
  return changeAmount;
}

bool isZh(){
  return Get.locale?.languageCode == 'zh';
}
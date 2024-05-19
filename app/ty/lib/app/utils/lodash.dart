// 封装lodash get方法
import 'dart:async';

import 'package:flutter_ty_app/app/utils/utils.dart';





class Lodash{
  dynamic get(Map obj, dynamic keys) {
    dynamic res = obj;

    if (keys is String) {
      keys = keys.split('.');
    }
    for (final key in keys) {
      if (res is Map && res.containsKey(key)) {
        res = res[key];
      } else {
        return null;
      }
    }
    return res;
  }
  // 去重
  List uniq(List list){
    return list.toSet().toList();
  }
  // 根据字段去重
  List uniqBy(List list, String propertyName){
    List uniqueList = [];
    Set<dynamic> seen = {};

    for (var item in list) {
      var key = item[propertyName]; 

      if (!seen.contains(key)) {
        uniqueList.add(item);
        seen.add(key);
      }
    }

    return uniqueList;
  }

  List pullAllBy(arr,values,propertyName){
    List res = [];
    List propertys = values.map((i) => i[propertyName]).toList(); 
    for(var item in arr){
      if(!propertys.contains(item[propertyName])){
        res.add(item);
      }
    }

    return res;  
  }

  bool isPlainObject(dynamic value) {
    return value != null && value is Map && !value.containsKey(const Symbol('iterator'));
  }

  // 防抖
  Function debounce(Function fn,{int time = 300}){
    Timer? timer;  
    return (){
      timer?.cancel();
      timer = Timer( Duration(milliseconds: time), () {
        fn();
       });
    };
  }

  List<T> deepCopyArr<T>(List<T> original) {
    List<T> copy = [];
    for (var item in original) {
      if (item is List<T>) {
        copy.addAll(deepCopyArr(item));
      } else {
        copy.add(item);
      }
    }
    return copy;
  }

  test(){
    var obj = {};
    var t = obj.containsKey(Symbol('iterator'));
    print(hasKey([1], 0));
      // List arr = [{'api':'12',},{'api':'12',},{'api':3}];
      // arr.forEach((element) {
      //   print(element['api']);
      // });
  
      // var arr2 = lodash.uniqBy(arr, 'api');
      // print(arr2);
  }
}
Lodash lodash = Lodash();

  // 例子说明
  /***----- pullAllBy -----***/ 
  // List<Map<String, dynamic>> array = [
  //       {'x': 1},
  //       {'x': 2},
  //       {'x': 3},
  //       {'x': 1},
  //     ];
  //     List<Map<String, dynamic>> values = [{'x': 1}, {'x': 3}];
  //     var res = lodash.pullAllBy(array, values, 'x');
  //     print(res); // [{x: 2}]
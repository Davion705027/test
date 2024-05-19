
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';

class GamingResultslogic {
  GamingResultslogic() {
    ///Initialize variables
  }
  // 国际化todo
  static Map nameMap = {
    '100':'英雄联盟',
    '101':'Dota2',
    '103':'王者荣耀',
    '102':'CS:GO/CS2',
  };
  static List<TypeModel> getMenu(){
    // var getName = ConfigController.to.getName;
    // List<ResultMenuItemModel> list = ['100','101','103','102'].map((e){
    //   ResultMenuItemModel item = ResultMenuItemModel();
    //   item.euid = int.parse(e) - 100;
    //   item.sportId = e;
    //   item.name = nameMap[e];
    //   return item;
    // }).toList()
    // {
  //   "ct": 0,
  //   "mi": "2101",
  //   "st": 2,
  //   "csid": 101,
  //   "sport_id": 101,
  //   "result_mi": 2101
  // };
    

    // todo 国际化
    List<TypeModel> list = [
      TypeModel(LocaleKeys.app_lol.tr, 100,2100,'assets/images/detail/bg/details-LOL.jpg'), // 2100
      TypeModel('Dota2', 101,2101,'assets/images/detail/bg/DOTA.jpg'), // 2101
      TypeModel(LocaleKeys.sport2_103.tr, 103,2103,'assets/images/detail/bg/details-KPL.jpg'), // 2103
      TypeModel('CS2', 102,2102,'assets/images/detail/bg/CS_GO.jpg'), // 2102
    ];
    return list;
  }
}

class TypeModel {
  late String name;
  late int euid;
  late int miid;
  late String image;

  TypeModel(this.name,this.euid,this.miid,this.image);
}
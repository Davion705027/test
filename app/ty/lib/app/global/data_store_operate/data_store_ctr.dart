import 'package:flutter/foundation.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_ctr_ws.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_map_operate.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

extension DataStoreCtr on MatchDataBaseWS{

  // MatchDataBaseWS? _wsCtr;
  // MatchDataBaseWS get wsCtr {
  //   _wsCtr ??= Get.find<MatchDataBaseWS>();
  //   return _wsCtr!;
  // }
  
  // MatchDataBaseWS wsCtr = MatchDataBaseWS();
  
  // dataStoreController? _dataStoreController;
  // dataStoreController get dataStoreController {
  //   _dataStoreController ??= Get.find<dataStoreController>();
  //   return _dataStoreController!;
  // }
  getNameCode() {
    String nameCode =dataStoreController.params['name_code'] ?? '';
    if (nameCode.isEmpty) {
      if (kDebugMode) {
        print('MatchDataBase -赛事数据仓库-必须有实例化名字标识---');
      }
      return;
    }
  }

  /// @description: 设置赛事为活动状态
  /// @param {Array} mids 赛事列表
  // void setActiveMids(mids) {
  //   if (mids != null) {
  //     /// 设置激活的赛事mids数组
  //     dataStoreController.midsAtion = mids;
  //     mids.forEach((String mid) {
  //       final match = dataStoreController.listToObj['mid_obj'][mid];
  //       if (match != null) {
  //         match['_action'] = true;
  //       }
  //     });
  //
  //     /// 不等于赛事详情时,赛事详情再设置数据时发送一次就行
  //     if ('match' != dataStoreController.type) {
  //       /// ws命令赛事订阅
  //       scmdC8(mids.toString());
  //     }
  //   }
  // }

  void setInactiveMids(mids) {
    if (mids != null) {
      mids.forEach((mid) {
        final match = dataStoreController.listToObj['mid_obj'][mid];
        if (match != null) {
          match['_action'] = false;
        }
      });
    }
  }



  // void wsMatchKeyUpdTimeCacheSet(matche, String? key, int ctsp) {
  //   String? mid = matche['mid'];
  //   if (mid != null && key != null) {
  //     dataStoreController.wsMatchKeyUpdTimeCache[mid][key] = ctsp;
  //   }
  // }

  int wsMatchKeyUpdTimeCacheGetTime(String? mid, String? key) {
    int res = 0;
    if (mid != null && key != null) {
      res = dataStoreController.wsMatchKeyUpdTimeCache[mid][key] ?? 0;
    }
    return res;
  }

  void setMatchUpdTimeKeys(List? matches, List? keys, int? time) {
    if (matches != null && keys != null && time != null) {
      /// 遍历赛事列表
      matches.forEach((match) {
        /// 获取赛事mid标识
        final mid = match['mid'];

        /// 遍历属性列表
        keys.forEach((key) {
          /// 设置属性时间
          dataStoreController.cacheMatch[mid][key] = time;
        });
      });
    }
  }

  Map getMatchUpdTimeKeys(String? mid) {
    Map res = {};
    if (mid != null) {
      res = dataStoreController.cacheMatch[mid] ?? {};
    }
    return res;
  }

  Map getListObj(List? list, int timestamp) {
    Map obj = {};
    if (list != null) {
      list.forEach((item) {
        if (item != null && item['mid'] != null) {
          obj[item['mid']] = item;
        }
      });

      /// 更新赛事的基本属性时间
      setMatchUpdTimeKeys(list, dataStoreController.matchUpdTimeKeys, timestamp);
    }
    return obj;
  }

  Map listComparison(List? oldList, List? newList) {
    Map ret = {'add': {}, 'del': {}, 'upd': {}};
    Map oldObj = getListObj(oldList,DateTime.now().millisecondsSinceEpoch);
    Map newObj = getListObj(newList,DateTime.now().millisecondsSinceEpoch);
    String key = '';
    String id = 'mid';
    if (newList != null) {
      newList.forEach((item) {
        if (item != null && item[id] != null) {
          key = item[id];
          if (oldObj[key] != null) {
            /// 修改的
            ret['upd'][key] = item;
          } else {
            /// 新增的
            ret['add'][key] = item;
          }
        }
      });
    }

    if (oldList != null) {
      oldList.forEach((item) {
        if (item != null && item[id] != null) {
          key = item[id];
          if (newObj[key] == null) {
            /// 需要删除的
            ret['del'][key] = item;
          }
        }
      });
    }
    return ret;
  }

  void matchAssign(Map? matchOld, Map? matchNew) {
    if (matchOld != null && matchNew != null) {
      matchAssignWithV1(matchOld, matchNew);
    }
  }

  void matchAssignWithV1(Map? matchOld, Map? matchNew) {
    if (matchOld != null && matchNew != null) {
      matchNew.forEach((key, value) {
        matchOld[key] = value;
      });
    }
  }

  // Map<String,dynamic> getQuickMidObj(String mid) {
  //   /// 获取指定mid的赛事
  //   final key = getListToObjKey(mid, mid, 'mid');
  //   return dataStoreController.listToObj['mid_obj'][key];
  // }

   getQuickMidObjRef(String mid) {
    /// 获取指定mid的赛事
    final key = getListToObjKey(mid, mid, 'mid');
    return dataStoreController.listToObj['mid_obj'][key];
  }

  Map<String, dynamic> serializedScoreObj(List msc, [bool isInit = false]) {
    Map<String, dynamic> scoreObj = {};
    if (isInit) {
      scoreObj = {
        'S11': {'home': '', 'away': ''},
        'S103': {'home': '0', 'away': '0'},
        'S5': {'home': '', 'away': ''},
        'S10102': {'home': '', 'away': ''}
      };
    }
    try {
      /// 遍历接口比分数据 转成比分对象
      msc.forEach((scoreStr) {
        if (scoreStr is String) {
          final List<String> scoreArr = scoreStr.split('|');
          final String key = scoreArr[0];
          final String value = scoreArr[1];
          if (value.isNotEmpty) {
            final List<String> score = value.split(':');
            scoreObj[key] = {'home': score[0], 'away': score[1]};
          }
        }
      });
    } catch (error) {
      if (kDebugMode) {
        print('serializedScoreObj msc: $msc');
      }
      if (kDebugMode) {
        print('serializedScoreObj: $error');
      }
    }
    return scoreObj;
  }

  void setSavaTabPlayData(Map? matchNew, Map? matchOld) {
    if (matchNew == null || matchOld == null) {
      /// 无效数据放弃设置
      return;
    }

    /// tab菜单字段开关和数key据对应关系
    final Map<String, dynamic> tabKeyData = {
      /// 角球开关
      'cosCorner': {
        'play_name': '角球',
        'field': 'hpsCorner',
      },

      /// 罚牌
      'hpsPunish': {
        'play_name': '罚牌',
        'field': 'hpsPunish',
      },

      /// 冠军
      'cosOutright': {
        'play_name': '冠军',
        'field': 'hpsOutright',
      },

      /// 晋级赛
      'cosPromotion': {
        'play_name': '晋级赛',
        'field': 'hpsPromotion',
      },

      /// 加时赛
      'cosOvertime': {
        'play_name': '加时赛',
        'field': 'hpsOvertime',
      },

      /// 点球大战
      'cosPenalty': {
        'play_name': 'hpsPenalty',
        'field': 'hpsPenalty',
      },

      /// 15分钟玩法
      'cos15Minutes': {
        'play_name': '15分钟玩法',
        'field': 'hps15Minutes',
      },

      /// 波胆
      'cosBold': {
        'play_name': '波胆',
        'field': 'hpsBold',
      },

      /// 5分钟玩法
      'cos5Minutes': {
        'play_name': '5分钟玩法',
        'field': 'hps5Minutes',
      },

      /// 特色组合
      'cosCompose': {
        'play_name': '特色组合',
        'field': 'hpsCompose',
      },
    };

    /// 设置历史数据
    tabKeyData.forEach((key, value) {
      final String arrName = value['field'];

      /// key-cos5Minutes , arrName-hps5Minutes
      final bool hasData = matchNew[arrName]?.length != null;
      final String updTime = '_${arrName}_upd_time';
      if (!hasData && matchNew[key] != null && matchOld[key] != null) {
        /// 新赛事设置tab开关为开时,赛时数据中未发现数据时,从历史数据中获取最新数据
        final List tabDataOld = matchOld[arrName] ?? [];

        /// 给新赛事tab名称设置历史数据
        matchNew[arrName] = List.from(tabDataOld);

        /// 设置tab数据更新时间
        matchNew[updTime] = DateTime.now().millisecondsSinceEpoch;
      }
    });
  }

  // void listSerializedMatchObj(List? list, [bool isWs = false]) {
  //   if (list?.length != null) {
  //     /// 格式化比分信息
  //     list!.forEach((match) {
  //       /// 保存历史tab玩法数据
  //       setSavaTabPlayData(match, getQuickMidObj(match['mid']));
  //       final scoreObj = match['msc_obj'];
  //       final msc = match['msc'];
  //       try {
  //         /// 转换比分
  //         final mscObj = serializedScoreObj(msc, true);
  //
  //         /// 数据赋值和合并逻辑
  //         if (scoreObj != null) {
  //           matchAssignWithV1(scoreObj, mscObj);
  //         } else {
  //           match['msc_obj'] = mscObj;
  //         }
  //       } catch (error) {
  //         if (kDebugMode) {
  //           print(error);
  //         }
  //       }
  //
  //       /// 转换玩法
  //       final playObj = match['play_obj'];
  //       final hpsPnsArr = match['hpsPns'];
  //       final playObjTemp = Map.fromIterable(hpsPnsArr,
  //           key: (o) {
  //             final hpid = o['hpid'];
  //             final hSpecial = o['hSpecial'];
  //             String res = 'hpid_$hpid';
  //             if (hSpecial != null) {
  //               /// res = res +`_${o.hSpecial}`;
  //             }
  //             return res;
  //           },
  //           value: (o) => o);
  //
  //       /// 数据赋值和合并逻辑
  //       if (playObj != null) {
  //         matchAssignWithV1(playObj, playObjTemp);
  //       } else {
  //         match['play_obj'] = playObjTemp;
  //       }
  //
  //       // final matchObj = getQuickMidObj(match['mid']);
  //       /// 设置赛事默认数据
  //       setMatchDefaultData(match);
  //       /// 赛事数据格式化
  //       listToManyObj([match],DateTime.now().millisecondsSinceEpoch);
  //       /// 设置赛事更新时间
  //       matchUpdTimeRetChange(match);
  //     });
  //   }
  // }

  void matchUpdTimeRetChange(Map? match) {
    if (match != null) {
      match['_upd_time'] = DateTime.now().millisecondsSinceEpoch;
    }
  }

  ///@description 获取其他玩法tab标题
  ///@param {Map<String, dynamic>} match 赛事对象
  ///@return {String} tab_play_keys
  String getTabPlayKeys(Map<String, dynamic> match) {
    List<String> tabPlayKeys = [];

    List<String> playKeys = dataStoreController.otherPlayNameToPlayId.keys.toList();
    playKeys.forEach((key) {
      String statusKey = 'cos${key.substring(3)}';

      ///当为组合玩法的时候 不走通用逻辑
      if (key == 'hpsCompose') {
        statusKey = 'compose';
      }
      bool status = match[statusKey];

      ///15分钟次要玩法前端强制关闭
      bool cos15minStatus =
          !(statusKey == 'cos15Minutes' && match['hSpecial'] == 6);

      ///5分钟次要玩法前端强制关闭状态
      bool cos5minStatus =
          !(statusKey == 'cos5Minutes' && match['hSpecial5min'] == 6);
      if (status && cos15minStatus && cos5minStatus) {
        tabPlayKeys.add(key);
      }
    });
    return tabPlayKeys.join(',');
  }

  ///@description 获取是否有附加盘数据
  ///@param {Map<String, dynamic>} match 赛事信息
  ///@param {String} hpsKey 附加盘数据的key
  ///@return {Map<String, bool>} hasAdd
  Map<String, bool> getHasAddN(Map<String, dynamic> match,
      {String hpsKey = 'hpsData[0].hpsAdd'}) {
    Map<String, bool> hasAdd = {'hasAdd1': false, 'hasAdd2': false};
    try {
      ///获取附加盘数据
      List<dynamic> hpsAddNData = match[hpsKey];

      ///获取玩法的最大坑位
      Map<String, dynamic> mainFun(Map<String, dynamic> item) {
        ///坑位
        Map<String, dynamic> hnObj = {
          'hn': 0,
          'hpid': item['hpid'],
          'item': item
        };

        ///获取赔率信息数据
        List<dynamic> hlArr = item['hl'];
        hlArr.forEach((item2) {
          ///检查是否有赔率数据
          // int olLength = item2['ol']?.length;

          ///获取坑位
          int hn = item2['hn'] ?? 0;

          ///获取最大有效坑位
          if (hn != 0 && hn > hnObj['hn']) {
            hnObj['hn'] = hn;
          }
        });
        return hnObj;
      }

      ///获取赛事的玩法的最大坑位
      int hnMax = 0;
      for (int i = 0; i < hpsAddNData.length; i++) {
        Map<String, dynamic> item = hpsAddNData[i];

        ///获取最大坑位
        Map<String, dynamic> hnObj = mainFun(item);
        if (hnObj['hn'] > hnMax) {
          hnMax = hnObj['hn'];
        }
      }
      ///附加盘1
      bool hasAdd1 = false;

      ///附加盘2
      bool hasAdd2 = false;

      ///根据最大坑位设置附加盘状态
      if (hnMax >= 3) {
        ///附加盘1
        hasAdd1 = true;

        ///附加盘2
        hasAdd2 = true;
      } else if (hnMax >= 2) {
        ///附加盘1
        hasAdd1 = true;

        ///附加盘2
        hasAdd2 = false;
      }

      ///设置是否有附加盘1
      hasAdd['hasAdd1'] = hasAdd1;

      ///设置是否有附加盘2
      hasAdd['hasAdd2'] = hasAdd2;
    } catch (error) {
      print('_get_has_add_n: $error');
    }
    return hasAdd;
  }

  ///@description 设置赛事默认数据
  ///@param {Map<String, dynamic>} match 赛事信息
  // void setMatchDefaultData(Map<String, dynamic> match) {
  //   Map<String, dynamic> matchMap = getQuickMidObj(match['mid']);
  //
  //   ///api数据更新时间
  //   matchUpdTimeRetChange(match);
  //
  //   ///获取是否有附加盘数据
  //   Map<String, bool> hasAddN = getHasAddN(match);
  //
  //   ///是否有附加盘1
  //   match['hasAdd1'] = matchMap['hasAdd1'] ?? hasAddN['hasAdd1'];
  //
  //   ///是否有附加盘2
  //   match['hasAdd2'] = matchMap['hasAdd2'] ?? hasAddN['hasAdd2'];
  //
  //   ///设置是否显示当前局玩法 ///组件显示时,组件内进行设置
  //   match['isShowCurHandicap'] = matchMap['isShowCurHandicap'] ?? false;
  //
  //   ///主客队名称后面是否显示上半场字符串
  //   match['upHalfText'] = matchMap['upHalfText'] ?? '';
  //
  //   ///组件显示时,组件内进行设置
  //   ///当前局盘口列表
  //   match['curHandicapList'] = matchMap['curHandicapList'] ?? [];
  //
  //   ///特定模版才会使用(模版7)
  //   ///足球角球玩法tab
  //   match['tabPlayKeys'] = getTabPlayKeys(match);
  //   match['playCurrentIndex'] = matchMap['playCurrentIndex'] ?? 0;
  //   match['playCurrentKey'] = matchMap['playCurrentKey'] ?? '';
  //
  //   ///是否有其他玩法
  //   match['hasOtherPlay'] = match['tabPlayKeys'] != null &&
  //       match['tabPlayKeys'].split(',').length > 0;
  //
  //   ///该值设置取决于match.tab_play_keys字段,可以删除
  //   match['otherHandicapList'] = matchMap['otherHandicapList'] ?? [];
  //
  //   ///默认比分数据
  //   ///match['scoreObj'] = serializedScore([], true);
  //   ///当前局比分
  //   match['curScore'] = matchMap['curScore'] ?? {'home': '', 'away': ''};
  //
  //   ///组件显示时,组件内进行设置
  //   ///主队比分
  //   match['homeScore'] = matchMap['homeScore'] ?? '';
  //
  //   ///组件显示时,组件内进行设置
  //   ///客队比分
  //   match['awayScore'] = matchMap['awayScore'] ?? '';
  //
  //   ///组件显示时,组件内进行设置
  //   ///历史比分列表
  //   match['scoreList'] = matchMap['scoreList'] ?? [];
  //
  //   ///赛事比分总分
  //   match['totalScoreStr'] = matchMap['totalScoreStr'] ?? '';
  //
  //   ///15分钟玩法阶段
  //   match['hSpecial'] = matchMap['hSpecial'] ?? 1;
  //
  //   ///5分钟玩法阶段
  //   match['hSpecial5min'] = matchMap['hSpecial5min'] ?? 1;
  //
  //   ///赛事更新时间 match._upd_time
  //   ///this.match_upd_time_ret_change(match);
  //   ///tpl_21_hpids = ""
  //   ///all_oid_arr = [] 可以移除,主要用于生成all_oids对象
  //   ///all_oids="" //过期旧投注项ID列表 ,删除无用投注项数据使用
  //
  //   ///all_ol_data={} ///坑位数据操作使用 可以移除
  //   ///all_hids="" ///快速修改数据时使用 可以移除
  //
  //   ///main_handicap_list = [] ///赛事显示时自行根据模版进行逻辑动态设置显示
  //
  //   ///play_current_index = 0
  //   ///play_current_key = ''
  //   ///other_handicap_list = []
  //   ///add1_handicap_list = []
  //   ///add2_handicap_list = []
  //   ///让球方
  //   ///team_let_ball = ""
  //   ///other_team_let_ball=""
  //   ///设置赛事logo
  //   match['matchLogo'] = {
  //     'home1Logo': match['mhlu'][0],
  //     'home1Letter': match['frmhn'][0],
  //     'home2Logo': match['mhlu'][1],
  //     'home2Letter': match['frmhn'][1],
  //     'away1Logo': match['malu'][0],
  //     'away1Letter': match['frman'][0],
  //     'away2Logo': match['malu'][1],
  //     'away2Letter': match['frman'][1],
  //     'isDouble': match['mhlu'].length > 1,
  //   };
  //
  //   ///历史比分处理(在各自组建显示时设置)
  //   ///homeRedScore = ""
  //   ///awayRedScore = ""
  //   ///homeYellowScore = ""
  //   ///awayYellowScore = ""
  //
  //   ///mscFormat = [] ///代码中只有设置的地方,没有使用的地方,可以删除
  //   ///send = "" //自定义属性send取值为my_self表示有用户模拟发送的指令, 可以删除
  // }

  ///数据更新版本号
  void updDataVersion() {
    dataStoreController.dataVersion['version'] = DateTime.now().millisecondsSinceEpoch;
  }

  ///@description: 设置所有列表数据
  ///@param {List<Map<String, dynamic>>} list 所有列表数据
  ///@param {Map<String, dynamic>} param 参数
  void setList(List? list, {Map<String, dynamic> param = const {}}) {
    if (list != null) {
      ///索引置换
      List<Map<String, dynamic>> temp =
          List<Map<String, dynamic>>.from(dataStoreController.matchList);
      String oldMidList = dataStoreController.matchList.map((m) => m['mid']).join(',');
      String newMidList = list.map((m) => m['mid']).join(',');
      if (newMidList != oldMidList) {
        flexIndex(list, temp);
        dataStoreController.matchList = list;
      } else {
        dataStoreController.matchList = List<Map<String, dynamic>>.from(list);
      }
      dataStoreController.type = param['type'] ?? 'list';

      ///格式化列表赛事(部分数组转对象)
      // listSerializedMatchObj(dataStoreController.matchList);

      ///列表数据同步到快捷操作对象中
      listToObjFun(dataStoreController.matchList, dataStoreController.listToObj);

      ///set_active_mids 报错 DOMException: Failed to execute 'postMessage' on 'Window': Response object could not be clone 先放在这
      ///this.set_active_mids(list.map(t => t.mid))
      ///ws命令赛事订阅
      // scmdC8();
      updDataVersion();
    }
  }

  ///@description: 用户修正组件中的key值
  ///@param {List<Map<String, dynamic>>} new_ 新列表
  ///@param {List<Map<String, dynamic>>} old_ 旧列表
  void flexIndex(List newList, List<Map<String, dynamic>> oldList) {
    List<int> flg = [];

    ///最多支持99个动态key值
    for (int i = 1; i < 100; i++) {
      flg.add(i);
    }
    Map<String, dynamic> obj_ = {};
    oldList.forEach((element) {
      obj_[element['mid']] = element;
    });

    Map<String, dynamic> newObj = {};
    Map<String, dynamic> oldObj = {};

    ///new_obj去重处理
    for (int i = 0; i < newList.length; i++) {
      Map<String, dynamic> element = newList[i];
      String temp = element['flex_index'];
      if (element != null && temp != null) {
        if (newObj[temp] != null) {
          element.remove('flex_index');
        } else {
          newObj[temp] = 1;
        }
      }
    }

    ///old_obj去重处理
    for (int i = 0; i < oldList.length; i++) {
      Map<String, dynamic> element = oldList[i];
      String temp = element['flex_index'];
      if (temp != null) {
        if (oldObj[temp] != null) {
          element.remove('flex_index');
        } else {
          oldObj[temp] = 1;
        }
      }
    }

    for (int i = 0; i < newList.length; i++) {
      Map<String, dynamic> element = newList[i];
      if (newList[i] != null &&
          newList[i]['mid'] != null &&
          obj_[newList[i]['mid']] != null) {
        if (newList[i]['mid'] == obj_[newList[i]['mid']]['mid']) {
          newList[i]['flex_index'] = obj_[newList[i]['mid']]['flex_index'];
          for (int k = 0; k < flg.length; k++) {
            if (flg[k] == obj_[newList[i]['mid']]['flex_index']) {
              flg.removeAt(k);
              break;
            }
          }
        } else {
          element['flex_index'] = 0;
        }
      } else if (element != null) {
        element['flex_index'] = 0;
      }
    }
    for (int i = 0; i < newList.length; i++) {
      Map<String, dynamic> element = newList[i];
      if (element['flex_index'] == null) {
        if (flg.isNotEmpty) {
          element['flex_index'] = flg[0];
          flg.removeAt(0);
        }
      }
    }
  }

  ///@description: 列表数据同步到快捷操作对象中
  ///@param {List<Map<String, dynamic>>} list 页面显示列表数据
  ///@param {bool} isMerge 是否进行合并数据同步(保证地址不变)
  ///@param {int} timestamp 时间戳
  void listToObjFun(List list, Map<String, dynamic> listToObj) {
    if (list != null) {
      Map<String, dynamic> obj = {};

      ///将list格式化成多个obj对象
      Map<String, dynamic> manyObj = listToManyObj(list,DateTime.now().millisecondsSinceEpoch);
      ///快速检索对象数据累加和赋值
      assignWithListToObj(listToObj, manyObj);
    }
  }

  ///快速检索对象数据累加和赋值
  void assignWithListToObj(
      Map<String, dynamic> oldObj, Map<String, dynamic> newObj) {
    ///页面显示赛事投注项对象
    ///olObj:{},
    ///页面显示赛事盘口对象
    ///hlObj:{},
    ///页面显示赛事坑位对象
    ///hnObj:{},
    ///页面显示赛事赛事对象
    ///midObj:{},

    ///对象赋值操作
    void setObjFun(
        String key, Map<String, dynamic> objOld, Map<String, dynamic> objNew) {
      if (objOld != null && objNew != null) {
        objNew.forEach((key, obj) {
          if (key != null && obj != null) {
            objOld[key] = obj;
          }
        });
      }
    }

    ///遍历对象一级层级
    oldObj.forEach((key, objV1Old) {
      Map<String, dynamic> objV1New = newObj[key];

      ///对象赋值操作
      setObjFun(key, objV1Old, objV1New);
    });
  }

  ///@description: 获取快速查询的key值
  ///@param {String} mid 赛事标识
  ///@param {String} id 精准查询使用到的id
  ///@param {String} type 精准查询id类型(mid/ol/hl/hn)
  ///@return {String} 快速查询的组合key值
  String getListToObjKey(String mid, String id, String type) {
    String res = id;
    switch (type) {
      case 'mid':
        res = '${mid}_';
        break;
      case 'ol':
      case 'hl':
      case 'hn':
        res = '${mid}_$id';
        break;
      default:
        res = id;
        break;
    }
    return res;
  }

  /// @description: 将赛事详情对象转成多个对象,以便提高操作速度和效率
  /// @param {Object} item 赛事对象
  /// @param {Object} many_obj 数据叠加时使用的变量
  /// @return {void} void
  void listItemToManyObj(
      Map<String, dynamic> item, Map<String, dynamic> manyObj) {
    if (item.containsKey('mid')) {
      // 快速查询对象mid_obj增加数据
      manyObj['mid_obj'][getListToObjKey(item['mid'], item['mid'], 'mid')] = item;
      // 需要解析的投注项赛事基础数据的路径
      final hpsKeyArr = [
        'hps',
        'hpsAdd',
        'hpsData[0].hps',
        'hpsData[0].hpsAdd',
        'hpsData[1].hps',
        'hpsData[1].hpsAdd',
        "hpsBold",
        "hpsOvertime",
        "hps15Minutes",
        "hps5Minutes",
        "hpsCorner",
        "hpsPunish",
        "hpsPenalty",
        "hpsPromotion",
        "hpsOutright",
        "odds_info",
        "hpsCompose"
      ];
      // 角球开关----------------------hpsCorner
      // 罚牌开关----------------------hpsPunish
      // 冠军开关----------------------hpsOutright
      // 晋级赛开关--------------------hpsPromotion
      // 加时赛开关--------------------hpsOvertime
      // 点球大战开关------------------hpsPenalty
      // 15分钟开关--------------------hps15Minutes
      // 5分钟开关 ----------------------hps5Minutes
      // 波胆开关-----------------------hpsBold
      // 主盘口------------------------hps
      // 副盘口------------------------hpsAdd
      // 赛事详情,所有投注数据----------odds_info
      // 特色组合----------------------hpsCompose

      // 投注项赛事列表数据
      List<dynamic>? hpsDataArr = null;
      for (final hps_key_str in hpsKeyArr) {
        /// 设置投注项赛事列表数据
        hpsDataArr = item[hps_key_str];
        // ///特色玩法数据h5做特殊处理
        // if (hps_key_str == 'hpsCompose' && !BUILDIN_CONFIG.IS_PC) {
        //   hps_key_str = 'hpsCompose_h5';
        // }
        switch (hps_key_str) {
          // 主玩副盘口数据时
          case 'hpsData[0].hpsAdd':
          case 'hpsData[1].hpsAdd':
          case 'hps':
          case 'hpsCompose_h5': // h5玩法的hpsCompose
          case 'hpsAdd':
          // 赛事详情所有玩法数据时
          case 'odds_info':
            if (hpsDataArr != null && hpsDataArr is List) {
              // 遍历玩法数据
              for (final item2 in hpsDataArr) {
                void fun(Map<String, dynamic> item2) {
                  if (!item2.containsKey('hsw')) {
                    item2['hsw'] =
                        item['play_obj']['hpid_${item2['hpid']}.hsw'];
                  }
                  // 玩法对象补偿
                  final playObjKey = 'hpid_${item2['chpid'] ?? item2['hpid']}';
                  if (!item['play_obj'].containsKey(playObjKey)) {
                    if (!item.containsKey('play_obj')) {
                      item['play_obj'] = {};
                    }
                    final objTemp = {};
                    for (final key in item2.keys) {
                      if (!['hl', 'ol'].contains(key)) {
                        objTemp[key] = item2[key];
                      }
                    }
                    item['play_obj'][playObjKey] = objTemp;
                  }
                  // 检查是否有盘口数据
                  if (item2.containsKey('hl') && item2['hl'].length > 0 ||
                      item2.containsKey('ol') && item2['ol'].length > 0) {
                    List<dynamic> itemArr = [];
                    if (item2.containsKey('ol') && item2['ol'].length > 0) {
                      itemArr = [item2];
                    } else {
                      itemArr = item2['hl'];
                    }
                    // 遍历盘口数据
                    for (final item3 in itemArr) {
                      if (item3 != null) {
                        if (item3.containsKey('hid')) {
                          // 增加玩法信息到盘口级别
                          item3['mid'] = item['mid'];
                          item3['hpid'] = item2['hpid'];
                          item3['hsw'] = item2['hsw'];

                          // 快速查询对象hl_obj增加数据
                          manyObj['hl_obj'][getListToObjKey(item['mid'], item3['hid'], 'hl')] = item3;
                        }
                        if (item3.containsKey('ol') && item3['ol'].length > 0) {
                          // 遍历投注项数据
                          for (final item4 in item3['ol']) {
                            // 处理ot是小数的情况,进行数据修正
                            String ot = '';
                            if (item4 != null) {
                              if (item4.containsKey('ot') &&
                                  item4['ot'].contains('.')) {
                                ot = item4['ot'].replaceAll('.', '-');
                              } else {
                                ot = item4['ot'];
                              }
                              // 设置坑位信息
                              final hn = item3.containsKey('hn')
                                  ? '${item['mid']}_${item2['chpid'] ?? item2['hpid']}_${item3['hn']}_$ot'
                                  : '';
                              // 押注项设置盘口状态
                              item4['_hpid'] = item2['hpid'];
                              item4['_chpid'] = item2['chpid'];
                              item4['_hs'] =
                                  item3.containsKey('hs') ? item3['hs'] : 0;
                              item4['_mhs'] =
                                  item.containsKey('mhs') ? item['mhs'] : 0;
                              item4['_mid'] = item['mid'];
                              item4['_hid'] = item3['hid'];
                              item4['_hn'] = hn;
                              item4['_hsw'] = item2['hsw'];
                              item4['_hipo'] = item3['hipo'];
                              item4['_csid'] = item['csid'];
                              item4['_ispo'] = item2.containsKey('ispo')
                                  ? item2['ispo']
                                  : item['ispo'];
                              item4['os'] =
                                  item4.containsKey('os') ? item4['os'] : 1;
                              // 快速查询对象ol_obj增加数据
                              manyObj['ol_obj'][getListToObjKey(item['mid'], item4['oid'], 'ol')] = item4;
                              if (hn != '') {
                                // 快速查询对象hn_obj增加数据
                                manyObj['hn_obj'][getListToObjKey(item['mid'], hn, 'hn')] = item4;
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }

                if (hps_key_str == 'odds_info' && item2.containsKey('plays')) {
                  final plays = item2['plays'];
                  for (final plays_items in plays) {
                    fun(plays_items);
                  }
                }
                fun(item2);
              }
            }
            break;
          default:
            if (hpsDataArr != null && hpsDataArr is List) {
              // 遍历玩法数据
              for (final item2 in hpsDataArr) {
                if (!item2.containsKey('hsw')) {
                  item2['hsw'] = item['play_obj']['hpid_${item2['hpid']}.hsw'];
                }
                // 玩法对象补偿
                final playObjKey = 'hpid_${item2['chpid'] ?? item2['hpid']}';
                if (!item['play_obj'].containsKey(playObjKey)) {
                  if (!item.containsKey('play_obj')) {
                    item['play_obj'] = {};
                  }
                  final objTemp = {};
                  for (final key in item2.keys) {
                    if (!['hl', 'ol'].contains(key)) {
                      objTemp[key] = item2[key];
                    }
                  }
                  item['play_obj'][playObjKey] = objTemp;
                }
                // 检查是否有盘口数据
                if (item2.containsKey('hl') && item2['hl'].length > 0 ||
                    item2.containsKey('hl') &&
                        item2['hl'][0].containsKey('ol') &&
                        item2['hl'][0]['ol'].length > 0) {
                  // if(item2.hl.ol.forEach(item3 => {
                  List<dynamic> itemArr = [];
                  if (item2.containsKey('hl')) {
                    final item3 = item2['hl'][0] ?? item2['hl'];
                    if (item3 != null) {
                      if (item3.containsKey('hid')) {
                        // 增加玩法信息到盘口级别
                        item3['mid'] = item['mid'];
                        item3['hpid'] = item2['hpid'];
                        item3['hsw'] = item2['hsw'];

                        // 快速查询对象hl_obj增加数据
                        manyObj['hl_obj'][getListToObjKey(item['mid'], item3['hid'], 'hl')] = item3;
                      }
                      if (item3.containsKey('ol') && item3['ol'].length > 0) {
                        // 遍历投注项数据
                        for (final item4 in item3['ol']) {
                          // 处理ot是小数的情况,进行数据修正
                          String ot = '';
                          if (item4 != null) {
                            if (item4.containsKey('ot') &&
                                item4['ot'].contains('.')) {
                              ot = item4['ot'].replaceAll('.', '-');
                            } else {
                              ot = item4['ot'];
                            }
                            // 设置坑位信息
                            final hn = item3.containsKey('hn')
                                ? '${item['mid']}_${item2['chpid'] ?? item2['hpid']}_${item3['hn']}_$ot'
                                : '';
                            // 押注项设置盘口状态
                            item4['_hpid'] = item2['hpid'];
                            item4['_chpid'] = item2['chpid'];
                            item4['_hs'] =
                                item3.containsKey('hs') ? item3['hs'] : 0;
                            item4['_mhs'] =
                                item.containsKey('mhs') ? item['mhs'] : 0;
                            item4['_mid'] = item['mid'];
                            item4['_hid'] = item3['hid'];
                            item4['_hn'] = hn;
                            item4['_hsw'] = item2['hsw'];
                            item4['_hipo'] = item3['hipo'];
                            item4['_csid'] = item['csid'];
                            item4['_ispo'] = item2.containsKey('ispo')
                                ? item2['ispo']
                                : item['ispo'];
                            item4['os'] =
                                item4.containsKey('os') ? item4['os'] : 1;

                            // 快速查询对象ol_obj增加数据
                            manyObj['ol_obj'][getListToObjKey(item['mid'], item4['oid'], 'ol')] = item4;
                            if (hn != '') {
                              // 快速查询对象hn_obj增加数据
                              manyObj['hn_obj'][getListToObjKey(item['mid'], hn, 'hn')] = item4;
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
            break;
        }
      }
    }
  }

  /// @description: 获取将赛事详情非坑位对象,以便提高操作速度和效率
  /// @param {String} mid 赛事对象
  /// @param {Array} key_arr 需要获取的值key ["hpsBold","hpsOvertime"]等
  /// @return {Object} 将赛事详情转成成对象,提高检索速度
  // Map<String, dynamic> get_match_to_map_obj(String mid, List<String> keyArr) {
  //   // final item = getQuickMidObj(mid);
  //   MatchEntity? match = dataStoreController.getMatchById(mid);
  //
  //   Map<String, dynamic> mapObj = {};
  //   if (match != null) {
  //     try {
  //       // 需要解析的投注项赛事基础数据的路径
  //       final hpsKeyArr = keyArr ??
  //           [
  //             'hps',
  //             'hpsAdd',
  //             'hpsData[0].hps',
  //             'hpsData[0].hpsAdd',
  //             'hpsData[1].hps',
  //             'hpsData[1].hpsAdd',
  //             "hpsBold",
  //             "hpsOvertime",
  //             "hps15Minutes",
  //             "hps5Minutes",
  //             "hpsCorner",
  //             "hpsPunish",
  //             "hpsPenalty",
  //             "hpsPromotion",
  //             "hpsOutright",
  //             "odds_info",
  //             "hpsCompose"
  //           ];
  //       // 角球开关----------------------hpsCorner
  //       // 罚牌开关----------------------hpsPunish
  //       // 冠军开关----------------------hpsOutright
  //       // 晋级赛开关--------------------hpsPromotion
  //       // 加时赛开关--------------------hpsOvertime
  //       // 点球大战开关------------------hpsPenalty
  //       // 15分钟开关--------------------hps15Minutes
  //       // 5分钟开关 ----------------------hps5Minutes
  //       // 波胆开关-----------------------hpsBold
  //       // 主盘口------------------------hps
  //       // 副盘口------------------------hpsAdd
  //       // 赛事详情,所有投注数据----------odds_info
  //       // 特色组合----------------------hpsCompose
  //
  //       // 投注项赛事列表数据
  //       List<dynamic>? hpsDataArr = null;
  //       for (final hps_key_str in hpsKeyArr) {
  //         // 设置投注项赛事列表数据
  //         hpsDataArr = match.hps;
  //
  //         // // //特色玩法数据h5做特殊处理
  //         // if (hps_key_str == 'hpsCompose' && !BUILDIN_CONFIG.IS_PC) {
  //         //   hps_key_str = 'hpsCompose_h5';
  //         // }
  //         switch (hps_key_str) {
  //           // 主玩副盘口数据时
  //           case 'hpsData[0].hpsAdd':
  //           case 'hpsData[1].hpsAdd':
  //           case 'hps':
  //           case 'hpsCompose_h5': // h5玩法的hpsCompose
  //           case 'hpsAdd':
  //           // 赛事详情所有玩法数据时
  //           case 'odds_info':
  //             if (hpsDataArr != null && hpsDataArr is List) {
  //               // 遍历玩法数据
  //               for (final item2 in hpsDataArr) {
  //                 void fun(Map<String, dynamic> item2) {
  //                   if (!item2.containsKey('hsw')) {
  //                     item2['hsw'] =
  //                         item['play_obj']['hpid_${item2['hpid']}.hsw'];
  //                   }
  //                   // 玩法对象补偿
  //                   final playObjKey =
  //                       'hpid_${item2['chpid'] ?? item2['hpid']}';
  //                   if (!item.containsKey('play_obj') ||
  //                       !item['play_obj'].containsKey(playObjKey)) {
  //                     if (!item.containsKey('play_obj')) {
  //                       item['play_obj'] = {};
  //                     }
  //                     final objTemp = {};
  //                     for (final key in item2.keys) {
  //                       if (!['hl', 'ol'].contains(key)) {
  //                         objTemp[key] = item2[key];
  //                       }
  //                     }
  //                     item['play_obj'][playObjKey] = objTemp;
  //                   }
  //                   // 检查是否有盘口数据
  //                   if (item2.containsKey('hl') && item2['hl'].length > 0 ||
  //                       item2.containsKey('ol') && item2['ol'].length > 0) {
  //                     List<dynamic> itemArr = [];
  //                     if (item2.containsKey('ol') && item2['ol'].length > 0) {
  //                       itemArr = [item2];
  //                     } else {
  //                       itemArr = item2['hl'];
  //                     }
  //                     // 遍历盘口数据
  //                     for (final item3 in itemArr) {
  //                       if (item3 != null) {
  //                         if (item3.containsKey('hid')) {
  //                           // 增加玩法信息到盘口级别
  //                           item3['mid'] = item['mid'];
  //                           item3['hpid'] = item2['hpid'];
  //                           item3['hsw'] = item2['hsw'];
  //                         }
  //                         if (item3.containsKey('ol') &&
  //                             item3['ol'].length > 0) {
  //                           // 遍历投注项数据
  //                           for (final item4 in item3['ol']) {
  //                             // 处理ot是小数的情况,进行数据修正
  //                             String ot = '';
  //                             if (item4 != null) {
  //                               if (item4.containsKey('ot') &&
  //                                   item4['ot'].contains('.')) {
  //                                 ot = item4['ot'].replaceAll('.', '-');
  //                               } else {
  //                                 ot = item4['ot'];
  //                               }
  //                               // 设置坑位信息
  //                               if (!item3.containsKey('hn')) {
  //                                 final hn =
  //                                     '${item['mid']}_${item2['chpid'] ?? item2['hpid']}_1_$ot';
  //                                 // 押注项设置盘口状态
  //                                 item4['_hpid'] = item2['hpid'];
  //                                 item4['_chpid'] = item2['chpid'];
  //                                 item4['_hs'] =
  //                                     item3.containsKey('hs') ? item3['hs'] : 0;
  //                                 item4['_mhs'] =
  //                                     item.containsKey('mhs') ? item['mhs'] : 0;
  //                                 item4['_mid'] = item['mid'];
  //                                 item4['_hid'] = item3['hid'];
  //                                 item4['_hn'] = hn;
  //                                 item4['_hsw'] = item2['hsw'];
  //                                 item4['_hipo'] = item3['hipo'];
  //                                 item4['_csid'] = item['csid'];
  //                                 item4['_ispo'] = item2.containsKey('ispo')
  //                                     ? item2['ispo']
  //                                     : item['ispo'];
  //                                 item4['os'] =
  //                                     item4.containsKey('os') ? item4['os'] : 1;
  //
  //                                 // // 快速查询对象hn_obj增加数据
  //                                 mapObj[getListToObjKey(item['mid'], hn, 'hn')] = item4;
  //                               }
  //                             }
  //                           }
  //                         }
  //                       }
  //                     }
  //                   }
  //                 }
  //
  //                 if (hps_key_str == 'odds_info' &&
  //                     item2.containsKey('plays')) {
  //                   final plays = item2['plays'];
  //                   for (final plays_items in plays) {
  //                     fun(plays_items);
  //                   }
  //                 }
  //                 fun(item2);
  //               }
  //             }
  //             break;
  //           default:
  //             if (hpsDataArr != null && hpsDataArr is List) {
  //               // 遍历玩法数据
  //               for (final item2 in hpsDataArr) {
  //                 if (!item2.containsKey('hsw')) {
  //                   item2['hsw'] =
  //                       item['play_obj']['hpid_${item2['hpid']}.hsw'];
  //                 }
  //                 // 玩法对象补偿
  //                 final playObjKey = 'hpid_${item2['chpid'] ?? item2['hpid']}';
  //                 if (!item['play_obj'].containsKey(playObjKey)) {
  //                   if (!item.containsKey('play_obj')) {
  //                     item['play_obj'] = {};
  //                   }
  //                   final objTemp = {};
  //                   for (final key in item2.keys) {
  //                     if (!['hl', 'ol'].contains(key)) {
  //                       objTemp[key] = item2[key];
  //                     }
  //                   }
  //                   item['play_obj'][playObjKey] = objTemp;
  //                 }
  //                 // 检查是否有盘口数据
  //                 if (item2.containsKey('hl') && item2['hl'].length > 0 ||
  //                     item2.containsKey('hl') &&
  //                         item2['hl'][0].containsKey('ol') &&
  //                         item2['hl'][0]['ol'].length > 0) {
  //                   // if(item2.hl.ol.forEach(item3 => {
  //                   if (item2.containsKey('hl')) {
  //                     final item3 = item2['hl'][0] ?? item2['hl'];
  //                     if (item3 != null) {
  //                       if (item3.containsKey('hid')) {
  //                         // 增加玩法信息到盘口级别
  //                         item3['mid'] = item['mid'];
  //                         item3['hpid'] = item2['hpid'];
  //                         item3['hsw'] = item2['hsw'];
  //                       }
  //                       if (item3.containsKey('ol') && item3['ol'].length > 0) {
  //                         // 遍历投注项数据
  //                         for (final item4 in item3['ol']) {
  //                           // 处理ot是小数的情况,进行数据修正
  //                           String ot = '';
  //                           if (item4 != null) {
  //                             if (item4.containsKey('ot') &&
  //                                 item4['ot'].contains('.')) {
  //                               ot = item4['ot'].replaceAll('.', '-');
  //                             } else {
  //                               ot = item4['ot'];
  //                             }
  //                             // 设置非坑位信息
  //                             if (!item3.containsKey('hn')) {
  //                               final hn =
  //                                   '${item['mid']}_${item2['chpid'] ?? item2['hpid']}_1_$ot';
  //                               // 押注项设置盘口状态
  //                               item4['_hpid'] = item2['hpid'];
  //                               item4['_chpid'] = item2['chpid'];
  //                               item4['_hs'] =
  //                                   item3.containsKey('hs') ? item3['hs'] : 0;
  //                               item4['_mhs'] =
  //                                   item.containsKey('mhs') ? item['mhs'] : 0;
  //                               item4['_mid'] = item['mid'];
  //                               item4['_hid'] = item3['hid'];
  //                               item4['_hn'] = hn;
  //                               item4['_hsw'] = item2['hsw'];
  //                               item4['_hipo'] = item3['hipo'];
  //                               item4['_csid'] = item['csid'];
  //                               item4['_ispo'] = item2.containsKey('ispo')
  //                                   ? item2['ispo']
  //                                   : item['ispo'];
  //                               item4['os'] =
  //                                   item4.containsKey('os') ? item4['os'] : 1;
  //
  //                               // 快速查询对象hn_obj增加数据
  //                               mapObj[getListToObjKey(item['mid'], hn, 'hn')] = item4;
  //                             }
  //                           }
  //                         }
  //                       }
  //                     }
  //                   }
  //                 }
  //               }
  //             }
  //             break;
  //         }
  //       }
  //     } catch (error) {
  //       print('get_match_to_map_obj: $error');
  //     }
  //   }
  //   return mapObj;
  // }

  /// @description: 赛事详情模块设置赛事信息数据
  /// @param {Map<String, dynamic>} match_details 赛事对象
  /// @param {List<dynamic>} odds_info 赔率信息
  /// @param {Map<String, dynamic>} param 是否数据合并
  /// @return {void} void
  void setMatchDetails(
      Map<String, dynamic> matchDetails, List<dynamic> oddsInfo,
      {Map<String, dynamic> param = const {}}) {
    if (matchDetails != null) {
      dataStoreController.type = param['type'] ?? 'match';
      // 格式化列表赛事(部分数组转对象)
      // listSerializedMatchObj([matchDetails]);
      if (oddsInfo != null) {
        // 设置赔率
        matchDetails['odds_info'] = oddsInfo;
      }

      // 列表数据同步到快捷操作对象中
      listToObjFun([matchDetails], dataStoreController.listToObj);
      // 设置激活的赛事mids数组
      dataStoreController.midsAtion = [matchDetails['mid']];
      /// ws命令赛事订阅
      // scmdC8();
      updDataVersion();
    }
  }

  /// @description: 将list格式化成多个obj对象
  /// @param {List<dynamic>} list 赛事列表
  /// @param {int} timestap 时间戳
  /// @return {Map<String, dynamic>} 将赛事列表转成成对象,提高检索速度
  Map<String, dynamic> listToManyObj(List<dynamic> list, int timestap) {
    final manyObj = {'ol_obj': {}, 'hl_obj': {}, 'hn_obj': {}, 'mid_obj': {}};
    if (list != null && list is List) {
      for (final item in list) {
        listItemToManyObj(item, manyObj);
      }
    }
    return manyObj;
  }

  /// @description: 获取赛事列表中的赛事mid索引位置
  /// @param {String} mid 赛事标识
  /// @param {List<dynamic>} list 赛事列表数据
  /// @return {int} 指定赛事列表中的位置
  int getMidIndexFormList(String mid, List<dynamic> list) {
    int res = -1;
    if (mid != null && list != null) {
      for (int i = 0; i < list.length; i++) {
        if (list[i]['mid'] == mid) {
          res = i;
          break;
        }
      }
    }
    return res;
  }

  /// @description: 删除赛事(释放赛事的所有数据,并从关联的列表)
  /// @param {String} mid 赛事标识
  /// @param {List<dynamic>} list 赛事列表数据
  /// @return {int} 指定赛事列表中的位置
  void removeMatch(String mid) {
    final midObjKey = getListToObjKey(mid, mid, 'mid');
    // 快速赛事对象查找赛事
    if (mid != null && dataStoreController.listToObj['mid_obj'][midObjKey] != null) {
      // 清除赛事的所有数据
      clearObj(dataStoreController.listToObj['mid_obj'][midObjKey]);
    }
    // 删除快速查询对象中指定赛事的所有赛事关联的挂载点
    deleteMatchFromQuickQueryObj(mid, mid, 'mid',[]);
  }

  /// @description: 删除快速查询中指定赛事和编号的挂载点(不清空赛事数据)
  /// @param {String} mid 赛事标识
  /// @param {String} id 精准查询使用到的id
  /// @param {String} type 精准查询id类型(mid/ol/hl/hn)
  /// @param {List<dynamic>} arr 需求清除的对象数组,默认为快速检索对象数组
  void deleteMatchFromQuickQueryObj(
      String mid, String id, String type, List arr) {
    if (mid != null) {
      final quickQueryStr = getListToObjKey(mid, id, type);
      //遍历快速查询对象
      (arr ?? [dataStoreController.listToObj]).forEach((objTemp) {
        objTemp.forEach((key, obj1) {
          if (obj1 != null) {
            //遍历快速查询中的二级对象
            obj1.forEach((key2, obj2) {
              // 找到指定赛事的对象
              if (key2 != null && key2.startsWith(quickQueryStr)) {
                // 删除其中的挂载点
                obj1.remove(key2);
              }
            });
          }
        });
      });
    }
  }

  /// @description: 获取list_to_obj中的赛事
  /// @param {List<String>} mids 赛事mid集合
  /// @param {String} type 返回的类型(Object/Array)
  /// @return {Map<String, dynamic>/List<dynamic>} 赛事信息集合
  dynamic getMatchObjectFormListToObj(List<String> mids,
      [String type = 'Object']) {
    dynamic res;
    if (type == 'Array') {
      res = [];
    } else {
      res = {};
    }
    try {
      mids.forEach((mid) {
        final temp = dataStoreController.listToObj['mid_obj'][mid];
        if (type == 'Array') {
          res.add(temp);
        } else {
          res[mid] = temp;
        }
      });
    } catch (error) {
      if (kDebugMode) {
        print('_get_match_arr_form_list_to_obj: $error');
      }
    }
    return res;
  }

  /// @description: 快速检索数据对象合并逻辑
  /// @param {Map<String, dynamic>} many_obj_old 老数据对象
  /// @param {Map<String, dynamic>} many_obj_new 新数据对象
  /// @param {List<String>} mids 赛事mid数组(为空时表示取obj所有key值)
  /// @param {bool} gc 是否回收垃圾
  /// @return {void} void
  void quickQueryObjAssign(Map<String, dynamic> manyObjOld,
      Map<String, dynamic> manyObjNew, List<String> mids,
      [bool gc = true]) {
    // 获取老数据对象keys
    final oldOlObjKeys = getQuickQueryObjObjKeys(manyObjOld['ol_obj'], mids);
    final oldHnObjKeys = getQuickQueryObjObjKeys(manyObjOld['hn_obj'], mids);
    final oldHlObjKeys = getQuickQueryObjObjKeys(manyObjOld['hl_obj'], mids);

    // 获取新数据对象keys
    final newOlObjKeys = getQuickQueryObjObjKeys(manyObjNew['ol_obj'], mids);
    final newHnObjKeys = getQuickQueryObjObjKeys(manyObjNew['hn_obj'], mids);
    final newHlObjKeys = getQuickQueryObjObjKeys(manyObjNew['hl_obj'], mids);

    // 快速检索对象数据合并
    matchAssign(manyObjOld['mid_obj'], manyObjNew['mid_obj']);
    ///============ 问下humal 下面三个方法没有
    // ol_obj_assign(manyObjOld['ol_obj'], manyObjNew['ol_obj']);
    //
    // hn_obj_assign(manyObjOld['hn_obj'], manyObjNew['hn_obj']);
    //
    // hl_obj_assign(manyObjOld['hl_obj'], manyObjNew['hl_obj']);
    if (gc) {
      // 获取无用数据
      final olObjKeys = oldOlObjKeys.toSet().difference(newOlObjKeys.toSet()).toList();
      final hnObjKeys = oldHnObjKeys.toSet().difference(newHnObjKeys.toSet()).toList();
      final hlObjKeys = oldHlObjKeys.toSet().difference(newHlObjKeys.toSet()).toList();
      // 删除无用数据
      olObjKeys.forEach((keys) {
        manyObjOld['ol_obj'].remove(keys);
      });
      hnObjKeys.forEach((keys) {
        manyObjOld['hn_obj'].remove(keys);
      });
      hlObjKeys.forEach((keys) {
        manyObjOld['hl_obj'].remove(keys);
      });
    }
  }

  List<String> getQuickQueryObjObjKeys(
      Map<String, dynamic> obj, List<String> mids) {
    List<String> res = [];
    if (obj != null) {
      if (mids != null) {
        mids.forEach((item) {
          String mid = '${item}_';
          obj.forEach((key, value) {
            if (key != null && key.startsWith(mid)) {
              res.add(key);
            }
          });
        });
      } else {
        res = obj.keys.toList();
      }
    }
    return res;
  }

  void clearListOther(List<dynamic> list) {
    List<String> listKeys = dataStoreController.listToObj['mid_obj'].keys.toList();
    List<Map<String, dynamic>> listMidObj = [];
    listKeys.forEach((item) {
      if (item != null) {
        String mid = item.replaceAll('_', '');
        listMidObj.add({'mid': mid});
      }
    });

    Map obj = listComparison(listMidObj, list);
    obj['del'].forEach((key, value) {
      if (key != null) {
        String mid = key.replaceAll('_', '');
        removeMatch(mid);
      }
    });
  }

  void clearMidObj(dynamic mid) {
    deleteMatchFromQuickQueryObj(mid, mid, 'mid', []);
  }

  void clearHlObj(dynamic mid, dynamic hid) {
    deleteMatchFromQuickQueryObj(mid, hid, 'hl', []);
  }

  void clearOlObj(dynamic mid, dynamic oid) {
    deleteMatchFromQuickQueryObj(mid, oid, 'ol', []);
  }

  void clearHnObj(dynamic mid, dynamic hn) {
    deleteMatchFromQuickQueryObj(mid, hn, 'hn', []);
  }

  void clearObj(dynamic any) {
    if (any is Map) {
      any.forEach((key, value) {
        clearObj(value);
        any.remove(key);
      });
      if (any is List) {
        any.clear();
      }
    }
  }

  // void assignWith(dynamic oldObj, dynamic newObj) {
  //   dynamic customizer(oldValue, newValue) {
  //     dynamic res = oldValue;
  //     String type = oldValue.runtimeType.toString();
  //     if (type == 'Map') {
  //       if (newValue == null) {
  //         res = newValue;
  //       } else {
  //         oldValue.forEach((key, value) {
  //           if (value != null) {
  //             if (newValue[key] == null && newValue.containsKey(key)) {
  //               oldValue.remove(key);
  //             }
  //           }
  //         });
  //       }
  //     } else if (type == 'List' && newValue is List) {
  //       newValue != null &&
  //           oldValue != null &&
  //           (oldValue.length == newValue.length);
  //       for (int i = 0; i < newValue.length; i++) {
  //         dynamic item = newValue[i];
  //         String type2 = item.runtimeType.toString();
  //         if (type2 == 'Map') {
  //           assignWith(oldValue[i], item);
  //         } else if (type2 == 'List') {
  //           assignWithList(oldValue[i], item);
  //         } else {
  //           oldValue[i] = newValue[i];
  //         }
  //       }
  //       return oldValue;
  //     }
  //     return res;
  //   }
  //   assignWith(oldObj, newObj);
  // }

  void assignWithList(List<dynamic> oldList, List<dynamic> newList) {
    if (oldList != null && newList != null && newList is List) {
      oldList.length = newList.length;
      for (int i = 0; i < oldList.length; i++) {
        dynamic itemNew = oldList[i];
        String type = itemNew.runtimeType.toString();
        if (type == 'Map') {
          // assignWith(itemNew, newList[i]);
        } else if (type == 'List') {
          assignWithList(itemNew, newList[i]);
        } else {
          oldList[i] = newList[i];
        }
      }
    }
  }

  void updMatchAllStatus(Map<String, dynamic> obj) {
    if (obj != null && obj.containsKey('mid')) {
      String mid = obj['mid'];
      if (obj.containsKey('mhs')) {
        quickQueryObjUpdStatusMhs(dataStoreController.listToObj, mid, obj['mhs']);
      }
      if (obj.containsKey('hid') && obj.containsKey('hs')) {
        quickQueryObjUpdStatusHs(dataStoreController.listToObj, mid, obj['hid'], obj['hs']);
      }
      if (obj.containsKey('oid') && obj.containsKey('os')) {
        quickQueryObjUpdStatusOs(dataStoreController.listToObj, mid, obj['oid'], obj['os']);
      }
    }
  }

  void quickQueryObjUpdStatusMhs(
      Map<String, dynamic> quickQueryObj, String mid, int mhs) {
    if (quickQueryObj != null && mid != null) {
      String midStr = getListToObjKey(mid, mid, 'mid');
      Map<String, dynamic> match = quickQueryObj['mid_obj'][midStr];
      if (match != null) {
        match['mhs'] = mhs;
      }
      Map<String, dynamic> object = quickQueryObj['ol_obj'];
      object.forEach((key, value) {
        if (key != null && key.startsWith(midStr) && value != null) {
          value['_mhs'] = mhs;
        }
      });
      object = quickQueryObj['hn_obj'];
      object.forEach((key, value) {
        if (key != null && key.startsWith(midStr) && value != null) {
          value['_mhs'] = mhs;
        }
      });
    }
  }

  void quickQueryObjUpdStatusHs(
      Map<String, dynamic> quickQueryObj, String mid, String hid, int hs) {
    if (quickQueryObj != null && hid != null) {
      String idStr = getListToObjKey(mid, hid, 'hl');
      Map<String, dynamic> obj = quickQueryObj['hl_obj'][idStr];
      if (obj != null) {
        obj['hs'] = hs;
        List<dynamic> objOl = obj['ol'];
        if (objOl != null) {
          objOl.forEach((item) {
            item != null && (item['_hs'] == hs);
          });
        }
      }
    }
  }

  void quickQueryObjUpdStatusOs(
      Map<String, dynamic> quickQueryObj, String mid, String oid, int os) {
    if (quickQueryObj != null && oid != null) {
      String idStr = getListToObjKey(mid, oid, 'ol');
      Map<String, dynamic> obj = quickQueryObj['ol_obj'][idStr];
      if (obj != null) {
        obj['os'] = os;
      }
    }
  }

  void clearQuickQueryObj(Map<String, dynamic> quickQueryObj) {
    clearObj(quickQueryObj['ol_obj']);
    clearObj(quickQueryObj['hl_obj']);
    clearObj(quickQueryObj['hn_obj']);
    clearObj(quickQueryObj['mid_obj']);
  }

  void clear() {
    clearQuickQueryObj(dataStoreController.listToObj);
    dataStoreController.midsAtion = [];
    clearObj(dataStoreController.cacheMatch);
    dataStoreController.cacheMatch = {};
    clearObj(dataStoreController.wsMatchKeyUpdTimeCache);
    dataStoreController.wsMatchKeyUpdTimeCache = {};
  }

  void destroy() {
    // scmdC8();
    clearQuickQueryObj(dataStoreController.listToObj);
    clearObj(dataStoreController.listToObj);
    clearObj(dataStoreController.matchUpdTimeKeys);
    clearObj(dataStoreController.cache);
    clearObj(dataStoreController.cacheMatch);
    clearObj(dataStoreController.wsMatchKeyUpdTimeCache);
    clearObj(dataStoreController.cacheOid);
    dataStoreController.midsAtion = [];

    destroy();
  }

  List<dynamic> listSortNew(String mid) {
    MatchEntity? match = dataStoreController.getMatchById(mid);
    // List<dynamic> list = getQuickMidObj(mid)?['odds_info'];
    List list = match!.hps;
    List<dynamic> newList = [];
    if (list != null && list is List) {
      for (int i = 0; i < list.length; i++) {
        if (list[i]['hton'] != 0) {
          newList.add(list[i]);
        }
      }
      if (newList.isNotEmpty) {
        int len = newList.length - 1;
        dynamic t;
        for (int i = 0; i < len; i++) {
          for (int k = 0; k < len - i; k++) {
            if (int.parse(newList[k]['hton']) <
                int.parse(newList[k + 1]['hton'])) {
              t = newList[k];
              newList[k] = newList[k + 1];
              newList[k + 1] = t;
            }
          }
        }
      }
    }
    newList.sort((a, b) {
      int a_ = a['team'] != null ? 1 : 0;
      int b_ = b['team'] != null ? 1 : 0;
      return b_ - a_;
    });
    return newList;
  }

  List<dynamic> listSortNormal(String mid) {
    MatchEntity? match = dataStoreController.getMatchById(mid);
    // List<dynamic> list = getQuickMidObj(mid)?['odds_info'];
    List<dynamic> list = match!.hps;
    List<dynamic> listNormal = [];
    if (list != null && list is List) {
      for (int i = 0; i < list.length; i++) {
        if (list[i]['hton'] == 0) {
          listNormal.add(list[i]);
        }
      }
      if (listNormal.isNotEmpty) {
        int len = listNormal.length - 1;
        dynamic t;
        for (int i = 0; i < len; i++) {
          for (int k = 0; k < len - i; k++) {
            if (int.parse(listNormal[k]['hpon']) >
                int.parse(listNormal[k + 1]['hpon'])) {
              t = listNormal[k];
              listNormal[k] = listNormal[k + 1];
              listNormal[k + 1] = t;
            }
          }
        }
      }
    }
    return listNormal;
  }

  void scmdC8WsReconnect() {
    // scmdC8();
  }
}

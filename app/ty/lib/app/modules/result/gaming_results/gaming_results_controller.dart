import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/manager/league_manager.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/api/result_api.dart';
import '../../../services/models/res/match_entity.dart';
import '../../login/login_head_import.dart';
import 'package:intl/intl.dart';

import 'gaming_results_logic.dart';

class GamingResultsController extends GetxController  with GetTickerProviderStateMixin {
  final GamingResultslogic logic = GamingResultslogic();

  final ScrollController scrollController = ScrollController();
  late TabController dateTabController;
  late TabController typeFilterTabController;

  List<DateItemModel> dateList = [];

  List<String> dateTimes = [];

  late List<TidDataList> matcheResultData = [];

  int dateIndex = 0;
  int typeFilterIndex = 0;

  String md = '';

  bool downloadData = false;
  bool noData = false;
  bool returnToFirst = false;
  bool isExpandAll = true;
  String typePicture = 'assets/images/detail/bg/details-LOL.jpg';
  String euid = '100';
  String tid = '';

  List typeFilterList = GamingResultslogic.getMenu();
  // List<TypeModel> typeFilterList = [
  //   TypeModel('英雄联盟', 100,'assets/images/detail/bg/details-LOL.jpg'),
  //   TypeModel('Dota2', 101,'assets/images/detail/bg/DOTA.jpg'),
  //   TypeModel('王者荣耀', 103,'assets/images/detail/bg/details-KPL.jpg'),
  //   TypeModel('CS:GO/CS2', 102,'assets/images/detail/bg/CS_GO.jpg'),
  // ];

  RxBool loading = false.obs;
  /// 记录请求次数
  int requestCount = 0;

  @override
  void onInit() {
    // registerBus();
    initDate();
    dateTabController = TabController(length: dateList.length, vsync: this);
    typeFilterTabController =
        TabController(length: typeFilterList.length, vsync: this);

    initData();
    scrollController.addListener(() {
      if (scrollController.offset > 5 * 100.0) {
        returnToFirst = true;
        update(["back"]);
      } else {
        returnToFirst = false;
        update(["back"]);
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    dateTabController.dispose();
    typeFilterTabController.dispose();
    super.onClose();
  }

  // registerBus() {
  //   Bus.getInstance().on(EventType.tid, (List<String> data) {
  //     tid = data.join(',');
  //     initData();
  //   });

  // }

  Future<void> initData({String? stid}) async {
    tid = stid ?? '';
    md = dateList[dateIndex].timestamp;
    getMatcheResult();
    // DateTime now = DateTime.now();
    // DateTime startOfDay = DateTime(now.year, now.month, now.day); // Set time to 00:00:00
    // md = startOfDay.millisecondsSinceEpoch.toString();
    // getMatcheResult();
  }

  Future<void> getMatcheResult() async {

    loading.value = true;
    try {
      requestCount++;
      matcheResultData.clear();
      downloadData = true;
      update(["data"]);
      final res = await ResultApi.instance().matcheResult(
        LeagueManager.type.value,
        '240640629535469568',
        'v2_h5_st',
        euid,
        '',
        md.toString(),
        1,
        LeagueManager.sort.value,
        tid,
        28,
      );
      if (res.data != null) {
        ///每次切换界面折叠开关就打开的。
        isExpandAll=true;
        onFormatData(res.data);
        downloadData = false;
        noData = false;
        update(["data"]);
      } else {
        downloadData = false;
        noData = true;
        update(["data"]);
      }
      loading.value = false;
      update();
    } catch (e) {
      1100.milliseconds.delay(() {
        if (isClosed) return;
        initData();
      });
    }



  }

  onFormatData(data) {
    // 上个id
    String preTid = '';
    // 上条数据
    late TidDataList preItem;
    data.asMap().forEach((index, element) {
      if (index > 0) {
        preTid = data[index - 1].tid;
      }
      String tid = element.tid;

      if (tid == preTid) {
        preItem.list.add(element);
      } else {
        TidDataList item = TidDataList();

        item.list = [element];
        item.tid = tid;
        item.mid = element.mid;
        item.tn = element.tn;
        item.tnjc = element.tnjc;

        preItem = item;

        matcheResultData.add(item);
      }
    });
    update(["data"]);
  }

  onDateIndex(int index) {
    dateIndex = index;
    md = dateList[index].timestamp;
    getMatcheResult();
    update(["date"]);
  }

  onTypeFilterIndex(int index) {
    LeagueManager.euid = typeFilterList[index].euid.toString();
    typeFilterIndex = index;
    euid = typeFilterList[index].euid.toString();
    typePicture = typeFilterList[index].image;
    update(["type"]);
    getMatcheResult();
  }

  //删选日期
  void initDate() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('MM/dd');
    String today = LocaleKeys.types_competitions_menu_itme_name_today.tr;

    for (int i = 0; i <= 7; i++) {
      DateTime date = now.subtract(Duration(days: i));
      String formattedDate = (date.year == now.year &&
          date.month == now.month &&
          date.day == now.day)
          ? today
          : '${date.day == now.day ? today : ''}${formatter.format(date)}';
      DateItemModel item = DateItemModel();
      item.date = formattedDate;
      item.timestamp = DateTime(date.year, date.month, date.day)
          .millisecondsSinceEpoch
          .toString();
      dateList.add(item);
      update(["date"]);
    }
  }

  void scrollToFirstItem() {
    scrollController.animateTo(
      0.0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
    update(["data"]);
  }

  onGoToDetails(item, int titleIndex) {
    Get.toNamed(Routes.matchResultsDetails, arguments: [{"item": item},{"typePicture": typePicture},{"titleIndex": titleIndex}] );
  }

  onExpandItem(item) {
    item.isExpand = !item.isExpand;
    update(["data"]);
  }

  // 点击展开全部
  onExpandAll() {
    isExpandAll = !isExpandAll;
    for (var element in matcheResultData) {
      element.isExpand = isExpandAll;
    }
    update(["data"]);
  }
}

// 列表渲染model
class TidDataList {
  late List<MatchEntity> list;
  late String tnjc;
  late String tid;
  late String mid;
  late String tn;
  bool isExpand = true;
}

class DateItemModel {
  late String date;
  late String timestamp;
}


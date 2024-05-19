import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/manager/league_manager.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/api/result_api.dart';
import '../../../services/models/res/mchampion_match_result_entity.dart';
import '../../login/login_head_import.dart';
import 'package:intl/intl.dart';

import 'championship_results_logic.dart';

class ChampionshipResultsController extends GetxController
    with GetTickerProviderStateMixin {
  final ChampionshipResultslogic logic = ChampionshipResultslogic();

  final ScrollController scrollController = ScrollController();
  late TabController dateTabController;

  List<DateItemModel> dateList = [];

  List<String> dateTimes = [];

  late List<MchampionMatchResultData> data = [];
  late List<SportItem> groupList = [];

  int dateIndex = 0;

  String md = '';

  bool downloadData = false;
  bool noData = false;
  bool returnToFirst = false;
  bool isExpandAll = true;
  String euid = '1';
  String startTime = '';
  String endTime = '';

  RxBool loading = false.obs;
  /// 记录请求次数
  int requestCount = 0;

  @override
  void onInit() {
    initDate();
    dateTabController = TabController(length: dateList.length, vsync: this);

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
    super.onClose();
  }
  // 选择了日期 切换其他赛果 回来还是要请求之前的时间
  Future<void> initData() async {
    var index = dateIndex;
    md = dateList[index].timestamp;
    startTime = dateList[index].startTime;
    endTime = dateList[index].endTime;
    getChampionMatchResult();

    // md = dateList[dateIndex].timestamp;
    // DateTime now = DateTime.fromMillisecondsSinceEpoch(md.toInt());
    // DateTime startOfDay = DateTime(now.year, now.month, now.day);
    // var s1 = dateList[dateIndex].timestamp;
    // var s2 = startOfDay.millisecondsSinceEpoch.toString();
   
    // startTime = DateTime(now.year, now.month, now.day, 00, 00, 00)
    //     .millisecondsSinceEpoch
    //     .toString();
    // endTime = DateTime(now.year, now.month, now.day, 23, 59, 59)
    //     .millisecondsSinceEpoch
    //     .toString();

    // getChampionMatchResult();
  }

  Future<void> getChampionMatchResult() async {

    loading.value = true;
    try {
      requestCount++;
      downloadData = true;
      update(["data"]);

      final res = await ResultApi.instance().championMatchResult(
        1,
        '240640629535469568',
        'v2_h5_st',
        endTime,
        10000,
        1,
        md.toString(),
        1,
        LeagueManager.sort.value,
        1000,
        startTime,
        28,
      );

      if (res.data.isNotEmpty) {
        downloadData = false;
        noData = false;
        onFormatData(res.data);
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

  // 格式化数据
  onFormatData(List<MchampionMatchResultData> data) {
    Map sportObj = {};
    Map tourObj = {};

    groupList = [];
    for (var element in data) {
      String sportId = element.sportId;
      String tournamentId = element.tournamentId;

      if (sportObj.containsKey(sportId)) {
        SportItem sportItem = sportObj[sportId];
        sportItem.length += 1;

        if (tourObj.containsKey(tournamentId)) {
          tourObj[tournamentId].list.add(element);
        } else {
          GroupItem groupItem = GroupItem();

          groupItem.tournamentId = element.tournamentId;
          groupItem.tournamentName = element.tournamentName;
          groupItem.sportName = element.sportName;

          groupItem.list = [element];
          tourObj[tournamentId] = groupItem;

          sportItem.list.add(groupItem);
        }
      } else {
        SportItem sportItem = SportItem();
        sportItem.sportName = element.sportName;
        sportItem.sportId = element.sportId;
        sportItem.length = 1;

        GroupItem groupItem = GroupItem();
        groupItem.tournamentId = tournamentId;
        groupItem.tournamentName = element.tournamentName;
        groupItem.sportName = element.sportName;

        groupItem.list = [element];
        tourObj[tournamentId] = groupItem;

        sportItem.list = [groupItem];
        sportObj[sportId] = sportItem;

        groupList.add(sportItem);
      }
    }
    // print(groupList);
  }

  onDateIndex(int index) {
    dateIndex = index;
    md = dateList[index].timestamp;
    startTime = dateList[index].startTime;
    endTime = dateList[index].endTime;
    getChampionMatchResult();
    update(["date"]);
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
      item.startTime = DateTime(date.year, date.month, date.day, 00, 00, 00)
          .millisecondsSinceEpoch
          .toString();
      item.endTime = DateTime(date.year, date.month, date.day, 23, 59, 59)
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

  onExpandItem(item) {
    item.isExpand = !item.isExpand;
    update(["data"]);
  }

}

class DateItemModel {
  late String date;
  late String timestamp;
  late String startTime;
  late String endTime;
}

/*
  [
    {
      title:'格斗',
      length:4,
      list:[
        {
          title:'ONE 冠军赛 2024‘，
          isExpand:true,
          list:[
            {
              team:'ONE 冠军赛 2024',
              time:'',
            },
            {
              team:'ONE 冠军赛 2024',
              time:'',
            },
            {
              team:'ONE 冠军赛 2024',
              time:'',
            },
          ]
        }
      ]
    }
  ]
*/

class SportItem {
  int length = 0;
  late String sportName = '';
  late String sportId = '';
  bool showTitle = false;
  late List<GroupItem> list = [];
}

class GroupItem {
  late int length;
  late String sportName;
  late String tournamentId;
  late String tournamentName;
  bool showTitle = false;
  bool isExpand = true;
  late List<MchampionMatchResultData> list = [];
}

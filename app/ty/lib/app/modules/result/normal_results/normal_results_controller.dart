import 'package:flutter_ty_app/app/global/config_controller.dart';
import '../../../../generated/locales.g.dart';
import '../../../core/constant/common/module/csid.dart';
import '../../../services/api/result_api.dart';
import '../../login/login_head_import.dart';
import 'package:intl/intl.dart';
import '../../setting_menu/league_filter/manager/league_manager.dart';
import '../gaming_results/gaming_results_controller.dart';
import 'normal_results_logic.dart';

class NormalResultsController extends GetxController
    with GetTickerProviderStateMixin {
  final NormalResultslogic logic = NormalResultslogic();

  final ScrollController scrollController = ScrollController();
  final ScrollController typeScrollController = ScrollController();
  late TabController dateTabController;
  late TabController typeFilterTabController;

  List<DateItemModel> dateList = [];

  List<String> dateTimes = [];

  List<int> visibleIndexes = [];

  late List<TidDataList> matcheResultData = [];

  List<int> visibleItemIndices = [];

  bool leftShow = false;
  bool rightShow = false;

  int dateIndex = 0;
  int firstIndex = 0;
  int lastIndex = 0;
  int typeFilterIndex = 0;


  bool downloadData = false;
  bool noData = false;
  bool returnToFirst = false;
  bool isExpandAll = true;
  String typePicture = 'assets/images/detail/bg/football.jpg';
  String euid = '1';
  String tid = '';

  RxBool loading = false.obs;
  /// 记录请求次数
  int requestCount = 0;

  List<TypeModel> typeFilterList = [
    // TypeModel('足球', 1, 'assets/images/detail/bg/football.jpg'),
    // TypeModel('篮球', 2, 'assets/images/detail/bg/basketball.jpg'),
    // TypeModel('电子足球', 90, 'assets/images/detail/bg/football.jpg'),
    // TypeModel('电子篮球', 91, 'assets/images/detail/bg/basketball.jpg'),
    // TypeModel('网球', 5, 'assets/images/detail/bg/tennis.jpg'),
    // TypeModel('斯诺克', 7, 'assets/images/detail/bg/snooker_pool.jpg'),
    // TypeModel('羽毛球', 10, 'assets/images/detail/bg/badminton.jpg'),
    // TypeModel('乒乓球', 8, 'assets/images/detail/bg/ping_pong.jpg'),
    // TypeModel('棒球', 3, 'assets/images/detail/bg/baseball.jpg'),
    // TypeModel('排球', 9, 'assets/images/detail/bg/volleyball.jpg'),
    // TypeModel('手球', 11, 'assets/images/detail/bg/handball.jpg'),
    // TypeModel('拳击/格斗', 12, 'assets/images/detail/bg/boxing.jpg'),
    // TypeModel('沙滩排球', 13, 'assets/images/detail/bg/beach_volleyball.jpg'),
    // TypeModel('水球', 16, 'assets/images/detail/bg/water_polo.jpg'),
    // TypeModel('曲棍球', 15, 'assets/images/detail/bg/hockey.jpg'),
    // TypeModel('联合式橄榄球', 14, 'assets/images/detail/bg/rugby.jpg'),
    // TypeModel('冰球', 4, 'assets/images/detail/bg/ice_hockey.jpg'),
    // TypeModel('美式足球', 6, 'assets/images/detail/bg/american_football.jpg'),
    // TypeModel('娱乐', 18, 'assets/images/detail/bg/rugby.jpg'),
  ];

  // List<ResultMenuItemModel> typeFilterList = NormalResultslogic.getMenu();

  @override
  void onInit() {
    typeFilterList = NormalResultslogic.getMenu();
    initDate();

    dateTabController = TabController(length: dateList.length, vsync: this);
    typeFilterTabController =
        TabController(length: typeFilterList.length, vsync: this);

    initData();
    typeScrollController.addListener(() {
      updateVisibleItem();
    });
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

  void updateVisibleItem() {
    // 获取当前可见的范围
    final min = typeScrollController.position.pixels;
    final max = min + typeScrollController.position.viewportDimension;

    // 打印可见项的索引
    visibleIndexes = typeFilterList
        .asMap()
        .keys
        .where(
            (index) => _itemOffset(index) >= min && _itemOffset(index) <= max)
        .toList();

    if (visibleIndexes.contains(typeFilterIndex)) {
      leftShow = false;
      rightShow = false;
    } else {
      if (typeFilterIndex <= 8) {
        leftShow = true;
        rightShow = false;
      } else if (typeFilterIndex >= 8) {
        leftShow = false;
        rightShow = true;
      } else {
        leftShow = false;
        rightShow = false;
      }
    }
    update(['type']);
  }

  num _itemOffset(int index) {
    // 计算列表中每个项的偏移量
    final top = index * 60.w; // 假设每个item的高度是50.0
    final bottom = top + 60.w;
    return top.clamp(0, double.infinity);
  }

  onTitle(int firstIndex, int lastIndex) {
    /*  print('firstIndex$firstIndex');
    print('lastIndex$lastIndex');
    firstIndex = firstIndex;
    lastIndex = lastIndex;*/
/*
    update(["type"]);
    if (typeFilterIndex <= firstIndex) {
      leftShow = true;
      rightShow = false;
    } else if (typeFilterIndex >= lastIndex) {
      leftShow = false;
      rightShow = true;
    } else {
      leftShow = false;
      rightShow = false;
    }
    update(["type"]);*/
  }

  Future<void> initData({String? stid}) async {
    tid = stid ?? '';
    LeagueManager.md = dateList[dateIndex].timestamp;
    getMatcheResult();
    // DateTime now = DateTime.now();
    // DateTime startOfDay = DateTime(now.year, now.month, now.day); // Set time to 00:00:00
    // LeagueManager.md = startOfDay.millisecondsSinceEpoch.toString();
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
        1,
        '240640629535469568',
        'v2_h5_st',
        euid,
        '',
        LeagueManager.md,
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
    tid = '';
    dateIndex = index;
    LeagueManager.md = dateList[index].timestamp;
    getMatcheResult();
    update(["date"]);
  }

  onTypeFilterIndex(int index) {
    leftShow = false;
    rightShow = false;
     double itemExtent = 50.0.h;
    /*typeScrollController.animateTo(index * itemExtent,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);*/

    LeagueManager.euid = typeFilterList[index].euid.toString();
    tid = '';
    typePicture = typeFilterList[index].image;
    typeFilterIndex = index;
    euid = typeFilterList[index].euid.toString();
    update(["type"]);
    returnToFirst = false;
    update(["back"]);
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
    Get.toNamed(Routes.matchResultsDetails, arguments: [
      {"item": item},
      {"typePicture": typePicture},
      {"titleIndex": titleIndex}
    ]);
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

class DateItemModel {
  late String date;
  late String timestamp;
}

class TypeModel {
  late String name;
  late String label;
  late int euid;
  late int miid;
  late String sportId;
  late String image; // 详情底图
  // late int position;

  TypeModel(this.label, this.euid, this.image) {
    sportId = (euid + 100).toString();
    miid = euid;
    name = ConfigController.to.getName(sportId);
    image = Csid.result_detail_images_postion[euid] ?? "";
    // position = Csid.sprite_images_postion[euid] ?? 0;
  }
}

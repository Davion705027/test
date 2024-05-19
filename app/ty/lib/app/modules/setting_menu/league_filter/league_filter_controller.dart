import 'package:flutter_ty_app/app/modules/setting_menu/league_filter/manager/league_manager.dart';
import 'package:flutter_ty_app/app/services/api/result_api.dart';
import 'package:flutter_ty_app/app/services/models/res/get_filter_match_list_new_entity.dart';
import 'package:flutter_ty_app/app/utils/lodash.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../../../global/ws/ws_type.dart';
import '../../../services/api/base_data_api.dart';
import '../../../utils/bus/bus.dart';
import '../../../utils/bus/event_enum.dart';
import '../../login/login_head_import.dart';
import 'const.dart';
import 'league_filter_logic.dart';


// 页面渲染分组model 例：A B组
class RenderGroupModel{
  String name='';
  String spell='';
  bool isSelect=false;
  bool isExpand=false;
  List<GetFilterMatchListNewData> list = [];

  RenderGroupModel();
}

class LeagueFilterController extends GetxController {
  Function(String stid) finishCb;

  LeagueFilterController({required this.finishCb});

  final LeagueFilterlogic logic = LeagueFilterlogic();
  TextEditingController searchController = TextEditingController();
  final AutoScrollController autoScrollController = AutoScrollController();
  late ListObserverController listObserverController =
      ListObserverController(controller: autoScrollController);

  bool selectAll = false;
  bool indicator = false;

  bool noData = false;

  int currentIndex = 0;
  double location = 0;

  // 只有一条数据 不显示分组头
  bool onlyOne = false;



  late Function debounceSearch;

  // ui 渲染的list
  List<RenderGroupModel> renderGroupList = [];

  // spell 索引列表  也可作为原数据 搜索过滤用
  Map<String,RenderGroupModel> spellMap = {};
  // 索引列表
  List<String> indexList = [
    'HOT',
    'A',
    'B',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  List selectedList = LeagueManager.tid.value;
  @override
  void onInit() {
    // ToastUtils.show(LeagueManager.tid.toString());
    initData();
    super.onInit();
  }



  Future<void> initData() async {
    debounceSearch = lodash.debounce(onSearch);

    noData = true;
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    int md = startOfDay.millisecondsSinceEpoch;
    final res = await ResultApi.instance().getFilterMatchListNew(
      LeagueManager.type.value,
      LeagueManager.euid,
      '',
      240640629535469568,
      'v2_h5',
      '1',
      LeagueManager.md,
    );

    noData = false;
    onGroupData(res.data);
    update();
  }
  onGroupData(List<GetFilterMatchListNewData> data){

    for(var i=0;i<indexList.length;i++){
      RenderGroupModel item = RenderGroupModel();
      if(i==0){
        item.name = '热门';
      }
      String spell = indexList[i];
      item.spell = spell;

      spellMap[spell] = item;
    }

    // print(selectedList);
    for(var i=0;i<data.length;i++){
      
      var element = data[i];
      var spell = element.spell;

      if(selectedList.isNotEmpty && selectedList.contains(element.id)){
        element.isSelect = true;
      }

      // 热门赛事
      if( orderArray.contains(element.id) ){
        spellMap['HOT']!.list.add(element);
        element.parent = spellMap['HOT']!;
      }else{
        if(spellMap.containsKey(spell)){
          // 子级关联父级
          element.parent = spellMap[spell]!;
          spellMap[spell]!.list.add(element);
        }
      }

    }
    // 热门排序
    
    customSortAndMerge( spellMap['HOT']!.list);

    renderGroupList = spellMap.values.where((element) => element.list.isNotEmpty).toList();

    renderGroupEffect();

    if(selectedList.isNotEmpty){
      for (var element in renderGroupList) {
        element.isSelect = element.list.every((element) => element.isSelect);
      }
      // 控制全选的选中
      setAllSelectRadioStatus();
    }

  }
  // 渲染数组 改变执行副作用
  renderGroupEffect(){
    setOnlyOne();
    // 根据渲染数据生成indexList
    indexList = renderGroupList.map((e) => e.spell).toList();
    // setChainGroup();
  }
  // 是否只有一条数据
  setOnlyOne(){
    onlyOne = renderGroupList.length == 1 && renderGroupList[0].list.length == 1;
    // onlyOne = renderGroupList.map((e) => e.list.length).reduce((value, element) => value + element) == 1;
  }
  // 子级关联父级
  setChainGroup(){
    for (var element in renderGroupList) {
      for (var element2 in element.list) {
        element2.parent = element;
      }
     }
  }
  onSearch(){
    String value = searchController.text;

    List<RenderGroupModel> finalList = [];
    for (var element in spellMap.values.toList()) {
      RenderGroupModel groupItem = RenderGroupModel();
      groupItem.isSelect = element.isSelect;
      groupItem.name = element.name;
      groupItem.spell = element.spell;
      groupItem.list = [];
      finalList.add(groupItem);
      for (var element2 in element.list) {
        if(element2.nameText.toLowerCase().contains(value.toLowerCase())){
          groupItem.list.add(element2);
          element2.parent = groupItem;
        }
      }
    }
    renderGroupList = finalList.where((element) => element.list.isNotEmpty).toList();
    renderGroupEffect();
    update();
  }

  // 点击单个分组折叠
  onClickItemExpand(RenderGroupModel item){
    item.isExpand = !item.isExpand;
    update();
  }
  // 全选
  onSelectAll() {
    bool val = !selectAll;
    selectAll = val;
    for (var element in renderGroupList) {
      element.isSelect = val;
      for (var element2 in element.list) {
        element2.isSelect = val;
      }
    }
    update();
  }
  // 选择单组边上的radio
  onSelectGroup(currentRenderGroup){
    bool groupBool = !currentRenderGroup.isSelect;
    currentRenderGroup.isSelect = groupBool;
    for (var element in currentRenderGroup.list) {
      element.isSelect = groupBool;
    }

    // 控制全选的选中
    setAllSelectRadioStatus();

    update();
  }
  // 选择组里面数据
  onSelectItem(GetFilterMatchListNewData groupItem){
    bool itemBool = !groupItem.isSelect;
    groupItem.isSelect = itemBool;
    // print(groupItem);

    // 找到当前点击的组
    RenderGroupModel group = groupItem.parent;
    // RenderGroupModel group = spellMap[groupItem.spell]!;
    var list = group.list;
    bool groupBool = list.every((element) => element.isSelect);
    // 控制当前组的选中
    group.isSelect = groupBool;

    // 控制全选的选中
    setAllSelectRadioStatus();

    update();
  }

  setAllSelectRadioStatus() {
    selectAll = renderGroupList.every((element) => element.isSelect);
  }

  onObserves(index) {
    currentIndex = index;
    update();
  }

  void changeIndex(int index) {
    indicator = true;
    currentIndex = index;
    listObserverController.animateTo(
      index: index,
      duration: const Duration(milliseconds: 10),
      curve: Curves.ease,
    );
    Future.delayed(const Duration(milliseconds: 800), () {
      indicator = false;
      update();
    });
  }

  void slidingUpdate(int index) {
    listObserverController.animateTo(
      index: index,
      duration: const Duration(milliseconds: 10),
      curve: Curves.ease,
    );
  }

  toOnVerticalDragDown(DragDownDetails details) {
    location = (details.localPosition.dy - details.localPosition.dx) - 13;
    update();
  }

  toOnVerticalDragEnd(DragEndDetails details) {
    indicator = false;
    update();
  }

  toOnVerticalDragUpdate(DragUpdateDetails details) {
    indicator = true;
    location = details.localPosition.dy + 10;

    double y = details.localPosition.dy;
    var itemHeight = screenHeight(Get.context!) / 2 / indexList.length;
    int index = (y ~/ itemHeight).clamp(0, indexList.length - 1);

    slidingUpdate(index);
    currentIndex = index;
    update();
  }

  // 点击完成
  onFinish() {
    List<GetFilterMatchListNewData> res = getSelectList();
    List<String> ids = [];
    for (var item in res) {
      ids.add(item.id);
    }
    // Bus.getInstance().emit(EventType.tid,ids);
    finishCb(ids.join(','));
    LeagueManager.tid.value = ids;
    Get.back();
  }
  // 获取选择的联赛列表
  List<GetFilterMatchListNewData> getSelectList(){
    List<GetFilterMatchListNewData> res = [];
    for (var group in renderGroupList) {
      if(group.isSelect){
        res.addAll(group.list);
      }else{
        for (var item in group.list) { 
          if(item.isSelect){
            res.add(item);
          }
        }
      }
    }
    return res;
  }

  // 热门赛事排序
  customSortAndMerge(List<GetFilterMatchListNewData> hotRealList) {
    if(hotRealList.isEmpty)return;
    // 使用映射将 orderArray 中的元素与其索引关联起来
    Map<dynamic, int> orderIndexMap = {};
    orderArray.asMap().forEach((index, item) {
      orderIndexMap[item] = index;
    });

    // 对过滤后的数组进行排序
    hotRealList.sort((a, b) {
      final indexA = orderIndexMap[a.id];
      final indexB = orderIndexMap[b.id];

      // 如果元素在 orderArray 中找不到，则默认按原始顺序排列
      if (indexA == null) return 1;
      if (indexB == null) return -1;

      return indexA - indexB;
    });

    return hotRealList;
  }

  onClearSearchText() {
    searchController.text = '';
    onSearch();
    update();
  }

}


// 热门联赛只展示九大联赛 其余联赛需要塞到 地域级List 或  球种级list
List<String> orderArray = [
   "28206" ,
   "6408" ,
   "18031" ,
   "32070" ,
   "180" ,
   "320" ,
   "239" ,
   "276" ,
   "79" ,
];
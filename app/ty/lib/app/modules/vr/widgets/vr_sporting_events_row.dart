import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

// TODO: 后续再拆分文件
class VrSportingEventModel {
  final String imgName;
  final String imgNameSel;
  final String eventName;
  final int unreadCount;

  VrSportingEventModel({
    this.imgName = '',
    this.imgNameSel = '',
    this.eventName = '',
    this.unreadCount = 0,
  });

  factory VrSportingEventModel.fromJson(Map<String, dynamic> json) =>
      VrSportingEventModel(
        imgName: json['imgName'],
        imgNameSel: json['imgNameSel'],
        eventName: json['eventName'],
        unreadCount: json['unreadCount'],
      );
}

class VrSportingEventsRow extends StatefulWidget {
  const VrSportingEventsRow({
    Key? key,
    this.sportsMenus = const [],
    this.onEventChanged,
    this.defaultSelIndex = 0,
    this.eventsFromModels,
    this.tabController,
  }) : super(key: key);

  // TODO: 如果是统一 model 的话可以直接传入体育赛事的 model 列表
  final List<VrSportingEventModel> sportsMenus;
  // 无特殊要求不需要传
  final int defaultSelIndex;
  final ValueChanged<int>? onEventChanged;
  final List<Map> Function()? eventsFromModels;
  final TabController? tabController;

  @override
  State<VrSportingEventsRow> createState() => _VrSportingEventsRowState();
}

class _VrSportingEventsRowState extends State<VrSportingEventsRow> {
  List _sportingEvents = [
    {
      'imgName': 'vr_home_football',
      'imgNameSel': 'vr_home_football_sel',
      'eventName': 'VR足球',
      'unreadCount': 25,
    },
    {
      'imgName': 'vr_home_basketball',
      'imgNameSel': 'vr_home_basketball_sel',
      'eventName': 'VR篮球',
      'unreadCount': 36,
    },
    {
      'imgName': 'vr_home_dog',
      'imgNameSel': 'vr_home_dog_sel',
      'eventName': 'VR赛狗',
      'unreadCount': 1258,
    },
    {
      'imgName': 'vr_home_horse',
      'imgNameSel': 'vr_home_horse_sel',
      'eventName': 'VR赛马',
      'unreadCount': 698,
    },
    {
      'imgName': 'vr_home_motorcycle',
      'imgNameSel': 'vr_home_motorcycle_sel',
      'eventName': 'VR摩托车',
      'unreadCount': 120,
    },
    {
      'imgName': 'vr_home_dirt_bike',
      'imgNameSel': 'vr_home_dirt_bike_sel',
      'eventName': '泥地摩托车',
      'unreadCount': 60,
    },
  ];

  int _selIndex = 0;

  void _onTabIndexChanged() {
    if (widget.tabController?.indexIsChanging == true) return;
    final index = widget.tabController?.index ?? 0;
    _selIndex = index;
    _safeSetState(() {});
  }

  void _safeSetState(VoidCallback fn) {
    if (mounted) setState(fn);
  }

  @override
  void initState() {
    List sportingEvents = widget.sportsMenus;
    if (sportingEvents.isEmpty) {
      sportingEvents = widget.eventsFromModels?.call() ?? [];
    }
    if (sportingEvents.isNotEmpty) {
      _sportingEvents = sportingEvents;
    }
    _selIndex = _sportingEvents.length > widget.defaultSelIndex
        ? widget.defaultSelIndex
        : 0;

    widget.tabController?.addListener(_onTabIndexChanged);
    super.initState();
  }

  @override
  void dispose() {
    widget.tabController?.removeListener(_onTabIndexChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.colorWhite,
      constraints: BoxConstraints(minWidth: Get.width),
      child: TabBar(
        controller: widget.tabController,
        isScrollable: true,
        indicator: const BoxDecoration(),
        labelPadding: EdgeInsets.zero,
        indicatorPadding: EdgeInsets.zero,
        tabs: List.generate(_sportingEvents.length, (index) {
          final event = _sportingEvents[index];

          String imgName = '';
          String eventName = '';
          int unreadCount = 0;
          final isSelected = _selIndex == index;
          if (event is VrSportingEventModel) {
            imgName = isSelected ? event.imgNameSel : event.imgName;
            eventName = event.eventName;
            unreadCount = event.unreadCount;
          } else if (event is Map) {
            imgName =
                'assets/images/vr/${isSelected ? event['imgNameSel'] : event['imgName']}.png';
            eventName = event['eventName'];
            unreadCount = event['unreadCount'];
          }

          return _buildEventColumn(
            imgName: imgName,
            eventName: eventName,
            unreadCount: unreadCount,
            isSelected: isSelected,
          );
        }),
      ),
    );
  }

  Widget _buildEventColumn({
    required String imgName,
    required String eventName,
    int unreadCount = 0,
    bool isSelected = false,
  }) {
    return Container(
      constraints: const BoxConstraints(minWidth: 52),
      child: Column(
        children: [
          const SizedBox(height: 2),
          Stack(
            clipBehavior: Clip.none,
            children: [
              ImageView(
                imgName,
                width: 24,
                height: 24,
              ),
              if (unreadCount > 0)
                Positioned(
                  right: -7,
                  top: -2,
                  child: Text(
                    '${unreadCount > 99 ? '99+' : unreadCount}',
                    style: TextStyle(
                      color:
                          !isSelected ? 'AFB3C8'.hexColor : '303442'.hexColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          Text(
            eventName,
            style: TextStyle(
              color: !isSelected ? 'AFB3C8'.hexColor : '303442'.hexColor,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

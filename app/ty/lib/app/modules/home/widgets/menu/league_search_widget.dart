import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/modules/home/models/league.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:flutter_ty_app/app/utils/csid_util.dart';
import 'package:flutter_ty_app/app/widgets/sport_icon.dart';

class LeagueSearchWidget extends StatefulWidget {
  const LeagueSearchWidget(
      {Key? key,
      required this.onSearch,
      required this.onLeagueChanged,
      required this.currentLeague})
      : super(key: key);
  final ValueChanged<String> onSearch;
  final ValueChanged<League> onLeagueChanged;
  final League currentLeague;

  @override
  _LeagueSearchWidgetState createState() => _LeagueSearchWidgetState();
}

class _LeagueSearchWidgetState extends State<LeagueSearchWidget> {
  bool _isSearch = false;
  int _currentIndex = 0;
  TextEditingController editingController = TextEditingController();
  RxString searchKey = ''.obs;
  late Worker worker;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _currentIndex = League.leagueList.indexOf(widget.currentLeague);
    Bus.getInstance().on(EventType.leagueReset, (value) {
      if (mounted) {
        setState(() {
          _currentIndex = 0;
        });
      }
    });
    editingController.addListener(() {
      searchKey.value = editingController.text;
    });
    worker = debounce<String>(searchKey, (callback) {
      widget.onSearch(callback);
    });

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Bus.getInstance().on(EventType.closeSearch, (value) {
        _isSearch = value;
        if (mounted) {
          setState(() {
            _isSearch = value;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    editingController.dispose();
    worker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isSearch ? _search() : _leagueSearch();
  }

  _search() {
    return Container(
      height: 28.h,
      padding: EdgeInsets.only(left: 8.w),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: Container(
                height: 24.h,
                decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? Colors.white.withOpacity(0.04)
                      : const Color(0xffF2F2F6),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.only(left: 12,right: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: focusNode,
                        controller: editingController,
                        decoration: InputDecoration(
                          hintText: LocaleKeys.ouzhou_search_placeholder.tr,
                          hintStyle: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Get.isDarkMode
                                ? Colors.white.withAlpha(80)
                                : Color(0xffC9CDDB),
                          ),
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        cursorColor: Color(0xff179CFF),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Get.isDarkMode
                              ? Colors.white
                              : const Color(0xff303442),
                        ),
                      ),
                    ),
                    editingController.text.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                editingController.clear();
                              });
                            },
                            child: Container(
                              height: 24.w,
                              width: 24.w,
                              alignment: Alignment.center,
                              child: ImageView(
                                'assets/images/home/search_clear.png',
                                width: 12.w,
                                height: 12.w,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                )),
          ),
          InkWell(
            onTap: () {
              setState(() {
                editingController.text = "";
                _isSearch = false;
              });
              focusNode.unfocus();
              widget.onSearch('');
            },
            child: Container(
              height: 32.h,
              width: 44.w,
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.common_cancel.tr,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Get.isDarkMode
                      ? Colors.white.withAlpha(80)
                      : Color(0xff303442),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _leagueSearch() {
    League.resetAllName();
    return Container(
      height: 28.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: League.leagueList.length,
              itemBuilder: (context, index) {
                League league = League.leagueList[index];
                bool isSelected = _currentIndex == index;
                int postion =
                    (LeagueSpriteImagesPosition.data[league.val] ?? 1) + 1;
                if (index == 0) {
                  return InkWell(
                    onTap: () {
                      if (_currentIndex != index) {
                        widget.onLeagueChanged(league);
                        setState(() {
                          _currentIndex = index;
                        });
                      }
                    },
                    child: Container(
                      height: 32.h,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        league.name.tr,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: isSelected
                              ? const Color(0xff179CFF)
                              : context.isDarkMode
                                  ? Colors.white.withAlpha(50)
                                  : const Color(0xff7981A4),
                        ),
                      ),
                    ),
                  );
                }
                return _Item(
                  tilte: league.name.tr,
                  icon: leagueIcon(
                      index: postion,
                      width: 16,
                      height: 16,
                      isSelected: isSelected),
                  isSelected: isSelected,
                  onTap: () {
                    if (_currentIndex != index) {
                      widget.onLeagueChanged(league);
                      setState(() {
                        _currentIndex = index;
                      });
                    }
                  },
                );
              },
            ),
          ),
          Obx(() {
            return ConfigController.to.accessConfig.value.searchSwitch
                ? InkWell(
                    onTap: () {
                      setState(() {
                        _isSearch = true;
                      });
                      focusNode.requestFocus();
                    },
                    child: Container(
                      height: 32.h,
                      alignment: Alignment.center,
                      child: ImageView(context.isDarkMode?'assets/images/home/league_search_nor.png':'assets/images/home/league_search.png',
                          width: 20.w, height: 20.h),
                    ),
                  )
                : const SizedBox(
                    width: 0,
                    height: 0,
                  );
          }),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    super.key,
    required this.tilte,
    required this.onTap,
    required this.icon,
    required this.isSelected,
  });

  final Widget icon;
  final String tilte;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(
              width: 4,
            ),
            Text(
              tilte,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: isSelected
                    ? const Color(0xff179CFF)
                    : context.isDarkMode
                        ? Colors.white.withAlpha(50)
                        : const Color(0xff7981A4),
              ),
            )
          ],
        ),
      ),
    );
  }
}

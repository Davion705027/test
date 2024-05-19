import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import 'common_rank_record_header.dart';

class RankingListView extends StatelessWidget {
  const RankingListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RankingTypeSwitch(),
        SizedBox(height: 8),
        RankingGroupStageCard(
          groupName: 'A组',
        ),
        SizedBox(height: 8),
        RankingGroupStageCard(
          groupName: 'B组',
        ),
      ],
    );
  }
}

class RankingGroupStageCard extends StatefulWidget {
  const RankingGroupStageCard({
    super.key,
    required this.groupName,
    this.isExpand = true,
  });

  final String groupName;
  final bool isExpand;

  @override
  State<RankingGroupStageCard> createState() => _RankingGroupStageCardState();
}

class _RankingGroupStageCardState extends State<RankingGroupStageCard> {
  late ValueNotifier<bool> _isExpand;

  _onToggleExpand(bool isExpand) {
    _isExpand.value = isExpand;
  }

  @override
  void initState() {
    _isExpand = ValueNotifier(widget.isExpand);
    super.initState();
  }

  @override
  void dispose() {
    _isExpand.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.colorWhite,
      ),
      child: Column(
        children: [
          GroupStageRankHeader(
            groupName: widget.groupName,
            isExpand: widget.isExpand,
            onToggleExpand: _onToggleExpand,
          ),
          ValueListenableBuilder(
            valueListenable: _isExpand,
            builder: (context, isExpand, child) {
              return AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: isExpand
                    ? const Column(
                        children: [
                          CommonRankRecordHeader(),
                          CommonRankRecordItem(
                            index: 0,
                            name: '曼城斯特',
                            top3UseImg: false,
                          ),
                          CommonRankRecordItem(
                            index: 1,
                            name: '曼联',
                            top3UseImg: false,
                          ),
                          CommonRankRecordItem(
                            index: 2,
                            name: '巴黎圣日尔曼',
                            top3UseImg: false,
                          ),
                          CommonRankRecordItem(
                            index: 3,
                            name: '热刺热巴舞澌法林',
                            top3UseImg: false,
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 9)
                    : const SizedBox(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class GroupStageRankHeader extends StatefulWidget {
  const GroupStageRankHeader({
    super.key,
    required this.groupName,
    required this.isExpand,
    this.onToggleExpand,
  });

  final String groupName;
  final bool isExpand;
  final ValueChanged<bool>? onToggleExpand;

  @override
  State<GroupStageRankHeader> createState() => _GroupStageRankHeaderState();
}

class _GroupStageRankHeaderState extends State<GroupStageRankHeader> {
  late ValueNotifier<bool> _isExpand;

  _onToggleExpand() {
    _isExpand.value = !_isExpand.value;
    widget.onToggleExpand?.call(_isExpand.value);
  }

  @override
  void initState() {
    _isExpand = ValueNotifier(widget.isExpand);
    super.initState();
  }

  @override
  void dispose() {
    _isExpand.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onToggleExpand,
      child: Row(
        children: [
          Container(
            width: 2,
            height: 12,
            margin: const EdgeInsets.only(right: 6),
            decoration: BoxDecoration(
              color: '#179CFF'.hexColor,
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(2),
              ),
            ),
          ),
          Expanded(
            child: Text(
              widget.groupName,
              style: TextStyle(
                fontSize: 12,
                color: '#303442'.hexColor,
                fontWeight: FontWeight.w600,
              ),
            ).paddingSymmetric(vertical: 4),
          ),
          ValueListenableBuilder(
            valueListenable: _isExpand,
            builder: (context, isExpand, child) => Icon(
              isExpand ? Icons.keyboard_arrow_down : Icons.navigate_next,
              color: '#C9CDDB'.hexColor,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

class RankingTypeSwitch extends StatefulWidget {
  const RankingTypeSwitch({
    super.key,
    this.onTypeChanged,
    this.defaultSelType = 1,
  });

  final int defaultSelType;
  final ValueChanged<int>? onTypeChanged;

  @override
  State<RankingTypeSwitch> createState() => _RankingTypeSwitchState();
}

class _RankingTypeSwitchState extends State<RankingTypeSwitch> {
  int _selType = 1;

  _onTypeChanged(int type) {
    _selType = type;
    if (mounted) setState(() {});
    widget.onTypeChanged?.call(_selType);
  }

  @override
  void initState() {
    _selType = widget.defaultSelType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      color: AppColor.colorWhite,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: '#F2F2F6'.hexColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => _onTypeChanged(1),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: _selType == 1 ? AppColor.colorWhite : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '小组赛',
                    style: TextStyle(
                      fontSize: 12,
                      color: '#303442'.hexColor,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => _onTypeChanged(2),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: _selType == 2 ? AppColor.colorWhite : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '淘汰赛',
                    style: TextStyle(
                      fontSize: 12,
                      color: '#303442'.hexColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

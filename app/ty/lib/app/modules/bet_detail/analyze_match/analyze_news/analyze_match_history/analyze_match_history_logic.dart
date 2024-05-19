import 'package:flutter_ty_app/app/services/api/analyze_detail_api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../services/models/res/analyze_back_video_info_entity_entity_entity_entity.dart';
import '../../../../login/login_head_import.dart';
import '../../../../match_detail/controllers/analyze_tab_controller.dart';
import '../../../../match_detail/controllers/match_detail_controller.dart';
import 'analyze_match_history_state.dart';

class AnalyzeMatchHistoryLogic extends GetxController
    with GetSingleTickerProviderStateMixin {
  static AnalyzeMatchHistoryLogic get to => Get.find();
  final AnalyzeMatchHistoryState state = AnalyzeMatchHistoryState();
  late TabController tabController;
  /// 详情tag，赛果进来需要传递
  String? tag;
  String? mid;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this)
      ..addListener(() {
        if (tabController.index.toDouble() == tabController.animation?.value) {
          state.curMainTab.value = tabController.index;
          dealTabVideo(state.curMainTab.value);
        }
      });
  }

  @override
  void onReady(){
    initData();
    super.onReady();
  }

  void initData() async {
    MatchDetailController controller =
    Get.find<MatchDetailController>(tag: tag);
    mid = controller.detailState.mId;
    print("======>mid  ${mid}");
    

    AnalyzeDetailApi.instance()
        .playbackVideoUrl(mid, "H5", "0")
        .then((value) {
      print("========>数据  ${value.data?.toJson()}");
      state.analyzeBackVideoInfoEntityEntityEntity = value.data;

        (value.data?.eventList ?? []).sort((a,b){
        if ((b.secondsFromStart??0) < (a?.secondsFromStart??0)) {
          return -1;
        } else if ((b.secondsFromStart??0) >( a.secondsFromStart??0)) {
          return 1;
        }
        if ((b.firstNum ??0)< (a.firstNum??0)) {
          return -1;
        } else if ((b.firstNum ??0)> (a.firstNum??0)) {
          return 1;
        }
        
        return 0;
      });
      state.analyzeList.value = value.data?.eventList??[];

      update(["playbackVideoUrlList"]);
    });

    //测试代码
    bool env =const bool.fromEnvironment("PACKAGE_MOCK", defaultValue: false);
    if(env){
      requestTest();
    }
  }

  void dealTabVideo(int page) {
    AnalyzeBackVideoInfoEntityEntityEntityEntity value =
        state.analyzeBackVideoInfoEntityEntityEntity ??
            AnalyzeBackVideoInfoEntityEntityEntityEntity();
    if (page == 0) {
      value.eventList?.sort(
              (a, b) => ((b.secondsFromStart ?? 0) - (a.secondsFromStart ?? 0)));
      state.analyzeList.value = value.eventList ?? [];
    } else if (page == 1) {
      List<AnalyzeBackVideoInfoEntityEntityEntityEventList>? eventList =
      getEventCode("goal", value);
      eventList?.sort(
              (a, b) => ((b.secondsFromStart ?? 0) - (a.secondsFromStart ?? 0)));
      state.analyzeList.value =eventList;
    } else if (page == 2) {
      List<AnalyzeBackVideoInfoEntityEntityEntityEventList>? eventList =
      getEventCode("corner", value);
      eventList?.sort(
              (a, b) => ((b.secondsFromStart ?? 0) - (a.secondsFromStart ?? 0)));
      state.analyzeList.value =eventList;
    }
    else if (page == 3) {

      List<AnalyzeBackVideoInfoEntityEntityEntityEventList>? eventList =
      getEventCode("yellow_card", value);
      eventList?.sort(
              (a, b) => ((b.secondsFromStart ?? 0) - (a.secondsFromStart ?? 0)));
      state.analyzeList.value =eventList;
    }
    // else if (page == 3) {
    //   List<AnalyzeBackVideoInfoEntityEntityEntityEventList>? eventList =
    //   getEventCode("punish", value);
    //   eventList?.sort(
    //           (a, b) => ((b.secondsFromStart ?? 0) - (a.secondsFromStart ?? 0)));
    //   state.analyzeList.value =eventList;
    // }
    update(["playbackVideoUrlList"]);
  }

  List<AnalyzeBackVideoInfoEntityEntityEntityEventList> getEventCode(
      String eventCode, AnalyzeBackVideoInfoEntityEntityEntityEntity value) {
    List<AnalyzeBackVideoInfoEntityEntityEntityEventList> eventList = [];
    for (AnalyzeBackVideoInfoEntityEntityEntityEventList analyzeBackVideoInfoEntityEntityEntityEventList
    in value.eventList ?? []) {
      if (analyzeBackVideoInfoEntityEntityEntityEventList.eventCode ==
          eventCode) {
        eventList.add(analyzeBackVideoInfoEntityEntityEntityEventList);
      }
    }
    return eventList;
  }

  setSelectItem(AnalyzeBackVideoInfoEntityEntityEntityEventList element){
    state.curAnalyzeBackVideoInfoEntityEntityEntityEventList=element;
    update(["playbackVideoUrlList"]);

  }

  void requestTest() {
    //  测试代码
    Future.delayed(Duration(seconds: 3), () {
      String data =
          "{\"eventList\":[{\"createTime\":null,\"eventCode\":\"corner\",\"eventId\":\"58376165\",\"eventTime\":\"1709962494000\",\"extraInfo\":\"\",\"firstNum\":1,\"fragmentCode\":\"08d0a5f4a87e630a061bb70907732126\",\"fragmentId\":\"809123\",\"fragmentPic\":\"https://playback-image.clean-yks.com/pic/08d0a5f4a87e630a061bb70907732126.jpg\",\"fragmentVideo\":\"https://playback.clean-yks.com/video/08d0a5f4a87e630a061bb70907732126.mp4\",\"homeAway\":\"悉尼奥林匹克1231232131232133123123\",\"isHomeOrAway\":\"away\",\"matchPeriodId\":\"6\",\"mid\":\"3254293\",\"secondsFromStart\":180,\"t1\":0,\"t2\":1},{\"createTime\":null,\"eventCode\":\"corner\",\"eventId\":\"58376333\",\"eventTime\":\"1709962582000\",\"extraInfo\":\"\",\"firstNum\":1,\"fragmentCode\":\"b62457e45bd2d93aad230ec22a180f50\",\"fragmentId\":\"809127\",\"fragmentPic\":\"https://playback-image.clean-yks.com/pic/b62457e45bd2d93aad230ec22a180f50.jpg\",\"fragmentVideo\":\"https://playback.clean-yks.com/video/b62457e45bd2d93aad230ec22a180f50.mp4\",\"homeAway\":\"萨瑟兰德\",\"isHomeOrAway\":\"home\",\"matchPeriodId\":\"6\",\"mid\":\"3254293\",\"secondsFromStart\":240,\"t1\":1,\"t2\":1},{\"createTime\":null,\"eventCode\":\"corner\",\"eventId\":\"58376372\",\"eventTime\":\"1709962833000\",\"extraInfo\":\"\",\"firstNum\":2,\"fragmentCode\":\"54444f7303d8a443f2cfb2d5dcd7384f\",\"fragmentId\":\"809147\",\"fragmentPic\":\"https://playback-image.clean-yks.com/pic/54444f7303d8a443f2cfb2d5dcd7384f.jpg\",\"fragmentVideo\":\"https://playback.clean-yks.com/video/54444f7303d8a443f2cfb2d5dcd7384f.mp4\",\"homeAway\":\"悉尼奥林匹克\",\"isHomeOrAway\":\"away\",\"matchPeriodId\":\"6\",\"mid\":\"3254293\",\"secondsFromStart\":480,\"t1\":1,\"t2\":2},{\"createTime\":null,\"eventCode\":\"corner\",\"eventId\":\"58376405\",\"eventTime\":\"1709963014000\",\"extraInfo\":\"\",\"firstNum\":3,\"fragmentCode\":\"9fdb11acf69fdc3d293a6e4510197ed7\",\"fragmentId\":\"809162\",\"fragmentPic\":\"https://playback-image.clean-yks.com/pic/9fdb11acf69fdc3d293a6e4510197ed7.jpg\",\"fragmentVideo\":\"https://playback.clean-yks.com/video/9fdb11acf69fdc3d293a6e4510197ed7.mp4\",\"homeAway\":\"悉尼奥林匹克\",\"isHomeOrAway\":\"away\",\"matchPeriodId\":\"6\",\"mid\":\"3254293\",\"secondsFromStart\":660,\"t1\":1,\"t2\":3},{\"createTime\":null,\"eventCode\":\"corner\",\"eventId\":\"58376407\",\"eventTime\":\"1709963030000\",\"extraInfo\":\"\",\"firstNum\":4,\"fragmentCode\":\"540490d7d58ea8509aeb4b72f0a0c921\",\"fragmentId\":\"809163\",\"fragmentPic\":\"https://playback-image.clean-yks.com/pic/540490d7d58ea8509aeb4b72f0a0c921.jpg\",\"fragmentVideo\":\"https://playback.clean-yks.com/video/540490d7d58ea8509aeb4b72f0a0c921.mp4\",\"homeAway\":\"悉尼奥林匹克\",\"isHomeOrAway\":\"away\",\"matchPeriodId\":\"6\",\"mid\":\"3254293\",\"secondsFromStart\":720,\"t1\":1,\"t2\":4},{\"createTime\":null,\"eventCode\":\"yellow_card\",\"eventId\":\"58376691\",\"eventTime\":\"1709964189000\",\"extraInfo\":\"\",\"firstNum\":1,\"fragmentCode\":\"039250acf3a25acae27a2017b3e3a214\",\"fragmentId\":\"809198\",\"fragmentPic\":\"https://playback-image.clean-yks.com/pic/039250acf3a25acae27a2017b3e3a214.jpg\",\"fragmentVideo\":\"https://playback.clean-yks.com/video/039250acf3a25acae27a2017b3e3a214.mp4\",\"homeAway\":\"悉尼奥林匹克\",\"isHomeOrAway\":\"away\",\"matchPeriodId\":\"6\",\"mid\":\"3254293\",\"secondsFromStart\":1680,\"t1\":0,\"t2\":1},{\"createTime\":null,\"eventCode\":\"yellow_card\",\"eventId\":\"58376692\",\"eventTime\":\"1709964189000\",\"extraInfo\":\"\",\"firstNum\":1,\"fragmentCode\":\"2e647af7e4793e547135ca81671593e6\",\"fragmentId\":\"809200\",\"fragmentPic\":\"https://playback-image.clean-yks.com/pic/2e647af7e4793e547135ca81671593e6.jpg\",\"fragmentVideo\":\"https://playback.clean-yks.com/video/2e647af7e4793e547135ca81671593e6.mp4\",\"homeAway\":\"萨瑟兰德\",\"isHomeOrAway\":\"home\",\"matchPeriodId\":\"6\",\"mid\":\"3254293\",\"secondsFromStart\":1740,\"t1\":1,\"t2\":1},{\"createTime\":null,\"eventCode\":\"yellow_card\",\"eventId\":\"58377313\",\"eventTime\":\"1709965268000\",\"extraInfo\":\"\",\"firstNum\":2,\"fragmentCode\":\"3dca8c84f3d57d31a1e796712397dbd2\",\"fragmentId\":\"809271\",\"fragmentPic\":\"https://playback-image.clean-yks.com/pic/3dca8c84f3d57d31a1e796712397dbd2.jpg\",\"fragmentVideo\":\"https://playback.clean-yks.com/video/3dca8c84f3d57d31a1e796712397dbd2.mp4\",\"homeAway\":\"悉尼奥林匹克\",\"isHomeOrAway\":\"away\",\"matchPeriodId\":\"6\",\"mid\":\"3254293\",\"secondsFromStart\":2700,\"t1\":1,\"t2\":2},{\"createTime\":null,\"eventCode\":\"corner\",\"eventId\":\"58377876\",\"eventTime\":\"1709966331000\",\"extraInfo\":\"\",\"firstNum\":2,\"fragmentCode\":\"8498e174af452cff4e3d1bd8fc5c3b5a\",\"fragmentId\":\"809342\",\"fragmentPic\":\"https://playback-image.clean-yks.com/pic/8498e174af452cff4e3d1bd8fc5c3b5a.jpg\",\"fragmentVideo\":\"https://playback.clean-yks.com/video/8498e174af452cff4e3d1bd8fc5c3b5a.mp4\",\"homeAway\":\"萨瑟兰德\",\"isHomeOrAway\":\"home\",\"matchPeriodId\":\"7\",\"mid\":\"3254293\",\"secondsFromStart\":3060,\"t1\":2,\"t2\":4},{\"createTime\":null,\"eventCode\":\"goal\",\"eventId\":\"58378086\",\"eventTime\":\"1709966918000\",\"extraInfo\":\"\",\"firstNum\":1,\"fragmentCode\":\"affd2b912c9107448e63eb7196fea50d\",\"fragmentId\":\"809375\",\"fragmentPic\":\"https://playback-image.clean-yks.com/pic/affd2b912c9107448e63eb7196fea50d.jpg\",\"fragmentVideo\":\"https://playback.clean-yks.com/video/affd2b912c9107448e63eb7196fea50d.mp4\",\"homeAway\":\"萨瑟兰德\",\"isHomeOrAway\":\"home\",\"matchPeriodId\":\"7\",\"mid\":\"3254293\",\"secondsFromStart\":3600,\"t1\":1,\"t2\":0},{\"createTime\":null,\"eventCode\":\"corner\",\"eventId\":\"58378124\",\"eventTime\":\"1709967027000\",\"extraInfo\":\"\",\"firstNum\":5,\"fragmentCode\":\"f4b23122866904db7a6e621e29920811\",\"fragmentId\":\"809380\",\"fragmentPic\":\"https://playback-image.clean-yks.com/pic/f4b23122866904db7a6e621e29920811.jpg\",\"fragmentVideo\":\"https://playback.clean-yks.com/video/f4b23122866904db7a6e621e29920811.mp4\",\"homeAway\":\"悉尼奥林匹克\",\"isHomeOrAway\":\"away\",\"matchPeriodId\":\"7\",\"mid\":\"3254293\",\"secondsFromStart\":3720,\"t1\":2,\"t2\":5},{\"createTime\":null,\"eventCode\":\"yellow_card\",\"eventId\":\"58378515\",\"eventTime\":\"1709967293000\",\"extraInfo\":\"\",\"firstNum\":3,\"fragmentCode\":\"fc45f114e18f736cb3e3dca3a562acc1\",\"fragmentId\":\"809392\",\"fragmentPic\":\"https://playback-image.clean-yks.com/pic/fc45f114e18f736cb3e3dca3a562acc1.jpg\",\"fragmentVideo\":\"https://playback.clean-yks.com/video/fc45f114e18f736cb3e3dca3a562acc1.mp4\",\"homeAway\":\"悉尼奥林匹克\",\"isHomeOrAway\":\"away\",\"matchPeriodId\":\"7\",\"mid\":\"3254293\",\"secondsFromStart\":3960,\"t1\":1,\"t2\":3}],\"playBackPicUrl\":\"https://playback-image.clean-yks.com\",\"playBackUrl\":\"https://playback.clean-yks.com\",\"referUrl\":\"https://proliveh5.sportxxx5blo.com\",\"serverTime\":\"1709967507973\"}";
      AnalyzeBackVideoInfoEntityEntityEntityEntity value =
          AnalyzeBackVideoInfoEntityEntityEntityEntity.fromJson(
              jsonDecode(data));
      state.analyzeBackVideoInfoEntityEntityEntity = value;
      value.eventList?.sort(
          (a, b) => ((b.secondsFromStart ?? 0) - (a.secondsFromStart ?? 0)));
      state.analyzeList.value = value.eventList ?? [];
      update(["playbackVideoUrlList"]);
    });
  }
}

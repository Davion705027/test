import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/extension/safe_update_extensions.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

mixin RefreshControllerMixin<R> on GetxController {
  late final RefreshController refreshController;

  bool isLoading = true;
  int pageNum = 1;
  int get pageSize => 10;
  int total = 0;

  // 因为后端返回两个 list：records 和 orders，所以需要子级根据需要返回 noMore
  bool get noMore => false;

  Future<void> onRefresh() async {
    if (refreshController.isLoading) {
      refreshController.refreshCompleted();
      return;
    }
    pageNum = 1;
    try {
      final res = await loadData();
      total = res?.$2 ?? 0;

      refreshController.refreshCompleted();
      // 刷新的时候 total 小于 pageSize，说明没有更多数据了
      if (total < pageSize) {
        refreshController.loadNoData();
      } else {
        refreshController.resetNoData();
      }
      isLoading = false;
      safeUpdate();
    } catch (e) {
      isLoading = false;
      debugPrint('onLoading: $e');
      // DialogUtil.showToast(e.toString());
      refreshController.refreshFailed();
      safeUpdate();
    }
  }

  Future<void> onLoading() async {
    if (refreshController.isRefresh) {
      refreshController.loadComplete();
      return;
    }
    if (noMore) {
      refreshController.loadNoData();
      return;
    }
    pageNum += 1;
    try {
      final res = await loadData();
      total = res?.$2 ?? 0;
      final recordsSize = res?.$1.length ?? 0;

      if (recordsSize < pageSize) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    } catch (e) {
      debugPrint('onLoading: $e');
      // DialogUtil.showToast(e.toString());
      refreshController.loadFailed();
    }
  }

  Future<(List<R> records, int total)?> loadData();

  @override
  void onInit() {
    refreshController = RefreshController();
    super.onInit();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }
}

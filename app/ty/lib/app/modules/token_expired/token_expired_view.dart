import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/main.dart';
import 'package:get/get.dart';

import '../../../generated/locales.g.dart';
import 'token_expired_logic.dart';

class TokenExpiredPage extends StatefulWidget {
  const TokenExpiredPage({Key? key}) : super(key: key);

  @override
  State<TokenExpiredPage> createState() => _TokenExpiredPageState();
}

class _TokenExpiredPageState extends State<TokenExpiredPage> {
  final logic = TokenExpiredLogic.to;
  final state = TokenExpiredLogic.to.state;

  @override
  Widget build(BuildContext context) {
    return oBContext != null
        ? Stack(
            children: [
              ImageView(
                state.imgKey,
                width: double.maxFinite,
              ),
              SafeArea(
                child: SizedBox(
                  height: 48.h,
                  child: Container(
                    margin: EdgeInsets.only(left: 14.w, right: 14.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => oBContext != null
                              ? Navigator.pop(oBContext!)
                              : Get.back(),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20.w,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          LocaleKeys.app_loginInvalid.tr.replaceAll(' ！', ''),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          width: 30.w,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        : ImageView(
            state.imgKey,
            width: double.maxFinite,
          );
  }

  @override
  void dispose() {
    Get.delete<TokenExpiredLogic>();
    super.dispose();
  }
}

import 'login_controller.dart';
import 'login_head_import.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Get.find<LoginController>();
  final logic = Get.find<LoginController>().logic;

  ///登陆头部
  Widget _loginHeader() {
    return Container(
      margin: EdgeInsets.only(
        top: 10.h,
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            height: 20.h,
          ),
          Text(
            '模拟登录',
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          ),
          Container(
            height: 30.h,
          ),
          Text(
            '环境———${controller.env}',
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          ),
          Container(
            height: 15.h,
          ),
          Text(
            'V ${controller.version}',
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  ///输入框
  Widget _loginInputBox() {
    return Container(
      margin: EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w),
      child: Column(
        children: [
          Container(
            height: 40.h,
            decoration: const BoxDecoration(
              color: AppColor.card,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              controller: controller.usernameController,
              keyboardType: TextInputType.text,
              cursorColor: Colors.blue,
              style: TextStyle(
                color: AppColor.backgroundColor,
                fontSize: 14.sp,
              ),
              inputFormatters: const [],
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10.h),
                hintText: '请输入用户名称',
                hintStyle: TextStyle(
                  color: AppColor.backgroundColor,
                  fontSize: 12.sp,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.0)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.0)),
                ),
                icon: Container(
                  margin: EdgeInsets.only(
                    left: 10.w,
                    right: 10.w,
                  ),
                  child: Text(
                    '用户名称',
                    style: TextStyle(
                      color: AppColor.backgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              autofocus: false,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.h),
            height: 40.h,
            decoration: const BoxDecoration(
              color: AppColor.card,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              controller: controller.passwordController,
              obscureText: controller.obscurePassword,
              keyboardType: TextInputType.text,
              cursorColor: Colors.blue,
              style: TextStyle(
                color: AppColor.backgroundColor,
                fontSize: 14.sp,
              ),
              inputFormatters: const [],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.h),
                hintText: '请输入用户密码',
                hintStyle: TextStyle(
                  color: AppColor.backgroundColor,
                  fontSize: 12.sp,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.0)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.0)),
                ),
                icon: Container(
                  margin: EdgeInsets.only(
                    left: 10.w,
                    right: 10.w,
                  ),
                  child: Text(
                    '用户密码',
                    style: TextStyle(
                      color: AppColor.backgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                border: InputBorder.none,
                suffixIcon: GestureDetector(
                  onTap: controller.onObscurePassword,
                  child: controller.obscurePassword == true
                      ? Icon(
                          Icons.visibility_off,
                          size: 25,
                          color: Colors.grey[500],
                        )
                      : Icon(
                          Icons.visibility,
                          size: 25,
                          color: Colors.grey[500],
                        ),
                ),
              ),
              autofocus: false,
            ),
          ),
          Container(
            height: 40.h,
            margin: EdgeInsets.only(top: 20.h),
            decoration: const BoxDecoration(
              color: AppColor.card,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              controller: controller.codeController,
              keyboardType: TextInputType.text,
              cursorColor: Colors.blue,
              style: TextStyle(
                color: AppColor.backgroundColor,
                fontSize: 14.sp,
              ),
              inputFormatters: const [],
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10.h),
                hintText: '请输入商户code',
                hintStyle: TextStyle(
                  color: AppColor.backgroundColor,
                  fontSize: 12.sp,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.0)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.0)),
                ),
                icon: Container(
                  margin: EdgeInsets.only(
                    left: 10.w,
                    right: 10.w,
                  ),
                  child: Text(
                    '商户code',
                    style: TextStyle(
                      color: AppColor.backgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              autofocus: false,
            ),
          ),
        ],
      ),
    );
  }

  ///登陆按钮
  Widget _login() {
    return GestureDetector(
      onTap: () => controller.toLogin(),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 40.h, left: 20.w, right: 20.w),
        height: 40.h,
        decoration: ShapeDecoration(
          color: const Color(0xFF3E65FF),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        width: double.maxFinite,
        child: Text(
           '登录',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  ///环境选择
  Widget _setting() {
    return GestureDetector(
      onTap: () => controller.toSelect(),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
        height: 40.h,
        decoration: ShapeDecoration(
          color: const Color(0xFF3E65FF),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        width: double.maxFinite,
        child: Text(
          '环境选择',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColor.backgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _loginHeader(),
                  _loginInputBox(),
                  _login(),
                  _setting(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    Get.delete<LoginController>();
    super.dispose();
  }
}

内部工具 ID 3267

## GetX CLI的使用

```agsl
// 创建page:
// (页面包括 controller, view, 和 binding)
// 注: 你可以随便命名, 例如: `get create page:login`
// 注: 选择了 Getx_pattern 结构才用这个选项
get create page:home

// 在指定文件夹创建新 controller:
// 注: 你无需引用文件夹, Getx 会自动搜索 home 目录,
// 并把你的controller放在那儿
get create controller:dialogcontroller on home

// 在指定文件夹创建新 view:
// 注: 你无需引用文件夹,Getx 会自动搜索 home 目录,
// 并把你的 view 放在那儿
get create view:dialogview on home

// 生成国际化文件:
// 注: 你在 'assets/locales' 目录下的翻译文件应该是json格式的
get generate locales assets/locales
```

## 快速开发插件

FlutterJsonBeanFactory ： json转dart实体类插件，注意将 Setting - Tools - FlutterJsonBeanFactory -
model suffix 设置为 info 统一模型文件后缀
Flutter-Toolkit ： 生成API接口请求代码插件。每个API类都有一个静态工厂方法，不要放到getx中管理。

## 资源文件

assets 管理图标、图片、字体等资源文件。按照模块划分。注意命名规范。
locales 管理国际化文件。按照模块划分。注意命名规范。

## 单模块开发

```
使用 getxcli 的 get create page:home 命令创建页面，会自动生成 controller, view, binding 三个文件。
根据模块复杂性，选择性拆分。 如果模块简单，可以不用拆分，直接在模块目录下创建 controller, view, binding 三个文件。
如果复杂，多出来 state 状态管理，widgets 小组件。



## 命名规范
1. 类文件命名：小写字母，单词之间用下划线分割。
2. 类名命名：大写字母开头，单词之间不用分割。大驼峰命名法。
3. 文件夹命名：小写字母。



```

## 用到插件：

![img](https://assets-image.oceasfe.com/public/upload/image/20231208/bd836b00959b11eea34cd99051d8ba36.png)

### Flutter-Toolkit生成  api

![img](https://assets-image.oceasfe.com/public/upload/image/20231208/aab3ca10959111ee8b03e1d29fcd2f0c.png)

## flutterjsonbeanfactory  解析JSON

![img](https://assets-image.oceasfe.com/public/upload/image/20231208/cac0f070959211eeaa7125019cb587d9.png)

### 多语言生成 ：

配置 get_cli https://pub.dev/packages/get_cli

get.bat generate locales assets/locales

$HOME/.pub-cache/bin/get generate locales assets/locales

![img](https://assets-image.oceasfe.com/public/upload/image/20231208/3168d150959611ee87a493432f560ad6.png)

TinyPNG 图片压缩

# 生成flutter 电竞SDK

用项目 flutter_dj_module 生成，项目代码同步 flutter_dj_app

flutter_dj_module 生成SDK命令

生成Android aar

flutter build aar --build-number 1.1

生成IOS framework

flutter build ios-framework

## 代码统计

python3 git-console-20240128.py mbJu29d510eMOkPGvXlH7WIjFg3hANqLCYx 90  "前端2024-01-28
集体统计汇总" "shangbao=1;team=ty"

更换入口，SDK

![img](https://assets-image.oceasfe.com/public/upload/image/20231208/d2203330959711ee8b03e1d29fcd2f0c.png)

//接收安卓iOS 带参跳转从URL 拿到 token，api 地址，语言

String url = window.defaultRouteName;

Android IOS 端带h5地址跳转 需注意 指定 /home? 路由

https://newh5.duof3he.com/home?token=111909998618645082&lang=en&domain=default&theme=new_theme&addr=eyJhcGkiOlsiaHR0cHM6Ly9kYXBpdHBnZnAxLmk5Y2dlLmNvbToxNzAyNyIsImh0dHBzOi8vZGdjcGFwaXRwcDEuZW9waGE3Zi5jb206MTAxNTIiXSwiY2RuIjpbImh0dHBzOi8vZHRvcGFsaXN0YXR0dzEuc3E1NTk1LmNvbSJdLCJoNSI6WyJodHRwczovL2R0cGF3c2g1LmR1b2YzaGUuY29tIiwiaHR0cHM6Ly9uZXdoNS5kdW9mM2hlLmNvbSJdLCJpbWdfdXJsIjpbImh0dHBzOi8vdXBody1jZG41LnE3YjQ1NDllLmNvbS8iXSwicGMiOlsiaHR0cHM6Ly9kdG9wcGNhbGkucXVhZ2g0ZS5jb20iLCJodHRwczovL25ld3BjLnF1YWdoNGUuY29tIl19

## 增加window支持

flutter create --platforms=windows .

![img](https://assets-image.oceasfe.com/public/upload/image/20231208/f7846280959811eeaa7125019cb587d9.png)

### 错误码重试机制

```agsl
  /// 列表信息
  @Extra({kRetryableKey: true, KRetryCodeKey: '0408006'})
  @POST('/yewu11/v1/m/matches')
  Future<ApiRes<List<MatchEntity>>> matches(
    @Body() MatchListReq req,
  );
```

代码统计
python3 git-console.py mbJu29d510eMOkPGvXlH7WIjFg3hANqLCYx 90   "前端2024-01-28 集体统计汇总"  "
shangbao=1;team=ty"

python3 git-console-vb-20240416.py

web配置    打印http日志
--web-port=8080 --dart-define=PACKAGE_MOCK=false --dart-define=LOG_OPEN=true --web-hostname=127.0.0.1 --web-browser-flag "--disable-web-security"

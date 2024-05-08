# Flutter入门到放弃

学习本文，你将收获到：

- Flutter、dart学习路线
- 基于homebrew 安装flutter环境
- Flutter 的约束布局、布局规则
- Flutter的三颗树
- 刷新率、帧率、VSync（垂直同步）
- Flutter的更新机制
- setState原理揭秘，diff算法
- flutter-hooks、GetX基本使用

## 学习路线

### dart:

dart官网：https://dart.dev/guides

dart知识点总结：https://juejin.cn/post/6905929089379500039

### flutter:

flutter官网：https://docs.flutter.dev/

flutter中文网：https://flutter.cn/docs/get-started/install

flutter实战第二版：https://book.flutterchina.club/

web开发转flutter：https://flutter.cn/docs/get-started/flutter-for/web-devs#performing-basic-layout-operations



## 环境安装

官方文档提供了win和mac的环境安装教程，下面我提供mac一种更方便的安装方式，无需配置环境变量。

1. 安装homebrew。

   > /bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"
   >
   > 终端输入此命令，然后输入1即可下载。

2. 安装Flutter SDK

   > brew install --cask flutter

3. 安装安卓SDK

   > brew install --cask android-sdk

4. `flutter doctor -v` 检查依赖安装情况

   > 安装成功后，会输出各个依赖的版本和存放地址等信息。当我们需要去编辑器配置SDK路径时，可以通过此命令去查找对应路径。
   >
   > 有未通过的自行百度下即可。

5. 安装模拟器

   > 以`Android Studio`为例：打开View ==> Tool Windows ==> Device Manager ==>Create Device 

### 编辑器

编辑器使用`Android Studio`和`Vscode`都可，都需要先安装`dart`和`flutter`插件。

`Android Studio`: https://flutter.cn/docs/tools/android-studio

`Vscode`: https://flutter.cn/docs/tools/vs-code

DevTools: https://flutter.cn/docs/tools/devtools/overview

> 重点看下Flutter inspector、Performance、Network



## 布局约束

官方文档 https://docs.flutter.dev/ui/layout/constraints

中文文档 https://flutter.cn/docs/ui/layout/constraints

flutter中的布局和HTML是不太一样的，先看文档中的几个例子：

1. 样例1中，只是在根节点下设置`Container` 的颜色，但是却充满了整个屏幕，要知道在HTML中添加一个div是不会自动设置宽高的。但是样例2设置了宽高，依旧却没有生效。

2. 样例3、4外面套个Center或Align能正确设置`Container` 的大小。

flutter中布局约束分为2类：**严格约束 (Tight)**与**宽松约束 (loose)**，或者叫紧约束和松约束。

> 严格约束给你了一种获得确切大小的选择。换句话来说就是，它的最大/最小宽度是一致的，高度也一样。也就是传递了严格约束，你的大小就被固定了，即使你设置了也是按严格约束来显示

> 宽松 约束的最小宽度/高度为 0

了解了这两个概念，再看上面的例子：

1. 样例1和2中的`Container` 在根节点下，他受到的是紧约束，宽高必须变得和屏幕一样大，所以就算你设置了宽高也是和屏幕一样大小。

2. Center和Align这两个`Widget` 可以将接收的紧约束转为松约束传递给下级。样例3的Center和样例1、2中的`Container` 同样受到紧约束：宽高必须为屏幕尺寸，但Center却告诉子级：你的宽高可以更小，但是不能超过屏幕尺寸。这样就渲染了实际宽高的`Container` 。

   

   ```dart
   Center(
     child: Container(
       color: red,
       child: Container(color: green, width: 30, height: 30),
     ),
   )
   ```

   分析下样例7代码：假设屏幕宽高为 375 × 667，Center接收的紧约束 (375 × 667 ) ，传递给`red Container`  松约束(0-375 × 0-667 )，`red Container`将此松约束传递给`green Container`,到此约束传完了，开始绘制尺寸了，`green Container`需要30 × 30，告诉`red Container`后，因为`red Container`没有固定尺寸，所以变成和子级一样大小，也是 30 × 30。由于绿色的 `Container` 完全覆盖了红色 `Container`，所以你看不见它。

### 布局规则

> 首先，上层 widget 向下层 widget 传递约束条件(constrainets)；
> 然后，下层 widget 向上层 widget 传递大小信息(size)。
> 最后，上层 widget 决定下层 widget 的位置和大小。

```dart
Center(
  child: Container(
    padding: const EdgeInsets.all(20),
    color: red,
    child: Container(color: green, width: 30, height: 30),
  ),
)
```

这是样例8的代码，根据布局规则我将代码绘制成了流程图

<img src="https://assets-image.oceasfe.com/public/upload/image/20231215/aa7322109b3811eeaa7125019cb587d9.png">



`red Container`因为有20padding，所以在向下传递约束时宽高就得分别减去40。

如何验证或者获取当前`Widget`的布局约束？ 在需要获取的位置使用`LayoutBuilder`

```dart
Center(
  child: Container(
    padding: const EdgeInsets.all(20),
    color: red,
    child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      print(constraints); // BoxConstraints(0.0<=w<=335.0, 0.0<=h<=627.0)
      return Container(color: green, width: 30, height: 30);
    },),
  ),
)
```

### 自定义约束：

根据flutter中的布局规则，布局约束都是自上而下传递的，如果需要自定义布局约束，可以使用`BoxConstraints`

```dart
Container(
  color: green,
  constraints: const BoxConstraints(minWidth: 100,minHeight: 100,maxWidth:200,maxHeight:200),
)
  
ConstrainedBox(
  constraints: const BoxConstraints(minWidth: 100,minHeight: 100,maxWidth:200,maxHeight:200),
  child: Widget(),
)

```




## Widget的状态

flutter包含两种核心的 widget 类：**有状态的** 和 **无状态的** widget。

`StatelessWidget`不包含变化的属性，适合封装一些ui组件。

当widget 拥有需要根据用户交互或其他因素而变化的特有属性，它就是 **有状态的**。在官方的计数器 widget中，用户点击按钮时数字递增，那么计数值就是计数器 widget 的状态。当值变化时，widget 则需要被重建以更新相关部分的 UI。这些 widget 会继承 `StatefulWidget`，并且「可变的」状态会保存在继承 `State`的另一个子类中（因为 widget 本身是不可变的）。 `StatefulWidget` 自身没有 build 方法，而在其对应的 `State` 对象中。每当你更改 `State` 对象时（例如计数增加），你需要调用 [`setState()`](https://api.flutter-io.cn/flutter/widgets/State/setState.html) 来告知框架，再次调用 `State` 的构建方法来更新 UI。



## 三棵树

- widget树

  **定义**：Widget 树是由开发者通过编写代码构建的，它定义了应用的界面结构和外观。Widget 在 Flutter 体系下设计为不可变的，用于描述界面的配置信息。创建开销很小，可以理解成一个配置文件。

  **作用**：Widget 树是应用的蓝图，它描述了界面上的所有元素（如按钮、文本、布局等）及其属性。

  **变化**：当应用的状态改变时，Widget 树会被重新构建，以反映最新的状态。

- element树

  **定义**：Element 树是 Flutter 在构建 Widget 树的基础上创建的，每个 Element 对应一个 Widget。Element 是可变的，用于管理 Widget 的生命周期和状态。

  **作用**：Element 树是 Widget 树和 RenderObject 树之间的桥梁。它负责根据 Widget 树的变化来更新 RenderObject 树，并将事件和数据从 Widget 层传递到渲染层。

  **变化**：当 Widget 树重新构建时，Flutter 会尽可能重用旧的 Element（diff），并根据新的 Widget 树更新 Element 树。

  在wiget中，widget中的`build(BuildContext context)`这里的context就是element。

- render树

  **定义**：RenderObject 树是由 Element 树创建和维护的，每个 RenderObject 负责具体的布局和绘制工作。真正有布局和绘制能力的对象，比如图像 Image 控件，最终会创建 RenderImage 进行图像渲染；对应于 Android 中的 View。
  
  **作用**：RenderObject 树描述了界面的几何结构和视觉表现。它负责计算和确定每个界面元素的大小和位置，并将它们绘制到屏幕上。
  
  **变化**：当 Element 树更新时，相应的 RenderObject 也会被更新。RenderObject 树会根据界面元素的属性和约束进行布局计算和绘制。

总的来说，Widget 树是应用的静态描述，Element 树是桥梁和管理者，RenderObject 树是负责具体布局和绘制的动态结构。这三棵树协同工作，将开发者定义的界面转化为最终显示在屏幕上的图像。

为了更为深刻的理解以上描述的含义，我们可以举一个更为形象的例子。Widget 作为大 Boss，他把近期的战略部署，即配置信息，写在纸上下发给经理人 Element，Element 看到详细的配置信息开始真正的开起活来了。我们还需要注意一点，大 Boss 随时会改变战略部署，然后不会在原有的纸上修改而是重新写下来，这时经理人为了减少工作量需要将新的计划与旧的计划比较来作出相应的更新措施(diff)。下面又来了，Element 作为经理人也很体面，当然不会把活全干完，于是又找了一个 RenderObject 的员工来帮它做粗重的累活。

如果了解react的话，widget就等同于开发者写的jsx，babel编译后会创建成React Element对象，flutter中的element就对应react中的fiber。

### 思考：为什么需要三颗树？

- 分层：Framework 将复杂的内部设计、渲染逻辑与开发接口隔离开，应用层只需关注 Widget 开发即可。
- 性能： 当布局改变，只需要遍历布局相关树。
- 清晰：更清晰的分离，使得 Widget 协议和 RenderObject 协议能够各自专注特定的需求，简化了 API，从而降低 bug 风险和测试负担。
- 类型安全：渲染 RenderObject 树会更安全，因为它可以在运行时保证子节点有合适的类型（例如，每个坐标系都有自己的 RenderObject 类型）。组合 widget 可以不考虑布局时使用的坐标系（例如，同一个 widget 可以分别在盒子布局和 sliver 布局中使用），因此在 Element 树中，验证 RenderObject 的类型需要将树遍历。



## VSync（垂直同步）

### 什么是VSync

先介绍两个概念：

- `Refresh Rate`（刷新率）指的是显示器每秒更新屏幕内容的次数，通常以赫兹（Hz）为单位表示。刷新率决定了显示器在单位时间内能够显示多少次新的图像。常见的刷新率有60Hz、75Hz、120Hz、144Hz等。比如60HZ，每秒刷新60次，也就是1000/60=16.6ms刷新一次。
- `Frame Rate`（帧率）指的是在视频或动画中每秒钟显示的帧数，通常以“fps”（frames per second）为单位表示。帧率描述了图像连续播放的速度，它直接影响到视频或动画的流畅度和视觉效果。例如，一个视频的帧率是30fps，意味着在一秒内播放了30帧图像，而60fps意味着每秒播放了60帧图像。

在没有启用VSync的情况，会出现下面情况：

1. 如果显示器的刷新率高于GPU生成图像帧的速度，那么在一个刷新周期内，GPU可能无法及时生成新的图像帧，导致显示器继续显示上一帧的内容。这会导致画面的更新速度慢于显示器的刷新速度，使得画面看起来卡顿或者卡帧
2. 帧率大于屏幕刷新率：如果你的电脑配置很高，GPU性能强大，而显示器的刷新率相对较低，例如你的显示器是60Hz，但GPU可以输出更高的帧率，比如90fps或120fps，那么就会出现帧率高于屏幕刷新率的情况

所以，Sync的作用就是协调显示器与显卡不同的工作速率，显卡在渲染每一帧之前都会等待同步信号，只有显示器完成一次刷新，发出垂直同步信号，显卡才会渲染下一桢，确保刷新率和帧率同步。

下面看两个例子图

<img src="https://assets-image.oceasfe.com/public/upload/image/20240424/0bbec1b001f911efb2df755eb7c34722.png"><img src="https://assets-image.oceasfe.com/public/upload/image/20240424/0bbe4c8001f911efb2df755eb7c34722.png">

两图均来自编辑器的性能工具面板，左图为官方计数器案例，右图为app项目。

可以看到同样60HZ的刷新率情况下，左图为理想状态，每一桢不超过16ms，帧率为60fps。但右图每秒的帧率为40fps，右图中计算的长任务居多，导致只渲染了40桢，这就存在丢帧，严重的会导致卡顿，加速手机耗电，手机立马变暖手宝。



### VSync在flutter中的作用

Flutter通过向手机平台注册VSync信号监听，当信号来临时，通过回调方法，触发widget的build、layout、paint过程，来更新需要刷新的元素。



## 渲染流程

对iOS的原生绘制来说，`UIView` 树由上到下遍历每一个 `UIView`，`UIView`进行`Constraint`—`Layout`—`Display`。而在 Flutter开发中界面是由 Widget 组成的，渲染在 Framework 层会有 `Build、Layout、Paint、Composite Layer` 等几个阶段。 将 Layer 进行组合，生成纹理，使用 OpenGL 的接口向 GPU 提交渲染内容进行光栅化与合成，是在 Flutter 的 C++ 层，使用的是 Skia 库代替原生的 Core Graphics。

- **Build:** 开始构建 Widget，将 UI 配置转换成可渲染的数据结构
- **Layout:** 确定每个 Widget 的位置和大小
- **Paint:** 将 Widget 绘制成用户看到的样子，生成图层或者 Texture
- **Composite:** 把Paint过程生成图层或纹理按照顺序进行组合合成

##### 渲染时机

在Flutter应用中，触发渲染（树的更新）主要有以下几种时机：

- 在Futter启动时`runApp`(Widget app)全局刷新
- 开发者主动调用`setState()`方法： 将该子树做StatefullWidget的一个子widget，并创建对应的State类实例，通过调用state.setState() 触发该子树的刷新
- 热重载

<img src="https://assets-image.oceasfe.com/public/upload/image/20240427/8f28ea10047611ef9ec1f7c5988a9e77.png">

1. Flutter的framework通知状态发生改变 （widget状态发生改变，用户交互、数据更新）
2. framework通知Engine渲染
3. Engine等下一个Vsync到来后，触发Framework执行渲染（UI线程Build->Layout->Paint），生成LayerTree传递给Engine
4. Raster【光栅线程/GPU线程】进行合成和光栅化展示到屏幕

什么是Layer?

> <a href="https://book.flutterchina.club/chapter14/paint.html#_14-5-3-layer">参考</a>

Layer : 可快取一组 RenderObject 绘图的结果，可提供半透明、位移、剪裁等效果，多个图层叠加合成产生最终的画面。通常情况下，处于后台的 Layer 不需要参与重绘，只需要参与合成即可。

Flutter中的图层是一个轻量级的、可组合的、具有层次结构的对象。它们可以嵌套，形成一个复杂的图层树（Layer Tree）。每个图层通常对应一个UI元素，比如文本、图像、矩形等，以及一些绘制效果，如遮罩、裁剪、透明度等。

图层在Flutter中有不同的类型，包括：

1. **OffsetLayer：** 表示一个矩形区域，可以包含其他图层或绘制命令。
2. **PictureLayer：** 表示一个静态的、不可变的图像，通常用于缓存渲染结果。
3. **ClipRectLayer、ClipRRectLayer、ClipPathLayer：** 分别表示矩形裁剪、圆角矩形裁剪和路径裁剪。
4. **TransformLayer：** 表示一个二维转换，如平移、旋转、缩放等。
5. **OpacityLayer：** 表示一个透明度效果，可以控制子图层的不透明度。
6. **PerformanceOverlayLayer：** 表示性能叠加层，用于显示渲染性能的相关信息。

Flutter框架会根据渲染树中的图层信息，将它们转换为实际的绘图命令，然后发送到屏幕上进行渲染。也就是接下来要讲的总体过程



### Build-Layout-Paint-Raster

上述流程主要分为UI 线程和 GPU 线程：

1. UI线程：将用户编写的 widget 树经层层转化，Build->Layout->Paint,最终会形成一个 Layer Tree，这个过程在 Flutter Framework 层实现

2. Raster【光栅线程/GPU线程】：Layer Tree 经合成器合成拍扁、Skia 转化成 2D 图形指令、经 OpenGL 或 Vulkan 硬件加速引擎，光栅化形成 GPU 指令，最终提交给 GPU 进行渲染。这部分在 Flutter Engine 层实现。虽然叫 GPU 线程，实际上它仍然运行在 CPU 线程中。你不能直接访问光栅线程或它的数据，但如果这个线程较慢，那它肯定是由你的Dart 代码引起的



<img src="https://assets-image.oceasfe.com/public/upload/image/20240504/730b185009f111ef9a13a9f0521ccd90.png">

上图需要打开Performance Overlay

- max 表示每桢的最大渲染时间
- Avg 表示每帧的平均渲染时间

总之，构建、布局、绘制和合成是 Flutter 渲染流程中的核心步骤，它们共同决定了应用的界面如何呈现给用户。此外，事件处理和交互也是确保良好用户体验的重要方面。



有以上基础后，我们顺势去探究setState的源码以及flutter的更新机制

## setState

思考下，以下代码的num最终会是多少？为什么这么问，因为在react中，在批量更新条件下多次setState只会更新一次，里面的回调函数是异步执行的，最终输出为1，页面渲染为3。那在flutter中呢？

```dart
int num = 1;
setState(() {
  num++;
});
setState(() {
  num++;
});
print(num);
```

flutter连续执行2次setState,内部的函数是同步执行的，所以变量为3，最终渲染到页面也是3。其实思想都大体一致，就在于回调函数执行的时机。

我们来研究一下flutter的setState，点进去可以大致看一下，以下为核心代码

```dart
@protected
void setState(VoidCallback fn) {
  // 省略异常处理代码
  final Object? result = fn() as dynamic;
  _element!.markNeedsBuild();
}
```

可以看到，setState的回调函数是同步执行的，所以我们在使用的过程中不能传入async函数。

这里的_element就是element树，断点打到这里，细看一下有什么属性：

- _parent  父级element
- _child     子级element
- _sort     排序
- _widget   当前widget信息
- _owner   管理元素声明周期的对象
- _dirty  标记该element是否是脏的，需要重新build
- _inDirtyList  是否在脏列表中 防重复
- _state  当前widet的state对象，里面同时挂载了state对应的widget、element

接着看`markNeedsBuild`，这个方法的意思就是标记需要构建

```dart
void markNeedsBuild() {
  // ...
  if (dirty) {
      return;
  }
  _dirty = true;
  owner!.scheduleBuildFor(this);
}

class BuildOwner{
  void scheduleBuildFor(Element element) {
    // ...
    if (!_scheduledFlushDirtyElements && onBuildScheduled != null) {
      _scheduledFlushDirtyElements = true;
      onBuildScheduled!();
    }
    _dirtyElements.add(element);
    element._inDirtyList = true;
  }
}
```

markNeedsBuild会将该element标记为脏的，BuildOwner这个类用来跟踪哪些widgets需要重新build，`scheduleBuildFor 是把一个 element 添加到 _dirtyElements 数组，以便在下一桢`WidgetsBinding.drawFrame`中调用 buildScope 的时候能够重构 element。

我们在`onBuildScheduled`方法上打个断点，断点进去后进入到`_handleBuildScheduled`，里面执行了`ensureVisualUpdate`，进入到这个方法中，这个方法在scheduler/binging.dart中

```dart
void ensureVisualUpdate() {
    switch (schedulerPhase) {
      case SchedulerPhase.idle:  // 任务 微任务 定时器回调
      case SchedulerPhase.postFrameCallbacks: // 处理下一帧的清理和工作计划
        scheduleFrame();
        return;
      case SchedulerPhase.transientCallbacks: // 动画回调
      case SchedulerPhase.midFrameMicrotasks: // 处理瞬态回调期间安排的微任务 
      case SchedulerPhase.persistentCallbacks: // 构建/布局/绘制 回调
        return;
    }
  }

```

schedulerPhase枚举值介绍 ： https://api.flutter-io.cn/flutter/scheduler/SchedulerPhase.html

进入到`scheduleFrame`

```dart
void scheduleFrame() {
  ensureFrameCallbacksRegistered();
  platformDispatcher.scheduleFrame();
  _hasScheduledFrame = true;
}
```

platformDispatcher.scheduleFrame这里就是回调C++注册Vsync信号，等到信号来临后，再通知framework进行渲染，执行drawFrame，这里也验证了我们上面讲到的渲染流程，这里总结下：dart发起更新，通过C++回调到Native层，注册一次Vsync监听，信号来临后，通知dart渲染。这样避免被动的等待Vsync信号通知，当一些静态页面，整个屏幕不会多次渲染。

当下一次 VSync 信号的到来时会执行 WidgetsBinding 的 handleBeginFrame() 和 handleDrawFrame() 来更新 UI（WidgetsBinding 是 Flutter Framework 与 Engine 通信的桥梁）。

- handleBeginFrame 主要处理动画状态的更新，然后执行 microtasks，因此自定义微任务的执行会影响渲染速度。
- handleDrawFrame 执行一帧的重绘管线，即 build -> layout -> paint。

 看build，WidgetsBinding 中 drawFrame： 

```dart
@override
void drawFrame() {
  if (rootElement != null) {
    buildOwner!.buildScope(rootElement!);
  }
  super.drawFrame();
  buildOwner!.finalizeTree();
}
```

通过buildScope这个方法去重新build，我们接着看这个方法

```dart
// framework.dart
void buildScope(Element context, [ VoidCallback? callback ]) {
   // 排序 
    _dirtyElements.sort(Element._sort);
   int dirtyCount = _dirtyElements.length;
   int index = 0;
   while (index < dirtyCount) {
    final Element element = _dirtyElements[index];
    element.rebuild();
   }
  
  //... 
  for (final Element element in _dirtyElements) {
    element._inDirtyList = false;
  }
  _dirtyElements.clear();
  _scheduledFlushDirtyElements = false;
	}
}
```

 首先将_dirtyElements进行排序，这是因为节点可能有很多个， 如果其中两个节点存在级联关系，父级的Widget build操作必然会调用到子级的Widget build，如果子级又自己build一次，相当于出现了重复操作，通过排序就会避免这个问题。

遍历脏数组，依次执行element.rebuild，执行完之后再清空脏数组，恢复节点状态

rebuild方法又调用了performRebuild，这里注意是重写的那个performRebuild

```dart
@override
@pragma('vm:notify-debugger-on-exception')
void performRebuild() {
	super.performRebuild(); // 清除dirty：_dirty = false;
	_child = updateChild(_child, built, slot);
}
```

走到这，是不是要开始diff了？接着往下看：

```dart
@protected
@pragma('vm:prefer-inline')
Element? updateChild(Element? child, Widget? newWidget, Object? newSlot) {
   bool hasSameSuperclass = true;
  final int oldElementClass = Element._debugConcreteSubtype(child);
  final int newWidgetClass = Widget._debugConcreteSubtype(newWidget);
  // hasSameSuperclass 代表是否是相同的widget的类型 比如从StatelessWidget变为StatefullWidget
  hasSameSuperclass = oldElementClass == newWidgetClass;
 
  
  // 两个widget相同
	if (hasSameSuperclass && child.widget == newWidget) { 
    if (child.slot != newSlot) {
      updateSlotForChild(child, newSlot);
    }
    newChild = child;
  } else if (hasSameSuperclass && Widget.canUpdate(child.widget, newWidget)) {
     child.update(newWidget); // 更新widget element不变更
     newChild = child;
  } else{
     deactivateChild(child);
     newChild = inflateWidget(newWidget, newSlot); // 子节点新增 删除之前的 重新创建widget、element
  } 
}

// canUpdate 判断是不是相同的widget
static bool canUpdate(Widget oldWidget, Widget newWidget) {
  return oldWidget.runtimeType == newWidget.runtimeType
      && oldWidget.key == newWidget.key;
}
```

执行`child.update`，如果是StatelessElement则直接重建子widger

如果是StatefulElement，会先回调我们自己在widget中声明的didUpdateWidget函数，传入oldWidge参数，可以理解为vue的watch

```dart
@override
void update(StatefulWidget newWidget) {
  super.update(newWidget);
  final StatefulWidget oldWidget = state._widget!;
  state._widget = widget as StatefulWidget;
  final Object? debugCheckForReturnedFuture = state.didUpdateWidget(oldWidget) as dynamic;
  rebuild(force: true);
}
```

如果是Column、Row等有children的widget组件， `child.update`方法，则会调用 `updateChildren`，内部循环调用`updateChild`方法。可以看到，不同的child（element），执行child.update调用的方法都不一样，因为各自element重写了update方法，比如SingleChildRenderObjectElement、MultiChildRenderObjectElement等，这就是面向对象编程的多态形式

```dart
@override
void update(MultiChildRenderObjectWidget newWidget) {
  _children = updateChildren(_children, multiChildRenderObjectWidget.children, forgottenChildren: _forgottenChildren);
}
```

这个updateChildren就是flutter的diff算法了。

### diff算法

```dart
@protected
List<Element> updateChildren(List<Element> oldChildren, List<Widget> newWidgets) {
	int newChildrenTop = 0;
  int oldChildrenTop = 0;
  int newChildrenBottom = newWidgets.length - 1;
  int oldChildrenBottom = oldChildren.length - 1;
  
  // 1. 从头开始遍历，更新节点
  while ((oldChildrenTop <= oldChildrenBottom) && (newChildrenTop <= newChildrenBottom)) {
    if (oldChild == null || !Widget.canUpdate(oldChild.widget, newWidget)) {
      break;
    }
  	final Element newChild = updateChild(oldChild, newWidget, slotFor(newChildrenTop, previousChild))!;
    newChildrenTop += 1;
    oldChildrenTop += 1;
  }
  
  // 2. 从尾开始遍历，不更新，放到后面更新 这么做flutter只是想按顺序更新所有的节点
  while ((oldChildrenTop <= oldChildrenBottom) && (newChildrenTop <= newChildrenBottom)) {
      final Element? oldChild = replaceWithNullIfForgotten(oldChildren[oldChildrenBottom]);
      final Widget newWidget = newWidgets[newChildrenBottom];
      assert(oldChild == null || oldChild._lifecycleState == _ElementLifecycle.active);
      if (oldChild == null || !Widget.canUpdate(oldChild.widget, newWidget)) {
        break;
      }
      oldChildrenBottom -= 1;
      newChildrenBottom -= 1;
    }
  
  // 3. 扫描中间区域 为old children生成key Map映射  
   Map<Key, Element>? oldKeyedChildren;
    if (haveOldChildren) {
      oldKeyedChildren = <Key, Element>{};
      while (oldChildrenTop <= oldChildrenBottom) {
        final Element? oldChild = replaceWithNullIfForgotten(oldChildren[oldChildrenTop]);
        assert(oldChild == null || oldChild._lifecycleState == _ElementLifecycle.active);
        if (oldChild != null) {
          if (oldChild.widget.key != null) {
            oldKeyedChildren[oldChild.widget.key!] = oldChild;
          } else {
            deactivateChild(oldChild);
          }
        }
        oldChildrenTop += 1;
      }
    }
  
  // 4. 更新中间区域 
  while (newChildrenTop <= newChildrenBottom) {
      Element? oldChild;
      final Widget newWidget = newWidgets[newChildrenTop];
      if (haveOldChildren) {
        final Key? key = newWidget.key;
        if (key != null) {
          oldChild = oldKeyedChildren![key];
          if (oldChild != null) {
            if (Widget.canUpdate(oldChild.widget, newWidget)) {
              // 相同key 则需要从oldKeyedChildren中移除
              oldKeyedChildren.remove(key);
            } else {
              // 没有和old children中匹配的key 则把oldChild设置为null,下面只需要创建newWidget即可
              oldChild = null;
            }
          }
        }
      }
      final Element newChild = updateChild(oldChild, newWidget, slotFor(newChildrenTop, previousChild))!;
      newChildren[newChildrenTop] = newChild;
      previousChild = newChild;
      newChildrenTop += 1;
    }
  
  // 到此 已经扫描了所有列表 现在只剩bottom区域没有更新
  
  // 5. 更新bottom区域
  while ((oldChildrenTop <= oldChildrenBottom) && (newChildrenTop <= newChildrenBottom)) {
      final Element oldChild = oldChildren[oldChildrenTop];
      final Widget newWidget = newWidgets[newChildrenTop];
      final Element newChild = updateChild(oldChild, newWidget, slotFor(newChildrenTop, previousChild))!;
      newChildren[newChildrenTop] = newChild;
      previousChild = newChild;
      newChildrenTop += 1;
      oldChildrenTop += 1;
    }
  
  // 6. 在第4步中我们已经复用了key相同的节点，剩下的节点就从旧列表中清除。
  if (haveOldChildren && oldKeyedChildren!.isNotEmpty) {
      for (final Element oldChild in oldKeyedChildren.values) {
        if (forgottenChildren == null || !forgottenChildren.contains(oldChild)) {
          deactivateChild(oldChild);
        }
      }
    }
}
```

从新旧子列表的头部和尾部开始对每一个 widget 的运行时类型和 key 进行匹配，这样就可能找到在两个列表中间所有不匹配子节点的（非空）范围。然后框架将旧子列表中该范围内的子项根据它的 key 放入一个哈希表中。接下来，框架将会遍历新的子列表以寻找该范围内能够匹配哈希表中的 key的子项。无法匹配的子项将会被丢弃并从头开始重建，匹配到的子项则使用它们新的 widget 进行重建。flutter中引入了globalKey，这种可以跨层级来复用。

diff的原理大致都差不多，最终的目的就是为了复用、精准化操作一些昂贵的、代价很大的东西，在flutter中，element是非常昂贵的，因为 element 拥有两份关键数据：Stateful widget 的状态对象及底层的渲染对象。当框架能够重用 element 时，用户界面的逻辑状态信息是不变的，并且可以重用之前计算的布局信息，只需要更新 RenderObject 的属性，而不需要重新创建和布局整个 RenderObject。这样就避免了不必要的布局和绘制计算，提高了性能。



### Layout-Paint

当 build 流程结束后，Element 的脏状态就清理完了，Widget Tree 和 Element Tree 的状态达到最新，后续就是Layout-Paint流程了。需要更新的 RenderObject 元素全部会被添加到 **PipelinOwner** 的 _nodesNeedingLayout 集合中，执行flushLayout，它将会自顶而下的遍历这些元素，进行测量和布局，最后调用 markNeedsPaint 方法将 RenderObject 标记为需要重绘，最后在 flushPaint 过程中将会对所有 needPaint 的元素进行重绘，将绘制命令记录到 Layer 中，同步 Layer Tree 信息。到此是UI线程生成Layer Tree的过程。再后续就是我们上面讲到的Raster。

> BuildOwner 是负责处理 rebuild 流程相关的脏 Element
> PipelinOwner 负责后续的绘制流水线

```dart
mixin RendererBinding on BindingBase, ServicesBinding, SchedulerBinding, GestureBinding, SemanticsBinding, HitTestable {
  @protected
  void drawFrame() {
    assert(renderView != null);
    // 调用 RenderView.performLayout()，遍历子节点，子节点在widget.updateRenderObject已经加入到列表内
    // 调用每个节点的 layout()，RenderObject的排版数据，使得每个RenderObject最终都能有正确的大小和位置
    pipelineOwner.flushLayout();
    // 更新渲染对象，此阶段每个渲染对象都会了解其子项是否需要合成
    // 在绘制阶段使用此信息选择如何实现裁剪等视觉效果
    pipelineOwner.flushCompositingBits();
    // 会调用 RenderView.paint() 最终触发各个节点的 paint()，最终生成一棵Layer Tree，并把绘制指令保存在Layer中
    pipelineOwner.flushPaint();
    if (sendFramesToEngine) {
       // 把Layer Tree提交给GPU 
      renderView.compositeFrame(); 
      pipelineOwner.flushSemantics(); // this also sends the semantics to the OS.
      _firstFrameSent = true;
    }
  }
}
```

到此setState的流程就差不多结束了，当我们调用一次setState，它会重新构建当前整个 `Widget` 树，这会带来性能损耗；其次，由于整个 `Widget` 树改变了，意味着整棵树对应的渲染层`Element`对象都会执行 `update`方法，虽然不一定会重新渲染，但是这整棵树的遍历的性能开销也很高。所以，虽然我们只是调用这一行代码，但其内部执行的调用栈是非常多的，那如果你能掌握这些流程，也就能针对处理相关问题做性能优化。

##### 对比react

flutter的状态更新借鉴的是React 16之前的版本，那我们可以对比下在react16之前中调用setState。react中的类组件，调用setState，会判断当前组件是否处于批量更新过程，否则将当前组件的实例放到dirtyComponent。当处于批量更新条件下，则循环dirtyComponents更新组件，并执行setState中设置的callback。那整个过程是不可中断，也容易导致性能问题。

```react
function enqueueUpdate(component) {
  // 如果没有处于批量创建/更新组件的阶段，则处理update state事务
  if (!batchingStrategy.isBatchingUpdates) {
    batchingStrategy.batchedUpdates(enqueueUpdate, component);
    return;
  }
  // 如果正处于批量创建/更新组件的过程，将当前的组件放在dirtyComponents数组中
  dirtyComponents.push(component);
}
```



## flutter-hooks

> <a href="https://pub.dev/packages/flutter_hooks">文档</a>

因为借鉴的react，所以在react16.8出了hooks之后，也希望在flutter中使用hooks，也是可以的，安装依赖库就可以直接使用了，下面演示useState的使用

```dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StateHooksExample extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final counter = useState<int>(0);
    return Column(
      children:[
          Text(counter.value.toString()),
          FloatingActionButton(
            onPressed:() => counter.value++,
            child: const Icon(Icons.add),
          ),
      ],
    );
  }
}
```

可以看到，在引入hooks之后，代码非常简洁，对比下和原生的计数器的区别

- 原生需要使用`StatefulWidget`维护状态，useState使用的是HookWidget（内部还是StatefulWidget）
- 原生需要调用setState, useState直接设置值

是不是有点像vue中直接设置值触发页面更新，这里的hooks还是和react中相差很大，我们可以看下内部的大致实现

```dart
ValueNotifier<T> useState<T>(T initialData) {
  return use(_StateHook(initialData: initialData));
}

class _StateHook<T> extends Hook<ValueNotifier<T>> {
  const _StateHook({required this.initialData});

  final T initialData;

  @override
  _StateHookState<T> createState() => _StateHookState();
}
```

useState接收一个泛型，返回`ValueNotifier<T>` ，ValueNotifier这个类实现了get和set value的方法，所以在使用useState后，需要.value才能拿到值，在vue3中ref也是这样实现，都需要.value。

```dart
class _StateHookState<T> extends HookState<ValueNotifier<T>, _StateHook<T>> {
  late final _state = ValueNotifier<T>(hook.initialData)
    ..addListener(_listener);
  @override
  ValueNotifier<T> build(BuildContext context) => _state;

  void _listener() {
    setState(() {});
  }
}
```

很显然，在监听到值修改后，调用了setState触发更新，万变不离其宗，最终还是需要走到原生的更新方法。

还有常用的useEffect、useReducer等hooks，感兴趣可以自行去了解，用法和react的hooks大致一致。

除了以上hooks，Flutter Hooks还提供了像useScrollController，用于控制可滚动的部件如`ListView`、`ScrollView`等，允许开发者监听滚动事件、控制滚动位置等。使用`useScrollController`可以让你以更声明式的方式来管理滚动相关的逻辑，同时在组件销毁时自动处理资源的释放，从而简化代码并提高可维护性，这也是hook带来的好处。

但是此hooks还是写在类组件中，随着功能增加类组件也会变得越来越臃肿，类组件代码维护成本也比较高



## Getx

> <a href="https://pub.dev/packages/get">文档</a>

GetX 是 Flutter 的超轻量级和强大解决方案。它结合了高性能状态管理、智能依赖注入和路由管理，快速实用。我们的项目中都使用了Getx，所以必须掌握。

##### Router定义

```dart
GetMaterialApp(  
  initialRoute: "/home",  
  unknownRoute: GetPage(name: "/404", page: () => const NotFoundPage()), 
  routingCallback: (routing) { ... } //相当于跳转的监听器
  getPages: [  
    GetPage(name: "/home", page: ()=> const HomePage()),  
    GetPage(name: "/detail", page: ()=> OneDetailPage()),
  ]
)
```

- `initialRoute`是首页是哪个

- unknownRoute`是没找到对应的页面时, 就去这个页面

- `getPages`定义路由表。注意page都是函数, 这样就能做到懒加载

- `routingCallback`是跳转的监听器,  当你跳转到下一页, 或是按back等会调用它

##### 跳转 参数

```dart
Get.to(NextScreen());  
Get.toName("/detail"); //比起to(), 一般使用toNamed()

// 跳转时带参数 
Get.toNamed("/router/back/p3?id=100&name=flutter")

// 用detail页来replace掉本页
Get.offNamed("/detail"); 

// 使用场景: 当点了"logout"按钮时, 清除所有页, 再跳到login页去
Get.offAllNamed("login"); //类似Android中的clear_task | new_task

// 后退
Get.back();
```

参数处理

```dart
Get.toNamed("/detail", arguments: '这是一个字符串参数'); 
// print(Get.arguments); // output: 这是一个字符串参数  可以传递任何类型的参数


Get.offAllNamed("/detail?device=phone&id=111&name=liang");
// print(Get.parameters['id']); // output: 111
// print(Get.parameters['name']); // output: liang

// 动态路由
GetPage(
  name: '/detail/:id', 
  page: () => Detail(),
),
Get.toNamed("/detail/1");

print(Get.parameters['id']); // out: 1
```

##### 响应式状态

- 如何声明
  ```dart
  // Rx{Type}
  final name = RxString(''); 
  
  // 泛型声明
  final name = Rx<String>(''); 
  
  // .obs
  final name = ''.obs;
  ```

  

- 如何使用

  1. 基于Obx

  ```dart
  // 1. 声明 HomeController 可以写到一个专门管理控制器的文件中，这样方便维护
  class HomeController extends GetxController {
    var count = 0.obs;
    increment() => count++; // 直接修改值
  }
  // 2. 引入Controller并使用  
  class Home extends StatelessWidget {
    const Home({super.key});
    @override
    Widget build(BuildContext context) {
      // 寻找Controller
    	HomeController controller = Get.find<HomeController>();
      return ElevatedButton(
        // 通过`c.count.value`使用状态，也可以不使用.value，.value可选的
        child: Obx(() => Text("${controller.count}")),
        onPressed: () => controller.increment(), // 改变状态
      );
    }
  }
  ```

  2. 基于GetBuilder<Controller>

  ```dart
  // 1.声明
  class HomeController extends GetxController {
    var count = 0;
    increment(){
      count++;
      update(); // 手动调用刷新
    };
  }
  // 2.导入
  class HomeBinding extends Bindings {
    @override
    void dependencies() {
      Get.lazyPut<HomeController>(
        () => HomeController(),
      );
    }
  }
  GetPage(
      name: _Paths.homeView,
      page: () => const HomeView(),
      binding: HomeBinding(),
  )
  
  // 3.使用
  class HomeView extends StatelessWidget {
    const HomeView({Key? key}) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      return GetBuilder<HomeController>{
        builder: (controller) {
          return ElevatedButton(
            child: const Text("${controller.count}"),
            onPressed: () => controller.increment(), // 改变状态
          ),
        },
      );
    }
  }
    
  ```

  如果需要精准更新某个widget的状态，可以给GetBuilder设置id属性
  
  ```dart
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>{
      id:'home',
      builder: (controller) {
        return ElevatedButton(),
      },
    );
  }
  ```
  
  在其他地方调用`update(['home'])`就只更新此widget。这也是作为性能优化的常规手段，往往我们只需要更新一小部分区域的状态时，不需要在外部组件调用setState，因为那会从外部widget开始递归遍历，虽然有diff，如果层级很深的话也会造成性能的浪费，因为我们明明知道只更新这小部分就行了。

​	可以看到，不管是上面的Obx还是GetBuilder，应该都是用的发布订阅模式，如果熟悉vue的话，我们声明的Obx，完	全就能映射到vue2中的watcher、vue3中的effect，只不过vue内部都以组件为粒度自动处理了，在flutter中，我们可	以自定义更新区域。



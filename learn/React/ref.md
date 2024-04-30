# ref
## 类组件获取ref
1. 字符串
2. 函数  1 2都是当dom创建的时候执行回调函数 第一个参数传入  ref传递到
3. createRef

## forwardRef 转发ref
解决ref不能跨层级捕获和传递，forward接受父级元素的ref，转发到子组件

## 组件通信
1. 类组件可以直接通过ref获取到组件实例
2. 函数组件 forwardRef useImperativeHandle  函数组件没用实例，得转发ref
useImperativeHandle 一方面第一个参数接受父组件传递的 ref 对象，另一方面第二个参数是一个函数，函数返回值，作为 ref 对象获取的内容

## ref原理
对于 Ref 处理函数，React 底层用两个方法处理：commitDetachRef（dom更新前后） 和 commitAttachRef 

只有含有ref tag 才会更新ref: fiber初始化和fiber更新并且ref指向变了 会更新ref

# 组件通信
1. props
2. ref
3. context
4. redux mobex

# 生命周期
### 挂载卸载
constructor
componentWillMount
componentDidMount
componentWillUnmount 

## 更新
componentWillReceiveProps 父组件改变props
shouldComponentUpdate 性能优化
componentWillUpdate  
componentDidUpdate

## 错误捕获
componentDidCatch

## 性能优化
shouldComponentUpdate
PureComponent



# hooks

## useEffect
异步执行 是在浏览器绘制视图之后。对于 useEffect 执行， React 处理逻辑是采用异步调用 ，对于每一个 effect 的 callback， React 会向 setTimeout回调函数一样，放入任务队列，等到主线程任务完成，DOM 更新，js 执行完成，视图绘制完毕，才执行。所以 effect 回调函数不会阻塞浏览器绘制视图。
 
## useLayoutEffect  
同步执行 是在浏览器绘制视图之前。useLayoutEffect 会在 DOM 更新之后，浏览器绘制之前，同步调用 callback，并且在 callback 执行期间，会阻塞浏览器绘制，造成卡顿。

## useEffect 和 useLayoutEffect 的区别

DOM mutation次数一样

- useEffect 是在渲染结束后执行副作用操作，useLayoutEffect 是在 DOM 更新后，浏览器绘制之前，执行副作用操作。
- useEffect 执行会异步调用，useLayoutEffect 执行会同步调用。
- useEffect 执行会晚于 useLayoutEffect 执行。
- useLayoutEffect 批量更新，代码里请求了多次更新，只会更新一次

同步执行  dom更新之后，浏览器绘制之前 这样可以方便修改dom ，因为callback同步执行，会阻塞浏览器绘制
执行过程： render commit layout [useLayoutEffect] paint [useEffect] 。。。


## React 内部如何区别 useEffect 和 useLayoutEffect ，执行时机有什么不同
react使用不同的EffectTag标记，在commit阶段通过标识符区分

大部分情况

## useInsertionEffect 18
### 解决CSS-in-JS 的问题
为组件动态生成一个css选择器，插入到head，动态生成的 CSS 选择器会有一小段哈希值来保证全局唯一性来避免样式发生冲突
useInsertionEffect 的执行在 DOM 更新前，所以此时使用 CSS-in-JS 避免了浏览器出现再次重回和重排的可能，解决了性能上的问题。
如果使用useLayoutEffect可能造成再次重会和重排

## 执行顺序
子useInsertionEffect ==》 父useInsertionEffect ==》 子useLayoutEffect ==》 父useLayoutEffect ==》 子useEffect ==》 父useEffect

# hooks 原理

hooks是函数组件和fiber的桥梁，对应3种形态，每个对象会实现useState等方法
1. 报错形态 在外部调用
2. mount 初始化
3. update 更新 

执行顺序 updateFunctionComponent ==》 renderWithHooks
执行每个函数之前，会绑定ReactCurrentDispatcher.current，区分是2 还是3形态 函数执行完后，会把current至为第三种形态。和获取vue的实例一样，只能在setup中调
## 调和
1. 类组件，memoizedState保存state信息，函数组件，保存hook
2. updateQueue存放useEffect产生的副作用组成的链表 在commit阶段更新
3. 绑定ReactCurrentDispatcher.current
4. hooks执行
5. hooks内部为什么能读取当前fiber  在renderWithHooks内部使用闭包缓存了当前fiber

## hooks初始化 与fiber建立联系

每个hook执行会产生一个hooks对象，这个对象保存当前的hooks信息，还有next指向下一个hooks对象。 workInProgressHook.next = hook;
		workInProgressHook = hook;
## hooks更新
首先会取出workInProgres.alternate 里面对应的 hook ，然后根据之前的 hooks 复制一份，

## 状态派发
执行hooks,保存state,创建queue（更新信息），创建一个dispatch更新函数，这个更新函数是dispatch.bind 绑定了fiber queu。

接下来执行更新函数：
每次setState,会创建一个update 放到hooks的pending队列中，判断如果当前fiber正在更新就不更新，反之比较两个state，不相等就调度更新fiber

## 副作用


## meno
当某个组件因为自己的内部状态发生变化而重渲染的时候，以它自己为根节点的组件子树上的所有子孙组件默认都会被迫进行重渲染。即使，该子孙组件的 props 和 state 没有发生变化的变化。这种重渲染，我们是称之为「被迫的，不必要的重渲染」 使用了之后会浅比较 Object.is -- 一个不为





































# 事件合成
当发生一次点击事件，React 会根据事件源对应的 fiber 对象，根据 return指针向上遍历，收集所有相同的事件，比如是 onClick，那就收集父级元素的所有 onClick 事件，比如是 onClickCapture，那就收集父级的所有 onClickCapture。得到了dispatchQueu后，需要执行事件，
如果是捕获阶段执行的函数，那么 listener 数组中函数，会从后往前执行，如果是冒泡阶段执行的函数，会从前往后执行，用这个模拟出冒泡阶段先子后父，捕获阶段先父后子。

初始化       事件收集       事件执行
1. 事件初始化 事件合成  捕获 冒泡容器绑定事件
2. 对一些特殊事件做预处理
3. 第一次执行捕获 第二次冒泡





















































# 调和 递归+ work loop
一个while循环，对每个节点进行work,为以下两个阶段，

## 递 begin work
采用深度优先遍历算法自上而下遍历element树 创建全新的fiber，child和return实现父子关系，最后把这个fiber返回
针对不对的fiber 计算他的子树不一样 
1. 如果是跟 就是跟的element
2. 如果是component 就是他的type函数执行
3. 如果是class 就是他的render
4 如果是host component 就是children

## 归 complete work
work loop 会对当前的 workInProgress 进行 complete work。当前的 workInProgress 一旦结束了 complete work, work loop 会检查当前的 workInProgress 是否有兄弟节点，有的话，那么就会对它的兄弟节点进行新的一轮 work loop。
当子级上的所有的子 fiber 节点都走完了 complete work 阶段，那么 work loop 就会对它们的父 fiber 节点进行 complete work。以此类推，work loop 会以「先是从左到右，后是从下到上」的方向对新建的 fiber 节点进行 complete work，直至回到 hostRootFiber





































# vue vs reavt
相同：
- vdom 
- 组件化
- 虚拟dom
- 数据驱动视图
- 生命周期
- 组件通信
- 路由
- 状态管理

不同：
- vue 双休数据绑定 单数据流
- vue watcher    调和
- 模版
- hoc 
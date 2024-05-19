// 时间   ===========》
// 2个月 保证全链路流程走通 而不是半成品状态
// 预计一个半月完成 剩下半个月试验阶段 走通之后正式上试玩环境

// 目标   支持 全赛种 全赛制 全玩法 全code码  赛事重播 调试的一个中间件
// 需求背景
// 商户对接我们自己API接口时,通常接口都是正常情况.不会遇到请求不通或者返回错误 都会返回正常所属的成功code码或者通用的成功code码。
// 但是通常商户对接时接口也会出现接口返回各种错误状态码等信息，商户不明白怎么样去处理应对 
// 因此需要做一个 商户跟我们对接文档 调试的中间件后台


// 需求目标
// 对外API对接文档 新增一个tab页 商户对接api调试页面
// 商户可以选择需要调试的 常规玩法 还是 虚拟 还是电竞等===》再去选择相对应的球类 如足球 篮球等球类 ，
// 每个球类下都会有相对应的 赛事 以及对应的各种玩法
// 然后商户选择相对应的赛事切片去进行调试
// 可选择相对应的接口，以及要返回的 接口状态码 ，并返回展示给商户


// 后台界面 
// code 码 有分组概念 通用的 不通用的  那个服务下的

// 服务层面
// 赛事重播
// 赛事切片 拿一个用户token 跟一个赛事id 去生产监听赛事的信息 4秒一次拉取信息 https ws建立通道  一直监听赛事直至结束
//  一般直接设定监听3小时就基本结束 
//  每一次拿到信息做入库 ，每一条生成一个唯一的监听id

// ===============================================================================================
//  请求我们mock数据接口
//  code 打标签 分组
//  玩法管理 玩法管理 pb加密 解密 


// 支持 全赛种 全赛制 全玩法 全code码  赛事重播 调试的一个中间件
// 足球
//     赛事
//         玩法
//             // java 接口给提供的错误提示
//             { code: 300, jie_jue_fang_shi: '请求超时，稍后刷新' }
//             { code: 400, jie_jue_fang_shi: '请求超时，稍后刷新' }
//             { code: 500, jie_jue_fang_shi: '请求超时，稍后刷新' }



/* ------------------------------------------------------------------------------------------------ */



/**
 * 赛种表
 */
race = [
    // {
    //     name: String,       // 赛种名称
    //     create_at: Date,    // 创建时间
    //     update_at: Date,     // 更新时间
    // },
    { name: '足球', create_at: '', update_at: '' },
    { name: '篮球', create_at: '', update_at: '' },
]

/**
 * 赛制（赛事）表
 */
competition = [
    // {
    //     name: String,    // 赛事名称
    //     race_id: String, // 赛种ID
    //     create_at: Date, // 创建时间
    //     update_at: Date, // 更新时间
    // },
    { name: '韩国K2联赛', race_id: 'id', create_at: '', update_at: '' },
    { name: '日本J2联赛', race_id: 'id', create_at: '', update_at: '' },
]

/**
 * 玩法表
 */
play = [
    // {
    //     name: String,            // 玩法
    //     competition_id: String,  // 赛事ID
    //     create_at: Date,         // 创建时间
    //     update_at: Date,         // 更新时间
    // },
    { name: '15分钟', competition_id: 'id', create_at: '', update_at: '' },
    { name: '波导', competition_id: 'id', create_at: '', update_at: '' },
    { name: '角球', competition_id: 'id', create_at: '', update_at: '' },
]

/**
 * 状态码
 * 
 * 用于收集 java 后端给的所有状态码
 */
status_code = [
    // {
    //     code: Number,        // 状态码
    //     msg: String,         // 状态码消息
    //     play_id: String,     // 玩法ID
    //     is_common: Boolean,  // 是否通用
    //     create_at: Date,     // 创建时间
    //     update_at: Date,     // 更新时间
    // },
    { code: 300, msg: '请求超时，稍后刷新', play_id: '', is_common: false, create_at: '', update_at: '' },
    { code: 400, msg: '请求超时，稍后刷新', play_id: '', is_common: false, create_at: '', update_at: '' },
    { code: 500, msg: '请求超时，稍后刷新', play_id: '', is_common: false, create_at: '', update_at: '' }
]

// 通用/公用 code， 状态码表中用 is_common 代替
// common_code = [
//     { id: '', code: '', name: '', mark: '', create_at: '', update_at: '' }
// ]


/**
 * 响应状态码记录表
 * 
 * 4秒记录一次的赛事接口返回数据
 * 注意：该表用户可以手动添加数据（在 admin 端）
 * 
 * 写 seeders ，监听一个赛事3小时，收集数据（token、赛事ID）
 * 
 * 列表，详情 两个类型的接口
 * 
 * 发起时间
 * 回来时间
 * 
 */
response_code_record = [
    // {
    //     id: String,              // 记录 ID
    //     type: String,            // 请求类型， http / ws
    //     code: Number,            // 响应码
    //     data: Object,            // 响应参数
    //     msg: String,             // 响应消息
    //     race_id: String,         // 赛种 ID
    //     competition_id: String,  // 赛事 ID
    //     play_id: String,         // 玩法 ID
    //     create_at: Date,         // 创建时间
    // },
]


// code 码管理
// code 码标签管理
// 接口管理：关联标签
// 赛事管理：赛事、赛种  【ws，http】  【列表（6/13）、详情】
// 赛事名称、赛种名称

// 切片管理：关联多表（状态、和数据本身需要分表） 6张表*2

// 客户端：接口拦截设置（消息体自定义设置），赛事重播

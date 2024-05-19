1. 导航

- 什么时候现实收藏
- 什么时候显示全部
- 什么时候显示电竞VR体育，电竞VR体育的位置
- 最后一个娱乐为什么不显示 匹配 id 匹配到的时候显示
- 联赛id跟列表传参id怎么对应

先去 全部联赛列表里面找到对应的联赛的 tid，然后在去拉接口。（热门联赛）

热门：

- 中 英 繁体。

列表：

0. mmp ms = 1 110 才匹配（已开赛的）其他直接显示时间。

1. 列表怎么分组的
2. 比分怎么展示的（滚球展示,）
2. 新手版的怎么展示的 (只显示赌赢的)

3. 联赛名称 后面 红色1（红黄牌，

4. flag 展示规则
5. 角球等等

```agsl
import { i18n_t } from "src/boot/i18n.js";
export const play_title = (title = 'coming song') => {
  return [
    { // 角球
      title: i18n_t('football_playing_way.corner'),
      id:1,
      unfold:0,
      show_tab:false,
      hps:[{
        hl:[{}]
      }],
      pids:'-111,113,-114,-119,-121,-122',
      hps_key:'hpsCorner',// 角球
      play_id:1001,
    },
    {  // 十五分钟玩法
      title: i18n_t('football_playing_way.hps15Minutes'),
      id:17,
      unfold:0,
      show_tab:false,
      hps15Minutes:[{
        hl:[{}]
      }],
      pids:'32,33,34,231,232,233',
      hps_key:'hps15Minutes',// 15分钟
      play_id:1007,
    },
    { // 波胆
      title: i18n_t('football_playing_way.hpsBold'),
      id: 18,
      unfold:0,
      show_tab:false,
      hps:[{
        hl:[{}]
      }],
      pids: "7",
      hps_key:'hpsBold',
      play_id:1008,
    },
    { // 特色组合
      title: i18n_t('football_playing_way.feature'),
      id: 11,
      unfold:0,
      show_tab:false,
      hps:[{
        hl:[{}]
      }],
      pids: "13,101,345,105",
      hps_key:'hpsCompose',
      play_id:1010,
    },
    {// 罚牌
      title: i18n_t('football_playing_way.penalty_cards'),
      id:5,
      unfold:0,
      show_tab:false,
      hps:[{
        hl:[{}]
      }],
      pids:'310,306,307,311,308,309',
      hps_key:'hpsPunish',// 罚牌
      play_id:1003,
    },
    {// 晋级
      title: i18n_t('football_playing_way.promotion'),
      id:3,
      unfold:0,
      show_tab:false,
      hps:[{
        hl:[{}]
      }],
      pids:'-135,-136',
      hps_key:'hpsPromotion',
      play_id:1005,
    },
    // 冠军
    {
      title: i18n_t('football_playing_way.champion'),
      id:30,
      unfold:0,
      show_tab:false,
      hps:[{
        hl:[{}]
      }],
      pids:'136',
      hps_key:'hpsOutright',
      play_id:1006,
    },
    // 加时
    {
      title: i18n_t('football_playing_way.overtime'),
      id:4,
      unfold:0,
      show_tab:false,
      hps:[{
        hl:[{}]
      }],
      pids:'-126,-128,-127,-129,-130,-332',
      hps_key:'hpsOvertime', 
      play_id:1002,
    },
    // 点球大战
    {
      title: i18n_t('football_playing_way.penalty_shootout'),
      id:2,
      unfold:0,
      show_tab:false,
      hps:[{
        hl:[{}]
      }],
      pids:'-333,-334,-335',
      hps_key:'hpsPenalty', 
      play_id:1004,
    },
    // 篮球
    {
      title:  i18n_t('basketball_playing_way.quarter'),
      id:6,
      unfold:0,
      show_tab:false,
      hps:[{
        hl:[{}]
      }],
      pids:'48,46,45',
      hps_key:'hpsAdd', // 篮球小节玩法
      play_id:2003,
    },
    // 网球
    {
      title: title,
      id:7,
      unfold:0,
      show_tab:false,
      hps:[{
        hl:[{}]
      }],
      pids:'162,163,164',
      hps_key:'hpsAdd',
      play_id:2003,
    },
    //乒乓球
    {
      title: title,
      id:8,
      unfold:0,
      show_tab:false,
      hps:[{
        hl:[{}]
      }],
      pids:'175,176,177',
      hps_key:'hpsAdd',
      play_id:2003,
    },
    //斯诺克
    {
      title: title,
      id:9,
      unfold:0,
      show_tab:false,
      hps:[{
        hl:[{}]
      }],
      pids:'184,185,186,190,191',
      hps_key:'hpsAdd',
      play_id:2003,
    },
  ]
}
```

1.元数据
/// 1011 菜单id -》 loadTournamentMatch -》key-value ： value中的 mid tid

早盘和滚球 ld开赛 nd未开赛的 直接拼 01

tid 和 mid 去 originDataEntity 中遍历查找。

2.csid 列表数据一致性问题

3.时间：中午12点。

## ws

ms - mpp

折叠 C8. 取消订阅。
C9: 折叠不订阅。（解决折叠不显示的赛事 结束后 收不到消息，不该显示的继续显示了）。

冠军也要订阅，赔率变化很少，需要订阅盘口的变化。
C105:

## 列表

1。顺序问题。

2. 关盘:
3. 增加赛事: C109:从关-开 拉列表数据。
4.

/// 赛事列表 上下跳动。

//常规球类 id csid  常规id为 100+csid
1: "足球"  
2: "篮球"
3: "棒球"
4: "冰球"
5: "网球"
6: "美式足球"
7: "斯诺克"
8: "乒乓球"
9: "排球"
10: "羽毛球"
11: "手球"
12: "拳击/格斗"
13: "沙滩排球"
14: "橄榄球"
15: "曲棍球"
16: "水球"
17: "田径"
18: "娱乐"
19: "游泳"
20:"体操"
21:"跳水"
22:"射击"
23:'举重'
24:'射箭'
25:'击剑'
26: "冰壶",
27: "跆拳道"
28: "高尔夫"
29: "自行车"
30: "赛马"
31: "帆船"
32: "划船"
33: "赛车"
34: "柔道"
35: "空手道"
36: "摔跤"
37: "板球"
38: "飞镖"
39: "沙滩足球"
40: "其他"
50:"趣味 "
//电子球类 csid
90: "电子足球"
91: "电子篮球"
//Vr球种 csid   ( 全id => `3${csid}` )
1001:"VR足球"
1002:"VR赛狗"
1004:"VR篮球"
1009:"VR泥地摩托车"
1010:"VR摩托车"
1011:"VR赛马"
//电子竞技 csid  ( 全id => `2${csid}` )
100:"英雄联盟"
101:"Dota2"
102:"CS:GO/CS2"
103:"王者荣耀"


//一级菜单
1:"滚球"  //实时滚球类
2:"今日"  //当日赛事
3:"早盘"  //早盘赛事
4:"冠军"  //菜单id对应客户端400，冠军类赛事
5:"即将开赛"  //即将开赛
6："串关" //串关赛事
300:"VR体育"  //体育类赛事
2000:"电竞"   //电子竞技类 赛事
5000："热门赛种"  //热门赛事球类复刻版50000 5000
28:"赛果"  //赛事结果 全球种
0:"收藏" //自定义id 0

//二级菜单
`${常规球种id(例如足球csid 1+100 = 101)}${一级菜单(例如滚球1)}` //组合结果  滚球今日 id 1011

生成唯一id
const mi = `${常规球类csid}${一级菜单id}`;
//例如 足球今日  1012
元数据处理

赛事列表的渲染需要等待5个元数据接口请求完成
接口1：  获取 新旧菜单ID对应
接口2：  获取 菜单-联赛-赛事
接口3：  获取 国际化菜单
接口4：  获取 元数据接口
接口5：  获取 菜单数量统计
通过菜单的默认球种 拿到对应 euid 去元数据里查找 当前 euid 下的 mids
获取全部赛事的 mids  (BaseData.mi_tid_mids_res 存放对应的数据)
通过 赛事 id  获取 对应元数据赛事， 该赛事目前没有提供赔率， 比分，盘口等； 只包含 队伍名称、联赛名称、以及对阵信息
获取到对应元数据 则 提交给仓库， 仓库会进一步处理
处理元数据同步请求 赛事接口 获取最新

1. 因为元数据接口 不及时，元数据接口返回的是全赛种赛事数据量大，不会实时同步最新数据
2. 元数据主要目的，切换界面避免 loading  秒显； 立马有界面呈现
3. 真实数据回来 替换掉 元数据
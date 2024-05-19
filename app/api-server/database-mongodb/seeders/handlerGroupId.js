const mongoose = require("mongoose");
var mongodb_connect_fn = require("../mongodb.config");
var key_group_model = require("../../app/model/keyGroup");
var css_key_model = require("../../app/model/cssKey");
var other_key_model = require("../../app/model/jsKey");

async function main() {
    await mongodb_connect_fn(
        // 'mongodb://admin:VNJ0t8ej9ZRHeUpt@16.162.122.76:27017/api_doc_test?authSource=admin',
    );
    const keyGroupModel = key_group_model({ mongoose });
    const cssKeyModel = css_key_model({ mongoose })
    const otherKeyModel = other_key_model({ mongoose })

    const keyGroupList = await keyGroupModel.find()
    console.log('查到 keyGroup 共：', keyGroupList.length);

    const keyGroupMapper = keyGroupList.reduce((o, v) => {
        v.__match__ = []
        const _key_ = [v.key, v.project, v.type].join('_#_')
        if (o[_key_]) console.log('--- 查到重复 keyGroup ---',_key_);
        o[_key_] = v
        return o
    }, {})

    const cssKeyList = await cssKeyModel.find()
    console.log('查到 cssKey 共：', cssKeyList.length);

    const noMatchCssKeyList = []
    const noMatchGroupKeySetByCssKey = new Set()
    for (const v of cssKeyList) {
        const matchKeyGroup = keyGroupMapper[[v.group, v.project, 1].join('_#_')]
        if (matchKeyGroup) {
            matchKeyGroup.__match__.push(v)
            // await cssKeyModel.findByIdAndUpdate(v.id, {group_id:matchKeyGroup.id})
        } else {
            noMatchGroupKeySetByCssKey.add(v.group)
            noMatchCssKeyList.push(v)
        }
        
    }
    //   console.log('cssKey 未匹配到 keyGroup ：', noMatchCssKeyList);
    console.log('cssKey 未匹配到 keyGroup ：', noMatchCssKeyList.length);
    console.log('cssKey 未匹配到 keyGroup 的 key 是：', noMatchGroupKeySetByCssKey);


    const otherKeyList = await otherKeyModel.find()
    console.log('查到 otherKey 共：', otherKeyList.length);

    const noMatchOtherKeyList = []
    const noMatchGroupKeySetByOtherKey = new Set()
    for (const v of otherKeyList) {
        const matchKeyGroup = keyGroupMapper[[v.group, v.project, 2].join('_#_')]
        if (matchKeyGroup) {
            matchKeyGroup.__match__.push(v)
            // await otherKeyModel.findByIdAndUpdate(v.id, {group_id:matchKeyGroup.id})
        } else {
            noMatchGroupKeySetByOtherKey.add(v.group)
            noMatchOtherKeyList.push(v)
        }
        
    }
    //   console.log('otherKey 未匹配到 keyGroup ：', noMatchOtherKeyList);
    console.log('otherKey 未匹配到 keyGroup ：', noMatchOtherKeyList.length);
    console.log('otherKey 未匹配到 keyGroup 的 key 是：', noMatchGroupKeySetByOtherKey);

    const noUseKeyGroup = []
    for (const key in keyGroupMapper) {
        const item = keyGroupMapper[key]
        if (!keyGroupMapper[key].__match__.length) noUseKeyGroup.push(
            { key: item.key, project: item.project, type: item.type, }
        )
    }

    console.log('未使用的 keyGroup ：', noUseKeyGroup);

    console.log("执行完毕");
}

main()
    .catch((err) => console.log(err))
    .finally(() => {
        process.exit(0);
    })

// [
//     [ 'h5_space', 1, 1 ]
//     [ 'pc_box_shadow', 2, 1 ],

//     ['h5.bettingConfiguration', 1, 2],
//     ['h5.BettingHistory', 1, 2],
//     ['h5.match_result', 1, 2],
//     ['h5.match_analysis', 1, 2],
//     ['h5.tab_hot', 1, 2],
//     ['h5.match', 1, 2],
//     ['h5.footer_menu', 1, 2],
// ]
// db.otherkeys.updateMany({ group: 'bettingConfiguration', project: 1 }, { $set: { group: 'h5.bettingConfiguration' } })
// db.otherkeys.updateMany({ group: 'BettingHistory', project: 1 }, { $set: { group: 'h5.BettingHistory' } })
// db.otherkeys.updateMany({ group: 'match_result', project: 1 }, { $set: { group: 'h5.match_result' } })
// db.otherkeys.updateMany({ group: 'match_analysis', project: 1 }, { $set: { group: 'h5.match_analysis' } })
// db.otherkeys.updateMany({ group: 'tab_hot', project: 1 }, { $set: { group: 'h5.tab_hot' } })
// db.otherkeys.updateMany({ group: 'match', project: 1 }, { $set: { group: 'h5.match' } })
// db.otherkeys.updateMany({ group: 'footer_menu', project: 1 }, { $set: { group: 'h5.footer_menu' } })



// db.keygroups.insertMany([
//     {"names":{"zh_cn":"h5_border_color"},"key":"h5_border_color","project":1,"type":1,"descriptions":{"zh_cn":"h5_border_color"},"status":1},
//     {"names":{"zh_cn":"pc_color"},"key":"pc_color","project":2,"type":1,"descriptions":{"zh_cn":"pc_color"},"status":1},
//     {"names":{"zh_cn":"pc_test_jinnian_1"},"key":"pc_test_jinnian_1","project":2,"type":2,"descriptions":{"zh_cn":"pc_test_jinnian_1"},"status":-1},
//     {"names":{"zh_cn":"h5_test_jinnian_1"},"key":"h5_test_jinnian_1","project":1,"type":2,"descriptions":{"zh_cn":"h5_test_jinnian_1"},"status":-1}
// ])
// ---------------------------------------------
// {
// 	"acknowledged" : true,
// 	"insertedIds" : [
// 		ObjectId("6455dd2a49dbfa4df260da78"),
// 		ObjectId("6455dd2a49dbfa4df260da79"),
// 		ObjectId("6455dd2a49dbfa4df260da7a"),
// 		ObjectId("6455dd2a49dbfa4df260da7b")
// 	]
// }
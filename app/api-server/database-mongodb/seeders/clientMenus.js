
const mongoose = require("mongoose");
var randomstring = require("randomstring");
var mongodb_connect_fn = require("../mongodb.config");
var clientMenuBuilder = require("../../app/model/clientMenu");
var clientRoleBuilder = require("../../app/model/clientRole");
var clientUserBuildr = require("../../app/model/user");

const Menu = {
    home: {
        en_gb: "Home",
        zh_cn: "首页",
    },
    Process: {
        en_gb: "Docking process",
        zh_cn: "对接流程",
        id: "6433928cb2cc77bbe36093c6",
    },
    connection: {
        en_gb: "How to creat a link",
        zh_cn: "如何建立连接",
        id: "641d5571f01607bc012907fa",
    },
    front_end: {
        en_gb: "Frontstage docking",
        zh_cn: "前端对接",
        id: "641d555af01607bc012907f7",
    },
    app: {
        en_gb: "App docking",
        zh_cn: "APP对接",
        id: "6523f452484f90d889b4f6d3"
    },
    api: {
        en_gb: "API",
        zh_cn: "API文档",
        id: "641ecbf61ff4e6bbffb4b362",
    },
    Excursus: {
        en_gb: "Appendix",
        zh_cn: "文档附录",
        id: "641ec8a81ff4e6bbffb4b321",
    },
    qa: {
        en_gb: "FAQs",
        zh_cn: "常见问题",
        id: "641ec8bc1ff4e6bbffb4b324",
    },
    qa: {
        en_gb: "Update description",
        zh_cn: "更新说明",
        id: "64b7a06d4f9517a174062954",
    },
    tool: {
        en_gb: "Tool",
        zh_cn: "工具",
    },
    modular: {
        en_gb: "Modular Docking Document",
        zh_cn: "模块化对接文档",
    },
    online_dev: {
        en_gb: "Modular Online Dev",
        zh_cn: "模块化在线调试",
    },
    interface_interception: {
        en_gb: "Interface Interception",
        zh_cn: "接口拦截",
    },
    match_replay: {
        en_gb: "Match Replay",
        zh_cn: "赛事重播",
    },
}

async function main() {
    await mongodb_connect_fn();
    const Model = clientMenuBuilder({ mongoose });
    const RoleModel = clientRoleBuilder({ mongoose });
    const UserModel = clientUserBuildr({ mongoose });

    let data = [];
    Object.keys(Menu).forEach(key => {
        const obj = {
            zh_cn: Menu[key].zh_cn,
            en_gb: Menu[key].en_gb,
            key: key,
            description: '初始化系统固定菜单'
        }
        data.push(obj);
    })
    /**
     * 1. 导入菜单数据
     */
    const menus = await Model.create(data);
    /**
     * 2. 初始化一个角色, 并且把所有的菜单绑定到这个角色上
     */
    const role = await RoleModel.create({
        name: '初始角色',
        description: '系统初始化的角色',
        menus: menus.map(menu => menu._id) // 绑定所有菜单到角色
    });

    /**
     * 3. 执行 update, 将现有的用户的 roleId 都更新成初始化的角色 id
     */
    await UserModel.updateMany({}, { roleId: role._id });

    console.log(Model, '--')
    console.log("执行完毕");
    process.exit(0);
}
main().catch((err) => console.log(err));
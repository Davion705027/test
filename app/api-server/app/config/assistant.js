






module.exports ={
    //  键类型 
    key_type:{
        css:1,
        js:2,
        layout:3,
        component:4,
        theme:5,
        i18n:6,
        assets:7
    } ,
    key_type_val_to_model_map:{
       key_1:'CssKey',
       key_2:'JsKey',
       key_3:'LayoutTemplate',
       key_4:'ComponentKey',
       key_5:'ThemeTemplate',
       key_6:'I18nKey',
       key_7:'AssetsKey',
    },
    // 打包环境
    pack_env_list:[
        { label: '开发', value: 'dev' },
        { label: '测试', value: 'test' },
        { label: '隔离', value: 'geli' },
        { label: 'mini', value: 'mini' },
        { label: '试玩', value: 'shiwan' },
        { label: '生产', value: 'online' },
    ] 
}
/*
 * @FilePath: /test/lodash/jiemi.js
 * @Description: 
 */
  const CryptoJS = require("crypto-js");
  var key = "panda1234_1234ob"
  function jiemi() {
    try {
      let data = mid_jiami_jiemi(obj, "jiemi");
      console.log('解密完了：',data);
    } catch (error) {
      console.error(error);
    }
  }
    // 解密 单个字符串
  function jiemi_word(word) {
    let _key = CryptoJS.enc.Utf8.parse(key);
    let decrypt = CryptoJS.AES.decrypt(word, _key, {
      mode: CryptoJS.mode.ECB,
      padding: CryptoJS.pad.Pkcs7
    });
    let ret = CryptoJS.enc.Utf8.stringify(decrypt).toString();
    return ret;
  }

  //加密 解密 中间方法
  const mid_jiami_jiemi = function(obj) {
    let encrypt_key_list = ['img','static','pc','h5','end','api'] ;//需要加密的字段
    let compute_result_by_key_type_array=(arr)=>{
        let list=[]
        if(!arr&&arr.length == 0 ){return list}
        arr.map((el,index)=>{
          if(typeof el =='object'){
            if(Array.isArray(el)){
              console.warn(el);
              list[index] = compute_result_by_key_type_array(el)
            }else{
              list[index] = compute_encrypt_key_obj(el)
            }
          }else{
            console.warn(el);
            list[index] = jiemi_word(el)
          }
        })
        return list
    }
    let compute_encrypt_key_obj= (o1)=>{
          let o2={}
          for(let i in o1){
            if(typeof o1[i] =='object'){
              if(Array.isArray(o1[i])){
                o2[i] = compute_result_by_key_type_array(o1[i])
                // 数组
              }else{
                // 对象
                o2[i] = compute_encrypt_key_obj(o1[i])
              }
            }else{
              if(encrypt_key_list.includes(i)){
                o2[i]= jiemi_word(o1[i],i)
              }else{
                o2[i]=o1[i]
              }
            }
          }
          return o2
    }
    return compute_encrypt_key_obj(obj)
  }

  var obj = {"update_time":"2023-10-20 16:14:44",
  "img":["pV9gSBMQ8z3xSR9EYFS38yLmr3+qSebRP0Cad2LynSo="],
  "static":["kRcCH5iub7vwYlL7KDPEoynVwXg74hBwdJQNBC7sdl9aDKqR3GvdECeXRhscoqcd"],
  "live_domains":{"pc":"zAeaUCCp6Q2vzOwnXNDMuu+0STybCXgyk852i7jr6xl/UkN1QmDi/y0TPBmRgQLF",
  "h5":"PGzZGHFGd7GRcJKI4nIZc22EFl/ax3WYFXSVDyYOuNl/UkN1QmDi/y0TPBmRgQLF",
  "end":"Ktf+db+0A6KHZe/fp5p8yePqTEDfRZ3fVdLo4EiBMOHuxPUIBerEhSvacm6VEJyt"},"file_name":"prod.json",
  "GAS":{"api":["WMDwqjhgM98SA487Y577ln5+7JDDFGLQdlrgZVVFmf0=","v1qHf6R6WhJVxuqbW0Jyw+Pwe4Wlfs5ZJPbS/o8sVYo=","ecSRAHjwT+/0y/7tN5+ZQoq5T/Wcuxym92Aa0e4X0ZU=","zOOscwb8/xPxVWU+SaGjCGBBt62pb/E8BiCEmX3AMKc=","0Pm9Wgic75Evd1Jih6sWNmnzXE/qD2Cqps8ocaQWx2U=","VLfl67w7WB9pcz7pncFywoOUO3LFmfZoKp6BLY7MhQI=","rofHE2IylfyDEGaX6Vv4FZKSDnms2vqaZAM5wAhfUdQ=","2wGQJcC2eCqL97SD9xgK8wQlnMQBaj91WqOcqxCRLcA=","ViHVJ9+cExp/9fw2RugliYTl/FN1gy4kYWSl5nBvOK0="]},"GAB":{"api":["8Xyd5JB+BjhJtKNgrV5IX2OpIFfZLjJRB0d96v/MgCI=","KG+YJVm2A90L70FDKL8j2gjANBr4TpZm7OgQmV5btfA=","0GwRyuaJjUaR65+MQfHRRZYDeLtR0bCw9tmJgFiv2Ag=","NqcNTJgjT/hKcYlYIhMnaNOZWJ47uizXMXKked+9x3I=","qIYK0UtKw498ZkncpBsdLV8uBEzhBbToJeLiO8/bhsk=","a/q+N7h+a62SSURhFTDvAWjufH8mSekDGOACWUHLNuw="]},"api":["CNyYOXngKUXqp1IvwLj5LK6H8Y+2zTChR2KsyCOTFZI=","q+GnUpmi3E/uF5OiDuykaXtr8OzplMWjLVG8L0zwutY=","FClTYcv7NB/c5eRj4ut47Vn4UA3U4tZ2IL5cTC4gB1M=","HcWCkGX80l+FMhp3AOoPK8M5QQdFdDTsZtd3SoNwXKlOYjZYXt/K3a0G/dTCM68M","xfcktyQsT6Hg80oxBjRru7snwGtM4DpGA0RcUafAY3o=","uV7EbQ3ENLpmPPQjxel1kE3SAUxH0nMkd2kJjD6fpcQ="],"update_by":"ob","type":"生产环境","GAY":{"api":["VXZRuXmeEhf4bAFJCmxi+Wsv+Dp7HP8RE22HXRJfddI=","LVqea+/mtzUvs5zISpaynM4XmdEXOmb/zSVGOHwFkfw=","D/JAaNHRBi9/XO4eyxJxRIHc7xG9UHTe+UZ8Wfdg73c=","VkHjaq+FFp+z8fb2LLsn9um/EQMrxwSORCQ0qb8b0Bc=","6exRJpI4+TW9Aixo7X38Qvw09qvOhASbP8GtE53U42o=","b1u1kjZgJLVOuRFRTPZLcO0C55R8v55hkckdIJnvnb4=","4eLLLhTiBUvgk8u5foQd5JLSfI2ZDzUJ/jKFZYGL1HY=","vgxpBqJGe1PSW78w9uCD2Em2mshZxeOT5xIi38OsdxQ="]},"GACOMMON":{"api":["CNyYOXngKUXqp1IvwLj5LK6H8Y+2zTChR2KsyCOTFZI=","q+GnUpmi3E/uF5OiDuykaXtr8OzplMWjLVG8L0zwutY=","FClTYcv7NB/c5eRj4ut47Vn4UA3U4tZ2IL5cTC4gB1M=","er6U8bBP11AdRPUrpwxCbSNR7uV2wp6zlgYr4NFhl/w=","xfcktyQsT6Hg80oxBjRru7snwGtM4DpGA0RcUafAY3o=","s70hXmlTlPhbz3hul8yoA6V1YpFeMjaRjsDFlVY6Xsc="]}}

  // jiemi(obj)

  // const aa = jiemi_word("pV9gSBMQ8z3xSR9EYFS38yLmr3+qSebRP0Cad2LynSo=")
  // console.log(aa);

  let _key = CryptoJS.enc.Utf8.parse(key);
  console.log(_key);
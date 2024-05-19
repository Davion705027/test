/*
 * @Date           : 2022-04-06 16:01:26
 * @LastEditTime: 2023-10-10 10:44:37
 * @Description    :  
 */
// app/service/jwt.js
// https://github.com/auth0/node-jsonwebtoken#errors--codes
const UUID = require('uuid').v4;
const Service = require('egg').Service;
const dayjs = require('dayjs');
const AuthException = require('../exception/auth');
class JwtService extends Service {
  // 生成token
  async createToken (data) {
    // const now = dayjs().unix();
    // const now = dayjs().unix();
    const config = this.app.config.jwt;

    // exp jwt的过期时间，这个过期时间必须要大于签发时间

    // nbf jwt的生效时间，定义在什么时间之前，该jwt都是不可用的
    
    // iat jwt的签发时间
    
    // jti jwt的唯一身份标识
    
    // uid 自定义 payload 存放  
    // https://github.com/auth0/node-jsonwebtoken#jwtsignpayload-secretorprivatekey-options-callback


    // jwt.sign(payload, secretOrPrivateKey, [options, callback])

  //载荷
    let payload=data
  //秘钥
  let secretOrPrivateKey= config.secret
  //选项
  let options={
    // algorithm (default: HS256)
    //   algorithm  : HS256 ,
    // expiresIn: expressed in seconds or a string describing a time span vercel/ms.
    // Eg: 60, "2 days", "10h", "7d". A numeric value is interpreted as a seconds count. If you use a string be sure you provide the time units (days, hours, etc), otherwise milliseconds unit is used by default ("120" is equal to "120ms").
    // notBefore: expressed in seconds or a string describing a time span vercel/ms.
    // Eg: 60, "2 days", "10h", "7d". A numeric value is interpreted as a seconds count. If you use a string be sure you provide the time units (days, hours, etc), otherwise milliseconds unit is used by default ("120" is equal to "120ms").
    // audience
    // issuer
    // jwtid 
    // subject
    // noTimestamp
    // header
    // keyid
    // mutatePayload: if true, the sign function will modify the payload object directly. This is useful if you need a raw reference to the payload after claims have been applied to it but before it has been encoded into a token.
  
    expiresIn:  config.expiresIn,
    jwtid:UUID(),
}
  

 let token=  await  this.app.jwt.sign(payload, secretOrPrivateKey,  options )

 return token

   
  }
  // 验证token
  async verifyToken (token) {
    if (!token) { // 如果token不存在就抛出异常
       return false 
    }
    token = token.substring(7)
    // console.log("验证token-----------------",token);
    // jwt.verify(token, secretOrPublicKey, [options, callback])
    
    let result=false

    const secretOrPublicKey = this.app.config.jwt.secret;

    try {
        result=  await this.app.jwt.verify(token, secretOrPublicKey);


      
    } catch (e) { 
        // 如果token验证失败直接抛出异常
      // 通过消息判断token是否过期

    //   throw new AuthException('令牌异常，请重新登录', 10003);
    console.log(e);
    result=false

    }
 
    // console.log(' 验证token-------',result);
    return result;
  }

 async get_token_info(){
    let token =  this.ctx.request.headers.authorization || "";
    let token_info = await  this.ctx.service.jwt.verifyToken(token) ||{};

   return token_info
  }
   
/**
 * 添加 操作人信息 
 * @param {*} obj 
 */
  async add_operator(obj){
    let token =  this.ctx.request.headers.authorization || "";
    let token_info = await  this.ctx.service.jwt.verifyToken(token) ||{};
    let operator= token_info['name']
    let operatorid= token_info['id']

    obj.operator = operator
    obj.operatorid = operatorid

    return {
      operator,
      operatorid
    }
  }
 
};

module.exports = JwtService;



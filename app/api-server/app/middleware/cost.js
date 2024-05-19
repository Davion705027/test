/*
 * @Date           : 2022-04-06 11:38:56
 * @LastEditTime   : 2022-04-06 14:30:49
 * @Description    :  
 */
module.exports =  (options, app) => {
    
    const header = options.header || 'X-Response-Time';
  
    return async function cost(ctx, next) {
    //   const now = Date.now();
    //   await next();
    //   ctx.set(header, `${Date.now() - now}ms`);

    await next();





    };
  };
  

//   // config/config.${env}.js
// config.middleware = ['cost'];
// config.cost = {
//   header: 'egg-cost',
// };

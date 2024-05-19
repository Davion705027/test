/*
 * @Date           : 2022-03-29 19:29:17
 * @LastEditTime   : 2022-04-03 20:58:09
 * @Description    :  
 */


var mongoosePaginate = require("mongoose-paginate");
module.exports = (app) => {
  const mongoose = app.mongoose;
  const Schema = mongoose.Schema;

  const schema_instance = new Schema(
  
    {
      
      //作者ID
       author: { type: String, required: true },
        //时刻内容  
        moment_content: { type: String, required: false },
        // 图片 数组
        moment_images: [String],
        //常规内容    [  { type:'text',content:""},  { type:'video',content:""} , { type:'image',content:""}  ]
        common_content: [{}],
         // 视频地址
        video_src:  String,
        //常规内容    [  { type:'text',content:""},  { type:'video',content:""} , { type:'image',content:""}  ]
        video_content: { type: String, required: false },
      //类型   1 momentArticle  时刻文章  2 videoArticle   视频文章  3   commonArticle 常规文章
      type:{
        type:Number,
        required: true
      },

      //官方助手
      updateRecord:[Number],
      //话题
      topic:[Number],

      //状态
      status:{
        type:Number,
         // -1 待审核  ， 1 启用 ，  ，3 热推 
        default:-1
      } ,
      // 是否置顶 
      is_top :{
        type: Boolean,
        default: false
      },
      // 是否置顶 
      is_top :{
        type: Boolean,
        default: false
      },
       // 是否 精华
       is_best :{
        type: Boolean,
        default: false
      },


      //点赞
      like:{
          type:Number,
          default:0
      },
      //精选置顶 评论
      top_comment:String,
      // 评论
      comment:{
        type:Number,
        default:0
      },
      //最后一次评论 
      last_comment_time:Date
       
    },
    {
      timestamps: true,
    }
  );

  schema_instance.method("toJSON", function () {
    const { __v, _id, ...object } = this.toObject();
    object.id = _id;
    object.createdAt = Date.parse(object.createdAt);
    object.updatedAt = Date.parse(object.updatedAt);
    return object;
  });

  schema_instance.plugin(mongoosePaginate);

  return mongoose.model("Article", schema_instance);
};

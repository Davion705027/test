
/*
 * @Date           : 2022-03-11 10:09:10
 * @FilePath: /client-api-doc-server/app/model/appLogger.js
 * @Description    :  app日志模型
 */
var mongoosePaginate = require("mongoose-paginate");
module.exports = (app) => {
    const mongoose = app.mongoose;
    const Schema = mongoose.Schema;
  
    const schema_instance = new Schema({
      project: { type: String, required:true },
      name: { type: String, required:true },
      filePath: { type: String ,required:true},
      size: { type: Number ,required:true},
    
    }, {
        timestamps: true,
      })  ;
    schema_instance.method("toJSON", function () {
      const { __v, _id, ...object } = this.toObject();
      object.id = _id;
      object.createdAt = Date.parse(object.createdAt);
      object.updatedAt = Date.parse(object.updatedAt);
      return object;
    });
    schema_instance.plugin(mongoosePaginate);
    return mongoose.model("AppLogger", schema_instance);
  };
  
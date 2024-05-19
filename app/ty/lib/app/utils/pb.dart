import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';


// 1. base64 解码转换为字节数组
// 2. 解压缩数据 pako / ZLibCodec
// 3. 以UTF-8编码的字节数据转换为对应的字符串
class PB{

  static isPb(String url){
    if(url.isEmpty)return '';
    url = url.split('?')[0];
    return url.endsWith('PB');
  }
  /**
   * @description: base64编码转换
   * @param {String} data  base64编码PB数据 String
   * @return {Object} 转换后的Json对象数据
   */
  unzipData(dynamic base64Data) {
    if(base64Data == null)return null;
    try {

      Uint8List uint8List = toUint8List(base64Data);
      Uint8List inflatedData = inflateData(uint8List);
      String decodedData = utf8.decode(inflatedData);
      var res = json.decode(decodedData);
      return res;
   
    } 
    catch (error) {
      print(error);
      print('unzipData error!');
    }
    return base64Data;
  }


  /**
   * @description: base64编码PB数据转换
   * @param {String} b64Data  经过base64编码后的PB数据
   * @return {Array} 转换后的字节数组
  */
  Uint8List toUint8List(String base64Data) {
    base64Data = base64Data.replaceAll('\n', '');
    // Base64解码
    List<int> bytes = base64.decode(base64Data);
    // 转换为Uint8List
    Uint8List uint8List = Uint8List.fromList(bytes);
    return uint8List;
  }

  Uint8List inflateData(Uint8List data) {
    // 解压缩数据
    ZLibCodec codec = ZLibCodec();
    List<int> inflatedData = codec.decode(data);
    return Uint8List.fromList(inflatedData);
  }

}
var pakoPb = PB();
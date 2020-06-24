import 'package:dio/dio.dart';
import 'package:zeongitbeautyflutter/assets/constant/config.constant.dart';
import 'package:zeongitbeautyflutter/assets/constant/key.constant.dart';
import 'package:zeongitbeautyflutter/assets/entity/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/util/storage.util.dart';

class HttpUtil {
  static Future<ResultEntity> get(String url, {Map<String, dynamic> params}) async {
    try {
      String token = _getToken();
      Options options =
          Options(headers: token != null ? {KeyConstant.TOKEN_KEY: token} : {});
      Response response = await Dio()
          .get(ConfigConstant.host + url, queryParameters: params, options: options);

      _handleToken(response);

      var result = ResultEntity().fromJson(response.data);
      return result;
    } catch (error) {
      return ResultEntity(status: 500, data: null, message: "服务器错误");
    }
  }

  static Future<ResultEntity> post(String url, {Map<String, dynamic> params}) async {
    try {
      String token = _getToken();
      Options options =
          Options(headers: token != null ? {KeyConstant.TOKEN_KEY: token} : {});
      Response response = await Dio()
          .post(ConfigConstant.host + url, data: params, options: options);

      _handleToken(response);
      var result = ResultEntity().fromJson(response.data);
      return result;
    } catch (error) {
      return ResultEntity(status: 500, data: null, message: "服务器错误");
    }
  }

  //统一处理返回token
  static  _handleToken(Response response) {
    try {
      var headers = response.headers;
      String token = headers.value(KeyConstant.TOKEN_KEY);
      if (token != null) {
        StorageManager.saveString(KeyConstant.TOKEN_KEY, token);
      }
    } catch (e) {}
  }

  //统一获取缓存token发送
  static _getToken() {
    try {
      return StorageManager.get(KeyConstant.TOKEN_KEY);
    } catch (e) {
      return null;
    }
  }
}

import 'package:dio/dio.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/plugins/constants/config.constant.dart';
import 'package:zeongitbeautyflutter/plugins/constants/key.constant.dart';
import 'package:zeongitbeautyflutter/plugins/constants/status.constant.dart';
import 'package:zeongitbeautyflutter/plugins/utils/storage.util.dart';

class HttpUtil {
  static Future<ResultEntity<T>> get<T>(String url,
      {Map<String, dynamic> params, String host}) async {
    if (host == null) {
      host = ConfigConstant.BEAUTY_HOST;
    }
    try {
      String token = _getToken();
      Options options = Options(
          headers: token != null ? {"Authorization": "Bearer " + token} : {});
      Response response = await Dio()
          .get(host + url, queryParameters: params, options: options);

      var result = ResultEntity(
          status: response.data["status"],
          message: response.data["message"],
          data: response.data["data"]);
      try {
        return ResultEntity.fromJson<T>(response.data);
      } catch (error) {
        return ResultEntity(
            status: result.status, message: result.message, data: null);
      }
    } catch (error) {
      return ResultEntity(
          status: StatusCode.PROGRAM, message: "服务器错误", data: null);
    }
  }

  static Future<ResultEntity<T>> post<T>(String url,
      {Map<String, dynamic> params, String host}) async {
    if (host == null) {
      host = ConfigConstant.BEAUTY_HOST;
    }
    try {
      String token = _getToken();
      Options options = Options(
          headers: token != null ? {"Authorization": "Bearer " + token} : {});
      Response response =
          await Dio().post(host + url, data: params, options: options);

      var result = ResultEntity(
          status: response.data["status"],
          message: response.data["message"],
          data: response.data["data"]);
      try {
        return ResultEntity.fromJson<T>(response.data);
      } catch (error) {
        return ResultEntity(
            status: result.status, message: result.message, data: null);
      }
    } catch (error) {
      return ResultEntity(
          status: StatusCode.PROGRAM, message: "服务器错误", data: null);
    }
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

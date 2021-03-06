import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class ResultEntity<T> {
  int status;
  String? message;
  T? data;

  ResultEntity({required this.status, required this.message, this.data});

  static fromJson<T>(Map<String, dynamic> json) {
    var data = ResultEntity<T>(
        status: json['status']?.toInt() ?? 500,
        message: json['message']?.toString() ?? "服务器错误");
    if (json['data'] != null) {
      try {
        data.data = JsonConvert.fromJsonAsT<T>(json['data']);
        if (data.data == null) {
          data.data = fromJsonAsT<T>(json['data']);
        }
      } catch (e) {
        data.data = fromJsonAsT<T>(json['data']);
      }
    }
    return data;
  }

  //Go back to a single instance by type
  static _fromJsonSingle(String type, json) {
    switch (type) {
      case 'String':
        return json?.toString();
      case 'int':
        return json?.toInt();
      case 'double':
        return json?.toDouble();
      case 'bool':
        return json;
    }
    return null;
  }

  //empty list is returned by type
  static _getListFromType(String type) {
    switch (type) {
      case 'String':
        return <String>[];
      case 'int':
        return <int>[];
      case 'double':
        return <double>[];
      case 'bool':
        return <bool>[];
    }
    return null;
  }

  static M fromJsonAsT<M>(json) {
    String type = M.toString();
    if (json is List && type.contains("List<")) {
      String itemType = type.substring(5, type.length - 1);
      List tempList = _getListFromType(itemType);
      json.forEach((itemJson) {
        tempList
            .add(_fromJsonSingle(type.substring(5, type.length - 1), itemJson));
      });
      return tempList as M;
    } else {
      return _fromJsonSingle(M.toString(), json) as M;
    }
  }
}

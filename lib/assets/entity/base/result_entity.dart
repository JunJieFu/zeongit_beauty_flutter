import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class ResultEntity<T> {
  int status;
  String message;
  T data;

  ResultEntity({this.status, this.message, this.data});

  static fromJson<T>(Map<String, dynamic> json) {
    var data = ResultEntity<T>();
    if (json['status'] != null) {
      data.status = json['status']?.toInt();
    }
    if (json['message'] != null) {
      data.message = json['message']?.toString();
    }
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
        return List<String>();
      case 'int':
        return List<int>();
      case 'double':
        return List<double>();
      case 'bool':
        return List<bool>();
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

import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/tag_frequency_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/plugins/constant/config.constant.dart';
import 'package:zeongitbeautyflutter/plugins/util/http.util.dart';

import '../constant/enum.constant.dart';

class UserService {
  static Future<ResultEntity<String>> signIn(String phone, String password) {
    return HttpUtil.post("/user/signIn",
        params: {"phone": phone, "password": password},
        host: ConfigConstant.ACCOUNT_HOST);
  }

  static Future<ResultEntity<int>> sendCode(
      String phone, CodeTypeConstant type) {
    return HttpUtil.post("/user/sendCode",
        params: {"phone": phone, "type": type.index},
        host: ConfigConstant.ACCOUNT_HOST);
  }

  static Future<ResultEntity<String>> singUp(
      String code, String phone, String password) {
    return HttpUtil.post("/user/signUp",
        params: {"code": code, "phone": phone, "password": password},
        host: ConfigConstant.ACCOUNT_HOST);
  }

  static Future<ResultEntity<dynamic>> forgot(
      String code, String phone, String password) {
    return HttpUtil.post("/user/forgot",
        params: {"code": code, "phone": phone, "password": password},
        host: ConfigConstant.ACCOUNT_HOST);
  }

  static Future<ResultEntity<UserInfoEntity>> getInfo() {
    return HttpUtil.get("/userInfo/get");
  }

  static Future<ResultEntity<UserInfoEntity>> getByTargetId(int targetId) {
    return HttpUtil.get("/userInfo/get", params: {"targetId": targetId});
  }
}

class PictureService {
  static Future<ResultEntity<PagePictureEntity>> pagingByRecommend(
      PageableEntity pageable) {
    return HttpUtil.get("/picture/pagingByRecommend",
        params: pageable.toJson());
  }

  static Future<ResultEntity<PagePictureEntity>> paging(PageableEntity pageable,
      {String tagList,
      bool precise,
      String name,
      DateTime startDate,
      DateTime endDate,
      double startWidth,
      double endWidth,
      double startHeight,
      double endHeight,
      double startRatio,
      double endRatio}) {
    var params = pageable.toJson();
    if (tagList != null) {
      params["tagList"] = tagList;
    }
    if (precise != null) {
      params["precise"] = precise;
    }
    if (name != null) {
      params["name"] = name;
    }
    if (startDate != null) {
      params["startDate"] = startDate;
    }
    if (endDate != null) {
      params["endDate"] = endDate;
    }
    if (startWidth != null) {
      params["startWidth"] = startWidth;
    }
    if (endWidth != null) {
      params["endWidth"] = endWidth;
    }
    if (startHeight != null) {
      params["startHeight"] = startHeight;
    }
    if (endHeight != null) {
      params["endHeight"] = endHeight;
    }
    if (startRatio != null) {
      params["startRatio"] = startRatio;
    }
    if (endRatio != null) {
      params["endRatio"] = endRatio;
    }

    return HttpUtil.get("/picture/paging", params: params);
  }

  static Future<ResultEntity<PictureEntity>> get(int id) {
    return HttpUtil.get("/picture/get", params: {"id": id});
  }

  static Future<ResultEntity<bool>> hide(int id) {
    return HttpUtil.post("/picture/hide", params: {"id": id});
  }

  static pagingRecommendById(PageableEntity pageable, int id) {
    var params = pageable.toJson();
    params["id"] = id;
    return HttpUtil.get("/picture/pagingRecommendById", params: params);
  }

  static Future<ResultEntity<PagePictureEntity>> pagingByFollowing(
      PageableEntity pageable) {
    return HttpUtil.get("/picture/pagingByFollowing",
        params: pageable.toJson());
  }
}

class FollowingService {
  static Future<ResultEntity<int>> follow(int followingId) {
    return HttpUtil.post("/following/focus",
        params: {"followingId": followingId});
  }

  static Future<ResultEntity<PageUserInfoEntity>> pagingFollowing(
      PageableEntity pageable, int targetId) {
    var params = pageable.toJson();
    params["targetId"] = targetId;
    return HttpUtil.get("/following/paging", params: params);
  }
}

class FollowerService {
  static Future<ResultEntity<PageUserInfoEntity>> pagingFollower(
      PageableEntity pageable, targetId) {
    var params = pageable.toJson();
    params["targetId"] = targetId;
    return HttpUtil.get("/follower/paging", params: params);
  }
}

class CollectionService {
  static Future<ResultEntity<PagePictureEntity>> paging(
      PageableEntity pageable, targetId) {
    var params = pageable.toJson();
    params["targetId"] = targetId;
    return HttpUtil.get("/collection/paging", params: params);
  }

  static Future<ResultEntity<int>> focus(int pictureId) {
    return HttpUtil.post("/collection/focus", params: {"pictureId": pictureId});
  }

  pagingUser(PageableEntity pageable, int pictureId) {
    var params = pageable.toJson();
    params["pictureId"] = pictureId;
    return HttpUtil.get("/collection/pagingUser", params: params);
  }
}

class WorksService {
  static Future<ResultEntity<PagePictureEntity>> paging(
      PageableEntity pageable, int targetId) {
    var params = pageable.toJson();
    params["targetId"] = targetId;
    return HttpUtil.get("/works/paging", params: params);
  }
}

class FootprintService {
  static Future<ResultEntity<PagePictureEntity>> paging(
      PageableEntity pageable, int targetId) {
    var params = pageable.toJson();
    params["targetId"] = targetId;
    return HttpUtil.get("/footprint/paging", params: params);
  }

  static save(int pictureId) {
    return HttpUtil.post("/footprint/save", params: {"pictureId": pictureId});
  }

  pagingUser(PageableEntity pageable, int pictureId) {
    var params = pageable.toJson();
    params["pictureId"] = pictureId;
    return HttpUtil.get("/footprint/pagingUser", params: params);
  }
}

class TagService {
  static Future<ResultEntity<List<TagFrequencyEntity>>> listTagTop30() async {
    return HttpUtil.get("/tag/listTagTop30");
  }

  static Future<ResultEntity<List<TagFrequencyEntity>>>
      listTagFrequencyByUserId(int targetId) {
    return HttpUtil.get("/tag/listTagFrequencyByUserId",
        params: {"targetId": targetId});
  }
}

class UserBlackHoleService {
  static Future<ResultEntity<int>> block(int targetId) async {
    return HttpUtil.post("/userBlackHole/block",
        params: {"targetId": targetId});
  }

  static Future<ResultEntity<BlackHoleEntity>> get(int targetId) async {
    return HttpUtil.get("/userBlackHole/get", params: {"targetId": targetId});
  }

  static Future<ResultEntity<PageUserBlackHoleEntity>> paging(
      PageableEntity pageable) {
    return HttpUtil.get("/userBlackHole/paging", params: pageable.toJson());
  }
}

class PictureBlackHoleService {
  static Future<ResultEntity<int>> block(String targetId) async {
    return HttpUtil.post("/pictureBlackHole/block",
        params: {"targetId": targetId});
  }

  static Future<ResultEntity<BlackHoleEntity>> get(int targetId) async {
    return HttpUtil.get("/pictureBlackHole/get",
        params: {"targetId": targetId});
  }

  static Future<ResultEntity<PagePictureBlackHoleEntity>> paging(
      PageableEntity pageable) {
    return HttpUtil.get("/pictureBlackHole/paging", params: pageable.toJson());
  }
}

class TagBlackHoleService {
  static Future<ResultEntity<int>> block(String tag) {
    return HttpUtil.post("/tagBlackHole/block", params: {"tag": tag});
  }

  static Future<ResultEntity<PageTagBlackHoleEntity>> paging(
      PageableEntity pageable) {
    return HttpUtil.get("/tagBlackHole/paging", params: pageable.toJson());
  }
}

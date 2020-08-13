import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/plugins/constant/config.constant.dart';
import 'package:zeongitbeautyflutter/plugins/util/http.util.dart';

class UserService {
  static Future<ResultEntity<bool>> signIn(String phone, String password) {
    return HttpUtil.post("/user/signIn",
        params: {"phone": phone, "password": password},
        host: ConfigConstant.ACCOUNT_HOST);
  }

  static Future<ResultEntity<UserInfoEntity>> getInfo() {
    return HttpUtil.get("/userInfo/get");
  }

  static Future<ResultEntity<UserInfoEntity>> getByTargetId(int targetId) {
    return HttpUtil.get("/userInfo/get", params: {"targetId": targetId});
  }

  static Future<ResultEntity<String>> follow(int followingId) {
    return HttpUtil.post("/following/focus",
        params: {"followingId": followingId});
  }

  static Future<ResultEntity<PageUserInfoEntity>> pagingFollower(
      PageableEntity pageable,
      {int targetId}) {
    var _ = pageable.toJson();
    _["page"]--;
    _["targetId"] = targetId;
    return HttpUtil.get("/follower/paging", params: _);
  }

  static Future<ResultEntity<PageUserInfoEntity>> pagingFollowing(
      PageableEntity pageable,
      {int targetId}) {
    var _ = pageable.toJson();
    _["page"]--;
    _["targetId"] = targetId;
    return HttpUtil.get("/following/paging", params: _);
  }
}

class PictureService {
  static Future<ResultEntity<PagePictureEntity>> pagingByRecommend(
      PageableEntity pageable) {
    var _ = pageable.toJson();
    _["page"]--;
    return HttpUtil.get("/picture/pagingByRecommend", params: _);
  }

  static Future<ResultEntity<PagePictureEntity>> paging(PageableEntity pageable,
      {String tagList, int targetId}) {
    var _ = pageable.toJson();
    _["page"]--;
    _["tagList"] = tagList;
    _["targetId"] = targetId;
    return HttpUtil.get("/picture/paging", params: _);
  }

  static Future<ResultEntity<PictureEntity>> get(int id) {
    return HttpUtil.get("/picture/get", params: {"id": id});
  }

  static pagingRecommendById(PageableEntity pageable, int id) {
    var _ = pageable.toJson();
    _["page"]--;
    _["id"] = id;
    return HttpUtil.get("/picture/pagingRecommendById", params: _);
  }

  static pagingByFollowing(PageableEntity pageable) {
    var _ = pageable.toJson();
    _["page"]--;
    return HttpUtil.get("/picture/pagingByFollowing", params: _);
  }
}

class CollectionService {
  static Future<ResultEntity<PagePictureEntity>> paging(PageableEntity pageable,
      {int targetId}) {
    var _ = pageable.toJson();
    _["page"]--;
    _["targetId"] = targetId;
    return HttpUtil.get("/collection/paging", params: _);
  }

  static Future<ResultEntity<String>> focus(int pictureId) {
    return HttpUtil.post("/collection/focus", params: {"pictureId": pictureId});
  }

  pagingUser(PageableEntity pageable, int pictureId) {
    var _ = pageable.toJson();
    _["page"]--;
    _["pictureId"] = pictureId;
    return HttpUtil.get("/collection/pagingUser", params: _);
  }
}

class WorksService {
  static Future<ResultEntity<PagePictureEntity>> paging(PageableEntity pageable,
      {int targetId}) {
    var _ = pageable.toJson();
    _["page"]--;
    _["targetId"] = targetId;
    return HttpUtil.get("/works/paging", params: _);
  }
}

class FootprintService {
  static Future<ResultEntity<PagePictureEntity>> paging(PageableEntity pageable,
      {int targetId}) {
    var _ = pageable.toJson();
    _["page"]--;
    _["targetId"] = targetId;
    return HttpUtil.get("/footprint/paging", params: _);
  }

  static save(int pictureId) {
    return HttpUtil.post("/footprint/save", params: {"pictureId": pictureId});
  }

  pagingUser(PageableEntity pageable, int pictureId) {
    var _ = pageable.toJson();
    _["page"]--;
    _["pictureId"] = pictureId;
    return HttpUtil.get("/footprint/pagingUser", params: _);
  }
}

class TagService {
  static Future<ResultEntity<List<String>>> listTagTop30() async {
    return HttpUtil.get("/tag/listTagTop30");
  }

  static listTagFrequencyByUserId(int targetId) {
    return HttpUtil.get("/tag/listTagFrequencyByUserId",
        params: {"targetId": targetId});
  }
}

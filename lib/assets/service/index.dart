import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/util/http.util.dart';

class UserService {
  static getInfo() {
    return HttpUtil.get("/userInfo/get");
  }

  static getByTargetId(String targetId) {
    return HttpUtil.get("/userInfo/get", params: {targetId: targetId});
  }

  static follow(String followingId) {
    return HttpUtil.post("/following/focus",
        params: {followingId: followingId});
  }

  static pagingFollower(PageableEntity pageable, String targetId) {
    var _ = pageable.toJson();
    _["page"]--;
    _["targetId"] = targetId;
    return HttpUtil.get("/follower/paging", params: _);
  }

  static pagingFollowing(PageableEntity pageable, String targetId) {
    var _ = pageable.toJson();
    _["page"]--;
    _["targetId"] = targetId;
    return HttpUtil.get("/following/paging", params: _);
  }
}

class PictureService {
  static pagingByRecommend(PageableEntity pageable) {
    var _ = pageable.toJson();
    _["page"]--;
    return HttpUtil.get("/picture/pagingByRecommend", params: _);
  }

  static paging(PageableEntity pageable, String tagList, String targetId) {
    var _ = pageable.toJson();
    _["page"]--;
    _["tagList"] = tagList;
    _["targetId"] = targetId;
    return HttpUtil.get("/picture/paging", params: _);
  }

  static get(String id) {
    return HttpUtil.get("/picture/get", params: {id: id});
  }

  static pagingRecommendById(PageableEntity pageable, String id) {
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
  static paging(PageableEntity pageable, String targetId) {
    var _ = pageable.toJson();
    _["page"]--;
    _["targetId"] = targetId;
    return HttpUtil.get("/collection/paging", params: _);
  }

  focus(String pictureId) {
    return HttpUtil.post("/collection/focus", params: {pictureId: pictureId});
  }

  pagingUser(PageableEntity pageable, String pictureId) {
    var _ = pageable.toJson();
    _["page"]--;
    _["pictureId"] = pictureId;
    return HttpUtil.get("/collection/pagingUser", params: _);
  }
}

class FootprintService {
  static paging(PageableEntity pageable, String targetId) {
    var _ = pageable.toJson();
    _["page"]--;
    _["targetId"] = targetId;
    return HttpUtil.get("/footprint/paging", params: _);
  }

  static save(String pictureId) {
    return HttpUtil.post("/footprint/save", params: {pictureId: pictureId});
  }

  pagingUser(PageableEntity pageable, String pictureId) {
    var _ = pageable.toJson();
    _["page"]--;
    _["pictureId"] = pictureId;
    return HttpUtil.get("/footprint/pagingUser", params: _);
  }
}

class TagService {
  static Future<ResultEntity> listTagTop30() async {
    return HttpUtil.get("/tag/listTagTop30");
  }

  static listTagFrequencyByUserId(String targetId) {
    return HttpUtil.get("/tag/listTagFrequencyByUserId",
        params: {targetId: targetId});
  }
}

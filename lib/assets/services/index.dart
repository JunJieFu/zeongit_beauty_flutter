import 'package:zeongitbeautyflutter/assets/constants/enum.constant.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/complaint.entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/feedback.entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_collection_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_footprint_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/tag_frequency_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/tag_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/models/dto.model.dart';
import 'package:zeongitbeautyflutter/plugins/constants/config.constant.dart';
import 'package:zeongitbeautyflutter/plugins/utils/http.util.dart';

class UserService {
  static Future<ResultEntity<String>> signIn(String phone, String password) {
    return HttpUtil.post("/user/signIn",
        params: {"phone": phone, "password": password},
        host: ConfigConstant.ACCOUNT_API_HOST);
  }

  static Future<ResultEntity<int>> sendCode(
      String phone, CodeTypeConstant type) {
    return HttpUtil.post("/user/sendCode",
        params: {"phone": phone, "type": type.index},
        host: ConfigConstant.ACCOUNT_API_HOST);
  }

  static Future<ResultEntity<String>> signUp(
      String code, String phone, String password) {
    return HttpUtil.post("/user/signUp",
        params: {"code": code, "phone": phone, "password": password},
        host: ConfigConstant.ACCOUNT_API_HOST);
  }

  static Future<ResultEntity<dynamic>> forgot(
      String code, String phone, String password) {
    return HttpUtil.post("/user/forgot",
        params: {"code": code, "phone": phone, "password": password},
        host: ConfigConstant.ACCOUNT_API_HOST);
  }
}

class UserInfoService {
  static Future<ResultEntity<UserInfoEntity>> get() {
    return HttpUtil.get("/userInfo/get");
  }

  static Future<ResultEntity<UserInfoEntity>> getByTargetId(int targetId) {
    return HttpUtil.get("/userInfo/get", params: {"targetId": targetId});
  }

  static Future<ResultEntity<PageUserInfoEntity>> paging(
      PageableEntity pageable,
      {SearchUserTune? criteria}) {
    var params = pageable.toJson();
    if (criteria?.nicknameList != null) {
      params["nicknameList"] = criteria!.nicknameList?.split(" ");
    }
    if (criteria?.precise != null) {
      params["precise"] = criteria!.precise;
    }
    if (criteria?.date.startDate != null) {
      params["startDate"] = criteria!.date.startDate;
    }
    if (criteria?.date.endDate != null) {
      params["endDate"] = criteria!.date.endDate;
    }
    return HttpUtil.get("/userInfo/paging", params: params);
  }
}

class PictureService {
  static Future<ResultEntity<PagePictureEntity>> pagingByRecommend(
      PageableEntity pageable,
      {DateRange? dateRange}) {
    var params = pageable.toJson();
    if (dateRange?.startDate != null) {
      params["startDate"] = dateRange!.startDate;
    }
    if (dateRange?.endDate != null) {
      params["endDate"] = dateRange!.endDate;
    }
    return HttpUtil.get("/picture/pagingByRecommend", params: params);
  }

  static Future<ResultEntity<PagePictureEntity>> paging(PageableEntity pageable,
      {SearchPictureTune? criteria}) {
    var params = pageable.toJson();
    if (criteria?.tagList != null) {
      params["tagList"] = criteria!.tagList!.split(" ");
    }
    if (criteria?.precise != null) {
      params["precise"] = criteria!.precise;
    }
    if (criteria?.name != null) {
      params["name"] = criteria!.name;
    }
    if (criteria?.date.startDate != null) {
      params["startDate"] = criteria!.date.startDate;
    }
    if (criteria?.date.endDate != null) {
      params["endDate"] = criteria!.date.endDate;
    }
    if (criteria?.startWidth != null) {
      params["startWidth"] = criteria!.startWidth;
    }
    if (criteria?.endWidth != null) {
      params["endWidth"] = criteria!.endWidth;
    }
    if (criteria?.startHeight != null) {
      params["startHeight"] = criteria!.startHeight;
    }
    if (criteria?.endHeight != null) {
      params["endHeight"] = criteria!.endHeight;
    }
    if (criteria?.startRatio != null) {
      params["startRatio"] = criteria!.startRatio;
    }
    if (criteria?.endRatio != null) {
      params["endRatio"] = criteria!.endRatio;
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

  static Future<ResultEntity<dynamic>> remove(int id) {
    return HttpUtil.post("/picture/remove", params: {"id": id});
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
  static Future<ResultEntity<PageCollectionEntity>> paging(
      PageableEntity pageable, targetId) {
    var params = pageable.toJson();
    params["targetId"] = targetId;
    return HttpUtil.get("/collection/paging", params: params);
  }

  static Future<ResultEntity<int>> focus(int pictureId) {
    return HttpUtil.post("/collection/focus", params: {"pictureId": pictureId});
  }

  static Future<ResultEntity<PageUserInfoEntity>> pagingUser(
      PageableEntity pageable, int pictureId) {
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
  static Future<ResultEntity<PageFootprintEntity>> paging(
      PageableEntity pageable, int targetId) {
    var params = pageable.toJson();
    params["targetId"] = targetId;
    return HttpUtil.get("/footprint/paging", params: params);
  }

  static save(int pictureId) {
    return HttpUtil.post("/footprint/save", params: {"pictureId": pictureId});
  }

  static Future<ResultEntity<PageUserInfoEntity>> pagingUser(
      PageableEntity pageable, int pictureId) {
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

  static Future<ResultEntity<List<TagPictureEntity>>> listTagAndPictureTop30() {
    return HttpUtil.get("/tag/listTagAndPictureTop30");
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

class FeedbackService {
  static Future<ResultEntity<FeedbackEntity>> save(String content,
      {String? email}) {
    return HttpUtil.post("/feedback/save",
        params: {"content": content, "email": email});
  }
}

class ComplaintService {
  static Future<ResultEntity<ComplaintEntity>> save(
      int pictureId, String content) {
    return HttpUtil.post("/complaint/save",
        params: {"content": content, "pictureId": pictureId});
  }
}

class SuggestService {
  static Future<ResultEntity<List<String>>> search(String keyword) {
    return HttpUtil.get("/suggest/search", params: {"keyword": keyword});
  }
}

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:zeongitbeautyflutter/assets/entity/collection_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/collection_entity_helper.dart';
import 'package:zeongitbeautyflutter/assets/entity/footprint_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/footprint_entity_helper.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/user_info_entity_helper.dart';
import 'package:zeongitbeautyflutter/assets/entity/tag_frequency_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/tag_frequency_entity_helper.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_black_hole_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/page_black_hole_entity_helper.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/page_user_info_entity_helper.dart';
import 'package:zeongitbeautyflutter/assets/entity/feedback.entity.dart';
import 'package:zeongitbeautyflutter/generated/json/feedback.entity_helper.dart';
import 'package:zeongitbeautyflutter/assets/entity/pagination_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/pagination_entity_helper.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_collection_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/page_collection_entity_helper.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/picture_entity_helper.dart';
import 'package:zeongitbeautyflutter/assets/entity/tag_picture_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/tag_picture_entity_helper.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_footprint_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/page_footprint_entity_helper.dart';
import 'package:zeongitbeautyflutter/assets/entity/complaint.entity.dart';
import 'package:zeongitbeautyflutter/generated/json/complaint.entity_helper.dart';
import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/black_hole_entity_helper.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/page_picture_entity_helper.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/pageable_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {
			case CollectionEntity:
				return collectionEntityFromJson(data as CollectionEntity, json) as T;
			case FootprintEntity:
				return footprintEntityFromJson(data as FootprintEntity, json) as T;
			case UserInfoEntity:
				return userInfoEntityFromJson(data as UserInfoEntity, json) as T;
			case TagFrequencyEntity:
				return tagFrequencyEntityFromJson(data as TagFrequencyEntity, json) as T;
			case PageUserBlackHoleEntity:
				return pageUserBlackHoleEntityFromJson(data as PageUserBlackHoleEntity, json) as T;
			case PagePictureBlackHoleEntity:
				return pagePictureBlackHoleEntityFromJson(data as PagePictureBlackHoleEntity, json) as T;
			case PageTagBlackHoleEntity:
				return pageTagBlackHoleEntityFromJson(data as PageTagBlackHoleEntity, json) as T;
			case PageUserInfoEntity:
				return pageUserInfoEntityFromJson(data as PageUserInfoEntity, json) as T;
			case FeedbackEntity:
				return feedbackEntityFromJson(data as FeedbackEntity, json) as T;
			case Meta:
				return metaFromJson(data as Meta, json) as T;
			case PageCollectionEntity:
				return pageCollectionEntityFromJson(data as PageCollectionEntity, json) as T;
			case PictureEntity:
				return pictureEntityFromJson(data as PictureEntity, json) as T;
			case TagPictureEntity:
				return tagPictureEntityFromJson(data as TagPictureEntity, json) as T;
			case PageFootprintEntity:
				return pageFootprintEntityFromJson(data as PageFootprintEntity, json) as T;
			case ComplaintEntity:
				return complaintEntityFromJson(data as ComplaintEntity, json) as T;
			case BlackHoleEntity:
				return blackHoleEntityFromJson(data as BlackHoleEntity, json) as T;
			case UserBlackHoleEntity:
				return userBlackHoleEntityFromJson(data as UserBlackHoleEntity, json) as T;
			case TagBlackHoleEntity:
				return tagBlackHoleEntityFromJson(data as TagBlackHoleEntity, json) as T;
			case PictureBlackHoleEntity:
				return pictureBlackHoleEntityFromJson(data as PictureBlackHoleEntity, json) as T;
			case PagePictureEntity:
				return pagePictureEntityFromJson(data as PagePictureEntity, json) as T;
			case PageableEntity:
				return pageableEntityFromJson(data as PageableEntity, json) as T;    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
		switch (type) {
			case CollectionEntity:
				return collectionEntityToJson(data as CollectionEntity);
			case FootprintEntity:
				return footprintEntityToJson(data as FootprintEntity);
			case UserInfoEntity:
				return userInfoEntityToJson(data as UserInfoEntity);
			case TagFrequencyEntity:
				return tagFrequencyEntityToJson(data as TagFrequencyEntity);
			case PageUserBlackHoleEntity:
				return pageUserBlackHoleEntityToJson(data as PageUserBlackHoleEntity);
			case PagePictureBlackHoleEntity:
				return pagePictureBlackHoleEntityToJson(data as PagePictureBlackHoleEntity);
			case PageTagBlackHoleEntity:
				return pageTagBlackHoleEntityToJson(data as PageTagBlackHoleEntity);
			case PageUserInfoEntity:
				return pageUserInfoEntityToJson(data as PageUserInfoEntity);
			case FeedbackEntity:
				return feedbackEntityToJson(data as FeedbackEntity);
			case Meta:
				return metaToJson(data as Meta);
			case PageCollectionEntity:
				return pageCollectionEntityToJson(data as PageCollectionEntity);
			case PictureEntity:
				return pictureEntityToJson(data as PictureEntity);
			case TagPictureEntity:
				return tagPictureEntityToJson(data as TagPictureEntity);
			case PageFootprintEntity:
				return pageFootprintEntityToJson(data as PageFootprintEntity);
			case ComplaintEntity:
				return complaintEntityToJson(data as ComplaintEntity);
			case BlackHoleEntity:
				return blackHoleEntityToJson(data as BlackHoleEntity);
			case UserBlackHoleEntity:
				return userBlackHoleEntityToJson(data as UserBlackHoleEntity);
			case TagBlackHoleEntity:
				return tagBlackHoleEntityToJson(data as TagBlackHoleEntity);
			case PictureBlackHoleEntity:
				return pictureBlackHoleEntityToJson(data as PictureBlackHoleEntity);
			case PagePictureEntity:
				return pagePictureEntityToJson(data as PagePictureEntity);
			case PageableEntity:
				return pageableEntityToJson(data as PageableEntity);
			}
			return data as T;
		}
  //Go back to a single instance by type
	static _fromJsonSingle<M>( json) {
		String type = M.toString();
		if(type == (CollectionEntity).toString()){
			return CollectionEntity().fromJson(json);
		}	else if(type == (FootprintEntity).toString()){
			return FootprintEntity().fromJson(json);
		}	else if(type == (UserInfoEntity).toString()){
			return UserInfoEntity().fromJson(json);
		}	else if(type == (TagFrequencyEntity).toString()){
			return TagFrequencyEntity().fromJson(json);
		}	else if(type == (PageUserBlackHoleEntity).toString()){
			return PageUserBlackHoleEntity().fromJson(json);
		}	else if(type == (PagePictureBlackHoleEntity).toString()){
			return PagePictureBlackHoleEntity().fromJson(json);
		}	else if(type == (PageTagBlackHoleEntity).toString()){
			return PageTagBlackHoleEntity().fromJson(json);
		}	else if(type == (PageUserInfoEntity).toString()){
			return PageUserInfoEntity().fromJson(json);
		}	else if(type == (FeedbackEntity).toString()){
			return FeedbackEntity().fromJson(json);
		}	else if(type == (Meta).toString()){
			return Meta().fromJson(json);
		}	else if(type == (PageCollectionEntity).toString()){
			return PageCollectionEntity().fromJson(json);
		}	else if(type == (PictureEntity).toString()){
			return PictureEntity().fromJson(json);
		}	else if(type == (TagPictureEntity).toString()){
			return TagPictureEntity().fromJson(json);
		}	else if(type == (PageFootprintEntity).toString()){
			return PageFootprintEntity().fromJson(json);
		}	else if(type == (ComplaintEntity).toString()){
			return ComplaintEntity().fromJson(json);
		}	else if(type == (BlackHoleEntity).toString()){
			return BlackHoleEntity().fromJson(json);
		}	else if(type == (UserBlackHoleEntity).toString()){
			return UserBlackHoleEntity().fromJson(json);
		}	else if(type == (TagBlackHoleEntity).toString()){
			return TagBlackHoleEntity().fromJson(json);
		}	else if(type == (PictureBlackHoleEntity).toString()){
			return PictureBlackHoleEntity().fromJson(json);
		}	else if(type == (PagePictureEntity).toString()){
			return PagePictureEntity().fromJson(json);
		}	else if(type == (PageableEntity).toString()){
			return PageableEntity().fromJson(json);
		}	
		return null;
	}

  //list is returned by type
	static M _getListChildType<M>(List data) {
		if(<CollectionEntity>[] is M){
			return data.map<CollectionEntity>((e) => CollectionEntity().fromJson(e)).toList() as M;
		}	else if(<FootprintEntity>[] is M){
			return data.map<FootprintEntity>((e) => FootprintEntity().fromJson(e)).toList() as M;
		}	else if(<UserInfoEntity>[] is M){
			return data.map<UserInfoEntity>((e) => UserInfoEntity().fromJson(e)).toList() as M;
		}	else if(<TagFrequencyEntity>[] is M){
			return data.map<TagFrequencyEntity>((e) => TagFrequencyEntity().fromJson(e)).toList() as M;
		}	else if(<PageUserBlackHoleEntity>[] is M){
			return data.map<PageUserBlackHoleEntity>((e) => PageUserBlackHoleEntity().fromJson(e)).toList() as M;
		}	else if(<PagePictureBlackHoleEntity>[] is M){
			return data.map<PagePictureBlackHoleEntity>((e) => PagePictureBlackHoleEntity().fromJson(e)).toList() as M;
		}	else if(<PageTagBlackHoleEntity>[] is M){
			return data.map<PageTagBlackHoleEntity>((e) => PageTagBlackHoleEntity().fromJson(e)).toList() as M;
		}	else if(<PageUserInfoEntity>[] is M){
			return data.map<PageUserInfoEntity>((e) => PageUserInfoEntity().fromJson(e)).toList() as M;
		}	else if(<FeedbackEntity>[] is M){
			return data.map<FeedbackEntity>((e) => FeedbackEntity().fromJson(e)).toList() as M;
		}	else if(<Meta>[] is M){
			return data.map<Meta>((e) => Meta().fromJson(e)).toList() as M;
		}	else if(<PageCollectionEntity>[] is M){
			return data.map<PageCollectionEntity>((e) => PageCollectionEntity().fromJson(e)).toList() as M;
		}	else if(<PictureEntity>[] is M){
			return data.map<PictureEntity>((e) => PictureEntity().fromJson(e)).toList() as M;
		}	else if(<TagPictureEntity>[] is M){
			return data.map<TagPictureEntity>((e) => TagPictureEntity().fromJson(e)).toList() as M;
		}	else if(<PageFootprintEntity>[] is M){
			return data.map<PageFootprintEntity>((e) => PageFootprintEntity().fromJson(e)).toList() as M;
		}	else if(<ComplaintEntity>[] is M){
			return data.map<ComplaintEntity>((e) => ComplaintEntity().fromJson(e)).toList() as M;
		}	else if(<BlackHoleEntity>[] is M){
			return data.map<BlackHoleEntity>((e) => BlackHoleEntity().fromJson(e)).toList() as M;
		}	else if(<UserBlackHoleEntity>[] is M){
			return data.map<UserBlackHoleEntity>((e) => UserBlackHoleEntity().fromJson(e)).toList() as M;
		}	else if(<TagBlackHoleEntity>[] is M){
			return data.map<TagBlackHoleEntity>((e) => TagBlackHoleEntity().fromJson(e)).toList() as M;
		}	else if(<PictureBlackHoleEntity>[] is M){
			return data.map<PictureBlackHoleEntity>((e) => PictureBlackHoleEntity().fromJson(e)).toList() as M;
		}	else if(<PagePictureEntity>[] is M){
			return data.map<PagePictureEntity>((e) => PagePictureEntity().fromJson(e)).toList() as M;
		}	else if(<PageableEntity>[] is M){
			return data.map<PageableEntity>((e) => PageableEntity().fromJson(e)).toList() as M;
		}
		throw Exception("not fond");
	}

  static M fromJsonAsT<M>(json) {
    if (json is List) {
      return _getListChildType<M>(json);
    } else {
      return _fromJsonSingle<M>(json) as M;
    }
  }
}
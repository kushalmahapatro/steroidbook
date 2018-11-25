import 'package:vod/sdk/ApiUtils.dart';

Future<GetAppHomeFeatureModel> getAppHomeFeatureAPI(
    Map<String, String> parameters) async {
  try {
    return GetAppHomeFeatureModel.fromJSON(await request_POST_header(
        parameters: parameters, url: getAppHomeFeature()));
  } catch (e) {
    print(e);
  }
  return null;
}

class GetAppHomeFeatureModel {
  List<HomeFeaturePageSectionModel> homePageSectionModelList;
  List<HomeFeaturePageBannerModel> homePageBannerModelList;
  int total_section = 0;
  int statusCode;
  var list;

  GetAppHomeFeatureModel(this.statusCode, this.homePageBannerModelList,
      this.homePageSectionModelList, this.total_section);

  GetAppHomeFeatureModel.fromJSON(String json)
      : assert(json != null),
        statusCode = (jsonDecode(json) as Map)["code"] as int ?? 0,
        total_section = (jsonDecode(json) as Map)["section_count"] as int ?? 0,
        homePageBannerModelList =
            ((jsonDecode(json) as Map)["banner_section_list"] as List)
                .map((map) => HomeFeaturePageBannerModel.fromJson(map))
                .toList(),
        homePageSectionModelList =
            ((jsonDecode(json) as Map)["section_name"] as List)
                .map((map) => HomeFeaturePageSectionModel.fromJson(map))
                .toList();
}

class HomeFeaturePageSectionModel {
  String studio_id = "";
  String language_id = "";
  String title = "";
  String section_id = "";
  String section_type = "";
  String total = "";
  List<HomeFeaturePageSectionDetailsModel> homeFeaturePageSectionDetailsModel;

  HomeFeaturePageSectionModel(
      this.title,
      this.section_id,
      this.language_id,
      this.section_type,
      this.studio_id,
      this.total,
      this.homeFeaturePageSectionDetailsModel);

  HomeFeaturePageSectionModel.fromJson(Map json)
      : assert(json != null),
        studio_id = json ["studio_id"] as String ?? "",
        section_id = json["section_id"] as String ?? "",
        language_id = json["language_id"] as String ?? "",
        section_type =
            json["section_type"] as String ?? "",
        title = json["title"] as String ?? "",
        total = json["total"] as String ?? "",
        homeFeaturePageSectionDetailsModel = (json ["data"]
                as List)
            .map((map) => HomeFeaturePageSectionDetailsModel.fromJson(map))
            .toList();
}

class HomeFeaturePageSectionDetailsModel {
  String is_episode = "";
  String movie_stream_uniq_id = "";
  String movie_id = "";
  String movie_stream_id = "";
  String muvi_uniq_id = "";
  String ppv_plan_id = "";
  String permalink = "";
  String name = "";
  String story = "";
  String genre = "";
  String content_types_id = "";
  String is_converted = "";
  String poster_url = "";
  String embeddedUrl = "";
  String isFreeContent = "";
  String banner = "";

  HomeFeaturePageSectionDetailsModel(
      this.content_types_id,
      this.embeddedUrl,
      this.genre,
      this.is_converted,
      this.is_episode,
      this.movie_id,
      this.movie_stream_id,
      this.movie_stream_uniq_id,
      this.muvi_uniq_id,
      this.name,
      this.permalink,
      this.poster_url,
      this.ppv_plan_id,
      this.story,
      this.banner,
      this.isFreeContent);

  HomeFeaturePageSectionDetailsModel.fromJson(Map json)
      : assert(json != null),
        is_episode = json["is_episode"] as String ?? "",
        movie_stream_uniq_id =
            json["movie_stream_uniq_id"] as String ?? "",
        movie_id = json["movie_id"] as String ?? "",
        movie_stream_id =
            json["movie_stream_id"] as String ?? "",
        muvi_uniq_id =
            json["muvi_uniq_id"] as String ?? "",
        ppv_plan_id = json["ppv_plan_id"] as String ?? "",
        permalink = json["permalink"] as String ?? "",
        name = json["name"] as String ?? "",
        story = json["story"] as String ?? "",
        content_types_id =
            json["content_types_id"] as String ?? "",
        is_converted =
            json["is_converted"] as String ?? "",
        poster_url = json["poster_url"] as String ?? "",
        embeddedUrl = json["embeddedUrl"] as String ?? "",
        isFreeContent =
            json["isFreeContent"] as String ?? "",
        banner = json["banner"] as String ?? "";
}

class HomeFeaturePageBannerModel {
  String image_path;
  String banner_url;

  HomeFeaturePageBannerModel(this.banner_url, this.image_path);

  HomeFeaturePageBannerModel.fromJson(Map json)
      : assert(json != null),
        image_path = json["image_path"] ?? "https://d2gx0xinochgze.cloudfront.net/public/no-image-a.png",
        banner_url = json["banner_url"];
}

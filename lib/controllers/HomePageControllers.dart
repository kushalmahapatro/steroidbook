import 'package:meta/meta.dart';
import 'package:vod/sdk/Api.dart';
import 'package:vod/utils/Utils.dart';

class HomePageController {
  final HomePageListener listener;
  final PreferenceManager preferenceManager;

  HomePageController({@required this.listener})
      : preferenceManager = PreferenceManager();

  void callApi() async {
    GetAppHomeFeatureModel appHomeFeature = await getAppHomeFeatureAPI({
      "authToken": AUTH_TOKEN,
      "feature_sec_limit": "",
      "feature_sec_offset": "",
      "user_id": "",
      "lang_code": "",
      "feature_content_limit": "",
      "feature_content_offset": "",
      "platform": "mobile",
      "country": await preferenceManager.getCountryCodePrefs()
    });
//    await new Future.delayed(const Duration(milliseconds: 1200));
    listener.onApiSuccess(data: appHomeFeature);
  }
}

abstract class HomePageListener {
  void onApiFailure({@required Failures failure});

  void onApiSuccess({@required GetAppHomeFeatureModel data});
}

enum Failures { NO_INTERNET, UNKNOWN }

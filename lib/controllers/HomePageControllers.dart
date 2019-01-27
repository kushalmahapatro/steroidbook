import 'package:meta/meta.dart';
import 'package:vod/sdk/Api.dart';
import 'package:vod/sdk/api/GetAppMenu.dart';
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
      "user_id": await preferenceManager.getUserId(),
      "lang_code": "en",
      "feature_content_limit": "",
      "feature_content_offset": "",
      "platform": "mobile",
      "country": await preferenceManager.getCountryCodePrefs()
    });
    GetAppMenuModel appMenuModel = await getAppMenuModel({
      "authToken": AUTH_TOKEN,
      "lang_code": "en",
      "country": await preferenceManager.getCountryCodePrefs()
    });
//    await new Future.delayed(const Duration(milliseconds: 1200));
    listener.onApiSuccess(homeData: appHomeFeature , drawerData: appMenuModel );
  }
}

abstract class HomePageListener {
  void onApiFailure({@required Failures failure});

  void onApiSuccess({@required GetAppHomeFeatureModel homeData, @required GetAppMenuModel drawerData });
}

enum Failures { NO_INTERNET, UNKNOWN }

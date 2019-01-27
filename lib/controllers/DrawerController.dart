import 'package:meta/meta.dart';
import 'package:vod/sdk/Api.dart';
import 'package:vod/sdk/api/GetAppMenu.dart';
import 'package:vod/utils/Utils.dart';

class NavigationDrawerController {
  final DrawerListener listener;
  final PreferenceManager preferenceManager;

  NavigationDrawerController({@required this.listener})
      : preferenceManager = PreferenceManager();

  void callApi() async {
    GetAppMenuModel appMenuModel = await getAppMenuModel({
      "authToken": AUTH_TOKEN,
      "lang_code": "en",
      "country": await preferenceManager.getCountryCodePrefs()
    });
//    await new Future.delayed(const Duration(milliseconds: 1200));
    listener.onApiSuccess( drawerData: appMenuModel );
  }
}

abstract class DrawerListener {
  void onApiFailure({@required Failures failure});

  void onApiSuccess({ @required GetAppMenuModel drawerData});
}

enum Failures { NO_INTERNET, UNKNOWN }

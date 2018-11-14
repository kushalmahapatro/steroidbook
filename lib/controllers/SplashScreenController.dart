import 'package:meta/meta.dart';
import 'package:vod/sdk/Api.dart';
import 'package:vod/utils/Utils.dart';

class SplashScreenController {
  final SplashScreenListener listener;
  final PreferenceManager preferenceManager;

  SplashScreenController({@required this.listener})
      : preferenceManager = PreferenceManager();

  void callApi() async {
    IpAddressModel ip = await ipAddressApi();
    CheckGeoBlockModel geoBlockModel = await checkGeoBlockApi({"authToken": AUTH_TOKEN, "ip": ip.ipAddress});
    await preferenceManager.setCountryCodePrefs(geoBlockModel.country);
    GetPlanListModel planListModel = await getPlanListApi({"authToken": AUTH_TOKEN, "country": await preferenceManager.getCountryCodePrefs()});
//    await new Future.delayed(const Duration(milliseconds: 1200));
    listener.routeTo(route: Routes.LOGIN);
  }
}

abstract class SplashScreenListener {
  void onApiFailure({@required Failures failure});

  void routeTo({@required Routes route});
}

enum Failures { NO_INTERNET, UNKNOWN }

enum Routes { LOGIN, HOME, MY_DOWNLOADS }

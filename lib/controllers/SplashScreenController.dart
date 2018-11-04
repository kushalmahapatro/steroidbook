import 'package:meta/meta.dart';
import 'package:vod/sdk/Api.dart';

class SplashScreenController {

  final SplashScreenListener listener;
  SplashScreenController({@required this.listener});

  void callApi() async {
    IpAddressModel ip = await ipAddressApi();
    print("ip:: "+ip.ipAddress);
    CheckGeoBlockModel geoBlockModel = await checkGeoBlockApi({"authToken":AUTH_TOKEN, "ip": ip.ipAddress});
    print(geoBlockModel.statusCode);
    await new Future.delayed(const Duration(milliseconds: 1500));
    listener.routeTo(route: Routes.LOGIN);
  }
}

abstract class SplashScreenListener {
  void onApiFailure({@required Failures failure});

  void routeTo({@required Routes route});
}

enum Failures { NO_INTERNET, UNKNOWN }

enum Routes { LOGIN, HOME, MY_DOWNLOADS }

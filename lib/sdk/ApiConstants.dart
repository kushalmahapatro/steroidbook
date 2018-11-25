import 'package:vod/utils/Constants.dart';

const String _BASE_URL = BASE_URL;

const String _IP_ADDRESS_ENDPOINT =  "https://api.ipify.org/?format=json";
const String _CHECK_GEO_BLOCK_ENDPONT = "checkGeoBlock";
const String _GET_PLAN_LIST_ENDPONT = "getStudioPlanLists";
const String _GET_APP_HOME_FEATURE = "GetAppHomeFeature";

String ipAddressUrl() {
  return _IP_ADDRESS_ENDPOINT;
}

String checkGeoBlockUrl() {
  return _BASE_URL + _CHECK_GEO_BLOCK_ENDPONT;
}

String getPlanListUrl() {
  return _BASE_URL + _GET_PLAN_LIST_ENDPONT;
}

String getAppHomeFeature() {
  return _BASE_URL + _GET_APP_HOME_FEATURE;
}
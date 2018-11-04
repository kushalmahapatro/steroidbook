import 'package:vod/utils/Constants.dart';

const String _BASE_URL = BASE_URL;

const String _IP_ADDRESS_ENDPOINT =  "https://api.ipify.org/?format=json";
const String _CHECK_GEO_BLOCK_ENDPONT = "checkGeoBlock";

String ipAddressUrl() {
  return _IP_ADDRESS_ENDPOINT;
}

String checkGeoBlockUrl() {
  return _BASE_URL + _CHECK_GEO_BLOCK_ENDPONT;
}
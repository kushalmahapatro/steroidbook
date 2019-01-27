import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:vod/sdk/Api.dart';
import 'package:vod/sdk/ApiConstants.dart';
import 'package:vod/sdk/api/GetContentList.dart';
import 'package:vod/sdk/api/LoginUser.dart';
import 'package:vod/utils/Utils.dart';
import 'package:connectivity/connectivity.dart';

class BlocContentList extends Object {
  ContentListData data;
  final PreferenceManager preferenceManager = PreferenceManager();

  //Extended Object cause we can't add Mixing without inheritance
  final _contentListApi =
      BehaviorSubject<ContentListData>(); //Log in API called StreamController

  Stream<ContentListData> get contentListApi => _contentListApi.stream;

  get contentListApiValue => _contentListApi.sink.add;

  dispose() async {
    await _contentListApi.drain();
    _contentListApi.close();
  }

  void callApi(String permalink, int offset,int limit) async {
    apiCall(permalink, offset, limit);

  }

  void apiCall(String permalink, int offset, int limit) async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a mobile network or wifi
      ContentListModel contentList = await getContentListApi({
        "authToken": AUTH_TOKEN,
        "country": await preferenceManager.getCountryCodePrefs(),
        "permalink": permalink,
        "limit": limit.toString(),
        "offset": offset.toString(),
        "lang_code": "en",
        "order_by": "",
      });

      if (contentList.status == 200) {
        data = ContentListData(true, contentList.msg, contentList);
        _contentListApi.add(data);
      } else {
        data = ContentListData(false, contentList.msg, null);
        _contentListApi.add(data);
      }
    } else {
      data = ContentListData(false, "No Internet Connection", null);
      _contentListApi.add(data);
    }
  }
  
}

class ContentListData {
  bool success;
  String message;
  ContentListModel apiData;

  ContentListData(this.success, this.message, this.apiData);
}

final blocContentList = BlocContentList(); //Single Global Instance
